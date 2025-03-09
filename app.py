from flask import Flask, render_template, request, redirect, url_for, jsonify, flash
from flask_sqlalchemy import SQLAlchemy
from flask_cors import CORS  # CORS eklentisi
import os
from werkzeug.utils import secure_filename
import traceback  # Hata izleme için
from sqlalchemy import extract  # Ay bilgisini almak için
from collections import OrderedDict
from sqlalchemy import desc  # Tarihe göre sıralama için
from sqlalchemy import or_  # Tarihe göre sıralama için
import datetime  # Bugünün tarihini almak için
from dateutil.relativedelta import relativedelta  # Ay ve yıl hesaplamaları için
from flask import session
from PIL import Image
import secrets
from dotenv import load_dotenv

load_dotenv()  # .env dosyasını yükle (isteğe bağlı)

app = Flask(__name__, template_folder='templates/harc/dist/pages')

# SECRET KEY EKLE
app.config['SECRET_KEY'] = 'cok gizli anahtar'  # Güçlü bir anahtar oluşturun (örneğin, os.urandom(24).hex())

app.config['SQLALCHEMY_DATABASE_URI'] = 'sqlite:///C:\\inetpub\\wwwroot\\db\\db.db'
app.config['SQLALCHEMY_TRACK_MODIFICATIONS'] = False
# app.config['SQLALCHEMY_ECHO'] = True  # SQL sorgularını yazdır (hata ayıklama için)
db = SQLAlchemy(app)
CORS(app)  # CORS'u etkinleştir

# Dosya yükleme ayarları
UPLOAD_FOLDER = os.path.join('static', 'savefile')  # static klasörünün altında savefile
if not os.path.exists(UPLOAD_FOLDER):
    os.makedirs(UPLOAD_FOLDER)
app.config['UPLOAD_FOLDER'] = UPLOAD_FOLDER
ALLOWED_EXTENSIONS = {'png', 'jpg', 'jpeg', 'gif', 'HEIC'}  # İzin verilen dosya uzantıları

class Admin(db.Model):
    __tablename__ = 'admin'
    rowid = db.Column(db.Integer, primary_key=True)
    isim = db.Column(db.String(50))
    sifre = db.Column(db.String(50))

    def __repr__(self):
        return f"Admin(rowid={self.rowid}, isim='{self.isim}', sifre='{self.sifre}')"

class Harc(db.Model):
    __tablename__ = 'HARC'
    rowid = db.Column(db.Integer, primary_key=True)  # rowid'yi birincil anahtar yap
    resim = db.Column(db.String(255))
    cinsi = db.Column(db.String(255))
    tarih = db.Column(db.String(255))
    firma = db.Column(db.String(255))
    model = db.Column(db.String(255))
    modelno = db.Column(db.String(255))
    km = db.Column(db.String(255))
    fiyat = db.Column(db.String(255))  # String olarak kaydedilecek
    musteri = db.Column(db.String(255))
    aciklama = db.Column(db.String(255))
    fis = db.Column(db.Integer)
    kontrol = db.Column(db.Integer)
    masraf = db.Column(db.String(255))  # Masraf sütunu eklendi

    def __repr__(self):
        return f"Harc(rowid={self.rowid}, cinsi='{self.cinsi}', fiyat={self.fiyat})"

def allowed_file(filename):
    return '.' in filename and \
           filename.rsplit('.', 1)[1].lower() in ALLOWED_EXTENSIONS

def compress_image(image_path, quality=60):
    """Resmi sıkıştırır ve kalitesini düşürür."""
    try:
        img = Image.open(image_path)
        img.save(image_path, optimize=True, quality=quality)
    except Exception as e:
        print(f"Resim sıkıştırma hatası: {e}")

def resize_image(image_path, max_size=(800, 800)):
    """Resmin boyutunu yeniden ayarlar."""
    try:
        img = Image.open(image_path)
        img.thumbnail(max_size)
        img.save(image_path)
    except Exception as e:
        print(f"Resim boyutlandırma hatası: {e}")

@app.route("/")
def index():
    admins = Admin.query.all()
    return render_template('index.html', icerik=render_template('index.html', admins=admins))

@app.route("/giris")
def giris_sayfasi():
    return render_template('giris.html', icerik=render_template('giris.html'))

@app.route("/giris2")
def giris_sayfasi2():
    return render_template('giris_2.html', icerik=render_template('giris_2.html'))

@app.route("/giris3")
def giris_sayfasi3():
    return render_template('giris_3.html', icerik=render_template('giris_3.html'))

@app.route("/giris4")
def giris_sayfasi4():
    return render_template('giris_4.html', icerik=render_template('giris_3.html'))

@app.route("/giris_kontrol", methods=['POST'])
def giris_kontrol():
    sifre = request.form['password'].strip()
    dashboard_data = get_dashboard_data()  # Dashboard verilerini al

    if not sifre:
        flash('Lütfen şifrenizi girin!')
        return render_template('giris.html', error='Lütfen şifrenizi girin!', dashboard_data=dashboard_data)

    admin = Admin.query.filter(or_(Admin.rowid == 1)).first()

    print("Formdan gelen şifre:", sifre)
    if admin:
        print("Veritabanındaki şifre:", admin.sifre)
        sifre_eslesiyor = (str(admin.sifre) == str(sifre))
        print("Şifreler eşleşiyor mu:", sifre_eslesiyor)
    else:
        print("Admin bulunamadı!")
        sifre_eslesiyor = False

    if admin and sifre_eslesiyor:
        # Oturuma kullanıcı rolünü kaydet
        # session['rol'] = admin.rol # Modelde rol kalmadığı için bunu yapmıyoruz.
        return redirect(url_for('main_sayfasi'))
    else:
        flash('Yanlış şifre!')
        return render_template('giris.html', error='Yanlış şifre!', dashboard_data=dashboard_data)

