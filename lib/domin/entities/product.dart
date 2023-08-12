import 'package:equatable/equatable.dart';

class Product extends Equatable {
  final int id;

  final String name;
  final String nameStore;

  final String detail;

  final double price;
  final String images;
  final int categoryId;

  final int status;

  const Product(
      {required this.id,
  
      required this.name,
      required this.nameStore,
      required this.detail,
      required this.price,
      required this.images,
      required this.categoryId,
      required this.status});

  @override

  List<Object> get props =>
      [id, name, nameStore, detail, price, images, categoryId, status];
}
