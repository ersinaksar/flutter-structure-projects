import 'package:block_paket/counter_bloc/counter_block.dart';
import 'package:block_paket/counter_bloc/counter_event.dart';
import 'package:block_paket/counter_bloc/counter_state.dart';
import 'package:block_paket/theme_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
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
          home: BlocProvider(
              create: (context) => CounterBlock(), child: MyHomePage()),
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
          }),
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
          child: Icon(Icons.remove),
          tooltip: "Tema DEğiştir",
        ),
      ],
    );
  }
}