@app.route("/giris_kontrol2", methods=['POST'])
def giris_kontrol2():
    sifre = request.form['password'].strip()
    dashboard_data = get_dashboard_data()  # Dashboard verilerini al

    if not sifre:
        flash('Lütfen şifrenizi girin!')
        return render_template('giris_2.html', error='Lütfen şifrenizi girin!', dashboard_data=dashboard_data)

    admin = Admin.query.filter_by(rowid=3).first()

    print("Formdan gelen şifre:", sifre)
    if admin:
        print("Veritabanındaki şifre:", admin.sifre)
        sifre_eslesiyor = (str(admin.sifre) == str(sifre))
        print("Şifreler eşleşiyor mu:", sifre_eslesiyor)
    else:
        print("Admin bulunamadı!")
        sifre_eslesiyor = False

    if admin and sifre_eslesiyor:
        # Oturuma kullanıcı rolünü kaydet
        # session['rol'] = admin.rol # Modelde rol kalmadığı için bunu yapmıyoruz.
        return redirect(url_for('harc_giris_sayfasi2'))
    else:
        flash('Yanlış şifre!')
        return render_template('giris_2.html', error='Yanlış şifre!', dashboard_data=dashboard_data)


@app.route("/giris_kontrol3", methods=['POST'])
def giris_kontrol3():
    sifre = request.form['password'].strip()
    dashboard_data = get_dashboard_data()  # Dashboard verilerini al

    if not sifre:
        flash('Lütfen şifrenizi girin!')
        return render_template('giris_3.html', error='Lütfen şifrenizi girin!', dashboard_data=dashboard_data)

    admin = Admin.query.filter_by(rowid=4).first()

    print("Formdan gelen şifre:", sifre)
    if admin:
        print("Veritabanındaki şifre:", admin.sifre)
        sifre_eslesiyor = (str(admin.sifre) == str(sifre))
        print("Şifreler eşleşiyor mu:", sifre_eslesiyor)
    else:
        print("Admin bulunamadı!")
        sifre_eslesiyor = False

    if admin and sifre_eslesiyor:
        # Oturuma kullanıcı rolünü kaydet
        # session['rol'] = admin.rol # Modelde rol kalmadığı için bunu yapmıyoruz.
        return redirect(url_for('harc_giris_sayfasi3'))
    else:
        flash('Yanlış şifre!')
        return render_template('giris_3.html', error='Yanlış şifre!', dashboard_data=dashboard_data)



@app.route("/giris_kontrol4", methods=['POST'])
def giris_kontrol4():
    sifre = request.form['password'].strip()
    dashboard_data = get_dashboard_data()  # Dashboard verilerini al

    if not sifre:
        flash('Lütfen şifrenizi girin!')
        return render_template('giris_4.html', error='Lütfen şifrenizi girin!', dashboard_data=dashboard_data)

    admin = Admin.query.filter_by(rowid=2).first()

    print("Formdan gelen şifre:", sifre)
    if admin:
        print("Veritabanındaki şifre:", admin.sifre)
        sifre_eslesiyor = (str(admin.sifre) == str(sifre))
        print("Şifreler eşleşiyor mu:", sifre_eslesiyor)
    else:
        print("Admin bulunamadı!")
        sifre_eslesiyor = False

    if admin and sifre_eslesiyor:
        # Oturuma kullanıcı rolünü kaydet
        # session['rol'] = admin.rol # Modelde rol kalmadığı için bunu yapmıyoruz.
        return redirect(url_for('harc_onay_sayfasi'))
    else:
        flash('Yanlış şifre!')
        return render_template('giris_4.html', error='Yanlış şifre!', dashboard_data=dashboard_data)


def get_daily_sales():
    today = datetime.date.today().strftime('%Y-%m-%d')
    harclar = Harc.query.filter(Harc.tarih.like(f'{today}%')).all()
    return sum(float(harc.fiyat.replace(',', '.')) if harc.fiyat else 0 for harc in harclar)

def get_last_month_sales():
    today = datetime.date.today()
    first_day_last_month = (today - relativedelta(months=1)).replace(day=1)
    last_day_last_month = today.replace(day=1) - datetime.timedelta(days=1)
    harclar = Harc.query.filter(Harc.tarih >= first_day_last_month.strftime('%Y-%m-%d'),
                                 Harc.tarih <= last_day_last_month.strftime('%Y-%m-%d')).all()
    return sum(float(harc.fiyat.replace(',', '.')) if harc.fiyat else 0 for harc in harclar)

def get_last_year_sales():
    today = datetime.date.today()
    first_day_last_year = (today - relativedelta(years=1)).replace(day=1, month=1)
    last_day_last_year = (today - relativedelta(years=1)).replace(day=31, month=12)
    harclar = Harc.query.filter(Harc.tarih >= first_day_last_year.strftime('%Y-%m-%d'),
                                 Harc.tarih <= last_day_last_year.strftime('%Y-%m-%d')).all()
    return sum(float(harc.fiyat.replace(',', '.')) if harc.fiyat else 0 for harc in harclar)

def get_all_time_sales():
    harclar = Harc.query.all()
    return sum(float(harc.fiyat.replace(',', '.')) if harc.fiyat else 0 for harc in harclar)

def get_all_time_approved_sales():
    harclar = Harc.query.filter(Harc.kontrol == 1).all()
    return sum(float(harc.fiyat.replace(',', '.')) if harc.fiyat else 0 for harc in harclar)

def get_last_year_approved_sales():
    today = datetime.date.today()
    first_day_last_year = (today - relativedelta(years=1)).replace(day=1, month=1)
    last_day_last_year = (today - relativedelta(years=1)).replace(day=31, month=12)
    harclar = Harc.query.filter(
        Harc.tarih >= first_day_last_year.strftime('%Y-%m-%d'),
        Harc.tarih <= last_day_last_year.strftime('%Y-%m-%d'),
        Harc.kontrol == 1  # Sadece onaylanmış olanları filtrele
    ).all()
    return sum(float(harc.fiyat.replace(',', '.')) if harc.fiyat else 0 for harc in harclar)

