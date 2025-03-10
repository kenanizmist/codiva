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
        sql = "SELECT * FROM admin WHERE id = 1 AND sifre = ?"
        
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
            ' Şifre doğruysa oturum aç ve main.asp'ye yönlendir
            Session("LoggedIn") = True
            Response.Redirect("../main.asp")
        Else
            ' Hatalı şifre
            hasError = True
            errorMessage = "Hatalı şifre. Lütfen tekrar deneyin."
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