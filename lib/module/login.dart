import 'package:buildcondition/buildcondition.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:online_store/layoute/shop_layoute.dart';
import 'package:online_store/module/module_cubit/module_cubit.dart';
import 'package:online_store/module/module_cubit/module_state.dart';
import 'package:online_store/module/signup.dart';
import 'package:online_store/shared/network/cash_helper.dart';
import 'package:online_store/shared/component/component.dart';

class LoginScreen extends StatelessWidget {
  var emailcontroller=TextEditingController();
  var passwordcontroller=TextEditingController();


  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (BuildContext context)=>ModulesCubit(),
        child: BlocConsumer<ModulesCubit,ModulesStates>(
            listener: (context,state){
              if(state is UserLoginSuccess){
                if(state.loginModel.status){  
                  CashHelper.saveData(key: 'token', value: state.loginModel.data.token).then((value){
                    Fluttertoast.showToast(msg:'Login Success',backgroundColor: Colors.green,textColor: Colors.white);
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => ShopLayoutScreen()));
                  });
                }else{
                }
              }else if(state is UserLoginError){
                Fluttertoast.showToast(msg:'Login Error',backgroundColor: Colors.red,textColor: Colors.white);
              }
            },
            builder: (context,state){
              return Scaffold(
                backgroundColor: Colors.white,
                body: Center(
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Center(child: Image.asset('images/logo2.jpg',width: 300,height: 250,)),
                          SizedBox(height: 30,),
                          TextFormFieldCustom(
                            lable: "Email Address",
                            controller:emailcontroller,
                            type: TextInputType.emailAddress,
                            suffixicon: Icons.email,
                          ),
                          SizedBox(height: 25,),
                          TextFormFieldCustom(
                            lable: "Password",
                            controller:passwordcontroller,
                            type: TextInputType.text,
                            suffixicon: Icons.lock,
                            obscure: true,
                          ),
                          SizedBox(height: 30,),
                          Center(
                            child: InkWell(
                              onTap: (){
                                ModulesCubit.get(context).userlogin(email: emailcontroller.text, password: passwordcontroller.text);
                              },
                              child: BuildCondition(
                                builder:(context)=> Container(
                                  decoration: BoxDecoration(
                                      color: Colors.black,
                                      borderRadius:BorderRadius.circular(10)
                                  ),
                                  height: 70,
                                  width: 400,

                                  child:Center(child: Text('Login',style: TextStyle(color: Colors.white,fontSize: 25,fontWeight: FontWeight.bold),)) ,

                                ),
                                fallback: (context)=>Center(child: CircularProgressIndicator()),
                                condition: state is ! UserLoginLoad,
                              ),
                            ),
                          ),
                          SizedBox(height: 15,),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text('Don\'t have an account ? ',style: TextStyle(color: Colors.blueGrey[800],fontSize: 18),),
                              TextButton(onPressed: (){
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(builder: (context) =>  RegesterScreen()));
                              },
                                  child: Text(' Register',style: TextStyle(color: Colors.blue[800],fontSize: 18),))
                            ],
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