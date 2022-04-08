import 'package:buildcondition/buildcondition.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:online_store/layoute/shop_layoute.dart';
import 'package:online_store/module/module_cubit/module_cubit.dart';
import 'package:online_store/module/module_cubit/module_state.dart';
import 'package:online_store/shared/component/component.dart';


class RegesterScreen extends StatelessWidget {
  var emailcontroller=TextEditingController();
  var namecontroller=TextEditingController();
  var passwordcontroller=TextEditingController();
  var phonecontroller=TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (BuildContext context)=>ModulesCubit(),
        child: BlocConsumer<ModulesCubit,ModulesStates>(
            listener: (context,state){
              if(state is UserRegisterSuccess){
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) =>  ShopLayoutScreen())
                );
              }
            },
            builder: (context,state){
              return Scaffold(
                body: SafeArea(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 80,left: 25,right: 25 ,bottom: 10),
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Create New Account",style: TextStyle(fontSize: 30,fontWeight: FontWeight.bold,color: Colors.black),),
                          SizedBox(height: 50,),
                          TextFormFieldCustom(
                            lable: 'Name',
                            controller:namecontroller,
                            suffixicon: Icons.text_fields_outlined,
                            type: TextInputType.text,

                          ),
                          SizedBox(height: 25,),
                          TextFormFieldCustom(
                            lable: 'Email',
                            controller:emailcontroller,
                            suffixicon: Icons.email,
                            type: TextInputType.emailAddress,

                          ),
                          SizedBox(height: 25,),
                          TextFormFieldCustom(
                            lable: 'Password',
                            controller:passwordcontroller,
                            suffixicon: Icons.lock,
                            type: TextInputType.text,
                          ),
                          SizedBox(height: 25,),
                          TextFormFieldCustom(
                            lable: 'Phone',
                            controller:phonecontroller,
                            suffixicon: Icons.phone,
                            type: TextInputType.number,

                          ),
                          SizedBox(height: 30,),
                          Center(
                            child: InkWell(
                              onTap: (){
                                ModulesCubit.get(context).UserRegister(email: emailcontroller.text, password: passwordcontroller.text, name: namecontroller.text,phone: phonecontroller.text);
                              },
                              child: BuildCondition(
                                builder:(context)=> Container(
                                  decoration: BoxDecoration(
                                      color: Colors.black,
                                      borderRadius:BorderRadius.circular(10)
                                  ),
                                  height: 70,
                                  width: 400,

                                  child:Center(child: Text('Register',style: TextStyle(color: Colors.white,fontSize: 25,fontWeight: FontWeight.bold,letterSpacing: 2),)) ,

                                ),
                                fallback: (context)=>Center(child: CircularProgressIndicator()),
                                condition: state is ! UserRegisterLoad,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            }
        )
    );
  }
}