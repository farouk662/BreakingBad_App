import 'dart:io';

import 'package:breaking_bad/cubit/cubit.dart';
import 'package:breaking_bad/network/dio_helper.dart';
import 'package:breaking_bad/screens/Characters_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  DioHelper.init();
  HttpOverrides.global = MyHttpOverrides();
  runApp(const MyApp());
}
class MyHttpOverrides extends HttpOverrides{
  @override
  HttpClient createHttpClient(SecurityContext? context){
    return super.createHttpClient(context)
      ..badCertificateCallback = (X509Certificate cert, String host, int port)=> true;}}
class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context)=>AppCubit()..getCharactersData(),
      child: const MaterialApp(debugShowCheckedModeBanner: false,

        home: CharactersScreen(),
      ),
    );
  }
}
