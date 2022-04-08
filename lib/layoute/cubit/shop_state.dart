import 'package:online_store/model/change_favorite.dart';
import 'package:online_store/model/login_model.dart';

abstract class ShopStates{}

class ShopInitialState extends ShopStates{}

class ShopApptChangeState extends ShopStates{}

class HomeDataLoadState extends ShopStates{}
class HomeDataSuccessState extends ShopStates{}
class HomeDataErrorState extends ShopStates{}

class CategoryDataLoadState extends ShopStates{}
class CategoryDataSuccessState extends ShopStates{}
class CategoryDataErrorState extends ShopStates{}

class FavoritesSuccessState extends ShopStates{
  final ChangeFavorite model;

  FavoritesSuccessState(this.model);
}
class FavoritesErrorState extends ShopStates{}

class GetFavoritesDataLoadState extends ShopStates{}
class GetFavoritesDataSuccessState extends ShopStates{}
class GetFavoritesDataErrorState extends ShopStates{}

class GetUserDataSuccessState extends ShopStates{}
class GetUserDataErrorState extends ShopStates{}

class UserUpdateProfileLoad extends ShopStates{}

class UserUpdateProfileSuccess extends ShopStates{
  final ShopLoginModel loginModel;
  UserUpdateProfileSuccess(this.loginModel);
}

class UserUpdateProfileError extends ShopStates{}

class SeachDataLoadState extends ShopStates{}
class SeachDataSuccessState extends ShopStates{}
class SeachDataErrorState extends ShopStates{}



