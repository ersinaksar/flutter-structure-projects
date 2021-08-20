import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_paket/counter_bloc/counter_event.dart';
import 'package:flutter_bloc_paket/counter_bloc/counter_state.dart';

class CounterBlock extends Bloc<CounterEvent, CounterState> {
  //bu block dan sınıf oluşturduğumuzda bir veri yollamak istiyor muyuz istemiyor muyuz
  // CounterState initialState dedidği o
  //CounterState(0) den bir nesne üreteceğiz ve içine de başlangıç değeri olarak 0 koyacağız
  CounterBlock() : super(CounterState(0));

  //yield in return den farkı geriye bir değer döndürdükten sonra metot bitmesin çalışmaya devam etsin
  @override
  Stream<CounterState> mapEventToState(CounterEvent event) async* {
    if (event is CounterArttir) {
      yield CounterState(state.sayac + 1);
    }
    if (event is CounterAzalt) {
      yield CounterState(state.sayac - 1);
    }
  }
}
