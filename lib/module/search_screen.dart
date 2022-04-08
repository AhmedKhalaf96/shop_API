import 'package:buildcondition/buildcondition.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:online_store/layoute/cubit/shop_cubit.dart';
import 'package:online_store/layoute/cubit/shop_state.dart';
import 'package:online_store/model/search_model.dart';
import 'package:online_store/shared/component/component.dart';

class SearchScreen extends StatelessWidget {
   SearchScreen({Key? key}) : super(key: key);
  var searchController=TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit,ShopStates>(
        listener: (context,state){},
        builder: (context,state){
          return Scaffold(
            appBar: AppBar(
              title: Text('Search',style: TextStyle(fontSize: 22,fontWeight: FontWeight.bold,)),
              backgroundColor: Colors.grey[200],elevation: 0.0,titleSpacing: 20,
              leading: Icon(Icons.arrow_back_ios),
            ),
            body: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                children: [
                  TextFormFieldCustom(
                    lable: 'Search',
                    controller: searchController,
                    suffixicon: Icons.search,
                    onsummit: (String text){
                      ShopCubit.get(context).search(text);
                    }
                  ),
                  SizedBox(height: 10,),
                  if(state is SeachDataLoadState)
                    LinearProgressIndicator(),
                  if(state is SeachDataSuccessState )
                    Expanded(
                      child: ListView.separated(
                          physics: BouncingScrollPhysics(),
                          itemBuilder: (context,index)=>Searchitem(ShopCubit.get(context).searchModel!.data!.data![index]),
                          separatorBuilder: (context,index)=>Divider(),
                          itemCount: ShopCubit.get(context).searchModel!.data!.data!.length),
                    ),
                ],
              ),
            ),
          );
        });

  }
  Widget Searchitem(Product product)=>Container(
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
                  child: Image(image: NetworkImage('${product.image}'),width: 120,fit: BoxFit.cover,height: 120,)),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0,vertical: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 20,),
                      Text('${product.name}',maxLines: 2,overflow: TextOverflow.ellipsis,style: TextStyle(fontWeight: FontWeight.bold,fontSize: 17),),
                      Spacer(),
                      Row(
                        children: [
                          Text('${product.price}',maxLines: 2,overflow: TextOverflow.ellipsis,style: TextStyle(fontWeight: FontWeight.bold,fontSize: 15,color:Colors.green),),
                        ],
                      ),
                    ],
                  ),
                ),
              ),

            ],
          ),
        ),
      ],
    ),
  );
}
