import 'package:online_store/model/login_model.dart';

abstract class ModulesStates{}

class ModulesInitialState extends ModulesStates{}

class UserLoginLoad extends ModulesStates{}

class UserLoginSuccess extends ModulesStates{
  final ShopLoginModel loginModel;
  UserLoginSuccess(this.loginModel);
}

class UserLoginError extends ModulesStates{}

class UserRegisterLoad extends ModulesStates{}

class UserRegisterSuccess extends ModulesStates{}

class UserRegisterError extends ModulesStates{}

