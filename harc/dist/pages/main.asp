
<%@LANGUAGE="VBSCRIPT" CODEPAGE="65001"%>
<!-- #include file="asp/kontrol.asp" -->
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


  
  
  
  
  
  
  
  
<script>
    fetch("asp/api5.asp")
        .then(response => response.json())
        .then(data => {
            const salesSummary = document.getElementById("eraTableBody5"); // Yıllık toplam satış fiyatını gösterecek etiket
            let totalSales = 0; // Tüm yıllara ait toplam satış fiyatı

            // Verileri döngüyle işleme
            data.forEach(row => {
                totalSales += parseFloat(row.fiyat) || 0; // Satış fiyatlarını toplama ekle
            });

            // Toplam satış fiyatını yazdır
            salesSummary.innerHTML = `${totalSales.toFixed(0).replace(/\B(?=(\d{3})+(?!\d))/g, ".")}₺`;

            // Toplam satış adedini yazdır
            salesQuantitySummary.innerHTML = `${totalQuantity.toFixed(0)} Adet `;
        })
        .catch(error => console.error("Hata:", error));
</script>




  
  
  
  
  
  
  <script>
    document.addEventListener("DOMContentLoaded", function () {
        fetch("asp/api5y.asp")
            .then(response => response.json())
            .then(data => {
                const salesSummary = document.getElementById("eraTableBody2"); // H3 etiketi
                let totalSales = 0; // Geçen yılın toplam satış fiyatı

                // Verileri döngüyle işleme
                data.forEach(row => {
                    // Fiyat verisindeki formatı kontrol et
                    let price = row.fiyat.replace(",", ".").trim(); // Virgül yerine nokta ve boşlukları temizle

                    // Sayıya çevirmeden önce kontrol et
                    if (!isNaN(price)) {
                        // Sayıyı parse et
                        price = parseFloat(price);

                        // Geçerli veriyi toplama ekle
                        totalSales += price;
                    }
                });

                // Yıllık toplam satış fiyatını yazdır (Geçen Yıl)
                salesSummary.innerHTML = `${totalSales.toFixed(0).replace(/\B(?=(\d{3})+(?!\d))/g, ".")}₺`;

            })
            .catch(error => console.error("Hata:", error));
    });
</script>


  
  
  
  
  
  <script>
    document.addEventListener("DOMContentLoaded", function () {
        fetch("asp/api5a.asp")
            .then(response => response.json())
            .then(data => {
                const salesSummary = document.getElementById("eraTableBody3"); // H3 etiketi
                let totalSales = 0; // Geçen ayın toplam satış fiyatı
                const salesQuantitySummary = document.getElementById("salesQuantitySummary");

                // Verileri döngüyle işleme
                data.forEach(row => {
                    // Fiyat verisindeki formatı kontrol et
                    let price = row.fiyat.replace(",", ".").trim(); // Virgül yerine nokta ve boşlukları temizle

                    // Sayıya çevirmeden önce kontrol et
                    if (!isNaN(price)) {
                        // Sayıyı parse et
                        price = parseFloat(price);

                        // Geçerli veriyi toplama ekle
                        totalSales += price;
                    }
                });

                // Yıllık toplam satış fiyatını yazdır (Geçen Ay)
                salesSummary.innerHTML = `${totalSales.toFixed(0).replace(/\B(?=(\d{3})+(?!\d))/g, ".")}₺`;
                // Yıllık toplam satış adedini yazdır (Geçen Ay)
                salesQuantitySummary.innerHTML = `₺`;

            })
            .catch(error => console.error("Hata:", error));
    });
