import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:online_store/layoute/cubit/shop_cubit.dart';
import 'package:online_store/layoute/shop_layoute.dart';
import 'package:online_store/module/login.dart';
import 'package:online_store/shared/network/cash_helper.dart';
import 'package:online_store/shared/component/observer.dart';
import 'package:online_store/shared/const.dart';
import 'package:online_store/shared/network/dio_helper.dart';

void main() {
  DioHelper.init();
  Widget widget;
  if(CashHelper.getData(key: 'token')==null){
    token='';
  }else{
    CashHelper.getData(key: 'token');
  }
  if(token!=null){
    widget=ShopLayoutScreen();
  }else{
    widget=LoginScreen();
  }
  BlocOverrides.runZoned(
        () {
      runApp( MyApp(widget));
    },
    blocObserver: MyBlocObserver(),
  );
}

class MyApp extends StatelessWidget {
  final Widget startwidget;
  MyApp(this.startwidget);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
        BlocProvider(create: (context)=>ShopCubit()..getHomeData()..getCategoryData()..getFavoritesData()..getUsersData())
    ],
    child: MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.grey,
      ),
      home: startwidget,
    ),
    );
  }
}
