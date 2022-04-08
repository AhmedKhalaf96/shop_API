import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:online_store/model/login_model.dart';
import 'package:online_store/module/module_cubit/module_state.dart';
import 'package:online_store/shared/network/dio_helper.dart';
import 'package:online_store/shared/network/end_points.dart';
class ModulesCubit extends Cubit<ModulesStates> {
  ModulesCubit() : super(ModulesInitialState());
  static ModulesCubit get(context) => BlocProvider.of(context);

  late ShopLoginModel loginModel;

  void userlogin({required String email, required String password,
  }) {
    emit(UserLoginLoad());
    DioHelper.postData(url: LOGIN, data:
    {
      "email": email,
      "password": password,
    },).then((value) {
      loginModel=ShopLoginModel.fromJson(value.data);
      print(loginModel.data.token);
      emit(UserLoginSuccess(loginModel));
    }).catchError((error) {
      print(error.toString());
      emit(UserLoginError());
    });
  }

  void UserRegister({required String email, required String password,
    required String name, required String phone,
  }) {
    emit(UserRegisterLoad());
    DioHelper.postData(url: SIGNUP, data:
    {
      "name":name,
      "email": email,
      "password": password,
      "phone":phone
    }).then((value) {
      emit(UserRegisterSuccess());
    }).catchError((error) {
      print(error.toString());
      emit(UserRegisterError());
    });
  }
  }