import 'dart:async';

import 'package:flutter/material.dart';

class StreamKullanimi extends StatefulWidget {
  const StreamKullanimi({Key? key}) : super(key: key);

  @override
  _StreamKullanimiState createState() => _StreamKullanimiState();
}

class _StreamKullanimiState extends State<StreamKullanimi> {
  final StreamController<int> _streamController = StreamController<int>();
  int _counter = 0;

  @override
  void dispose() {
    //bununla işimiz bittiğinde bunu kapatıyoruz ki bununnkullandığı kaynakları siteme geri veriyoruz
    // ve herhangi bir hatayla karşılaşmayalım
    _streamController.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Stream Kullanımı"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Butona bu kadar kez bastınız"),
            //streambuilder sayesinde biz sğrekli burada yazdığımız eventi dinliyoruz. Bu event
            // burada counter oluyor bizim için
            StreamBuilder<int>(
              //başlangıç değerimiz
              initialData: 0,
              //içindeki yapıları dinleyeceğim yada güncelleyeceğim stream nedir bana bunu ver
              stream: _streamController.stream,
              builder: (BuildContext context, AsyncSnapshot<int> snapshot) {
                return Text(
                  "${snapshot.data}",
                  style: Theme.of(context).textTheme.display1,
                );
              },
            )
          ],
        ),
      ),
      floatingActionButton: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          FloatingActionButton(
            heroTag: "1",
            onPressed: () {
              //event giren şeyler state çıkan şeyler
              _streamController.sink.add(++_counter);
            },
            child: Icon(Icons.add),
          ),
          SizedBox(
            height: 5,
          ),
          FloatingActionButton(
            heroTag: "2",
            onPressed: () {
              _streamController.sink.add(--_counter);
            },
            child: Icon(Icons.remove),
          ),
          SizedBox(
            height: 5,
          ),
        ],
      ),
    );
  }
}
