import 'package:flutter/material.dart';

Widget TextFormFieldCustom({
  required TextEditingController controller,
  var validator,
  required String lable,
  var prifixicon,
  var suffixicon,
  var suffixpress,
  var priffixpress,
  var ontap,
  var onsummit,
  var type,
  bool obscure=false,
})=>TextFormField(
  controller:controller,
  validator: validator,
  keyboardType:type ,
  onTap: ontap,
  onFieldSubmitted: onsummit,
  obscureText: obscure,
  cursorColor: Colors.black,
  decoration: InputDecoration(
      labelText: lable,labelStyle: TextStyle(fontWeight: FontWeight.w600,fontSize: 20),
      prefix: prifixicon !=null ?IconButton(onPressed:priffixpress, icon: Icon(prifixicon)):null,
      suffix: suffixicon !=null ?IconButton(onPressed:suffixpress, icon: Icon(suffixicon)):null,
      border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(width: 1,color: Colors.black)
      ),
  ),
);


Widget CustomBotton({
   var ontap,required String name,
})=>InkWell(
  onTap:ontap ,
  child: Container(
    height: 70,width: double.maxFinite,
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(20),
    ),
    child: Center(child: Text(name,style: TextStyle(color: Colors.black,fontSize: 30,letterSpacing: 3,fontWeight: FontWeight.bold),)),
  ),
);