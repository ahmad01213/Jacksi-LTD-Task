import 'package:task_app/domin/entities/product.dart';

class ProductModel extends Product {
  const ProductModel(
      {required super.id,
      required super.name,
      required super.nameStore,
      required super.detail,
      required super.price,
      required super.images,
      required super.categoryId,
      required super.status});

  factory ProductModel.fromJson(Map<String, dynamic> json) => ProductModel(
      id: json["id"],
      name: json["name"],
      nameStore: json["nameStore"],
      detail: json["detail"],
      price: json["price"].toDouble(),
      images: json["images"],
      status: json["status"],
      categoryId: json["categoryId"]);
}
