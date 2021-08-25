import 'package:flutter/material.dart';
import 'package:screen_bloc/login/model/login_response_model.dart';

class LoginDetailViev extends StatelessWidget {
  final LoginResponseModel model;

  const LoginDetailViev({Key? key, required this.model}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Detail page"),
      ),
      body: Center(
        child: Container(
          child: Text(model.token ?? ''),
        ),
      ),
    );
  }
}