</script>


  
 <script>
    document.addEventListener("DOMContentLoaded", function () {
        fetch("asp/api5g.asp")
            .then(response => response.json())
            .then(data => {
                const salesSummary = document.getElementById("eraTableBody4"); // H3 etiketi (Günlük Satış Fiyatı)
                const salesQuantity = document.getElementById("salesQuantity"); // P etiketi (Bekleyen Onay Adedi)
                let totalSales = 0; // Toplam satış fiyatı
                let adetSayisi = 0; // Kontrolü 0 olanların adedi

                // Verileri döngüyle işleme
                data.forEach(row => {
                    // Fiyat verisindeki formatı kontrol et
                    let price = row.fiyat.replace(",", ".").trim(); // Virgül yerine nokta ve boşlukları temizle

                    // Sayıya çevirmeden önce kontrol et
                    if (!isNaN(price)) {
                        // Sayıyı parse et
                        price = parseFloat(price);

                        // Geçerli veriyi toplama ekle
                        totalSales += price;
                    }

                    // Kontrol sütununu kontrol et
                    if (row.kontrol === "0") {
                        adetSayisi++;
                    }
                });

                // Toplam satış fiyatını yazdır
                salesSummary.innerHTML = `${totalSales.toFixed(0).replace(/\B(?=(\d{3})+(?!\d))/g, ".")}₺`;
                salesQuantity.innerHTML = `${adetSayisi} Adet`;

            })
            .catch(error => console.error("Hata:", error));
    });