def get_last_year_unapproved_sales():
    today = datetime.date.today()
    first_day_last_year = (today - relativedelta(years=1)).replace(day=1, month=1)
    last_day_last_year = (today - relativedelta(years=1)).replace(day=31, month=12)
    harclar = Harc.query.filter(
        Harc.tarih >= first_day_last_year.strftime('%Y-%m-%d'),
        Harc.tarih <= last_day_last_year.strftime('%Y-%m-%d'),
        Harc.kontrol == 0  # Sadece onaylanmamış olanları filtrele
    ).all()
    return sum(float(harc.fiyat.replace(',', '.')) if harc.fiyat else 0 for harc in harclar)

def get_last_month_approved_sales():
    today = datetime.date.today()
    first_day_last_month = (today - relativedelta(months=1)).replace(day=1)
    last_day_last_month = today.replace(day=1) - datetime.timedelta(days=1)
    harclar = Harc.query.filter(
        Harc.tarih >= first_day_last_month.strftime('%Y-%m-%d'),
        Harc.tarih <= last_day_last_month.strftime('%Y-%m-%d'),
        Harc.kontrol == 1  # Sadece onaylanmış olanları filtrele
    ).all()
    return sum(float(harc.fiyat.replace(',', '.')) if harc.fiyat else 0 for harc in harclar)

def get_last_month_unapproved_sales():
    today = datetime.date.today()
    first_day_last_month = (today - relativedelta(months=1)).replace(day=1)
    last_day_last_month = today.replace(day=1) - datetime.timedelta(days=1)
    harclar = Harc.query.filter(
        Harc.tarih >= first_day_last_month.strftime('%Y-%m-%d'),
        Harc.tarih <= last_day_last_month.strftime('%Y-%m-%d'),
        Harc.kontrol == 0  # Sadece onaylanmamış olanları filtrele
    ).all()
    return sum(float(harc.fiyat.replace(',', '.')) if harc.fiyat else 0 for harc in harclar)

def get_daily_approved_sales():
    today = datetime.date.today().strftime('%Y-%m-%d')
    harclar = Harc.query.filter(Harc.tarih.like(f'{today}%'), Harc.kontrol == 1).all()
    return sum(float(harc.fiyat.replace(',', '.')) if harc.fiyat else 0 for harc in harclar)

def get_daily_unapproved_sales():
    today = datetime.date.today().strftime('%Y-%m-%d')
    harclar = Harc.query.filter(Harc.tarih.like(f'{today}%'), Harc.kontrol == 0).all()
    return sum(float(harc.fiyat.replace(',', '.')) if harc.fiyat else 0 for harc in harclar)

def get_monthly_approved_unapproved_sales():
    """Son 12 ayın onaylı ve onaysız harcamalarını getirir."""
    today = datetime.date.today()
    monthly_data = {}

    for i in range(12):
        # İlgili ayın ilk ve son gününü hesapla
        first_day_of_month = (today - relativedelta(months=i)).replace(day=1)
        last_day_of_month = (today - relativedelta(months=i)).replace(day=1) + relativedelta(months=1, days=-1)

        # Veritabanından onaylı ve onaysız harcamaları getir
        approved_sales = Harc.query.filter(
            Harc.tarih >= first_day_of_month.strftime('%Y-%m-%d'),
            Harc.tarih <= last_day_of_month.strftime('%Y-%m-%d'),
            Harc.kontrol == 1
        ).all()
        unapproved_sales = Harc.query.filter(
            Harc.tarih >= first_day_of_month.strftime('%Y-%m-%d'),
            Harc.tarih <= last_day_of_month.strftime('%Y-%m-%d'),
            Harc.kontrol == 0
        ).all()

        # Toplam fiyatları hesapla
        total_approved = sum(float(harc.fiyat.replace(',', '.')) if harc.fiyat else 0 for harc in approved_sales)
        total_unapproved = sum(float(harc.fiyat.replace(',', '.')) if harc.fiyat else 0 for harc in unapproved_sales)

        # Ay bilgisini (YYYY-MM) anahtar olarak kullan
        month_key = first_day_of_month.strftime('%Y-%m')
        monthly_data[month_key] = {
            'approved': total_approved,
            'unapproved': total_unapproved
        }

    # Ayları tersine çevirerek kronolojik sıraya göre sırala
    monthly_data = OrderedDict(sorted(monthly_data.items()))
    return monthly_data

def prepare_sales_chart_data(monthly_data):
    """Grafik için veri hazırlar."""
    categories = list(monthly_data.keys())
    approved_data = [monthly_data[month]['approved'] for month in categories]
    unapproved_data = [monthly_data[month]['unapproved'] for month in categories]
    return categories, approved_data, unapproved_data

def get_expense_distribution():
    """Geçen seneki onaylı harcamaların dağılımını getirir."""
    today = datetime.date.today()
    last_year = today.year - 1
    expense_types = ["ULAŞIM", "TAKSİ", "YEMEK", "OTOPARK", "DİĞER"]
    expense_data = {}

    for expense_type in expense_types:
        # Geçen seneki, kontrol=1 olan ve belirli cinse ait harcamaları filtrele
        harclar = Harc.query.filter(
            extract('year', Harc.tarih) == last_year,
            Harc.kontrol == 1,
            Harc.cinsi == expense_type
        ).all()

        # Toplam fiyatı hesapla
        total_price = sum(float(harc.fiyat.replace(',', '.')) if harc.fiyat else 0 for harc in harclar)
        expense_data[expense_type] = total_price

    return expense_data

