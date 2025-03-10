<%@LANGUAGE="VBSCRIPT" CODEPAGE="65001"%>
<%
Response.CharSet = "UTF-8"
Response.CodePage = "65001"
Response.ContentType = "application/json" 'JSON çıktısı için

' Veritabanı bağlantı bilgileri
Dim strConn, conn, rs, SQL, parametre, deger

strConn = "Provider=Microsoft.Jet.OLEDB.4.0;Data Source=" & Server.MapPath("/db/harc.mdb")

' Formdan gelen verileri al
parametre = Trim(Request.QueryString("parametre"))
deger = Trim(Request.QueryString("deger"))

' Veritabanı bağlantısını aç
Set conn = Server.CreateObject("ADODB.Connection")
conn.Open strConn

' SQL Sorgusu (parametreye göre)
If parametre = "modelno" Then
    SQL = "SELECT model, modelno, musteri FROM HARC WHERE modelno LIKE '%" & Replace(deger, "'", "''") & "%'"
ElseIf parametre = "musteri" Then
    SQL = "SELECT model, modelno, musteri FROM HARC WHERE musteri LIKE '%" & Replace(deger, "'", "''") & "%'"
Else
    ' Geçersiz parametre
    Response.Write "{""success"": false, ""error"": ""Geçersiz parametre!""}"
    Response.End
End If

' Sorguyu çalıştır
Set rs = conn.Execute(SQL)

' Sonuçları kontrol et
If Not rs.EOF Then
    ' JSON formatında sonuçları döndür
    Response.Write "{""success"": true, " & _
                   """model"": """ & Replace(rs("model"), """", """""") & """, " & _
                   """musteri"": """ & Replace(rs("musteri"), """", """""") & """, " & _
                   """modelno"": """ & Replace(rs("modelno"), """", """""") & """}"
Else
    ' Veri bulunamadı
    Response.Write "{""success"": false, ""error"": ""Veri bulunamadı!""}"
End If

' Bağlantıyı kapat
rs.Close
Set rs = Nothing
conn.Close
Set conn = Nothing
%>