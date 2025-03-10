<%@LANGUAGE="VBSCRIPT" CODEPAGE="65001"%>
<%
Response.CharSet = "UTF-8"
%>

<!doctype html>
<html lang="en">
  <!--begin::Head-->
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title>CODIVA</title>
    <!--begin::Primary Meta Tags-->
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <meta name="title" content="AdminLTE v4 | Dashboard" />
    <meta name="author" content="ColorlibHQ" />
    <meta
      name="description"
      content="AdminLTE is a Free Bootstrap 5 Admin Dashboard, 30 example pages using Vanilla JS."
    />
    <meta
      name="keywords"
      content="bootstrap 5, bootstrap, bootstrap 5 admin dashboard, bootstrap 5 dashboard, bootstrap 5 charts, bootstrap 5 calendar, bootstrap 5 datepicker, bootstrap 5 tables, bootstrap 5 datatable, vanilla js datatable, colorlibhq, colorlibhq dashboard, colorlibhq admin dashboard"
    />
    <!--end::Primary Meta Tags-->
    <!--begin::Fonts-->
    <link
      rel="stylesheet"
      href="https://cdn.jsdelivr.net/npm/@fontsource/source-sans-3@5.0.12/index.css"
      integrity="sha256-tXJfXfp6Ewt1ilPzLDtQnJV4hclT9XuaZUKyUvmyr+Q="
      crossorigin="anonymous"
    />
    <!--end::Fonts-->
    <!--begin::Third Party Plugin(OverlayScrollbars)-->
    <link
      rel="stylesheet"
      href="https://cdn.jsdelivr.net/npm/overlayscrollbars@2.10.1/styles/overlayscrollbars.min.css"
      integrity="sha256-tZHrRjVqNSRyWg2wbppGnT833E/Ys0DHWGwT04GiqQg="
      crossorigin="anonymous"
    />
    <!--end::Third Party Plugin(OverlayScrollbars)-->
    <!--begin::Third Party Plugin(Bootstrap Icons)-->
    <link
      rel="stylesheet"
      href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css"
      integrity="sha256-9kPW/n5nn53j4WMRYAxe9c1rCY96Oogo/MKSVdKzPmI="
      crossorigin="anonymous"
    />
    <!--end::Third Party Plugin(Bootstrap Icons)-->
    <!--begin::Required Plugin(AdminLTE)-->
    <link rel="stylesheet" href="../../dist/css/adminlte.css" />
    <!--end::Required Plugin(AdminLTE)-->
    <!-- apexcharts -->
    <link
      rel="stylesheet"
      href="https://cdn.jsdelivr.net/npm/apexcharts@3.37.1/dist/apexcharts.css"
      integrity="sha256-4MX+61mt9NVvvuPjUWdUdyfZfxSB1/Rf9WtqRHgG5S0="
      crossorigin="anonymous"
    />
    <!-- jsvectormap -->
    <link
      rel="stylesheet"
      href="https://cdn.jsdelivr.net/npm/jsvectormap@1.5.3/dist/css/jsvectormap.min.css"
      integrity="sha256-+uGLJmmTKOqBr+2E6KDYs/NRsHxSkONXFHUL0fy2O/4="
      crossorigin="anonymous"
    />
 <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
<script>
        document.addEventListener("DOMContentLoaded", function() {
            // Hedef element
            const headerContainer = document.getElementById("header-container");

            // header.html dosyasını yükle
            fetch("menu.html")
                .then(response => {
                    if (!response.ok) {
                        throw new Error("Header yüklenemedi!");
                    }
                    return response.text();
                })
                .then(data => {
                    headerContainer.innerHTML = data;
                })
                .catch(error => {
                    console.error("Hata:", error);
                });
        });
    </script>

<script language="JavaScript">
  function updateKontrol(id, checkbox) {
   var kontrol = checkbox.checked ? 1 : 0;
   window.location.href = "harcirah_onay.asp?id=" + id + "&kontrol=" + kontrol;
  }
 </script> 
 
  
  
 

<style>
	.bg, th {
	background-color: #b5bdbd;
	color: #000;
	height: 10px;
	border: 1px solid;
	
}
.btn {
	background-color: #007bff;
	color: #fff;
	border: none;
	cursor: pointer;
	border-radius: 4px;
	text-decoration:none;
	width: 140px;
	height: 30px;
	align: center;
	margin-bottom: 50px;
}

.tdw {
text-align: center;
align: center;
border: 1px solid #000;
}

