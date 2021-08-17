//2 farklı stream yapımız olmalı
//state için StreamController
//event için StreamController
import 'dart:async';

import 'package:provider_block/block/sayac/sayac_event.dart';

class SayacBlock {
  int _sayac = 0;

  //state için StreamController
  final _sayacStateStreamController = StreamController<int>();
  Stream<int> get sayac => _sayacStateStreamController.stream;
  StreamSink<int> get _sayacStateSink => _sayacStateStreamController.sink;
  //event için StreamController
  final _sayacEventStreamController = StreamController<SayacEvent>();
  Stream<SayacEvent> get _sayacEventStream =>
      _sayacEventStreamController.stream;
  StreamSink<SayacEvent> get sayacEventSink => _sayacEventStreamController.sink;

  SayacBlock() {
    //sayac ebentinin sinkine bir girdi olduğu zaman streami tetikleniyor bizde streamini dinliyoruz
    //tetiklendiğinde otomatikman bizde dinlediğimiz için _mapEventToState fonksiyonu tetiklenecek
    _sayacEventStream.listen(_mapEventToState);
  }

  void _mapEventToState(SayacEvent event) {
    if (event is ArttirmaEvent) {
      _sayac++;
    } else {
      _sayac--;
    }

    _sayacStateSink.add(_sayac);
  }
}