@app.route("/main")
def main_sayfasi():
    daily_sales = get_daily_sales()
    last_month_sales = get_last_month_sales()
    last_year_sales = get_last_year_sales()
    all_time_sales = get_all_time_sales()
    all_time_approved_sales = get_all_time_approved_sales()
    last_year_approved_sales = get_last_year_approved_sales()
    last_year_unapproved_sales = get_last_year_unapproved_sales()
    last_month_approved_sales = get_last_month_approved_sales()
    last_month_unapproved_sales = get_last_month_unapproved_sales()
    daily_approved_sales = get_daily_approved_sales()  # Yeni fonksiyon
    daily_unapproved_sales = get_daily_unapproved_sales()  # Yeni fonksiyon

    dashboard_data = get_dashboard_data()  # Dashboard verilerini al

    return render_template(
        'main.html',
        daily_sales=daily_sales,
        last_month_sales=last_month_sales,
        last_year_sales=last_year_sales,
        all_time_sales=all_time_sales,
        all_time_approved_sales=all_time_approved_sales,
        last_year_approved_sales=last_year_approved_sales,
        last_year_unapproved_sales=last_year_unapproved_sales,
        last_month_approved_sales=last_month_approved_sales,
        last_month_unapproved_sales=last_month_unapproved_sales,
        daily_approved_sales=daily_approved_sales,  # Template'e gönder
        daily_unapproved_sales=daily_unapproved_sales,  # Template'e gönder
		dashboard_data=dashboard_data,
        icerik = render_template('main.html',dashboard_data=dashboard_data)
    )

def get_dashboard_data():
    """Dashboard için gerekli verileri toplar."""
    harclar = Harc.query.all()
    toplam_harcama = sum(float(harc.fiyat.replace(',', '.')) if harc.fiyat else 0 for harc in harclar)
    onaylanan_harcama = sum(float(harc.fiyat.replace(',', '.')) if harc.fiyat and harc.kontrol == 1 else 0 for harc in harclar)
    bekleyen_harcama = toplam_harcama - onaylanan_harcama
    toplam_kayit_sayisi = len(harclar)
    onaylanan_kayit_sayisi = sum(1 for harc in harclar if harc.kontrol == 1)
    bekleyen_kayit_sayisi = toplam_kayit_sayisi - onaylanan_kayit_sayisi

    # Grafik verisini hazırla
    monthly_data = get_monthly_approved_unapproved_sales()
    categories, approved_data, unapproved_data = prepare_sales_chart_data(monthly_data)

     # Masraf dağılımı verisini al
    expense_data = get_expense_distribution()

    return {
        'toplam_harcama': toplam_harcama,
        'onaylanan_harcama': onaylanan_harcama,
        'bekleyen_harcama': bekleyen_harcama,
        'toplam_kayit_sayisi': toplam_kayit_sayisi,
        'onaylanan_kayit_sayisi': onaylanan_kayit_sayisi,
        'bekleyen_kayit_sayisi': bekleyen_kayit_sayisi,
        'chart_categories': categories,
        'chart_approved_data': approved_data,
        'chart_unapproved_data': unapproved_data,
        'expense_data': expense_data  # Masraf dağılımı verisi
    }

@app.route("/harc_giris", methods=['GET', 'POST'])
def harc_giris_sayfasi():
    full_filename = None  # Başlangıçta full_filename'i None olarak tanımla
    if request.method == 'POST':
        # Dosya yoksa
        if 'file' not in request.files:
            return render_template('harc_giris.html', message='Dosya yok', full_filename=full_filename, icerik=render_template('harc_giris.html'))

        file = request.files['file']

        # Dosya adı yoksa
        if file.filename == '':
            return render_template('harc_giris.html', message='Dosya adı yok', full_filename=full_filename, icerik=render_template('harc_giris.html'))

        # İzin verilen dosya türündeyse
        if file and allowed_file(file.filename):
            # Güvenli bir dosya adı oluştur
            random_name = secrets.token_hex(8)  # 16 karakterlik rastgele hex adı
            extension = file.filename.rsplit('.', 1)[1].lower()
            filename = f"{random_name}.{extension}"
            file_path = os.path.join(app.config['UPLOAD_FOLDER'], filename)

            # Tam dosya adını sakla
            full_filename = filename

            # Dosyayı kaydet
            file.save(file_path)

            # Resmi yeniden boyutlandır ve sıkıştır
            resize_image(file_path)
            compress_image(file_path)

            # Dosya boyutunu kontrol et
            file_size_kb = os.path.getsize(file_path) / 1024
            if file_size_kb > 300:
                compress_image(file_path, quality=30)  # Daha fazla sıkıştır
                file_size_kb = os.path.getsize(file_path) / 1024
                if file_size_kb > 300:
                    os.remove(file_path)  # Boyut hala büyükse sil
                    return render_template('harc_giris.html', message='Dosya boyutu çok büyük!', full_filename=full_filename, icerik=render_template('harc_giris.html'))

            return render_template('harc_giris.html', message='Dosya başarıyla yüklendi!', full_filename=full_filename, icerik=render_template('harc_giris.html'))

        else:
            return render_template('harc_giris.html', message='İzin verilmeyen dosya türü', full_filename=full_filename, icerik=render_template('harc_giris.html'))

    return render_template('harc_giris.html', full_filename=full_filename, icerik=render_template('harc_giris.html'))


