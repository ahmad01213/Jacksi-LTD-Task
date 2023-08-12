import 'package:equatable/equatable.dart';
import 'package:task_app/domin/entities/category.dart';

import 'package:task_app/domin/entities/product.dart';

class Home extends Equatable {
  final  List<Category> categories;
  final List<Product> products;

  const Home({required this.categories, required this.products});
  
  @override

  List<Object> get props =>[categories,products];
}
