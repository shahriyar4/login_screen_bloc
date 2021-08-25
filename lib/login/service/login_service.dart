import 'dart:io';
import 'package:dio/dio.dart';
import 'package:screen_bloc/login/model/login_response_model.dart';
import 'package:screen_bloc/login/model/login_request_model.dart';
import 'package:screen_bloc/login/service/ILoginService.dart';

class LoginService extends ILoginService {
  LoginService(Dio dio) : super(dio);

  @override
  Future<LoginResponseModel?> postuserLogin(LoginRequestModel model) async {
    final response = await dio.post(loginPath, data: model);

    if (response.statusCode == HttpStatus.ok) {
      return LoginResponseModel.fromJson(response.data);
    } else {
      return null;
    }
  }
}
