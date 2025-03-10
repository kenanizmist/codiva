<%@LANGUAGE="VBSCRIPT" CODEPAGE="65001"%>
<%
Response.CharSet = "UTF-8"
Response.CodePage = "65001"

' Veritabanı bağlantı bilgileri
Dim strConn, conn, rs, SQL

strConn = "Provider=Microsoft.Jet.OLEDB.4.0;Data Source=" & Server.MapPath("/codiva/db/db.mdb")

' Form gönderilmişse verileri kaydet
If Request.ServerVariables("REQUEST_METHOD") = "POST" Then
    ' Müşteri ve depo bilgilerini döngü dışında bir kez al
    Dim musteri, depo
    musteri = Trim(Request.Form("musteri_1")) ' İlk satırdaki müşteri adını al
    depo = Trim(Request.Form("depo_1")) ' İlk satırdaki depo adını al

    ' Veritabanı bağlantısını başlat
    Set conn = Server.CreateObject("ADODB.Connection")
    conn.Open strConn

    ' Adet kadar döngü oluştur
    For i = 1 To Request.Form("satirSayisi")
        ' Form alanlarından gelen verileri al
        Dim modelno, firma, model, fiyat, sfiyat, adet, aciklama, kur, islemTarih, renk, beden

        modelno = Trim(Request.Form("modelno_" & i))
        firma = Trim(Request.Form("firma_" & i))
        model = Trim(Request.Form("model_" & i))
        fiyat = Trim(Request.Form("fiyat_" & i))
        sfiyat = Trim(Request.Form("sfiyat_" & i))

        ' Hata durumunda varsayılan değerler atayalım
        adet = 0
        beden = 0

        ' Değerleri sayıya dönüştürmeyi deneyelim
        On Error Resume Next
        adet = CInt(Trim(Request.Form("adet_" & i)))
        beden = CInt(Trim(Request.Form("beden_" & i)))
        Err.Clear ' Hatayı temizle
        On Error GoTo 0 ' Hata işlemeyi kapat

        aciklama = Trim(Request.Form("aciklama_" & i))
        kur = Trim(Request.Form("kur_" & i))
        renk = Trim(Request.Form("renk_" & i))

        ' Verileri kontrol et
        If modelno <> "" And firma <> "" And model <> "" And fiyat <> "" And sfiyat <> "" And beden > 0 Then  ' modelno, firma, model, fiyat, sfiyat kontrolü ve beden'in 0'dan büyük olduğundan emin ol

            ' Tarihi Access'in beklediği formata dönüştür
            Dim formattedDate
            islemTarih = Date() 'Sunucunun o anki tarihini al
            formattedDate = "#" & Month(islemTarih) & "/" & Day(islemTarih) & "/" & Year(islemTarih) & "#"

            ' Veritabanına ekleme sorgusu
            SQL = "INSERT INTO MAGA (modelno, firma, model, fiyat, sfiyat, adet, aciklama, kur, musteri, depo, islemTarih, renk, beden) VALUES ('" & Replace(modelno, "'", "''") & "', '" & Replace(firma, "'", "''") & "', '" & Replace(model, "'", "''") & "', " & fiyat & ", " & sfiyat & ", " & adet & ", '" & Replace(aciklama, "'", "''") & "', '" & Replace(kur, "'", "''") & "', '" & Replace(musteri, "'", "''") & "', '" & Replace(depo, "'", "''") & "', " & formattedDate & ", '" & Replace(renk, "'", "''") & "', " & beden & ")"
            conn.Execute SQL

            ' Kaynak depodaki adeti güncelle (Her zaman yapılacak)
            If adet > 0 Then ' Adet pozitifse düşür
                SQL = "UPDATE MAGA SET adet = adet - " & adet & " WHERE modelno = '" & Replace(modelno, "'", "''") & "' AND depo = 'Mağaza' AND beden = " & beden
                conn.Execute SQL
            ElseIf adet < 0 Then ' Adet negatifse arttır (mutlak değerini alarak arttır)
                SQL = "UPDATE MAGA SET adet = adet + " & Abs(adet) & " WHERE modelno = '" & Replace(modelno, "'", "''") & "' AND depo = 'Mağaza' AND beden = " & beden
                conn.Execute SQL
            End If
        End If
    Next ' satirSayisi döngüsü

    ' Veritabanı bağlantısını kapat
    conn.Close
    Set conn = Nothing
End If
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
        <p class="success-message">Kayıt başarıyla güncellendi.</p>
    </div>
    <script>
        setTimeout(function() { 
            window.location.href = '../magaza.html'; 
        }, 500);
    </script>
</body>
</html>