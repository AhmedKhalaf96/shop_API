import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:online_store/layoute/cubit/shop_cubit.dart';
import 'package:online_store/layoute/cubit/shop_state.dart';
import 'package:online_store/module/login.dart';
import 'package:online_store/shared/network/cash_helper.dart';
import 'package:online_store/shared/component/component.dart';
import 'package:online_store/shared/const.dart';

class SettingScreen extends StatelessWidget {
   SettingScreen({Key? key}) : super(key: key);
   var nameController=TextEditingController();
   var emailController=TextEditingController();
   var phoneController=TextEditingController();

   @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit,ShopStates>(
      listener: (context, state) {},
      builder: (context, state) {
        nameController.text=ShopCubit.get(context).userModel.data.name;
        emailController.text=ShopCubit.get(context).userModel.data.email;
        phoneController.text=ShopCubit.get(context).userModel.data.phone;
        return Scaffold(
          backgroundColor: Colors.black,
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.only(top: 30.0,right: 10,left: 10,bottom: 10),
              child: Column(
                children: [
                  Container(
                    height: 400,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: Colors.white,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 20.0,horizontal: 15),
                      child: Column(
                        children: [
                          TextFormFieldCustom(
                            controller: nameController,
                            lable: 'Name',suffixicon: Icons.person,
                          ),
                          SizedBox(height: 35,),
                          TextFormFieldCustom(
                            controller: emailController,
                            lable: 'Email',suffixicon: Icons.email,
                          ),
                          SizedBox(height: 35,),
                          TextFormFieldCustom(
                            controller: phoneController,
                            lable: 'Phone',suffixicon: Icons.phone_android,
                          ),

                        ],
                      ),
                    ),
                  ),
                  // Spacer(),
                  SizedBox(height: 80,),
                  CustomBotton(name: 'Update',ontap: (){
                    ShopCubit.get(context).UpdateUsersData(name: nameController.text,
                    email: emailController.text,phone: phoneController.text
                    );
                  }),
                  SizedBox(height: 20,),
                  CustomBotton(
                      ontap: (){
                        signout(context);
                      },
                      name: 'LOGOUT'
                  ),

                ],
              ),
            ),
          ),
        );
      },

    );
  }
}
