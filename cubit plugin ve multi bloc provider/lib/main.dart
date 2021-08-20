import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_paket/counter_bloc/counter_block.dart';
import 'package:flutter_bloc_paket/counter_bloc/counter_event.dart';
import 'package:flutter_bloc_paket/counter_bloc/counter_state.dart';
import 'package:flutter_bloc_paket/cubit_plugin/sayici_cubit.dart';
import 'package:flutter_bloc_paket/theme_cubit.dart';

//event ya d bloüu kullandığımızda neler olacğına dair bilgi veriyor
/// Custom [BlocObserver] which observes all bloc and cubit instances.
class SimpleBlocObserver extends BlocObserver {
  @override
  void onEvent(Bloc bloc, Object? event) {
    super.onEvent(bloc, event);
    print(event);
  }

  @override
  void onTransition(Bloc bloc, Transition transition) {
    super.onTransition(bloc, transition);
    print(transition);
  }

  @override
  void onError(BlocBase bloc, Object error, StackTrace stackTrace) {
    print(error);
    super.onError(bloc, error, stackTrace);
  }
}

void main() {
  Bloc.observer = SimpleBlocObserver();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      //tüm ağaca bu değeri verdik material app artık bu değeri biliyor
      create: (context) => ThemeCubit(),
      child: BlocBuilder<ThemeCubit, ThemeData>(builder: (context, tema) {
        return MaterialApp(
          title: 'Flutter Demo',
          theme: tema,
          home: MultiBlocProvider(providers: [
            BlocProvider(create: (context) => CounterBlock()),
            BlocProvider(create: (context) => SayiciCubit()),
          ], child: MyHomePage()),
        );
      }),
    );
  }
}

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Flutter Block Paketi"),
      ),
      body: MyCenterWidget(),
      floatingActionButton: MyActions(),
    );
  }
}

class MyCenterWidget extends StatelessWidget {
  const MyCenterWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            'You have pushed the button this many times:',
          ),
          BlocBuilder<CounterBlock, CounterState>(
            builder: (context, counterState) {
              return Text(
                counterState.sayac.toString(),
                style: Theme.of(context).textTheme.headline4,
              );
            },
          ),
          BlocBuilder<SayiciCubit, SayiciState>(
            builder: (context, sayiciState) {
              return Text(
                sayiciState.deger.toString(),
                style: Theme.of(context).textTheme.headline4,
              );
            },
          ),
        ],
      ),
    );
  }
}

class MyActions extends StatelessWidget {
  const MyActions({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        FloatingActionButton(
          heroTag: "1",
          onPressed: () {
            context.read<CounterBlock>().add(CounterArttir());
          },
          child: Icon(Icons.add),
          tooltip: "Arttır",
        ),
        SizedBox(
          height: 5,
        ),
        FloatingActionButton(
          heroTag: "2",
          onPressed: () {
            context.read<CounterBlock>().add(CounterAzalt());
          },
          child: Icon(Icons.remove),
          tooltip: "Azalt",
        ),
        FloatingActionButton(
          heroTag: "3",
          onPressed: () {
            context.read<ThemeCubit>().temaDegistir();
          },
          child: Icon(Icons.brightness_6),
          tooltip: "Tema DEğiştir",
        ),
        FloatingActionButton(
          heroTag: "3",
          onPressed: () {
            context.read<SayiciCubit>().arttir();
          },
          child: Icon(Icons.accessibility),
          tooltip: "Tema DEğiştir",
        ),
      ],
    );
  }
}