</script>
<style>
        /* Yukarıdaki CSS kodunu buraya ekleyin */
        #eraTableBody2 {
            padding: 20px;
            text-align: center;
            font-size: 56px;
        }

        /* Telefonlar için (ekran genişliği 768px'den küçük olduğunda) */
        @media (max-width: 768px) {
            #eraTableBody2 {
                font-size: 28px; /* Yazı boyutunu yarıya indir */
                padding: 10px; /* Padding'i de orantılı olarak azalt */
            }
        }
        /* Yukarıdaki CSS kodunu buraya ekleyin */
        #eraTableBody3 {
            padding: 20px;
            text-align: center;
            font-size: 56px;
        }

        /* Telefonlar için (ekran genişliği 768px'den küçük olduğunda) */
        @media (max-width: 768px) {
            #eraTableBody3 {
                font-size: 28px; /* Yazı boyutunu yarıya indir */
                padding: 10px; /* Padding'i de orantılı olarak azalt */
            }
        }
        /* Yukarıdaki CSS kodunu buraya ekleyin */
        #eraTableBody5 {
            padding: 20px;
            text-align: center;
            font-size: 56px;
        }

        /* Telefonlar için (ekran genişliği 768px'den küçük olduğunda) */
        @media (max-width: 768px) {
            #eraTableBody5 {
                font-size: 28px; /* Yazı boyutunu yarıya indir */
                padding: 10px; /* Padding'i de orantılı olarak azalt */
            }
        }
    </style>
  </head> 
  <!--end::Head-->
  <!--begin::Body-->
  <body class="layout-fixed sidebar-expand-lg bg-body-tertiary">
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
            <!--begin::Fullscreen Toggle-->
            <li class="nav-item">
              <a class="nav-link" href="#" data-lte-toggle="fullscreen">
                <i data-lte-icon="maximize" class="bi bi-arrows-fullscreen"></i>
                <i data-lte-icon="minimize" class="bi bi-fullscreen-exit" style="display: none"></i>
              </a>
            </li>
            <!--end::Fullscreen Toggle-->
            <!--begin::User Menu Dropdown-->
            
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
        <!--begin::MENU-->
        <div class="sidebar-wrapper">
		
			<div id="header-container"></div>   
		</div>
        <!--end::MENU-->
      </aside>
      <!--end::Sidebar-->
      <!--begin::App Main-->
      <main class="app-main">
   	  
        <!--begin::App Content Header-->
        <div class="app-content-header">
          <!--begin::Container-->
          <div class="container-fluid">
            <!--begin::Row-->
            <div class="row">
              <div class="col-sm-6">
                    <h3>Dashboard</h3>
					</div>
            </div>
            <!--end::Row-->
          </div>
          <!--end::Container-->
        </div>
        <!--end::App Content Header-->
        <!--begin::App Content-->
        <div class="app-content">
          <!--begin::Container-->
          <div class="container-fluid">
            <!--begin::Row-->
            <div class="row">
              <!--begin::Col-->
              <div class="col-lg-3 col-6">
                <!--begin::Small Box Widget 1-->
                <div class="small-box text-bg-primary">
                  <div class="inner">
                    <h3 id="eraTableBody4"></h3>
                    <h6>Beklenen Onay</h6><h5  id="salesQuantity"></h5>
                  </div>
                  <svg
                    class="small-box-icon"
                    fill="currentColor"
                    viewBox="0 0 24 24"
                    xmlns="http://www.w3.org/2000/svg"
                    aria-hidden="true">
                    <path
                      d="M2.25 2.25a.75.75 0 000 1.5h1.386c.17 0 .318.114.362.278l2.558 9.592a3.752 3.752 0 00-2.806 3.63c0 .414.336.75.75.75h15.75a.75.75 0 000-1.5H5.378A2.25 2.25 0 017.5 15h11.218a.75.75 0 00.674-.421 60.358 60.358 0 002.96-7.228.75.75 0 00-.525-.965A60.864 60.864 0 005.68 4.509l-.232-.867A1.875 1.875 0 003.636 2.25H2.25zM3.75 20.25a1.5 1.5 0 113 0 1.5 1.5 0 01-3 0zM16.5 20.25a1.5 1.5 0 113 0 1.5 1.5 0 01-3 0z">
					</path>
                  </svg>
                  <a
                    href="harcirah_onay.asp"
                    class="small-box-footer link-light link-underline-opacity-0 link-underline-opacity-50-hover">
                    Günlük Satış <i class="bi bi-link-45deg"></i>
					
                  </a>
                </div>
                <!--end::Small Box Widget 1-->
              </div>
              <!--end::Col-->
              <div class="col-lg-3 col-6">
                <!--begin::Small Box Widget 2-->
                <div class="small-box text-bg-success">
                  <div class="inner">
                    <h3 id="eraTableBody3"></h3>
                  </div>
                  <svg
                    class="small-box-icon"
                    fill="currentColor"
                    viewBox="0 0 24 24"
                    xmlns="http://www.w3.org/2000/svg"
                    aria-hidden="true">
                    <path
                      d="M18.375 2.25c-1.035 0-1.875.84-1.875 1.875v15.75c0 1.035.84 1.875 1.875 1.875h.75c1.035 0 1.875-.84 1.875-1.875V4.125c0-1.036-.84-1.875-1.875-1.875h-.75zM9.75 8.625c0-1.036.84-1.875 1.875-1.875h.75c1.036 0 1.875.84 1.875 1.875v11.25c0 1.035-.84 1.875-1.875 1.875h-.75a1.875 1.875 0 01-1.875-1.875V8.625zM3 13.125c0-1.036.84-1.875 1.875-1.875h.75c1.036 0 1.875.84 1.875 1.875v6.75c0 1.035-.84 1.875-1.875 1.875h-.75A1.875 1.875 0 013 19.875v-6.75z"
                    ></path>
                  </svg>
                  <a
                    href="#"
                    class="small-box-footer link-light link-underline-opacity-0 link-underline-opacity-50-hover">
                    Önceki Ay <i class="bi bi-link-45deg"></i>
                  </a>
                </div>
                <!--end::Small Box Widget 2-->
              </div>
              <!--end::Col-->
              <div class="col-lg-3 col-6">
                <!--begin::Small Box Widget 3-->
                <div class="small-box text-bg-warning">
                  <div class="inner">
                    <h3 id="eraTableBody2"></h3>
                  </div>
                  <svg
                    class="small-box-icon"
                    fill="currentColor"
                    viewBox="0 0 24 24"
                    xmlns="http://www.w3.org/2000/svg"
                    aria-hidden="true">
                    <path
                      d="M6.25 6.375a4.125 4.125 0 118.25 0 4.125 4.125 0 01-8.25 0zM3.25 19.125a7.125 7.125 0 0114.25 0v.003l-.001.119a.75.75 0 01-.363.63 13.067 13.067 0 01-6.761 1.873c-2.472 0-4.786-.684-6.76-1.873a.75.75 0 01-.364-.63l-.001-.122zM19.75 7.5a.75.75 0 00-1.5 0v2.25H16a.75.75 0 000 1.5h2.25v2.25a.75.75 0 001.5 0v-2.25H22a.75.75 0 000-1.5h-2.25V7.5z"
                    ></path>
                  </svg>
                  <a
                    href="#"
                    class="small-box-footer link-dark link-underline-opacity-0 link-underline-opacity-50-hover">
                    Önceki Yıl <i class="bi bi-link-45deg"></i>
                  </a>
                </div>
                <!--end::Small Box Widget 3-->
              </div>
              <!--end::Col-->
              <div class="col-lg-3 col-6">
                <!--begin::Small Box Widget 4-->
                <div class="small-box text-bg-danger">
                  <div class="inner">
                    <h3 id="eraTableBody5"></h3>
                  </div>
                  <svg
                    class="small-box-icon"
                    fill="currentColor"
                    viewBox="0 0 24 24"
                    xmlns="http://www.w3.org/2000/svg"
                    aria-hidden="true">
                    <path
                      clip-rule="evenodd"
                      fill-rule="evenodd"
                      d="M2.25 13.5a8.25 8.25 0 018.25-8.25.75.75 0 01.75.75v6.75H18a.75.75 0 01.75.75 8.25 8.25 0 01-16.5 0z">
					</path>
                    <path
                      clip-rule="evenodd"
                      fill-rule="evenodd"
                      d="M12.75 3a.75.75 0 01.75-.75 8.25 8.25 0 018.25 8.25.75.75 0 01-.75.75h-7.5a.75.75 0 01-.75-.75V3z"
                    ></path>
                  </svg>
                  <a
                    href="#"
                    class="small-box-footer link-light link-underline-opacity-0 link-underline-opacity-50-hover">
                    KASA <i class="bi bi-link-45deg"></i>
                  </a>
                </div>
                <!--end::Small Box Widget 4-->
              </div>
              <!--end::Col-->
            </div>
            <!--end::Row-->
			<!-- /.bar-start -->
			  <div class="card-body">
    <!--begin::Row-->
    <div class="row">
        <canvas class="col-md-2 progress-group" id="bar" style="height: 400px; width: 100%;"></canvas>
        <script>
            var ctx = document.getElementById('bar').getContext('2d');

            // JSON verilerini çek
            fetch('asp/kasaciro.asp')
                .then(response => response.json())
                .then(data => {
                    // Veriler
                    var salesData = data.ciroData;
                    var labels = data.aylar;

                    // Satış renklerini belirle
                    var colors = salesData.map(function(value) {
                        if (value > 40000) {
                            return 'red'; // 150,000 TL'nin altı
                        } else if (value <= 40000 && value >= 25000) {
                            return 'orange'; // 150,000-250,000 TL arası
                        } else {
                            return 'green'; // 250,000 TL'nin üstü
                        }
                    });

                    // Grafiği oluştur
                    new Chart(ctx, {
                        type: 'bar',
                        data: {
                            labels: labels,
                            datasets: [{
                                label: 'TL',
                                backgroundColor: colors,
                                borderColor: 'green',
                                data: salesData
                            }]
                        },
                        options: {
                            plugins: {
                                legend: {
                                    display: false // Açıklama ve kutuyu kaldırır
                                }
                            },
                            responsive: true, // Grafiğin kapsayıcıya göre boyutlanmasını sağlar
                            maintainAspectRatio: false // En-boy oranını koruma özelliğini kapatır
                        }
                    });
                })
                .catch(error => console.error('Veri yüklenemedi:', error));
        </script>
    </div>
    <p class="text-center"><strong>Yıllık Satış Grafiği</strong></p>
    <!-- /.col -->
