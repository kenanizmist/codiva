<%@LANGUAGE="VBSCRIPT" CODEPAGE="65001"%>
<%
Response.CharSet = "UTF-8"
%>
<%
Dim conn, SQL, firma, tarih, model, modelno, depo, beden, adet

' Formdan gelen verileri al
firma = Request.Form("firma")
tarih = Request.Form("tarih")
model = Request.Form("model")
modelno = Request.Form("modelno")
depo = Request.Form("depo")
raf = Request.Form("raf")
adet = Request.Form("adet")
renk = Request.Form("renk")
kesimadet = Request.Form("kesimadet")
sevkadet = Request.Form("sevkadet")
fark = Request.Form("fark")
beden = Request.Form("beden")

' fark hesapla (eğer kesimadet ve sevkadet integer değilse, onları da SafeInt ile çevirin)
fark = (kesimadet) - (sevkadet)

' Veritabanı bağlantısını oluştur
Set conn = Server.CreateObject("ADODB.Connection")
On Error Resume Next
conn.Open "Provider=Microsoft.Jet.OLEDB.4.0;Data Source=" & Server.MapPath("/codiva/db/db.mdb")

' Hata kontrolü
If Err.Number <> 0 Then
    Response.Write("Veritabanı bağlantı hatası: " & Err.Description)
    Response.End
End If
On Error GoTo 0

' Veritabanına veri eklemek için SQL sorgusu
SQL = "INSERT INTO MAGA (firma, tarih, model, modelno, depo, raf, adet, renk, kesimadet, sevkadet, fark, beden) " & _
      "VALUES ('" & firma & "', '" & tarih & "', '" & model & "', '" & modelno & "', '" & depo & "', '" & raf & "', '" & adet & "', '" & renk & "', '" & kesimadet & "', '" & sevkadet & "', '" & fark & "', '" & beden & "')"

' SQL sorgusunu çalıştır
conn.Execute SQL

' Hata kontrolü
If Err.Number <> 0 Then
    Response.Write("Kayıt ekleme hatası: " & Err.Description)
    Response.End
Else
    
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
                window.location.href = '../main.html'; 
            }, 500);
        </script>
    </body>
    </html>
    <%
End If

' Bağlantıyı kapat
conn.Close
Set conn = Nothing
%>