@app.route("/harc_giris2", methods=['GET', 'POST'])
def harc_giris_sayfasi2():
    full_filename = None  # Başlangıçta full_filename'i None olarak tanımla
    if request.method == 'POST':
        # Dosya yoksa
        if 'file' not in request.files:
            return render_template('harc_giris2.html', message='Dosya yok', full_filename=full_filename, icerik=render_template('harc_giris2.html'))

        file = request.files['file']

        # Dosya adı yoksa
        if file.filename == '':
            return render_template('harc_giris2.html', message='Dosya adı yok', full_filename=full_filename, icerik=render_template('harc_giris2.html'))

        # İzin verilen dosya türündeyse
        if file and allowed_file(file.filename):
            # Güvenli bir dosya adı oluştur
            random_name = secrets.token_hex(8)  # 16 karakterlik rastgele hex adı
            extension = file.filename.rsplit('.', 1)[1].lower()
            filename = f"{random_name}.{extension}"
            file_path = os.path.join(app.config['UPLOAD_FOLDER'], filename)

            # Tam dosya adını sakla
            full_filename = filename

            # Dosyayı kaydet
            file.save(file_path)

            # Resmi yeniden boyutlandır ve sıkıştır
            resize_image(file_path)
            compress_image(file_path)

            # Dosya boyutunu kontrol et
            file_size_kb = os.path.getsize(file_path) / 1024
            if file_size_kb > 300:
                compress_image(file_path, quality=30)  # Daha fazla sıkıştır
                file_size_kb = os.path.getsize(file_path) / 1024
                if file_size_kb > 300:
                    os.remove(file_path)  # Boyut hala büyükse sil
                    return render_template('harc_giris2.html', message='Dosya boyutu çok büyük!', full_filename=full_filename, icerik=render_template('harc_giris2.html'))

            return render_template('harc_giris2.html', message='Dosya başarıyla yüklendi!', full_filename=full_filename, icerik=render_template('harc_giris2.html'))

        else:
            return render_template('harc_giris2.html', message='İzin verilmeyen dosya türü', full_filename=full_filename, icerik=render_template('harc_giris2.html'))

    return render_template('harc_giris2.html', full_filename=full_filename, icerik=render_template('harc_giris2.html'))

    

@app.route("/harc_giris3", methods=['GET', 'POST'])
def harc_giris_sayfasi3():
    full_filename = None  # Başlangıçta full_filename'i None olarak tanımla
    if request.method == 'POST':
        # Dosya yoksa
        if 'file' not in request.files:
            return render_template('harc_giris3.html', message='Dosya yok', full_filename=full_filename, icerik=render_template('harc_giris3.html'))

        file = request.files['file']

        # Dosya adı yoksa
        if file.filename == '':
            return render_template('harc_giris3.html', message='Dosya adı yok', full_filename=full_filename, icerik=render_template('harc_giris3.html'))

        # İzin verilen dosya türündeyse
        if file and allowed_file(file.filename):
            # Güvenli bir dosya adı oluştur
            random_name = secrets.token_hex(8)  # 16 karakterlik rastgele hex adı
            extension = file.filename.rsplit('.', 1)[1].lower()
            filename = f"{random_name}.{extension}"
            file_path = os.path.join(app.config['UPLOAD_FOLDER'], filename)

            # Tam dosya adını sakla
            full_filename = filename

            # Dosyayı kaydet
            file.save(file_path)

            # Resmi yeniden boyutlandır ve sıkıştır
            resize_image(file_path)
            compress_image(file_path)

            # Dosya boyutunu kontrol et
            file_size_kb = os.path.getsize(file_path) / 1024
            if file_size_kb > 300:
                compress_image(file_path, quality=30)  # Daha fazla sıkıştır
                file_size_kb = os.path.getsize(file_path) / 1024
                if file_size_kb > 300:
                    os.remove(file_path)  # Boyut hala büyükse sil
                    return render_template('harc_giris3.html', message='Dosya boyutu çok büyük!', full_filename=full_filename, icerik=render_template('harc_giris3.html'))

            return render_template('harc_giris3.html', message='Dosya başarıyla yüklendi!', full_filename=full_filename, icerik=render_template('harc_giris3.html'))

        else:
            return render_template('harc_giris3.html', message='İzin verilmeyen dosya türü', full_filename=full_filename, icerik=render_template('harc_giris3.html'))

    return render_template('harc_giris3.html', full_filename=full_filename, icerik=render_template('harc_giris3.html'))

    
@app.route("/harc_kaydet", methods=['POST'])
def harc_kaydet():
    try:  # Hata yakalamak için try bloğu
        if request.method == 'POST':
            tarih = request.form['tarih']
            firma = request.form['firma']
            model = request.form['model']
            modelno = request.form['modelno']
            km = request.form['km']
            fiyat = request.form['fiyat']
            musteri = request.form['musteri']
            aciklama = request.form['aciklama']
            fis = request.form['fis']
            cinsi = request.form['cinsi']
            masraf = request.form['masraf']
            resim = request.form.get('resim', '')  # Resim adını al

            yeni_harc = Harc(
                tarih=tarih,
                firma=firma,
                model=model,
                modelno=modelno,
                km=km,
                fiyat=fiyat,  # String olarak kaydedilecek
                musteri=musteri,
                aciklama=aciklama,
                fis=fis,
                cinsi=cinsi,
                masraf=masraf,
                resim=resim,  # Dosya adını kaydet
                kontrol=0  # Yeni kayıtlar için varsayılan değer
            )

            db.session.add(yeni_harc)
            db.session.commit()
            print("Veritabanına kaydedildi.")  # Veritabanına kaydedildi mesajını kontrol et
            return redirect(url_for('harc_onay_sayfasi'))  # Başka bir sayfaya yönlendirme (isteğe bağlı)

    except Exception as e:
        print(f"Hata oluştu: {e}")  # Hata mesajını yazdır
        traceback.print_exc()  # Detaylı hata izini yazdır
        flash(f'Bir hata oluştu: {e}')  # Hata mesajını kullanıcıya göster
        return redirect(url_for('harc_giris_sayfasi'))

    return "Harc kaydetme başarısız oldu."   
    