</div>
				
	<div class="card mb-2">
	  <div class="card-header">
		<h3 class="card-title">Masraf Dağılımı</h3>
	  </div>
	  <!-- /.card-header -->
	  <div class="card-body">
		<!--begin::Row-->
		<div class="row">
		<div id="pie-chart"></div>
	  </div>
	  <!-- /.footer -->
	</div>			
<script>
  // Veriyi getir
  fetch('asp/pie_chart_data.asp')
    .then(response => response.json())
    .then(data => {
      // Grafik seçeneklerini tanımla
      const pie_chart_options = {
        series: [data.yemek, data.taksi, data.ulasim, data.otopark, data.diger], // ASP'den gelen toplamlar
        chart: {
          type: 'donut',
        },
        labels: ['YEMEK', 'TAKSİ', 'ULAŞIM', 'OTOPARK', 'DİĞER'],
        dataLabels: {
          enabled: false,
        },
        colors: ['#20c997', '#0d6efd', '#ffc107', '#8c03a1', '#8f0404'],
      };

      // Grafik oluştur ve göster
      const pie_chart = new ApexCharts(document.querySelector('#pie-chart'), pie_chart_options);
      pie_chart.render();
    })
    .catch(error => console.error('Hata:', error));
</script>				
				
				
				
				
				
				
				
				
				
