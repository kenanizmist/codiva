<%@LANGUAGE="VBSCRIPT" CODEPAGE="65001"%>
<%
' Veritabanı bağlantı bilgilerini buraya girin
Dim conn, rs, strSQL, nakit, kart, eft, toplam

' Veritabanı bağlantısı oluştur
Set conn = Server.CreateObject("ADODB.Connection")
conn.Open "Provider=Microsoft.Jet.OLEDB.4.0;Data Source=" & Server.MapPath("/codiva/db/db.mdb")

' Değerleri sıfırla
nakit = 0
kart = 0
eft = 0
toplam = 0

' Geçen ayın başlangıcını ve sonunu al
Dim ilkGun, sonGun
Dim yil, ay

yil = Year(DateAdd("m", -1, Date)) ' Geçen yıl
ay = Month(DateAdd("m", -1, Date)) ' Geçen ay

' Geçen ayın ilk ve son günlerini oluştur
ilkGun = DateSerial(yil, ay, 1)
sonGun = DateSerial(yil, ay + 1, 0)

' Tarihleri "01/01/2025" formatına dönüştür
ilkGun = Replace(FormatDateTime(ilkGun, vbShortDate), ".", "/")
sonGun = Replace(FormatDateTime(sonGun, vbShortDate), ".", "/")

' Tarihleri ekrana yazdır (kontrol için)
Response.Write "İlk Gün: " & ilkGun & "<br>"
Response.Write "Son Gün: " & sonGun & "<br>"

' SQL sorgusu
strSQL = "SELECT kur, SUM(fiyat) AS toplam_fiyat FROM MAGA " & _
         "WHERE depo = 'SATIŞ' AND islemTarih >= #" & ilkGun & "# AND islemTarih <= #" & sonGun & "# " & _
         "GROUP BY kur"

' Kayıt kümesi oluştur
Set rs = Server.CreateObject("ADODB.Recordset")
rs.Open strSQL, conn, 3, 3

' Verileri işle
If Not rs.EOF Then
  Do While Not rs.EOF
    Dim kurDegeri, fiyatDegeri
    kurDegeri = Trim(UCase(rs("kur"))) 'Boşlukları temizle ve büyük harfe çevir
    fiyatDegeri = CDbl(rs("toplam_fiyat")) 'Veriyi double'a çevir

    Select Case kurDegeri
      Case "NAKİT"
        nakit = fiyatDegeri
      Case "K.KARTI"
        kart = fiyatDegeri
      Case "EFT"
        eft = fiyatDegeri
    End Select

    rs.MoveNext
  Loop
End If

' Kayıt kümesini ve bağlantıyı kapat
rs.Close
Set rs = Nothing
conn.Close
Set conn = Nothing

' Toplamı hesapla
toplam = nakit + kart + eft

' JSON çıktısı oluştur
Response.ContentType = "application/json"
Response.Write "{""nakit"": " & nakit & ", ""kart"": " & kart & ", ""eft"": " & eft & ", ""toplam"": " & toplam & "}"
%>