//sayaçla ilgili olabilecek tüm eventleri burada tanımlıyoruz

//abstract soyut sınıfı
//1- bundan bir nesne üretilsin istemiyoruz bunu içinde herhangi bir metot da olmayacak
//abstract soyut sınıfı kullanma amacımız
//1- metotların içeriği belli olmayabilir ör alan hesapla diye  içeriği bilinmeyen bir metot olabilir
//İki sınıfı abstract sınıfından türettiğimizde bu iki sınıfı tek bir çatı altında toplamış oluyoruz.
// Yani yarın öbür gün bir metoda bir parametre geçeceğimiz zaman ben bunu arttırmamı geçeyim azaltmamı
// geçeyim bilmediğim durumda sayacevent i geçebilirim
abstract class SayacEvent {}

class ArttirmaEvent extends SayacEvent {}

class AzaltmaEvent extends SayacEvent {}
