import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ThemeCubit extends Cubit<ThemeData> {
  ThemeCubit() : super(_acikTema);
  //static yapınca sınıf değişkeni oluyor
  static final _acikTema = ThemeData(
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        foregroundColor: Colors.white,
      ),
      brightness: Brightness.light);

  static final _koyuTema = ThemeData(
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        foregroundColor: Colors.deepOrange,
      ),
      brightness: Brightness.dark);

  void temaDegistir() {
    emit(state.brightness == Brightness.dark ? _acikTema : _koyuTema);
  }
}
