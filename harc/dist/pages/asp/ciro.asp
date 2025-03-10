<%@LANGUAGE="VBSCRIPT" CODEPAGE="65001"%>
<%
' Gelen verileri al
Dim ay, ciro, yil, nakit, kart, eft
ay = Request.Form("ay")
ciro = Request.Form("ciro")
yil = Request.Form("yil")
nakit = Request.Form("nakit")
kart = Request.Form("kart")
eft = Request.Form("eft")

' Boş değer kontrolü
If ay <> "" And ciro <> "" And yil <> "" And nakit <> "" And kart <> "" And eft <> "" Then
    ' Veritabanı bağlantısını aç
    Dim conn, sqlQuery
    Set conn = Server.CreateObject("ADODB.Connection")
    conn.Open "Provider=Microsoft.Jet.OLEDB.4.0;Data Source=" & Server.MapPath("/codiva/db/db.mdb")
    
    ' SQL sorgusu oluştur
    sqlQuery = "INSERT INTO satis (ay, ciro, yil, nakit, kart, eft) VALUES ('" & Replace(ay, "'", "''") & "', " & Replace(ciro, ",", ".") & ", '" & Replace(yil, "'", "''") & "', " & Replace(nakit, ",", ".") & ", " & Replace(kart, ",", ".") & ", " & Replace(eft, ",", ".") & ")"
    
    ' SQL sorgusunu çalıştır
    conn.Execute(sqlQuery)

    ' Veritabanı bağlantısını kapat
    conn.Close
    Set conn = Nothing

     ' Hata kontrolü
    If Err.Number <> 0 Then
        errMessage = "Hata oluştu: " & Err.Description
        Response.Write "<p style='color: red;'>" & errMessage & "</p>"
        Err.Clear
    Else
        ' Başarı mesajı
        Response.Write "<!DOCTYPE html>"
        Response.Write "<html lang='tr'>"
        Response.Write "<head><meta charset='UTF-8'><meta name='viewport' content='width=device-width, initial-scale=1.0'><title>Kayıt Başarılı</title>"
        Response.Write "<style>body, html {height: 100%; margin: 0; font-family: Arial, sans-serif; display: flex; justify-content: center; align-items: center; background-color: #f0f0f0;} .message-container {text-align: center; background-color: #0056b3; padding: 20px; border-radius: 5px; box-shadow: 0 2px 10px rgba(0,0,0,0.1);} .success-message {color: #ffffff; font-size: 18px; margin-bottom: 10px;}</style>"
        Response.Write "</head>"
        Response.Write "<body>"
        Response.Write "<div class='message-container'>"
        Response.Write "<p class='success-message'>Kayıt Başarıyla Gerçekleşti.</p>"
        Response.Write "</div>"
        Response.Write "<script>setTimeout(function() { window.location.href = '../kasa.html'; }, 500);</script>"
        Response.Write "</body></html>"
    End If
Else
    ' Hata mesajı
    Response.Write "<script>alert('Lütfen tüm alanları doldurunuz!');window.history.back();</script>"
End If
%>
