<%


' Kullanıcının giriş yapıp yapmadığını kontrol et
If Session("LoggedIn") <> True Then
    ' Eğer giriş yapılmamışsa, kullanıcıyı giriş sayfasına yönlendir
    Response.Redirect("giris.html")
End If
%>