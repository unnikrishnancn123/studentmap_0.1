import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:studentmap/simple_bloc_observer.dart';
import 'package:studentmap/student/view/Homescreen.dart';




void main() {
  Bloc.observer = const SimpleBlocObserver();
  runApp( const App());
}

class App extends MaterialApp {
  const App({super.key}) : super(home: const HomeScreen());
}


