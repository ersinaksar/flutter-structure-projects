import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

//kullanıcı durumlarını ele alan uzun işlemler
enum KullaniciDurumu { OturumAcilmis, OturumAcilmamis, OturumAciliyor }

class AuthService with ChangeNotifier {
  //kullanıcı oluşturmamızı sağlayacak kullanıcı oturu açmamızı sağlayacak auth nesnemiz
  final FirebaseAuth _auth = FirebaseAuth.instance;
  KullaniciDurumu _durum = KullaniciDurumu.OturumAcilmamis;

  KullaniciDurumu get durum => _durum;

  set durum(KullaniciDurumu value) {
    _durum = value;
    //duruma bir değer atadığımızda arayüzü haberdar etmek için notifier listener i buraya koyduk
    notifyListeners();
  }

  AuthService() {
    //kullanıcının oturup açıp kapattığı bilgisini dinliyoruz
    _auth.authStateChanges().listen(_authStateChanged);
  }

  void _authStateChanged(User? user) {
    if (user == null) {
      //set metodunu kullanmak için durum yazıyoruz. _durum yazsaydık doğrudan değişkeni değiştirmiş olacaktık
      durum = KullaniciDurumu.OturumAcilmamis;
    } else {
      durum = KullaniciDurumu.OturumAcilmis;
    }
  }

  Future<User?> createUserWithEmailandPassword(
      String email, String sifre) async {
    try {
      durum = KullaniciDurumu.OturumAciliyor;
      UserCredential _credential = await _auth.createUserWithEmailAndPassword(
          email: email, password: sifre);
      User? _yeniKullanici = _credential.user;
      return _yeniKullanici;
    } catch (e) {
      //br hata çıktığında durumu oturum açılmamaış olarak ypıyoruz ki ekranda dönmeye devam eden çember yerine
      //sistemi haberdar edip bir şey göstrebilelelim
      durum = KullaniciDurumu.OturumAcilmamis;
      debugPrint("hata "
          "dosya: auth_service"
          "fonksiyon:createUserWithEmailandPassword"
          "hata: $e");
      return null;
    }
  }

  Future<User?> signInUserWithEmailandPassword(
      String email, String sifre) async {
    try {
      durum = KullaniciDurumu.OturumAciliyor;
      UserCredential _credential =
          await _auth.signInWithEmailAndPassword(email: email, password: sifre);
      User? _oturumAcanKullanici = _credential.user;
      return _oturumAcanKullanici;
    } catch (e) {
      //br hata çıktığında durumu oturum açılmamaış olarak ypıyoruz ki ekranda dönmeye devam eden çember yerine
      //sistemi haberdar edip bir şey göstrebilelelim
      durum = KullaniciDurumu.OturumAcilmamis;
      debugPrint("hata "
          "dosya: auth_service"
          "fonksiyon:signInUserWithEmailandPassword"
          "hata: $e");
      return null;
    }
  }

  Future<bool> signOut() async {
    try {
      await _auth.signOut();
      durum = KullaniciDurumu.OturumAcilmamis;
      return true;
    } catch (e) {
      debugPrint("hata "
          "dosya: auth_service"
          "fonksiyon:signOut"
          "hata: $e");
      return false;
    }
  }
}
