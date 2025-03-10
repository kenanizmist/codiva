<%@LANGUAGE="VBSCRIPT" CODEPAGE="65001"%>

<%
Option Explicit

' Veritabanı bağlantı bilgilerinizi buraya girin
Dim ConnString, Conn, RS, SQL
ConnString = "Provider=Microsoft.Jet.OLEDB.4.0;Data Source=" & Server.MapPath("/db/harc.mdb")

Set Conn = Server.CreateObject("ADODB.Connection")
Conn.Open ConnString

' Son 13 ayı hesapla
Dim i, AyAdi, AyNo, Yil
Dim Aylar(12) ' 13 ay için dizi

For i = 0 To 12
  AyNo = Month(DateAdd("m", -i, Date))
  Yil = Year(DateAdd("m", -i, Date))

  ' Ay adını al (Türkçe)
  Select Case AyNo
    Case 1:  AyAdi = "Ocak"
    Case 2:  AyAdi = "Şubat"
    Case 3:  AyAdi = "Mart"
    Case 4:  AyAdi = "Nisan"
    Case 5:  AyAdi = "Mayıs"
    Case 6:  AyAdi = "Haziran"
    Case 7:  AyAdi = "Temmuz"
    Case 8:  AyAdi = "Ağustos"
    Case 9:  AyAdi = "Eylül"
    Case 10: AyAdi = "Ekim"
    Case 11: AyAdi = "Kasım"
    Case 12: AyAdi = "Aralık"
  End Select

  Aylar(12 - i) = AyAdi & " " & Yil ' Diziyi doğru sırada doldur
Next

' Verileri çek
Dim CiroData(12), j

For j = 0 To 12
  SQL = "SELECT SUM(fiyat) AS ToplamCiro FROM HARC WHERE MONTH(tarih) = " & Month(DateValue(Aylar(j) & " 1")) & " AND YEAR(tarih) = " & Year(DateValue(Aylar(j) & " 1")) & ""
  Set RS = Conn.Execute(SQL)

  If Not RS.EOF Then
    If IsNull(RS("ToplamCiro")) Then
      CiroData(j) = 0 ' Eğer veri yoksa 0 olarak ayarla
    Else
      CiroData(j) = RS("ToplamCiro")
    End If
  Else
    CiroData(j) = 0
  End If

  RS.Close
  Set RS = Nothing
Next

' JSON olarak çıktı
Response.ContentType = "application/json"
Response.Charset = "UTF-8"

Dim JSON
JSON = "{""aylar"":[""" & Join(Aylar, """,""") & """],""ciroData"":[" & Join(CiroData, ",") & "]}"

Response.Write JSON

Conn.Close
Set Conn = Nothing
%>