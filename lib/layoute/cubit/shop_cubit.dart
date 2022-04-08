import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:online_store/layoute/cubit/shop_state.dart';
import 'package:online_store/model/category_model.dart';
import 'package:online_store/model/change_favorite.dart';
import 'package:online_store/model/favorite_model.dart';
import 'package:online_store/model/home_model.dart';
import 'package:online_store/model/login_model.dart';
import 'package:online_store/model/search_model.dart';
import 'package:online_store/module/category_screen.dart';
import 'package:online_store/module/favorites_screen.dart';
import 'package:online_store/module/home_screen.dart';
import 'package:online_store/module/setting_screen.dart';
import 'package:online_store/shared/const.dart';
import 'package:online_store/shared/network/dio_helper.dart';
import 'package:online_store/shared/network/end_points.dart';

class ShopCubit extends Cubit<ShopStates> {
  ShopCubit() : super(ShopInitialState());

  static ShopCubit get(context) => BlocProvider.of(context);

  int currentIndex = 0;
   HomeModel? homeModel;
  late CategoryModel categoryModel;
  List<Widget>screens = [
    HomeScreen(),
    CategoryScreen(),
    FavoriteScreen(),
    SettingScreen()
  ];
  List<String>titles = [
    'Home',
    'Category',
    'Favorite',
    'Setting',
  ];
  void Scr(var ind){
    currentIndex = ind;
    emit(ShopApptChangeState());
  }
  Map<int, bool>? favorites={};
  void getHomeData(){
    emit(HomeDataLoadState());
    DioHelper.getData(url: HOME,token: token1).then((value){
      homeModel=HomeModel.fromJson(value.data);
      homeModel!.data.products.forEach((element) {
        favorites!.addAll({
          element.id:
          element.in_favorites
        });
      });
      emit(HomeDataSuccessState());
    }).catchError((error){
      emit(HomeDataErrorState());
    });
  }

  void getCategoryData(){
    emit(CategoryDataLoadState());
    DioHelper.getData(url: CATEGORY).then((value){
      categoryModel=CategoryModel.fromJson(value.data);
      emit(CategoryDataSuccessState());
    }).catchError((error){
      emit(CategoryDataErrorState());
    });
  }
  
  late ChangeFavorite changeFavorite;
  void changeFavorites(int productId){
    favorites![productId] = !favorites![productId]!;
    DioHelper.postData(url: FAVORITES, data: {'product_id':productId},token: token1).then((value){
      changeFavorite=ChangeFavorite.fromJson(value.data);
      print(favorites);
      print(value.data);
      if(changeFavorite.status==false){
        favorites![productId] = !favorites![productId]!;
      }else{
        getFavoritesData();
      }
      emit(FavoritesSuccessState(changeFavorite));
    }).catchError((error){
      favorites![productId] = !favorites![productId]!;
      emit(FavoritesErrorState());

    });
  }

  late FavoritesModel favoritesModel;
  void getFavoritesData(){
    emit(GetFavoritesDataLoadState());
    DioHelper.getData(url: FAVORITES,token: token1).then((value){
      favoritesModel=FavoritesModel.fromJson(value.data);
      emit(GetFavoritesDataSuccessState());
    }).catchError((error){
      emit(GetFavoritesDataErrorState());
    });
  }

  late ShopLoginModel userModel;
  void getUsersData(){
    DioHelper.getData(url: PROFILE,token: token1).then((value){
      userModel=ShopLoginModel.fromJson(value.data);
      print(userModel.data.name);
      emit(GetUserDataSuccessState());
    }).catchError((error){
      print(error.toString());
      emit(GetUserDataErrorState());
    });
  }

  void UpdateUsersData({
    required String name,
    required String email,
    required String phone,

  }){
    emit(UserUpdateProfileLoad());
    DioHelper.putData(url: UPDATEPROFILE,token: token1,data:{
      'name':name,'email':email,'phone':phone,
    } ).then((value){
      userModel=ShopLoginModel.fromJson(value.data);
      print(userModel.data.name);
      emit(UserUpdateProfileSuccess(userModel));
    }).catchError((error){
      print(error.toString());
      emit(UserUpdateProfileError());
    });
  }

  SearchModel? searchModel;
  void search(String text){
    emit(SeachDataLoadState());
    DioHelper.postData(url: SEARCH,token: token1, data: {
      'text':text,
    }).then((value){
      searchModel=SearchModel.fromJson(value.data);
      //print(searchModel!.data!.data.toString());
      emit(SeachDataSuccessState());
    }).catchError((error){
      print(error.toString());
      emit(SeachDataErrorState());
    });
  }
}