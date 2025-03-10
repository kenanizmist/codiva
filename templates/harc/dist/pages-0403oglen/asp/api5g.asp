<%@LANGUAGE="VBSCRIPT" CODEPAGE="65001"%>
<%
Response.ContentType = "application/json"
Set conn = Server.CreateObject("ADODB.Connection")
conn.Open "Provider=Microsoft.Jet.OLEDB.4.0;Data Source=" & Server.MapPath("/db/harc.mdb")

' Bugünü al
Dim todayDate
todayDate = Date()

' Sorguyu oluştur
sqlQuery = "SELECT * FROM HARC WHERE musteri AND DateValue(tarih) = DateValue('" & todayDate & "') ORDER BY id DESC"
Set rs = conn.Execute(sqlQuery)

Dim result
result = "[]"

If Not rs.EOF Then
    Dim records
    records = "["
    Dim firstRecord
    firstRecord = True

    Do Until rs.EOF
        If Not firstRecord Then
            records = records & ","  ' İlk kayıt değilse virgül ekle
        Else
            firstRecord = False
        End If

        records = records & "{"
        records = records & """id"":""" & rs("id") & ""","
        records = records & """tarih"":""" & Year(rs("tarih"))&"." & Month(rs("tarih"))&"." & Day(rs("tarih")) & ""","
        records = records & """firma"":""" & rs("firma") & ""","
        records = records & """model"":""" & rs("model") & ""","
        records = records & """modelno"":""" & rs("modelno") & ""","
        records = records & """aciklama"":""" & rs("aciklama") & ""","
        records = records & """fiyat"":""" & rs("fiyat") & ""","
        records = records & """kontrol"":""" & rs("kontrol") & ""","
        records = records & """musteri"":""" & rs("musteri") & """"
        records = records & "}"

        rs.MoveNext
    Loop

    records = records & "]"
    result = records
End If

Response.Write result
rs.Close
conn.Close
%>