@app.route("/harc_kaydet2", methods=['POST'])
def harc_kaydet2():
    try:  # Hata yakalamak için try bloğu
        if request.method == 'POST':
            tarih = request.form['tarih']
            firma = request.form['firma']
            model = request.form['model']
            modelno = request.form['modelno']
            km = request.form['km']
            fiyat = request.form['fiyat']
            musteri = request.form['musteri']
            aciklama = request.form['aciklama']
            fis = request.form['fis']
            cinsi = request.form['cinsi']
            masraf = request.form['masraf']
            resim = request.form.get('resim', '')  # Resim adını al

            yeni_harc = Harc(
                tarih=tarih,
                firma=firma,
                model=model,
                modelno=modelno,
                km=km,
                fiyat=fiyat,  # String olarak kaydedilecek
                musteri=musteri,
                aciklama=aciklama,
                fis=fis,
                cinsi=cinsi,
                masraf=masraf,
                resim=resim,  # Dosya adını kaydet
                kontrol=0  # Yeni kayıtlar için varsayılan değer
            )

            db.session.add(yeni_harc)
            db.session.commit()
            print("Veritabanına kaydedildi.")  # Veritabanına kaydedildi mesajını kontrol et
            return redirect(url_for('harc_onay_sayfasi2'))  # Başka bir sayfaya yönlendirme (isteğe bağlı)

    except Exception as e:
        print(f"Hata oluştu: {e}")  # Hata mesajını yazdır
        traceback.print_exc()  # Detaylı hata izini yazdır
        flash(f'Bir hata oluştu: {e}')  # Hata mesajını kullanıcıya göster
        return redirect(url_for('harc_giris_sayfasi2'))

    return "Harc kaydetme başarısız oldu." 
    
@app.route("/harc_kaydet3", methods=['POST'])
def harc_kaydet3():
    try:  # Hata yakalamak için try bloğu
        if request.method == 'POST':
            tarih = request.form['tarih']
            firma = request.form['firma']
            model = request.form['model']
            modelno = request.form['modelno']
            km = request.form['km']
            fiyat = request.form['fiyat']
            musteri = request.form['musteri']
            aciklama = request.form['aciklama']
            fis = request.form['fis']
            cinsi = request.form['cinsi']
            masraf = request.form['masraf']
            resim = request.form.get('resim', '')  # Resim adını al

            yeni_harc = Harc(
                tarih=tarih,
                firma=firma,
                model=model,
                modelno=modelno,
                km=km,
                fiyat=fiyat,  # String olarak kaydedilecek
                musteri=musteri,
                aciklama=aciklama,
                fis=fis,
                cinsi=cinsi,
                masraf=masraf,
                resim=resim,  # Dosya adını kaydet
                kontrol=0  # Yeni kayıtlar için varsayılan değer
            )

            db.session.add(yeni_harc)
            db.session.commit()
            print("Veritabanına kaydedildi.")  # Veritabanına kaydedildi mesajını kontrol et
            return redirect(url_for('harc_onay_sayfasi3'))  # Başka bir sayfaya yönlendirme (isteğe bağlı)

    except Exception as e:
        print(f"Hata oluştu: {e}")  # Hata mesajını yazdır
        traceback.print_exc()  # Detaylı hata izini yazdır
        flash(f'Bir hata oluştu: {e}')  # Hata mesajını kullanıcıya göster
        return redirect(url_for('harc_giris_sayfasi3'))

    return "Harc kaydetme başarısız oldu."

def calculate_totals(harclar):
    toplamTutar = 0
    toplamTutarKontrol1 = 0
    for harc in harclar:
        try:
            # Virgülü noktaya çevirerek float'a dönüştürmeyi dene
            fiyat_str = harc.fiyat.replace(',', '.') if harc.fiyat else '0'
            fiyat = float(fiyat_str)
            toplamTutar += fiyat  # Tüm kayıtların fiyatlarını topla

            if int(harc.kontrol) == 1:
                toplamTutarKontrol1 += fiyat  # Sadece kontrol=1 olanların fiyatlarını topla

        except ValueError as e:
            print(f"Hata: Geçersiz fiyat değeri bulundu (rowid: {harc.rowid}, fiyat: {harc.fiyat}), Hata Mesajı: {e}")
            # Geçersiz fiyat değerini sıfır olarak kabul et

    print(f"Toplam Tutar: {toplamTutar}, ToplamTutarKontrol1: {toplamTutarKontrol1}")  # Hata ayıklama
    return toplamTutar, toplamTutarKontrol1

def group_by_month(harclar):
    """Harcamaları aya göre gruplandırır."""
    grouped_data = OrderedDict()  # Sıralı bir sözlük kullan
    for harc in harclar:
        ay = harc.tarih  # Tam tarihi al
        if ay not in grouped_data:
            grouped_data[ay] = {
                'harclar': [],
                'toplamTutar': 0,
                'toplamTutarKontrol1': 0
            }
        grouped_data[ay]['harclar'].append(harc)
        try:
            fiyat_str = harc.fiyat.replace(',', '.') if harc.fiyat else '0'
            fiyat = float(fiyat_str)
            grouped_data[ay]['toplamTutar'] += fiyat
            if int(harc.kontrol) == 1:
                grouped_data[ay]['toplamTutarKontrol1'] += fiyat
        except ValueError as e:
            print(f"Hata: Geçersiz fiyat değeri (rowid: {harc.rowid}, fiyat: {harc.fiyat}), Hata Mesajı: {e}")
    return grouped_data

def get_dashboard_data():
    """Dashboard için gerekli verileri toplar."""
    harclar = Harc.query.all()
    toplam_harcama = sum(float(harc.fiyat.replace(',', '.')) if harc.fiyat else 0 for harc in harclar)
    onaylanan_harcama = sum(
        float(harc.fiyat.replace(',', '.')) if harc.fiyat and harc.kontrol == 1 else 0 for harc in harclar)
    bekleyen_harcama = toplam_harcama - onaylanan_harcama
    toplam_kayit_sayisi = len(harclar)
    onaylanan_kayit_sayisi = sum(1 for harc in harclar if harc.kontrol == 1)
    bekleyen_kayit_sayisi = toplam_kayit_sayisi - onaylanan_kayit_sayisi

    # Grafik verisini hazırla
    monthly_data = get_monthly_approved_unapproved_sales()
    categories, approved_data, unapproved_data = prepare_sales_chart_data(monthly_data)

    # Masraf dağılımı verisini al
    expense_data = get_expense_distribution()

    return {
        'toplam_harcama': toplam_harcama,
        'onaylanan_harcama': onaylanan_harcama,
        'bekleyen_harcama': bekleyen_harcama,
        'toplam_kayit_sayisi': toplam_kayit_sayisi,
        'onaylanan_kayit_sayisi': onaylanan_kayit_sayisi,
        'bekleyen_kayit_sayisi': bekleyen_kayit_sayisi,
        'chart_categories': categories,
        'chart_approved_data': approved_data,
        'chart_unapproved_data': unapproved_data,
        'expense_data': expense_data  # Masraf dağılımı verisi
    }

