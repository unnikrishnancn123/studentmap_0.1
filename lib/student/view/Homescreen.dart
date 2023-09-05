
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:studentmap/student/service/helper.dart';
import '../blocparts/studentbloc/form bloc/form_bloc.dart';
import '../model/studentmodel.dart';
import '../widget/formwidget.dart';

class HomeScreen extends StatefulWidget {
  final Student? student;

  const HomeScreen({Key? key, this.student}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  late Helper? db;
  Student? student;

  @override
  void initState() {
    super.initState();
    FormBloc();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => FormBloc(),
      child: GetMaterialApp(
        title: 'Test App',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const FormWidget(),
      ),
    );
  }
}
