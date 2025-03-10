<%@ Language="VBScript" %>
<!-- #include file="aspuploader/include_aspuploader.asp" -->

<html lang="tr">
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
    <link
      rel="stylesheet" href="eresya/magaza-deneme/assets/js/snippets.js"
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
 <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
 <script>
  function sistemTarihiniYazdir() {
      var bugun = new Date();
      var gun = String(bugun.getDate()).padStart(2, '0');
      var ay = String(bugun.getMonth() + 1).padStart(2, '0'); // Aylar 0'dan başlar, +1 ekliyoruz.
      var yil = bugun.getFullYear();
      
      var tarihFormatli = gun + "/" + ay + "/" + yil;
      document.getElementById("tarihInput").value = tarihFormatli;
  }

  window.onload = sistemTarihiniYazdir; // Sayfa yüklendiğinde çalıştır.
</script>
 
 
 
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
	height: 50px;
	align: center;
	text-align: center;
}

.tdw {
text-align: center;
border: 1px solid #969595;
}

 /* Responsive Styles */
    @media (max-width: 768px) {
        .pad {
            padding: 10px;
        }

        table {
            width: 100% !important;
            /* Force full width */
            margin-bottom: 15px;
            /* Add some spacing */
        }

        th,
        td {
            display: block;
            width: 100%;
            box-sizing: border-box;
            text-align: left !important;
        }

        th {
            text-align: center !important;
            /* Center header text */
            background-color: #f2f2f2;
            /* Make headers stand out */
        }

        tr {
            margin-bottom: 10px;
            border: 1px solid #ddd;
        }

        input[type="text"],
        select,
        textarea { /* Textarea'yı da dahil et */
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
        textarea::placeholder { /* Textarea placeholder */
            color: #aaa;
        }
    }

	</style>
	
	

<script>
    document.addEventListener("DOMContentLoaded", function() {
        const kmInput = document.getElementById("kmInput");
        const fiyatInput = document.getElementById("fiyatInput");

        function calculateFiyat() {
            const kmValue = parseFloat(kmInput.value) || 0; // Eğer boşsa 0 olarak kabul et
            const masrafValue = parseFloat(masrafInput.value) || 0; // Eğer boşsa 0 olarak kabul et

            if (!isNaN(kmValue) && !isNaN(masrafValue)) {
                const fiyat = (kmValue * 3.5) + masrafValue;
                fiyatInput.value = fiyat.toFixed(0);
            } else {
                fiyatInput.value = ""; // Geçersiz giriş durumunda fiyatı temizle
            }
        }

        kmInput.addEventListener("input", calculateFiyat);
        masrafInput.addEventListener("input", calculateFiyat);
    });
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
						<h3> GİRİŞ EKRANI</h3>
					</td>
				</tr>
			</table>
		</div>
		</section>
		
					
 <section>
 <div class="demo pad" align="center">
	<%
	Dim uploader
	Set uploader=new AspUploader
	uploader.MultipleFilesUpload=true
	uploader.MaxSizeKB=10240
	uploader.InsertText="Resim Seç"
	uploader.SaveDirectory="savefiles"
	uploader.AllowedFileExtensions="*.jpg,*.png,*.gif,*.zip,*.heic"
	%>
	<%=uploader.GetString() %>
	
	<script type='text/javascript'>
	function CuteWebUI_AjaxUploader_OnTaskComplete(task)
	{
		var div=document.createElement("DIV");
		var link=document.createElement("A");
		link.setAttribute("href","savefiles/"+task.FileName);
		link.setAttribute("target","_blank");
		link.innerHTML="You have uploaded file: savefiles/"+task.FileName;
		div.appendChild(link);
		document.body.appendChild(div);

		// Input alanını yakala (name="resim" olan)
		var resimInput = document.querySelector('input[name="resim"]'); // ID yerine name ile yakalıyoruz

		// Eğer input alanı varsa, değeri yazdır
		if (resimInput) {
			resimInput.value = task.FileName;
		}
	}
	</script>
</div>
		<div class="pad">
		
			<form method="post" action="asp/harc_kaydet.asp">		
    <table align="center" width="100%" border="1">
        <tr>
            <td class="bg" align="right">
                <b>Tarih : </b> 
            </td>
            <td  style="background-color: #fff;">
                <input type="text" name="tarih" id="tarihInput" style="border:1px; width:100%; height:50px;" required />
            </td> 
            <td class="bg" align="right">
                <b>Firma :</b> 
            </td>
            <td >
                <input type="text" name="firma" id="firmaInput" value="SINEPTIC LTD ŞTİ" style="border:1px; width:100%; height:50px;"/>
            </td>                       
        </tr>
        <tr>
            <td  class="bg"align="right">
                <b>Departman : </b> 
            </td>
            <td >
                <input type="text" name="model" id="modelInput" placeholder="Departman Girin.." style="border:1px; width:100%; height:50px;"/>
            </td>    
            <td class="bg" align="right">
                <b>Sicil No :</b>  
            </td>
            <td >
                <input type="text" name="modelno" id="modelnoInput" placeholder="Sicil No Girin.." style="border:1px; width:100%; height:50px;" />
            </td>                        
        </tr>
        <tr>
            <td  class="bg"align="right">
                <b>Adı-Soyadı : </b> 
            </td>
            <td >
                <input type="text" name="musteri" id="musteriInput" placeholder="Ad-Soyad Girin.." style="border:1px; width:100%; height:50px;"/>
            </td>    
            <td class="bg" align="right">
                <b>KM :</b>  
            </td>
            <td>
                <input type="text" name="km" id="kmInput" placeholder="KM Girin.." style="border:1px; width:100%; height:50px;" />
            </td>                        
        </tr>  
        <tr>
            <td  class="bg"align="right">
                <b>Masraf : </b> 
            </td>
            <td >
                <input type="text" name="masraf" id="masrafInput" placeholder="Masraf Tutarı.." style="border:1px; width:100%; height:50px;"/>
            </td>   
            <td class="bg" align="right">
                <b>Tutar :</b>  
            </td>
            <td >
                <input type="text" name="fiyat" id="fiyatInput" placeholder="Toplam Tutar.." style="border:1px; width:100%; height:50px;" />
            </td>                        
        </tr>  
        <tr>
            <td colspan="2" align="right">
				<select name="fis" value="fis" id="fisInput" style="border:1px; width:100%; height:50px;" required >
				  <option value="" disabled selected>Fişi Var Mı?</option>
				  <option width="100" value="VAR"><b>VAR</b></option>
				  <option width="100" value="YOK"><b>YOK</b></option>
				</select>
            </td>  
            <td colspan="2" align="right">
				<select name="cinsi" value="cinsi" id="cinsiInput" style="border:1px; width:100%; height:50px;" required >
				  <option value="" disabled selected>Masraf Seçiniz</option>
				  <option width="100" value="ULAŞIM"><b>ULAŞIM</b></option>
				  <option width="100" value="TAKSİ"><b>TAKSİ</b></option>
				  <option width="100" value="YEMEK"><b>YEMEK</b></option>
				  <option width="100" value="OTOPARK"><b>OTOPARK</b></option>
				  <option width="100" value="DİĞER"><b>DİĞER</b></option>
				</select>
            </td>                       
        </tr>   
        <tr>
            <td colspan="4" align="right">
                <textarea type="text" name="aciklama" id="aciklamaInput" placeholder="Açıklama Girin.." style="border:1px; width:100%; height:50px;"></textarea>
            </td>                       
        </tr>   
        <tr>
            <td colspan="4" align="right">
				
			<input type="text" name="resim" id="resimInput" placeholder="Resim Adı.." style="border:1px; width:100%; height:50px;" />
			

			
			
			
			
			
     
			</td>                       
        </tr>                  
    </table>

    </td>
    </tr>
    <tr>
        <table align="center">
            <tr>				
                <td align="center" width="100">
                    <button class="btn">Kaydet</button>
                </td> 
            </tr>						
        </table>
    </tr>	
</form>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script>
$(document).ready(function() {
    // Müşteri alanına enter basıldığında (Ad veya Soyad için)
    $("#musteriInput").keypress(function(event) {
        if (event.which === 13) { // Enter tuşu
            event.preventDefault();
            let musteri = $(this).val().trim(); // Girilen müşteri adı/soyadı

            if (musteri !== "") {
                // getDataFromDB fonksiyonunu kullanarak musteri bilgisini çek
                getDataFromDB("musteri", musteri); 
            }
        }
    });

    // Model No alanına enter basıldığında
    $("#modelnoInput").keypress(function(event) {
        if (event.which === 13) { // Enter tuşu
            event.preventDefault();
            getDataFromDB("modelno", $(this).val().trim()); // getDataFromDB fonksiyonunu kullan
        }
    });

    // Veritabanından veri çekme fonksiyonu (Model No ve Müşteri için)
    function getDataFromDB(parametreAdi, parametreDegeri) {
        if (parametreDegeri !== "") {
            $.ajax({
                url: "asp/model_getir2.asp", // Verileri alacağımız ASP sayfası (ORTAK)
                method: "GET",
                data: {
                    parametre: parametreAdi, // modelno veya musteri
                    deger: parametreDegeri // Girilen değer
                },
                dataType: "json",
                success: function(response) {
                    if (response.success) {
                        // Verileri ilgili alanlara yaz
                        $("#modelInput").val(response.model);
                        $("#modelnoInput").val(response.modelno);
                        $("#musteriInput").val(response.musteri);
                    } else {
                        alert("Veri bulunamadı!");
                    }
                },
                error: function(xhr, status, error) {
                    alert("Sunucu hatası: " + xhr.responseText);
                }
            });
        }
    }
});
</script>
      
	   


		
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
