<%@LANGUAGE="VBSCRIPT" CODEPAGE="65001"%>
<%
Option Explicit

'Değişken tanımlamaları
Dim strConn, objConn, strSQL, tarih, firma, model, modelno, musteri, fiyat, aciklama, masraf, km, cinsi, resim, fis

'Veritabanı bağlantı dizesi
strConn = "Provider=Microsoft.Jet.OLEDB.4.0;Data Source=" & Server.MapPath("/db/harc.mdb")

'Formdan gelen verileri al
tarih = Trim(Request.Form("tarih"))
firma = Trim(Request.Form("firma"))
model = Trim(Request.Form("model"))
modelno = Trim(Request.Form("modelno"))
musteri = Trim(Request.Form("musteri"))
fiyat = Trim(Request.Form("fiyat"))
aciklama = Trim(Request.Form("aciklama"))
masraf = Trim(Request.Form("masraf"))
km = Trim(Request.Form("km"))
cinsi = Trim(Request.Form("cinsi"))
resim = Trim(Request.Form("resim"))
fis = Trim(Request.Form("fis"))

'Veritabanına kaydetme
On Error Resume Next

'Veritabanı bağlantısını oluştur
Set objConn = Server.CreateObject("ADODB.Connection")

'Bağlantıyı aç
objConn.Open strConn

'Hata oluştuysa
If Err.Number <> 0 Then
  Response.Write "Veritabanı bağlantısı sırasında bir hata oluştu: " & Err.Description
  Response.End
End If

'SQL sorgusunu oluştur
strSQL = "INSERT INTO HARC (tarih, firma, model, modelno, musteri, fiyat, aciklama, masraf, km, cinsi, resim, fis) VALUES (" 'Cinsi sütunu eklendi
strSQL = strSQL & "'" & Replace(tarih, "'", "''") & "', "
strSQL = strSQL & "'" & Replace(firma, "'", "''") & "', "
strSQL = strSQL & "'" & Replace(model, "'", "''") & "', "
strSQL = strSQL & "'" & Replace(modelno, "'", "''") & "', "
strSQL = strSQL & "'" & Replace(musteri, "'", "''") & "', "
strSQL = strSQL & "'" & Replace(fiyat, "'", "''") & "', "
strSQL = strSQL & "'" & Replace(aciklama, "'", "''") & "', "
strSQL = strSQL & "'" & Replace(masraf, "'", "''") & "', "
strSQL = strSQL & "'" & Replace(km, "'", "''") & "', "
strSQL = strSQL & "'" & Replace(cinsi, "'", "''") & "', "
strSQL = strSQL & "'" & Replace(resim, "'", "''") & "', "
strSQL = strSQL & "'" & Replace(fis, "'", "''") & "')" 'Son değerden sonra virgül yok

'Sorguyu çalıştır
objConn.Execute strSQL

'Hata oluştuysa
If Err.Number <> 0 Then
  Response.Write "Veri kaydı sırasında bir hata oluştu: " & Err.Description
  Response.End
End If

'Bağlantıyı kapat
objConn.Close
Set objConn = Nothing

'Hata yönetimini kapat
On Error Goto 0
%>
<!DOCTYPE html>
<html lang="tr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Kayıt Güncelleme Başarılı</title>
    <style>
        body, html {
            height: 100%;
            margin: 0;
            font-family: Arial, sans-serif;
            display: flex;
            justify-content: center;
            align-items: center;
            background-color: #f0f0f0;
        }
        .message-container {
            text-align: center;
            background-color: #0056b3;
            padding: 20px;
            border-radius: 5px;
            box-shadow: 0 2px 10px rgba(0,0,0,0.1);
        }
        .success-message {
            color: #ffffff;
            font-size: 18px;
            margin-bottom: 10px;
        }
    </style>
</head>
<body>
    <div class="message-container">
        <p class="success-message">Kayıt Başarıyla Gerçekleşti.</p>
    </div>
    <script>
        setTimeout(function() {
            window.location.href = '../harc_giris3.asp';
        }, 500);
    </script>
</body>
</html>