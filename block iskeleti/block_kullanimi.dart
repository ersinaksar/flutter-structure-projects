import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider_block/block/sayac/sayac_block.dart';
import 'package:provider_block/block/sayac/sayac_event.dart';

class BlockKullanimi extends StatefulWidget {
  const BlockKullanimi({Key? key}) : super(key: key);

  @override
  _BlockKullanimiState createState() => _BlockKullanimiState();
}

class _BlockKullanimiState extends State<BlockKullanimi> {
  final _sayacBlock = SayacBlock();
  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Block Kullanımı"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Butona bu kadar kez bastınız"),
            StreamBuilder<int>(
              initialData: 0,
              stream: _sayacBlock.sayac,
              builder: (context, snapshot) {
                return Text(
                  snapshot.data.toString(),
                  style: TextStyle(fontSize: 50),
                );
              },
            ),
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
              _sayacBlock.sayacEventSink.add(ArttirmaEvent());
            },
            child: Icon(Icons.add),
          ),
          SizedBox(
            height: 5,
          ),
          FloatingActionButton(
            heroTag: "2",
            onPressed: () {
              _sayacBlock.sayacEventSink.add(AzaltmaEvent());
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