def get_expense_distribution():
    """Geçen seneki onaylı harcamaların dağılımını getirir."""
    today = datetime.date.today()
    last_year = today.year - 1
    expense_types = ["ULAŞIM", "TAKSİ", "YEMEK", "OTOPARK", "DİĞER"]
    expense_data = {}

    for expense_type in expense_types:
        # Geçen seneki, kontrol=1 olan ve belirli cinse ait harcamaları filtrele
        harclar = Harc.query.filter(
            extract('year', Harc.tarih) == last_year,
            Harc.kontrol == 1,
            Harc.cinsi == expense_type
        ).all()

        # Toplam fiyatı hesapla
        total_price = sum(float(harc.fiyat.replace(',', '.')) if harc.fiyat else 0 for harc in harclar)
        expense_data[expense_type] = total_price

    return expense_data

@app.route('/get_harc_data')
def get_harc_data():
    modelno = request.args.get('modelno')
    print(f"get_harc_data: modelno = {modelno}")
    harc = Harc.query.filter_by(modelno=modelno).first()
    print(f"get_harc_data: harc = {harc}")

    if harc:
        print(f"get_harc_data: model = {harc.model}, musteri = {harc.musteri}")
        return jsonify({'model': harc.model, 'musteri': harc.musteri})
    else:
        print("get_harc_data: Harc kaydı bulunamadı")
        return jsonify({'model': '', 'musteri': ''})

@app.route("/harc_onay")
def harc_onay_sayfasi():
    search_term = request.args.get('searchTerm', '')
    id = request.args.get('id')
    kontrol = request.args.get('kontrol')

    print(f"harc_onay_sayfasi: id = {id}, kontrol = {kontrol}")  # Hata ayıklama

    if id and kontrol is not None:
        harc = Harc.query.get(id)  # Harc.query.get(rowid)  # Düzeltildi
        print(f"harc_onay_sayfasi: Harc.query.get(rowid) = {harc}")  # Hata ayıklama
        if harc:  # Harc nesnesi bulunduysa
            harc.kontrol = int(kontrol)
            db.session.commit()
        else:  # Harc nesnesi bulunamadıysa
            print(f"Harc kaydı bulunamadı (rowid: {id})")  # rowid ile güncellendi
            return redirect(url_for('harc_onay_sayfasi', searchTerm=search_term))
        return redirect(url_for('harc_onay_sayfasi', searchTerm=search_term))

    if search_term:
        harclar = Harc.query.filter(
            (Harc.cinsi.contains(search_term)) |
            (Harc.musteri.contains(search_term)) |
            (Harc.modelno.contains(search_term))
        ).order_by(Harc.tarih.desc()).all()  # Tarihe göre sırala
    else:
        harclar = Harc.query.order_by(Harc.tarih.desc()).all()  # Tarihe göre sırala

    grouped_harclar = group_by_month(harclar)  # Veriyi gruplandır

    toplamTutar = 0
    toplamTutarKontrol1 = 0
    for ay, data in grouped_harclar.items():
        toplamTutar += data['toplamTutar']
        toplamTutarKontrol1 += data['toplamTutarKontrol1']

    # Hata ayıklama: rowid değerlerini yazdır
    print("Sıralanmış tarih değerleri:")
    for harc in harclar:
        print(harc.tarih)

    # Kontrol=0 olan kayıtları filtrele
    bekleyen_onaydaki_harclar = [harc for harc in harclar if harc.kontrol == 0]

    # Kontrol=0 olan kayıtların fiyat toplamını hesapla
    gunluk_satis_fiyati = sum(float(harc.fiyat) if harc.fiyat else 0 for harc in bekleyen_onaydaki_harclar)

    return render_template(
        'harc_onay.html',
        grouped_harclar=grouped_harclar,  # Gruplandırılmış veriyi gönder
        toplamTutar=toplamTutar,
        toplamTutarKontrol1=toplamTutarKontrol1,
        search_term=search_term,
        bekleyen_onay_adedi=bekleyen_onaydaki_harclar,
        gunluk_satis_fiyati=gunluk_satis_fiyati,
        icerik=render_template('harc_onay.html', grouped_harclar=grouped_harclar,
                               toplamTutar=toplamTutar,
                               toplamTutarKontrol1=toplamTutarKontrol1,
                               search_term=search_term,
                               bekleyen_onay_adedi=bekleyen_onaydaki_harclar,
                               gunluk_satis_fiyati=gunluk_satis_fiyati)
    )

