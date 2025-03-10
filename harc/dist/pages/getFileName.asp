<%
' Hata ayıklama için Response.Buffer özelliğini açın
Response.Buffer = True
On Error Resume Next ' Hataları görmezden gelme

' Klasör yolunu belirle
Dim folderPath
folderPath = Server.MapPath("savefiles")

' FileSystemObject oluştur
Dim fso
Set fso = Server.CreateObject("Scripting.FileSystemObject")

' Klasör var mı kontrol et
If fso.FolderExists(folderPath) Then
    ' Klasördeki dosyaları al
    Dim folder, file, lastFile, lastDate
    Set folder = fso.GetFolder(folderPath)
    
    ' En son eklenen dosyayı bul
    lastDate = DateSerial(1900, 1, 1) ' Başlangıç tarihini çok eski bir tarih yap
    For Each file In folder.Files
        ' Dosyanın son değiştirilme tarihini al
        Dim fileDate
        fileDate = file.DateLastModified
        
        ' Tarih karşılaştırmasını yap
        If fileDate > lastDate Then
            lastDate = fileDate
            lastFile = file.Name
        End If
    Next
    
    ' En son dosyanın adını yazdır
    If lastFile <> "" Then
        Response.Write lastFile
    Else
        Response.Write "Dosya bulunamadı."
    End If
Else
    Response.Write "Klasör bulunamadı."
End If

' Hata varsa göster
If Err.Number <> 0 Then
    Response.Write "Hata: " & Err.Description
End If
%>