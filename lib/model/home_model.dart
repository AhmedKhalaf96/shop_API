class HomeModel{
  late bool status;
  late HomeModelData data;

  HomeModel.fromJson(Map<String, dynamic>json){
    status=json['status'];
    data=HomeModelData.fromJson(json['data']);
  }
}
class HomeModelData{
    List<BannersModel> banners=[];
    List <ProductModel> products=[];

  HomeModelData.fromJson(Map<String, dynamic>json){
    json['banners'].forEach((element) {
      banners.add(BannersModel.fromJson(element));
    });
    json['products'].forEach((element) {
      products.add(ProductModel.fromJson(element));
    });
  }

}
class BannersModel{
  late int id;
  late String image;
  BannersModel.fromJson(Map<String, dynamic>json){
    id=json['id'];
    image=json['image'];
  }
}
class ProductModel{
    late int id;
    late dynamic price;
    late dynamic old_price;
    late dynamic discount;
    late String image;
    late String name;
    late bool in_favorites;
    late bool in_cart;

    ProductModel.fromJson(Map<String, dynamic>json){
      id=json['id'];
      price=json['price'];
      old_price=json['old_price'];
      discount=json['discount'];
      image=json['image'];
      name=json['name'];
      in_favorites=json['in_favorites'];
      in_cart=json['in_cart'];

    }

}