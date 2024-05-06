import 'package:simple_grocery/data/category_items.dart';

class CategoryModel {
  final String categoryName;
  final String categoryImg;

  CategoryModel({
    required this.categoryName,
    required this.categoryImg,
  });
}

List<CategoryModel> categoryModel = categoryItems
    .map((e) => CategoryModel(
        categoryName: e['categoryName'], categoryImg: e['categoryImg']))
    .toList();
