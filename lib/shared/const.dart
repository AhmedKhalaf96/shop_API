import 'package:flutter/material.dart';
import 'package:online_store/module/login.dart';
import 'package:online_store/shared/network/cash_helper.dart';

String token='';
String tt='UItRoHsGxAmX2e60rTZAsXdKbf51k1HP1ZY8DBHXKmAfmAme342DDDaXujjDurmXwpylXn';

String token1='AuUh0vENFzul3II1AxU05m5D0EEwuhltIaDh9DYkCNazWZiSbe3NMbr2bVNgVdcMcihRUe';


void signout(context){
  CashHelper.removeData(key: 'token').then((value){
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => LoginScreen()));

  });
}