.selected-row {
    background-color: #93fac5;/* Arama zemin rengi */
    color: black; /* Yazı rengini beyaz yapar */
}

  .checkedRow {
   background-color: #93fac5;
   color: black;
  }
 .separatorRow{
   background-color: #16b2fa;
   color: white;
  }
  
  
  
  
 /* Responsive Styles */
@media (max-width: 768px) {
    .pad {
        padding: 0px;
    }

    table {
        width: 100% !important;
        /* Force full width */
        margin-bottom: 15px;
        /* Add some spacing */
        border-spacing: 0 55px; /* Satırlar arasına 55px boşluk ekler */
        border-collapse: separate; /* border-spacing'in etkili olması için */
    }

    th,
    td {
        display: block;
        width: 100%;
        box-sizing: border-box;
        text-align: center !important;
        border: none !important; /* Hücrelerdeki kenarlıkları kaldır */
    }

    th {
        text-align: center !important;
        /* Center header text */
        background-color: #f2f2f2;
        /* Make headers stand out */
    }

    tr {
        margin-bottom: 0; /* Önceki margin-bottom'ı kaldır */
        border: 1px solid #ddd;
        display: block; /*tr'leri de block yaparsak border düzgün gözükür */
        margin-bottom: 20px; /* İsteğe bağlı: Satırlar arasına ek bir boşluk */

    }

    input[type="text"],
    select,
    textarea {
        /* Textarea'yı da dahil et */
        width: 100%;
        padding: 8px;
        box-sizing: border-box;
        margin-bottom: 5px;
        height: auto !important;
        display: block;
    }

    .btn {
        width: 100%;
        padding: 10px;
        box-sizing: border-box;
    }

    /* Optional: Hide labels and use placeholders */
    .bg {
        display: none;
    }

    input[type="text"]::placeholder,
    textarea::placeholder {
        /* Textarea placeholder */
        color: #aaa;
    }

}

</style>
	
