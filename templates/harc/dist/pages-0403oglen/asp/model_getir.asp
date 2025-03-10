<%@LANGUAGE="VBSCRIPT" CODEPAGE="65001"%>
<%
Response.CharSet = "UTF-8"
Response.CodePage = "65001"

On Error Resume Next ' Hataları göster
Response.ContentType = "text/plain" ' JSON yerine düz metin olarak hata göstermek için

Dim conn, rs, dbPath, modelNo, sql
modelNo = Trim(Request.QueryString("modelno"))

dbPath = Server.MapPath("/codiva/db/db.mdb")
Set conn = Server.CreateObject("ADODB.Connection")

conn.Open "Provider=Microsoft.Jet.OLEDB.4.0;Data Source=" & dbPath

' **Hata Kontrolü**
If Err.Number <> 0 Then
    Response.Write "Veritabanı bağlantı hatası: " & Err.Description
    Response.End
End If

sql = "SELECT firma, model, fiyat, sfiyat, kur, renk, aciklama, barcode FROM MAGA WHERE modelno='" & modelNo & "'"
Set rs = conn.Execute(sql)

' **Hata kontrolü**
If Err.Number <> 0 Then
    Response.Write "SQL hatası: " & Err.Description
    Response.End
End If

' **Eğer kayıt bulunursa, JSON olarak yazdır**
If Not rs.EOF Then
    Response.Write "{""success"":true,"
    Response.Write """firma"":""" & rs("firma") & ""","
    Response.Write """model"":""" & rs("model") & ""","
    Response.Write """beden"":""" & rs("beden") & ""","
    Response.Write """fiyat"":""" & rs("fiyat") & ""","
    Response.Write """sfiyat"":""" & rs("sfiyat") & ""","
    Response.Write """kur"":""" & rs("kur") & ""","
    Response.Write """renk"":""" & rs("renk") & ""","
    Response.Write """barcode"":""" & rs("barcode") & ""","
    Response.Write """aciklama"":""" & rs("aciklama") & """}"
Else
    Response.Write "{""success"":false, ""error"":""Model No bulunamadı.""""}"
End If

rs.Close
conn.Close
Set rs = Nothing
Set conn = Nothing
%>
