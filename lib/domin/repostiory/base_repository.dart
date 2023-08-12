import 'package:dartz/dartz.dart';
import 'package:task_app/domin/entities/product.dart';

import '../../core/failur/failure.dart';
import '../entities/home.dart';

abstract class BaseRepository{
  Future<Either<Failure, Home>> getHomeData();
  Future<Either<Failure, List<Product>>> getProductsByCategoryId({categoryId});
  Future<Either<Failure, String>> addProduct({product});
  Future<Either<Failure, String>> uploadImages({file});


}