<script>
async function filtrele() {
    // Arama çubuğundaki değeri al
    const searchTerm = document.getElementById("searchInput").value;

    try {
        // ASP dosyasına sorgu gönder
        const response = await fetch(`asp/arama_magaza.asp?searchTerm=${encodeURIComponent(searchTerm)}`);
        if (!response.ok) {
            throw new Error(`HTTP Hatası! Durum: ${response.status}`);
        }

        const data = await response.json();

        // Tabloyu güncelle
        const tableBody = document.getElementById("eraTableBody");
        tableBody.innerHTML = ""; // Mevcut sonuçları temizle

        let toplamFiyat = 0; // Toplam fiyat için değişken
        let toplamFiyatKontrol1 = 0; // Kontrol=1 olanların toplam fiyatı için değişken

        if (data.length > 0) {
            data.forEach(row => {
                const tr = document.createElement("tr");

                // Fiyat kontrolü (örneğin, negatif fiyatları işaretlemek için)
                let fiyatStili = "";
                if (parseFloat(row.fiyat) < 0) {
                    fiyatStili = "style='background-color: #93fac5; color: black;'"; // Veya istediğiniz stil
                }

                // Kontrol değerine göre satır stili ve ikon
                let kontrolStili = "";
                let kontrolIcon = "";
                if (row.kontrol == 0) {
                    kontrolStili = "background-color: #b31307; color: white;";
                    kontrolIcon = '<i class="bi bi-hand-thumbs-down"></i>';
                } else if (row.kontrol == 1) {
                    kontrolStili = "background-color: #93fac5; color: black;";
                    kontrolIcon = '<i class="bi bi-hand-thumbs-up"></i>';
                }

                tr.style = kontrolStili; // Satırın stilini ayarla

                tr.innerHTML = `
                <td class="tdw" style="${fiyatStili}">${row.resim}</td>
                <td class="tdw" style="${fiyatStili}">${row.cinsi}</td>
                <td class="tdw" style="${fiyatStili}">${row.tarih}</td>
                <td class="tdw" style="${fiyatStili}">${row.firma}</td>
                <td class="tdw" style="${fiyatStili}">${row.model}</td>
                <td class="tdw" style="${fiyatStili}">${row.modelno}</td>
                <td class="tdw" style="${fiyatStili}">${row.km}</td>
                <td class="tdw" style="${fiyatStili}">${row.fiyat}</td>
                <td class="tdw" style="${fiyatStili}">${row.musteri}</td>
                <td class="tdw" style="${fiyatStili}">${row.aciklama}</td>
                <td class="tdw" style="${fiyatStili}">${row.fis}</td>
                <td class="tdw" style="${fiyatStili}">${kontrolIcon}</td>
                `;
                tableBody.appendChild(tr);

                // Toplam fiyatı güncelle
                toplamFiyat += parseFloat(row.fiyat);

                // Kontrol=1 ise toplam fiyatı güncelle
                if (row.kontrol == 1) {
                    toplamFiyatKontrol1 += parseFloat(row.fiyat);
                }
            });

            // Toplam satırını ekle
            const toplamSatir = document.createElement("tr");
            toplamSatir.innerHTML = `
                <td  class="separatorRow" colspan="8" align="right"><b>Toplam Tutar : ${toplamFiyat.toFixed(2)} ₺</b></td>
                <td  class="separatorRow" colspan="4" align="right"><b>Onaylanmış Tutar : ${toplamFiyatKontrol1.toFixed(2)} ₺</b></td>
            `;
            tableBody.appendChild(toplamSatir);

        } else {
            tableBody.innerHTML = "<tr><td colspan='20'>Sonuç bulunamadı.</td></tr>";
        }
    } catch (error) {
        console.error("Hata:", error);
    }
}
</script>
 

  
  
  
  </head> 
  <!--end::Head-->
  <!--begin::Body-->
  <body class="layout-fixed sidebar-expand-lg bg-body-tertiary">
    <!--begin::App Wrapper-->
    <div class="app-wrapper">
      <!--begin::Header-->
      <nav class="app-header navbar navbar-expand bg-body">
        <!--begin::Container-->
        <div class="container-fluid">
          <!--begin::Start Navbar Links-->
          <ul class="navbar-nav">
            <li class="nav-item">
              <a class="nav-link" data-lte-toggle="sidebar" href="#" role="button">
                <i class="bi bi-list"></i>
              </a>
            </li>
            <li class="nav-item d-none d-md-block"><a href="#" class="nav-link">Menu</a></li>
          </ul>
          <!--end::Start Navbar Links-->
          <!--begin::End Navbar Links-->
          <ul class="navbar-nav ms-auto">
            <!--begin::Fullscreen Toggle-->
            <li class="nav-item">
              <a class="nav-link" href="#" data-lte-toggle="fullscreen">
                <i data-lte-icon="maximize" class="bi bi-arrows-fullscreen"></i>
                <i data-lte-icon="minimize" class="bi bi-fullscreen-exit" style="display: none"></i>
              </a>
            </li>
            <!--end::Fullscreen Toggle-->
            <!--begin::User Menu Dropdown-->
            <li class="nav-item dropdown user-menu">
              <a href="#" class="nav-link dropdown-toggle" data-bs-toggle="dropdown">
                <img
                  src="../../dist/assets/img/avatar3.png"
                  class="user-image rounded-circle shadow"
                  alt="User Image"
                />
                <span class="d-none d-md-inline">Yönetici</span>
              </a>
            </li>
            <!--end::User Menu Dropdown-->
          </ul>
          <!--end::End Navbar Links-->
        </div>
        <!--end::Container-->
      </nav>
      <!--end::Header-->
      <!--begin::Sidebar-->
      <aside class="app-sidebar bg-body-secondary shadow" data-bs-theme="dark">
        <!--begin::Sidebar Brand-->
        <div class="sidebar-brand">
          <!--begin::Brand Link-->
          <a href="./main.asp" class="brand-link">
            <!--begin::Brand Image-->
            <img
              src="../../dist/pages/img/logok.png"
			  width="200"
			  height="100"
              class="brand-image opacity-75 shadow"
            />
          </a>
          <!--end::Brand Link-->
        </div>
        <!--end::Sidebar Brand-->
        <!--begin::Sidebar Wrapper-->
        <div class="sidebar-wrapper">
           <!--begin::MENU-->
        <div class="sidebar-wrapper">
		
			<div id="header-container"></div>   
		</div>
        <!--end::MENU-->
        </div>
        <!--end::Sidebar Wrapper-->
      </aside>
      <!--end::Sidebar-->
      <!--begin::App Main-->
      <main class="app-main">
       
	  
	  
	  
			
		  
	   <section align="center">
		<div>
			<table align="center" class="container" border="0">
				<tr>
					<td align="center" border="0">
					<br>
						<h3> HARCİRAH EKRANI</h3>
					</td>
				</tr>
			</table>
		</div>
	  </section>
		
	
		
	<section style="width:100%;">	
		<div class="pad">	
			<table align="center" id="dataTable" style="width: 100%; border: 1px solid;" border="1">
				<colgroup>
					<col style="width: 100px;">
					<col style="width: 150px;">
					<col style="width: 120px;">
					<!-- Diğer sütun genişliklerini tanımlayın -->
				</colgroup>
				<thead>
				<tr>
					<td colspan="16" align="center">
						<form class="form-inline my-2 my-lg-0" onsubmit="event.preventDefault(); filtrele();">
							<input class="form-control mr-sm-2" id="searchInput" type="search" placeholder="Cinsi, Soyad yada Sicil No ile arama yapın..." aria-label="Search" style="width: 100%; height: 50px;">
							<button class="btn btn-outline-success my-4 my-sm-0" type="button" onclick="window.location.href='harcirah_onay.asp'">Temizle</button>
							<button class="btn btn-outline-success my-2 my-sm-0" type="submit">Ara</button>
						</form><br>
					</td>
				</tr>
					<tr>
							<th class="tdw bg">Resim</th>
							<th class="tdw bg">M.Cinsi</th>
							<th class="tdw bg">Tarih</th>
							<th class="tdw bg">Firma</th>
							<th class="tdw bg">Departman</th>
							<th class="tdw bg">Sicil No</th>
							<th class="tdw bg">KM</th>
							<th class="tdw bg">Tutar</th>
							<th class="tdw bg">Ad-Soyad</th>
							<th class="tdw bg">Açıklama</th>
							<th class="tdw bg">Fiş</th>
							<th class="tdw bg">Kontrol</th>
					</tr>
				</thead>
				<tbody id="eraTableBody">

    <%
    ' Veritabanı bağlantısı
    Dim conn, rs, SQL, id, kontrol, toplamTutar, oncekiTarih

    Set conn = Server.CreateObject("ADODB.Connection")
    conn.Open "Provider=Microsoft.Jet.OLEDB.4.0;Data Source=" & Server.MapPath("/db/harc.mdb")

    ' Kontrol güncelleme işlemi
    id = Request.QueryString("id")
    kontrol = Request.QueryString("kontrol")

    If id <> "" And kontrol <> "" Then
     SQL = "UPDATE HARC SET kontrol = " & kontrol & " WHERE id = " & id
     conn.Execute SQL
    End If

    ' Verileri çekme (Son kayıt en üstte olacak şekilde)
    SQL = "SELECT * FROM HARC ORDER BY tarih DESC, id DESC"
    Set rs = conn.Execute(SQL)

    ' Değişkenleri sıfırla
    toplamTutar = 0
    oncekiTarih = ""

    ' Verileri listeleme
    If Not rs.EOF Then
     Do While Not rs.EOF

      ' Tarih değiştiyse ayırıcı satır ekle
      If rs("tarih") <> oncekiTarih And oncekiTarih <> "" Then
       %>
       <tr class="separatorRow">
        <td colspan="3" align="center"><b> <%=oncekiTarih%></b></td>
        <td colspan="4" align="center"><b>Toplam Tutar:</b></td>
        <td><b><%=toplamTutar%> ₺</b></td>
        <td colspan="5"></td>
       </tr>
       <%
       toplamTutar = 0 ' Toplamı sıfırla
      End If

      ' Satır sınıfını belirleme (kontrol alanına göre)
      Dim rowClass
      If rs("kontrol") = 1 Then
       rowClass = "checkedRow"
      Else
       rowClass = ""
      End If

      %>
      <tr class="<%=rowClass%>">
       <td class="tdw">
