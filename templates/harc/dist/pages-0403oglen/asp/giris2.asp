<%
Dim userPassword, hasError, errorMessage

' İlk önce hata durumunu ve hata mesajını ayarlayın
hasError = False
errorMessage = ""

' Form gönderilmişse (Request metodu POST ise)
If Request.ServerVariables("REQUEST_METHOD") = "POST" Then
    ' Kullanıcıdan gelen şifreyi al
    userPassword = Request.Form("password")

    ' Şifre kontrolü
    If IsEmpty(userPassword) Or Len(Trim(userPassword)) = 0 Then
        hasError = True
        errorMessage = "Şifre alanı boş bırakılamaz. Lütfen şifrenizi giriniz."
    Else
        ' Veritabanı bağlantısını oluştur
        Dim conn, rs, sql
        Set conn = Server.CreateObject("ADODB.Connection")
conn.Open "Provider=Microsoft.Jet.OLEDB.4.0;Data Source=" & Server.MapPath("/db/harc.mdb")

        ' SQL sorgusunu oluştur (doğrudan sorgu birleştirmesi)
        sql = "SELECT * FROM admin WHERE id = 2 AND sifre = ?"
        
        ' Command nesnesi oluştur
        Dim cmd
        Set cmd = Server.CreateObject("ADODB.Command")
        cmd.ActiveConnection = conn
        cmd.CommandText = sql
        cmd.CommandType = 1 ' adCmdText

        ' Parametreyi ekle
        cmd.Parameters.Append cmd.CreateParameter("sifre", 200, 1, 255, userPassword)

        ' Sorguyu çalıştır
        Set rs = cmd.Execute()
        
        If Not rs.EOF Then
            ' Şifre doğruysa mağaza sayfasına yönlendir
            Response.Redirect "../harcirah_liste2.asp"
        Else
            ' Hatalı şifre
            hasError = True
            errorMessage = "Hatalı şifre. Lütfen tekrar deneyin."

            ' Hatalı şifre
            validatePassword = 0
            errorMessage = "Şifre alanı boş bırakılamaz."
        End If
        
        ' Bağlantıyı kapat
        rs.Close
        conn.Close
        Set rs = Nothing
        Set cmd = Nothing
        Set conn = Nothing
    End If
End If
%>

<!DOCTYPE html>
<html lang="tr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Giriş Yap</title>
    <style>
        body, html {
            height: 100%;
            margin: 0;
            font-family: Arial, sans-serif;
			color: #fff;
			font-size: 18px;
            display: flex;
            justify-content: center;
            align-items: center;
            background-color: #f0f0f0;
        }
        .message-container {
            text-align: center;
			text-color: #ffffff;
            background-color: #0056b3;
            padding: 20px;
            border-radius: 5px;
            box-shadow: 0 2px 10px rgba(0,0,0,0.1);
        }
        .error-message {
            color: #ff0000;
            font-size: 18px;
            margin-bottom: 10px;
        }
		.btn {
        margin: 0 5px;
        padding: 8px 15px;
        background-color: #07b55b;
        color: #fff;
        border: none;
        cursor: pointer;
        border-radius: 4px;
		text-decoration:none;
		width: 200px;
		}
		.lbl{
		text-color: #ffffff;
		}
    </style>

</head>
<body>
<table class="message-container">
	<tr>
		<td>
			<div class="message-container">
				<% If hasError Then %>
					<div class="error-message"><%= errorMessage %></div>
				<% End If %>
				<form action="giris2.asp" method="post" onsubmit="return validatePassword()">
					<b>Lütfen Şifrenizi Girin:<br><br>
					<input type="password" id="password" name="password" style="border:1px; width:100%; height:30px;"><br><br>
					<input type="submit" class="btn" value="Giriş">			
				</form>
			</div>

		</td>
	</tr>
	<tr>
		<td>		
			<button onclick="window.location.href='/harcirah/index.html'" class="btn"><b>Geri</button>				
		</td>
	</tr>
</table>
</body>
</html>
