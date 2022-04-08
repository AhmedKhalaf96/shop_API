import 'package:buildcondition/buildcondition.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:online_store/layoute/cubit/shop_cubit.dart';
import 'package:online_store/layoute/cubit/shop_state.dart';
import 'package:online_store/model/category_model.dart';

class CategoryScreen extends StatelessWidget {
  const CategoryScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit,ShopStates>(
        listener: (context,state){},
        builder:(context,state){
          return Scaffold(
            backgroundColor: Colors.black,
            body: BuildCondition(
              condition: state is ShopApptChangeState,
              fallback: (context)=>Center(child: CircularProgressIndicator()),
              builder: (context)=>categoryBuilder(ShopCubit.get(context).categoryModel),
            ),
          );
        });
  }
  Widget categoryBuilder(CategoryModel model)=>SingleChildScrollView(
    physics: BouncingScrollPhysics(),
    child: Column(
      children: [
        Container(
          color: Colors.black,
          child: GridView.count(
              mainAxisSpacing: 5,crossAxisSpacing: 5,childAspectRatio: 1/.6,
              crossAxisCount: 1,shrinkWrap: true,physics: NeverScrollableScrollPhysics(),
              children: List.generate(model.data.data.length, (index) =>BuildProductGrid(model.data.data[index]))
          ),
        )
      ],
    ),
  );
  Widget BuildProductGrid(CategoryData model)=>Container(
    color: Colors.white,
    child: Stack(
      alignment: AlignmentDirectional.topStart,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image(image: NetworkImage(model.image),width: double.infinity,fit: BoxFit.cover,height: 200,),
            SizedBox(height: 10,),
            Center(child: Text(model.name,style: TextStyle(fontSize: 30,fontWeight: FontWeight.bold),))
          ],
        ),
      ],
    ),
  );
}
