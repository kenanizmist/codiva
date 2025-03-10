<%@LANGUAGE="VBSCRIPT" CODEPAGE="65001"%>
<%
Response.CharSet = "UTF-8"
%>
<%
Response.ContentType = "application/json"
dim conn, rs, dbPath, soyadi, sql, sonuc

' Veritabanı bağlantısı
dbPath = Server.MapPath("/codiva/db/db.mdb")
Set conn = Server.CreateObject("ADODB.Connection")

On Error Resume Next
conn.Open "Provider=Microsoft.Jet.OLEDB.4.0; Data Source=" & dbPath
If Err.Number <> 0 Then
    Response.Write "{""success"":false, ""error"":""Veritabanına bağlanılamadı!""}"
    Response.End
End If
On Error GoTo 0

' Kullanıcıdan gelen soyadını al
soyadi = Trim(Request.QueryString("soyadi"))

' SQL ile sadece adi sütununda arama yap
sql = "SELECT TOP 1 adi FROM musteri WHERE adi LIKE '%" & soyadi & "%'"
Set rs = conn.Execute(sql)

' Sonuç döndürme
If Not rs.EOF Then
    sonuc = "{""success"":true, ""adi"":""" & Replace(rs("adi"), """", "\""") & """}"
Else
    sonuc = "{""success"":false, ""error"":""Müşteri bulunamadı!""}"
End If

' Bağlantıları kapat
rs.Close
Set rs = Nothing
conn.Close
Set conn = Nothing

' JSON olarak geri döndür
Response.Write sonuc
%>