@app.route("/harc_liste")
def harc_liste_sayfasi():
    search_term = request.args.get('searchTerm', '')
    id = request.args.get('id')
    kontrol = request.args.get('kontrol')

    print(f"harc_liste_sayfasi: id = {id}, kontrol = {kontrol}")  # Hata ayıklama

    if id and kontrol is not None:
        harc = Harc.query.get(id)  # Harc.query.get(rowid) # Düzeltildi
        print(f"harc_liste_sayfasi: Harc.query.get(rowid) = {harc}")  # Hata ayıklama
        if harc:  # Harc nesnesi bulunduysa
            harc.kontrol = int(kontrol)
            db.session.commit()
        else:  # Harc nesnesi bulunamadıysa
            print(f"Harc kaydı bulunamadı (rowid: {id})")  # rowid ile güncellendi
            return redirect(url_for('harc_liste_sayfasi', searchTerm=search_term))
        return redirect(url_for('harc_liste_sayfasi', searchTerm=search_term))

    if search_term:
        harclar = Harc.query.filter(
            (Harc.cinsi.contains(search_term)) |
            (Harc.musteri.contains(search_term)) |
            (Harc.modelno.contains(search_term))
        ).order_by(Harc.tarih.desc()).all()  # Tarihe göre sırala
    else:
        harclar = Harc.query.order_by(Harc.tarih.desc()).all()  # Tarihe göre sırala

    grouped_harclar = group_by_month(harclar)  # Veriyi gruplandır

    toplamTutar = 0
    toplamTutarKontrol1 = 0
    for ay, data in grouped_harclar.items():
        toplamTutar += data['toplamTutar']
        toplamTutarKontrol1 += data['toplamTutarKontrol1']

    # Hata ayıklama: rowid değerlerini yazdır
    print("Sıralanmış tarih değerleri:")
    for harc in harclar:
        print(harc.tarih)

    # Kontrol=0 olan kayıtları filtrele
    bekleyen_onaydaki_harclar = [harc for harc in harclar if harc.kontrol == 0]

    # Kontrol=0 olan kayıtların fiyat toplamını hesapla
    gunluk_satis_fiyati = sum(float(harc.fiyat) if harc.fiyat else 0 for harc in bekleyen_onaydaki_harclar)

    return render_template(
        'harc_liste.html',
        harclar=harclar,
        grouped_harclar=grouped_harclar,  # Gruplandırılmış veriyi gönder
        toplamTutar=toplamTutar,
        toplamTutarKontrol1=toplamTutarKontrol1,
        search_term=search_term,
        bekleyen_onay_adedi=bekleyen_onaydaki_harclar,
        gunluk_satis_fiyati=gunluk_satis_fiyati,
        icerik=render_template('harc_onay.html', harclar=harclar,
                               grouped_harclar=grouped_harclar,
                               toplamTutar=toplamTutarKontrol1,
                               search_term=search_term,
                               bekleyen_onay_adedi=bekleyen_onaydaki_harclar,
                               gunluk_satis_fiyati=gunluk_satis_fiyati)
    )


@app.route("/harc_liste2")
def harc_liste_sayfasi2():
    search_term = request.args.get('searchTerm', '')
    id = request.args.get('id')
    kontrol = request.args.get('kontrol')

    print(f"harc_liste_sayfasi2: id = {id}, kontrol = {kontrol}")  # Hata ayıklama

    if id and kontrol is not None:
        harc = Harc.query.get(id)  # Harc.query.get(rowid) # Düzeltildi
        print(f"harc_liste_sayfasi2: Harc.query.get(rowid) = {harc}")  # Hata ayıklama
        if harc:  # Harc nesnesi bulunduysa
            harc.kontrol = int(kontrol)
            db.session.commit()
        else:  # Harc nesnesi bulunamadıysa
            print(f"Harc kaydı bulunamadı (rowid: {id})")  # rowid ile güncellendi
            return redirect(url_for('harc_liste_sayfasi2', searchTerm=search_term))
        return redirect(url_for('harc_liste_sayfasi2', searchTerm=search_term))

    if search_term:
        harclar = Harc.query.filter(
            (Harc.cinsi.contains(search_term)) |
            (Harc.musteri.contains(search_term)) |
            (Harc.modelno.contains(search_term))
        ).order_by(Harc.tarih.desc()).all()  # Tarihe göre sırala
    else:
        harclar = Harc.query.order_by(Harc.tarih.desc()).all()  # Tarihe göre sırala

    grouped_harclar = group_by_month(harclar)  # Veriyi gruplandır

    toplamTutar = 0
    toplamTutarKontrol1 = 0
    for ay, data in grouped_harclar.items():
        toplamTutar += data['toplamTutar']
        toplamTutarKontrol1 += data['toplamTutarKontrol1']

    # Hata ayıklama: rowid değerlerini yazdır
    print("Sıralanmış tarih değerleri:")
    for harc in harclar:
        print(harc.tarih)

    # Kontrol=0 olan kayıtları filtrele
    bekleyen_onaydaki_harclar = [harc for harc in harclar if harc.kontrol == 0]

    # Kontrol=0 olan kayıtların fiyat toplamını hesapla
    gunluk_satis_fiyati = sum(float(harc.fiyat) if harc.fiyat else 0 for harc in bekleyen_onaydaki_harclar)

    return render_template(
        'harc_liste2.html',
        harclar=harclar,
        grouped_harclar=grouped_harclar,  # Gruplandırılmış veriyi gönder
        toplamTutar=toplamTutar,
        toplamTutarKontrol1=toplamTutarKontrol1,
        search_term=search_term,
        bekleyen_onay_adedi=bekleyen_onaydaki_harclar,
        gunluk_satis_fiyati=gunluk_satis_fiyati,
        icerik=render_template('harc_onay.html', harclar=harclar,
                               grouped_harclar=grouped_harclar,
                               toplamTutar=toplamTutarKontrol1,
                               search_term=search_term,
                               bekleyen_onay_adedi=bekleyen_onaydaki_harclar,
                               gunluk_satis_fiyati=gunluk_satis_fiyati)
    )

@app.route("/cikis")
def index_sayfasi():
    return render_template('index.html')

@app.route("/test")
def test_db_connection():
    try:
        admins = Admin.query.all()
        if admins:
            return f"Veritabanına başarıyla bağlandı ve {len(admins)} adet admin bulundu."
        else:
            return "Veritabanına bağlandı, ancak admin tablosunda veri bulunamadı."
    except Exception as e:
        return f"Veritabanı bağlantısı veya sorgu sırasında bir hata oluştu: {str(e)}"

if __name__ == '__main__':
    app.run(debug=True)