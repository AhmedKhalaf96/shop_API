import 'package:buildcondition/buildcondition.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:online_store/layoute/cubit/shop_cubit.dart';
import 'package:online_store/layoute/cubit/shop_state.dart';
import 'package:online_store/model/favorite_model.dart';

class FavoriteScreen extends StatelessWidget {
  const FavoriteScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit,ShopStates>(
      listener: (context,state){},
      builder: (context,state){
      return Scaffold(
       backgroundColor: Colors.black,
       body: BuildCondition(
         builder:(context)=>ListView.separated(
           physics: BouncingScrollPhysics(),
             itemBuilder: (context,index)=>BuildFavItem(ShopCubit.get(context).favoritesModel.data!.data![index],context),
             separatorBuilder: (context,index)=>SizedBox(height: 1),
            itemCount: ShopCubit.get(context).favoritesModel.data!.data!.length),
         condition: State is ! GetFavoritesDataLoadState,
         fallback: (context)=>Center(child: CircularProgressIndicator()),
       )

      );
      },
    );
  }
  Widget BuildFavItem(FavoritesData model,context) => Padding(
    padding: const EdgeInsets.symmetric(vertical: 10),
    child: Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadiusDirectional.circular(20),
      ),
      height: 130,
      child: Stack(
        alignment: AlignmentDirectional.topStart,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 1),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(width: 15,),
                Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadiusDirectional.only(
                        topStart: Radius.circular(20),
                      ),
                    ),
                    child: Image(image: NetworkImage('${model.product!.image}'),width: 120,fit: BoxFit.cover,height: 120,)),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0,vertical: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 20,),
                        Text('${model.product!.name}',maxLines: 2,overflow: TextOverflow.ellipsis,style: TextStyle(fontWeight: FontWeight.bold,fontSize: 17),),
                        Spacer(),
                        Row(
                          children: [
                            Text('${model.product!.price}',maxLines: 2,overflow: TextOverflow.ellipsis,style: TextStyle(fontWeight: FontWeight.bold,fontSize: 15,color:Colors.green),),
                            SizedBox(width: 15,),
                            if(model.product!.discount!=0)
                              Text('${model.product!.oldPrice.toString()}',maxLines: 2,overflow: TextOverflow.ellipsis,style: TextStyle(fontWeight: FontWeight.bold,fontSize: 15,color: Colors.grey,decoration: TextDecoration.lineThrough),),
                            Spacer(),
                            IconButton(onPressed: (){
                              ShopCubit.get(context).changeFavorites(model.product!.id!);
                            }, icon: Icon(Icons.favorite,color: ShopCubit.get(context).favorites![model.product!.id]==true?Colors.red:Colors.grey,
                            )),
                          ],
                        ),
                      ],
                    ),
                  ),
                )

              ],
            ),
          ),
          if(model.product!.discount !=0)
            Container(
              decoration: BoxDecoration(
                color: Colors.red,
                borderRadius: BorderRadiusDirectional.only(
                  topStart: Radius.circular(20),
                ),
              ),
              width: 150,
              height: 30,
              child: Center(child: Text('Discound Is : ${model.product!.discount} %',style: TextStyle(color: Colors.white,fontSize: 17,fontWeight: FontWeight.bold))),
            )
        ],
      ),
    ),
  );
}
