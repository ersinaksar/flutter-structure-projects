import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider_block/auth_service.dart';
import 'package:provider_block/counter.dart';

class ProviderlaSayacUygulamasi extends StatelessWidget {
  const ProviderlaSayacUygulamasi({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final myAuth = Provider.of<AuthService>(context);

    switch (myAuth.durum) {
      case KullaniciDurumu.OturumAciliyor:
        return Scaffold(
          body: Center(
            child: CircularProgressIndicator(),
          ),
        );
      case KullaniciDurumu.OturumAcilmamis:
        return Scaffold(
          body: Center(
            child: Column(
              //verilerimiz ortaya gelsin diye bunu ekliyoruz
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Uygulamayı kullanmak içi Lütfen Oturum Açin"),
                RaisedButton(
                  onPressed: () async {
                    await myAuth.createUserWithEmailandPassword(
                        "ersinaksar@yandex.com", "123456");
                  },
                  color: Colors.blue,
                  child: Text("Kullanıcı Oluştur"),
                ),
                RaisedButton(
                  onPressed: () async {
                    await myAuth.signInUserWithEmailandPassword(
                        "ersinaksar@yandex.com", "123456");
                  },
                  color: Colors.blue,
                  child: Text("Oturum Açın"),
                ),
              ],
            ),
          ),
        );
      case KullaniciDurumu.OturumAcilmis:
        return Scaffold(
          appBar: AppBar(
            title: Text("Providerla Sayac Uygulaması"),
          ),
          body: Center(
            //Burada değeri göserme işlemini yapıyoruz
            child: MyColumn(),
          ),
          //Burada değeri arttırma ve azaltma işlemini yapıyoruz
          floatingActionButton: MyFloatingActionButtons(),
        );
    }
  }
}

class MyFloatingActionButtons extends StatelessWidget {
  const MyFloatingActionButtons({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //listen false ayarladığımızda tama change notifier içerisindeki değerlelerle ilgienniyorum ama bu değerler her
    // değiştiğinde buradaki build metodunu tekrar çalıştırmayacağım demek
    var mySayac = Provider.of<Counter>(context, listen: false);
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        FloatingActionButton(
          heroTag: "1",
          onPressed: mySayac.arttir,
          child: Icon(Icons.add),
        ),
        SizedBox(
          height: 5,
        ),
        FloatingActionButton(
          heroTag: "2",
          onPressed: mySayac.azalt,
          child: Icon(Icons.remove),
        ),
      ],
    );
  }
}

class MyColumn extends StatelessWidget {
  const MyColumn({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final myAuth = Provider.of<AuthService>(context);
    var mySayac = Provider.of<Counter>(context);
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          mySayac.sayac.toString(),
          style: TextStyle(fontSize: 30),
        ),
        Text(
          myAuth.user.email.toString(),
          style: TextStyle(fontSize: 30),
        ),
        RaisedButton(
          onPressed: () async {
            await myAuth.signOut();
          },
          color: Colors.blue,
          child: Text("Oturumu kapat"),
        ),
      ],
    );
  }
}
