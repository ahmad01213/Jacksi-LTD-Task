
import 'package:task_app/data/models/category_model.dart';
import 'package:task_app/data/models/product_model.dart';
import 'package:task_app/domin/entities/category.dart';

import '../../domin/entities/home.dart';

class HomeModel extends Home {
  const HomeModel({required super.categories, required super.products});

  factory HomeModel.fromJson(Map<String, dynamic> json) {
    return HomeModel(
        categories: List<Category>.from(
            (json["categories"] as List).map((e) => CategoryModel.fromJson(e))),
        products: List<ProductModel>.from(
            (json["products"] as List).map((e) => ProductModel.fromJson(e))));
  }
}
