<%@LANGUAGE="VBSCRIPT" CODEPAGE="65001"%>
<%
' Veritabanı bağlantı bilgilerini buraya girin
Dim conn, rs, strSQL, yemek, taksi, ulasim, otopark, diger, toplam

' Veritabanı bağlantısı oluştur
Set conn = Server.CreateObject("ADODB.Connection")
conn.Open "Provider=Microsoft.Jet.OLEDB.4.0;Data Source=" & Server.MapPath("/db/harc.mdb")

' Değerleri sıfırla
yemek = 0
taksi = 0
ulasim = 0
otopark = 0
diger = 0
toplam = 0

' SQL sorgusu
strSQL = "SELECT cinsi, SUM(fiyat) AS toplam_fiyat FROM HARC WHERE kontrol = 1 GROUP BY cinsi"

' Kayıt kümesi oluştur
Set rs = Server.CreateObject("ADODB.Recordset")

'Hata yönetimi
On Error Resume Next
rs.Open strSQL, conn, 3, 3

If Err.Number <> 0 Then
    Response.Write "{""error"": ""Veritabanı sorgusu sırasında hata oluştu: " & Err.Description & """}"
    Response.End
End If
On Error Goto 0 'Hata yakalamayı kapat

' Verileri işle
If Not rs.EOF Then
  Do While Not rs.EOF
    Dim kurDegeri, fiyatDegeri
    kurDegeri = Trim(UCase(rs("cinsi"))) 'Boşlukları temizle ve büyük harfe çevir

        'Veri dönüşümünde hata olursa, sıfır kabul et
    On Error Resume Next
        fiyatDegeri = CDbl(rs("toplam_fiyat"))
        If Err.Number <> 0 Then
            fiyatDegeri = 0
        End If
    On Error Goto 0

    Select Case kurDegeri
      Case "YEMEK"
        yemek = fiyatDegeri
      Case "TAKSİ"
        taksi = fiyatDegeri
      Case "ULAŞIM"
        ulasim = fiyatDegeri
      Case "OTOPARK"
        otopark = fiyatDegeri
      Case "DİĞER"
        diger = fiyatDegeri
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
toplam = yemek + taksi + ulasim + otopark + diger

' JSON çıktısı oluştur
Response.ContentType = "application/json"
Response.Write "{""yemek"": " & yemek & ", ""taksi"": " & taksi & ", ""ulasim"": " & ulasim & ", ""otopark"": " & otopark & ", ""diger"": " & diger & ", ""toplam"": " & toplam & "}"
%>