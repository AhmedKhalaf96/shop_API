
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:online_store/layoute/cubit/shop_cubit.dart';
import 'package:online_store/layoute/cubit/shop_state.dart';
import 'package:online_store/module/favorites_screen.dart';
import 'package:online_store/module/search_screen.dart';

class ShopLayoutScreen extends StatelessWidget {
  const ShopLayoutScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit,ShopStates>(
      listener: (context,state){},
      builder: (context,state){
        return Scaffold(
          appBar: AppBar(title: Text(ShopCubit.get(context).titles[ShopCubit.get(context).currentIndex],
              style: TextStyle(fontSize: 25,color: Colors.black,fontWeight: FontWeight.bold)),
            backgroundColor: Colors.grey[200],elevation: 0.0,titleSpacing: 50,actions: [
              Padding(
                padding: const EdgeInsets.only(right: 20.0),
                child: Row(
                  children: [
                    InkWell(child: Icon(Icons.search,size: 35,),onTap: (){
                      Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => SearchScreen()));
                    }),
                    SizedBox(width: 15,),
                    InkWell(
                        onTap: (){
                          Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => FavoriteScreen()));
                        },
                        child: Icon(Icons.favorite,color: Colors.red[700],size: 30,)),
                    SizedBox(width: 15,),
                    Icon(Icons.shopping_cart,size: 30,),

                  ],
                ),
              )
              ]),
          body: ShopCubit.get(context).screens[ShopCubit.get(context).currentIndex],
          bottomNavigationBar: BottomNavigationBar(
            unselectedItemColor: Colors.grey[600],
            backgroundColor:Colors.white,
            selectedItemColor: Colors.black,
            type: BottomNavigationBarType.fixed,
            currentIndex: ShopCubit.get(context).currentIndex,
            onTap:(index){
              ShopCubit.get(context).Scr(index);
            },
            items: [
              BottomNavigationBarItem(icon: Icon(Icons.home,),
                label: "home",
              ),
              BottomNavigationBarItem(icon: Icon(Icons.apps),
                label: "Category",
              ),
              BottomNavigationBarItem(icon: Icon(Icons.favorite),
                label: "Favorites",
              ),
              BottomNavigationBarItem(icon: Icon(Icons.settings),
                label: "Setting",
              ),
            ],

          ),
        );
      },
    );
  }
}
