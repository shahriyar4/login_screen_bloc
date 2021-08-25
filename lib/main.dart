import 'package:flutter/material.dart';
import 'package:screen_bloc/login/view/login_view.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(  ),
      title: 'Material App',
      home: LoginView(),
    );
  }
}
