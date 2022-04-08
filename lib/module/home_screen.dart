import 'package:buildcondition/buildcondition.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:online_store/layoute/cubit/shop_cubit.dart';
import 'package:online_store/layoute/cubit/shop_state.dart';
import 'package:online_store/model/home_model.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit,ShopStates>(
      listener: (context,state){
        if(state is FavoritesSuccessState){
          if(state.model.status==false){
            Fluttertoast.showToast(msg: state.model.Message.toString(),backgroundColor: Colors.red);
          }else{
            Fluttertoast.showToast(msg: state.model.Message.toString(),backgroundColor: Colors.green);
          }
        }else if(state is FavoritesErrorState){
          Fluttertoast.showToast(msg: "Error",backgroundColor: Colors.red);
        }
      },
      builder: (context,state){
        return Scaffold(
          backgroundColor: Colors.black,
          body: BuildCondition(
            condition: state is HomeDataSuccessState || ShopCubit.get(context).homeModel!=null,
            fallback: (context)=>Center(child: CircularProgressIndicator()),
            builder: (context)=>productBuilder(ShopCubit.get(context).homeModel!,context),
          ),
        );
      },
    );
  }
  Widget productBuilder(HomeModel model,context)=>SingleChildScrollView(
    physics: BouncingScrollPhysics(),
    child: Column(
      children: [
        CarouselSlider(items: model.data.banners.map((e) =>Image(
    image: NetworkImage('${e.image}'),fit: BoxFit.cover,width: double.maxFinite,)).toList(),
            options: CarouselOptions(
           height: 200,
           initialPage: 0,
           enableInfiniteScroll: true,scrollDirection: Axis.horizontal,viewportFraction: 1.0,
           reverse: false,autoPlay: true,autoPlayInterval: Duration(seconds: 3),
           autoPlayAnimationDuration: Duration(seconds: 1),autoPlayCurve: Curves.fastOutSlowIn
         )),
        SizedBox(height: 10,),
        Container(
          color: Colors.black,
          child: GridView.count(
              mainAxisSpacing: 5,crossAxisSpacing: 5,childAspectRatio: 1/1.4,
              crossAxisCount: 2,shrinkWrap: true,physics: NeverScrollableScrollPhysics(),
            children: List.generate(model.data.products.length, (index) =>BuildProductGrid(model.data.products[index],context))
          ),
        )
      ],
    ),
  );
  Widget BuildProductGrid(ProductModel model,context)=>Container(
    color: Colors.white,
    child: Stack(
      alignment: AlignmentDirectional.topStart,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image(image: NetworkImage(model.image),width: double.infinity,fit: BoxFit.cover,height: 200,),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(model.name,maxLines: 2,overflow: TextOverflow.ellipsis,style: TextStyle(fontWeight: FontWeight.bold,fontSize: 17),),
                  SizedBox(height: 2,),
                  Row(
                    children: [
                      Text('${model.price}',maxLines: 2,overflow: TextOverflow.ellipsis,style: TextStyle(fontWeight: FontWeight.bold,fontSize: 15,color:Colors.green),),
                      SizedBox(width: 15,),
                      if(model.discount!=0)
                        Text('${model.old_price}',maxLines: 2,overflow: TextOverflow.ellipsis,style: TextStyle(fontWeight: FontWeight.bold,fontSize: 15,color: Colors.grey,decoration: TextDecoration.lineThrough),),
                      Spacer(),
                      IconButton(onPressed: (){
                        ShopCubit.get(context).changeFavorites(model.id);
                      }, icon: Icon(Icons.favorite,color: ShopCubit.get(context).favorites![model.id]==true?Colors.red:Colors.grey,
                      )),
                    ],
                  ),
                ],
              ),
            )

          ],
        ),
        if(model.discount !=0)
          Container(
          width: 150,
          height: 30,
          color: Colors.red,
          child: Center(child: Text('Discound Is : ${model.discount} %',style: TextStyle(color: Colors.white,fontSize: 17,fontWeight: FontWeight.bold))),
        )
      ],
    ),
  );
}