<!--end::Row-->
</div>
<!-- /.bar-end -->
<script>
  // İlk harfi büyük yapma fonksiyonu
  function capitalize(string) {
    return string.charAt(0).toUpperCase() + string.slice(1);
  }

  // Progress bar değerlerini güncellemek için bir fonksiyon
  function updateProgressBars() {
    const progressData = {
      kaban: <%= kabanadet %>, // ASP değişkenlerini kullan
      ceket: <%= ceketadet %>,
      elbise: <%= elbiseadet %>,
      etek: <%= etekadet %>,
      pantolon: <%= pantolonadet %>,
    };

    // Her bir progress bar için DOM elementlerini bul ve güncelle
    Object.keys(progressData).forEach((item) => {
      const adet = progressData[item];
      const progressBar = document.getElementById(`progressBar${capitalize(item)}2`);
      const adetLabel = document.getElementById(`${item}adet`);

      // Progress bar genişliğini ve metni güncelle
      if (progressBar) {
        progressBar.style.width = `${adet}%`; // Genişlik
      }
      if (adetLabel) {
        adetLabel.innerHTML = `<b>${adet} Ad.</b>`; // Metin içeriği
      }
    });

    // Ay ve toplam adet bilgilerini güncelle
    const ay = "<%= ayIsmi %>"; // ASP değişkenini kullan
    const toplamAdet = <%= toplamAdet %>; // ASP değişkenini kullan
    const salesTitle = document.getElementById('salesTitle');

    // Başlık güncelleniyor
    if (salesTitle) {
      salesTitle.textContent = `${ay} 2025 Ürün Satış Grafiği (Toplam: ${toplamAdet})`;
    }
  }

  // Progress bar değerlerini güncellemek için bir fonksiyon (YILLIK)
  function updateProgressBarsYillik() {
    const progressDataYillik = {
      kaban: <%= kabanadetYillik %>, // ASP değişkenlerini kullan
      ceket: <%= ceketadetYillik %>,
      elbise: <%= elbiseadetYillik %>,
      etek: <%= etekadetYillik %>,
      pantolon: <%= pantolonadetYillik %>,
    };

    // Her bir progress bar için DOM elementlerini bul ve güncelle
    Object.keys(progressDataYillik).forEach((item) => {
      const adet = progressDataYillik[item];
      const progressBar = document.getElementById(`progressBar${capitalize(item)}Yillik`);
      const adetLabel = document.getElementById(`${item}adetYillik`);

      // Progress bar genişliğini ve metni güncelle
      if (progressBar) {
        progressBar.style.width = `${adet}%`; // Genişlik
      }
      if (adetLabel) {
        adetLabel.innerHTML = `<b>${adet} Ad.</b>`; // Metin içeriği
      }
    });

    // Ay ve toplam adet bilgilerini güncelle
    const yil = "<%= yilIsmi %>"; // ASP değişkenini kullan
    const toplamAdet = <%= toplamAdetYillik %>; // ASP değişkenini kullan
    const salesTitle = document.getElementById('salesTitleYillik');

    // Başlık güncelleniyor
    if (salesTitle) {
      salesTitle.textContent = `${yil} Yılı Ürün Satış Grafiği (Toplam: ${toplamAdet})`;
    }
  }

  // Sayfa yüklendiğinde progress barları güncelle
  window.onload = function() {
    updateProgressBars();
    updateProgressBarsYillik(); // Yıllık olanı da çağırıyoruz.
  };
</script>			
		
			
			
          </div>
          <!--end::Container-->
        </div>
        <!--end::App Content-->
      </main>
      <!--end::App Main-->
      <!--begin::Footer-->
      <footer class="app-footer">       
        <!--begin::Copyright-->
        <strong>
          Copyright &copy;2024&nbsp;
          <a href="https://www.eresya.com/" target="_blank" class="text-decoration-none">CODIVA</a>.
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