<%
' "art" sütunu ile dosya ismi eşleşmesi kontrolü
Dim resimName, imageName, foundImage
artName = rs("resim")
foundImage = False

For Each imageName In imageFiles
	If LCase(imageName) = LCase(artName & ".jpg") Then ' Dosya uzantısına dikkat edin
		Response.Write "<img src='savefiles/" & imageName & "' alt='" & imageName & "' width='50' height='50' onclick='openModal(""" & imageName & """)'>"
		foundImage = True
		Exit For
	End If
Next

If Not foundImage Then
	Response.Write "Resim Yok"
End If
%>
	   </td>
       <td class="tdw"><%=rs("cinsi")%></td>
       <td class="tdw"><%=rs("tarih")%></td>
       <td class="tdw"><%=rs("firma")%></td>
       <td class="tdw"><%=rs("model")%></td>
       <td class="tdw"><%=rs("modelno")%></td>
       <td class="tdw"><%=rs("km")%></td>
       <td class="tdw"><%=rs("fiyat")%></td>
       <td class="tdw"><%=rs("musteri")%></td>
       <td class="tdw"><%=rs("aciklama")%></td>
       <td class="tdw"><%=rs("fis")%></td>
       <td class="tdw">
        <input type="checkbox" name="kontrol_<%=rs("id")%>" value="1" <%If rs("kontrol") = 1 Then Response.Write("checked")%> onclick="updateKontrol(<%=rs("id")%>, this)">
       </td>
      </tr>  
		<tr>
				<th colspan="12" class="tdw bg"> </th>
		</tr>
   <%
      ' Toplamı güncelle
      toplamTutar = toplamTutar + CDbl(rs("fiyat"))

      ' Önceki tarihi güncelle
      oncekiTarih = rs("tarih")

      rs.MoveNext
     Loop

     ' Son tarih için ayırıcı satır ekle
     %>
     <tr class="separatorRow">
        <td colspan="3" align="center"><b><%=oncekiTarih%></b></td>
        <td colspan="4" align="center"><b> Toplam Tutar:</b></td>
        <td><b><%=toplamTutar%> ₺</b></td>
        <td colspan="5"></td>
       </tr>
     <%

    Else
     Response.Write("<tr><td colspan='10'>Kayıt bulunamadı.</td></tr>")
    End If

    ' Bağlantıyı kapatma
    rs.Close
    Set rs = Nothing
    conn.Close
    Set conn = Nothing
   %>

  </tbody>
 </table>
			</table>	
		</div>
	</section>
			
			
			
			
			
			
			
		
      </main>
      <!--end::App Main-->
      <!--begin::Footer-->
      <footer class="app-footer">
       
        <!--begin::Copyright-->
        <strong>
          Copyright &copy;2024&nbsp;
          <a href="#" class="text-decoration-none">CODIVA</a>.
        </strong>
        All rights reserved.
        <!--end::Copyright-->
      </footer>
      <!--end::Footer-->
    </div>
    <!--end::App Wrapper-->
    <!--begin::Script-->
    <!--begin::Third Party Plugin(OverlayScrollbars)-->
    <script
      src="https://cdn.jsdelivr.net/npm/overlayscrollbars@2.10.1/browser/overlayscrollbars.browser.es6.min.js"
      integrity="sha256-dghWARbRe2eLlIJ56wNB+b760ywulqK3DzZYEpsg2fQ="
      crossorigin="anonymous"
    ></script>
    <!--end::Third Party Plugin(OverlayScrollbars)--><!--begin::Required Plugin(popperjs for Bootstrap 5)-->
    <script
      src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.8/dist/umd/popper.min.js"
      integrity="sha384-I7E8VVD/ismYTF4hNIPjVp/Zjvgyol6VFvRkX/vR+Vc4jQkC+hVqc2pM8ODewa9r"
      crossorigin="anonymous"
    ></script>
    <!--end::Required Plugin(popperjs for Bootstrap 5)--><!--begin::Required Plugin(Bootstrap 5)-->
    <script
      src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.min.js"
      integrity="sha384-0pUGZvbkm6XF6gxjEnlmuGrJXVbNuzT9qBBavbLwCsOGabYfZo0T0to5eqruptLy"
      crossorigin="anonymous"
    ></script>
    <!--end::Required Plugin(Bootstrap 5)--><!--begin::Required Plugin(AdminLTE)-->
    <script src="../../dist/js/adminlte.js"></script>
    <!--end::Required Plugin(AdminLTE)--><!--begin::OverlayScrollbars Configure-->
    <script>
      const SELECTOR_SIDEBAR_WRAPPER = '.sidebar-wrapper';
      const Default = {
        scrollbarTheme: 'os-theme-light',
        scrollbarAutoHide: 'leave',
        scrollbarClickScroll: true,
      };
      document.addEventListener('DOMContentLoaded', function () {
        const sidebarWrapper = document.querySelector(SELECTOR_SIDEBAR_WRAPPER);
        if (sidebarWrapper && typeof OverlayScrollbarsGlobal?.OverlayScrollbars !== 'undefined') {
          OverlayScrollbarsGlobal.OverlayScrollbars(sidebarWrapper, {
            scrollbars: {
              theme: Default.scrollbarTheme,
              autoHide: Default.scrollbarAutoHide,
              clickScroll: Default.scrollbarClickScroll,
            },
          });
        }
      });
    </script>
    <!--end::OverlayScrollbars Configure-->
    <!-- OPTIONAL SCRIPTS -->
    <!-- apexcharts -->
    <script
      src="https://cdn.jsdelivr.net/npm/apexcharts@3.37.1/dist/apexcharts.min.js"
      integrity="sha256-+vh8GkaU7C9/wbSLIcwq82tQ2wTf44aOHA8HlBMwRI8="
      crossorigin="anonymous">
	</script>
    
    <!--end::Script-->
  </body>
  <!--end::Body-->
</html>
   