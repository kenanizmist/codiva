<%@LANGUAGE="VBSCRIPT" CODEPAGE="65001"%>
<%
Response.CharSet = "UTF-8"
Response.ContentType = "application/json" ' JSON çıktısı için

Dim conn, rs, SQL, searchTerm, json, i

' Veritabanı bağlantısı
Set conn = Server.CreateObject("ADODB.Connection")
conn.Open "Provider=Microsoft.Jet.OLEDB.4.0;Data Source=" & Server.MapPath("/db/harc.mdb")

' Arama terimini al
searchTerm = Request.QueryString("searchTerm")

' SQL sorgusunu oluştur
SQL = "SELECT id, resim, cinsi, tarih, firma, model, modelno, km, masraf, musteri, fiyat, aciklama, kontrol, fis FROM HARC"
If searchTerm <> "" Then
    SQL = SQL & " WHERE musteri LIKE '%" & searchTerm & "%' OR modelno LIKE '%" & searchTerm & "%' OR cinsi LIKE '%" & searchTerm & "%'"
End If
SQL = SQL & " ORDER BY tarih DESC, id DESC"

' Kayıt kümesini oluştur
Set rs = conn.Execute(SQL)

' JSON çıktısı oluşturma
If Not rs.EOF Then
    json = "["
    i = 0
    Do While Not rs.EOF
        If i > 0 Then
            json = json & ","
        End If
        json = json & "{"""
        json = json & "id" & """:""" & rs("id") & ""","""
        json = json & "resim" & """:""" & rs("resim") & ""","""
        json = json & "cinsi" & """:""" & rs("cinsi") & ""","""
        json = json & "tarih" & """:""" & rs("tarih") & ""","""
        json = json & "firma" & """:""" & rs("firma") & ""","""
        json = json & "model" & """:""" & rs("model") & ""","""
        json = json & "modelno" & """:""" & rs("modelno") & ""","""
        json = json & "km" & """:""" & rs("km") & ""","""
        json = json & "masraf" & """:""" & rs("masraf") & ""","""
        json = json & "musteri" & """:""" & rs("musteri") & ""","""
        json = json & "fiyat" & """:""" & rs("fiyat") & ""","""
        json = json & "aciklama" & """:""" & rs("aciklama") & ""","""
        json = json & "fis" & """:""" & rs("fis") & ""","""
        json = json & "kontrol" & """:""" & rs("kontrol") & """}"
        i = i + 1
        rs.MoveNext
    Loop
    json = json & "]"
Else
    json = "[]" ' Boş dizi döndür
End If

' JSON çıktısını gönder
Response.Write json

' Bağlantıyı kapat
rs.Close
Set rs = Nothing
conn.Close
Set conn = Nothing
%>