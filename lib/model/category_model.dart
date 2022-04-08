class CategoryModel{
  late bool status;
  late CategoryDataModel data;

  CategoryModel.fromJson(Map<String, dynamic>json){
    status=json['status'];
    data=CategoryDataModel.fromJson(json['data']);
  }
}
class CategoryDataModel{
  List<CategoryData> data=[];
  CategoryDataModel.fromJson(Map<String, dynamic>json){
    json['data'].forEach((element) {
      data.add(CategoryData.fromJson(element));
    });
  }

}

class CategoryData{
  late int id;
  late String name;
  late String image;
  CategoryData.fromJson(Map<String, dynamic>json){
    id=json['id'];
    name=json['name'];
    image=json['image'];
  }
}