import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:screen_bloc/login/service/login_service.dart';
import 'package:screen_bloc/login/view/login_detail_view.dart';
import 'package:screen_bloc/login/viewmodel/login_cubit.dart';

class LoginView extends StatelessWidget {
  final GlobalKey<FormState> formKey = GlobalKey();

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final String baseUrl = 'https://reqres.in/api';

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LoginCubit(
        formKey,
        emailController,
        passwordController,
        service: LoginService(
          Dio(BaseOptions(baseUrl: baseUrl)),
        ),
      ),
      child: BlocConsumer<LoginCubit, LoginState>(
        listener: (context, state) {
          if (state is LoginCompleted) {
            state.navigate(context);
          }
        },
        builder: (context, state) {
          return buildScaffold(context, state);
        },
      ),
    );
  }

  Scaffold buildScaffold(BuildContext context, LoginState state) {
    return Scaffold(
        appBar: buildAppBar(context),
        body: Form(
          key: formKey,
          autovalidateMode: state is LoginValidateState
              ? (state.isValidate
                  ? AutovalidateMode.always
                  : AutovalidateMode.disabled)
              : AutovalidateMode.disabled,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              buildFormFieldEmail(),
              SizedBox(height: MediaQuery.of(context).size.height * 0.03),
              buildFormFieldPassword(),
              SizedBox(height: MediaQuery.of(context).size.height * 0.03),
              buildElevatedLoginButton(context)
            ],
          ),
        ));
  }

  Widget buildElevatedLoginButton(BuildContext context) {
    return BlocConsumer<LoginCubit, LoginState>(
      listener: (context, state) {},
      builder: (context, state) {
        if (state is LoginCompleted) {
          return Card(
              child: Icon(
            Icons.check,
          ));
        }
        return ElevatedButton(
            onPressed: () {
              context.read<LoginCubit>().postUserModel();
            },
            child: Text("Save"));
      },
    );
  }

  AppBar buildAppBar(BuildContext context) {
    return AppBar(
      title: Text('LoginView'),
      leading: Visibility(
          visible: context.watch<LoginCubit>().isLoading,
          child: Padding(
            padding: EdgeInsets.all(12.0),
            child: CircularProgressIndicator(),
          )),
    );
  }

  TextFormField buildFormFieldPassword() {
    return TextFormField(
      controller: passwordController,
      validator: (value) => (value ?? '').length > 5 ? null : "5den kicikdir",
      decoration:
          InputDecoration(border: OutlineInputBorder(), labelText: "Password"),
    );
  }

  TextFormField buildFormFieldEmail() {
    return TextFormField(
      controller: emailController,
      validator: (value) => (value ?? '').length > 6 ? null : "6den kicikdir",
      decoration:
          InputDecoration(border: OutlineInputBorder(), labelText: "E-mail"),
    );
  }
}

extension LoginCompletedExtension on LoginCompleted {
  void navigate(BuildContext context) {
    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) => LoginDetailViev(model: model),
    ));
  }
}
