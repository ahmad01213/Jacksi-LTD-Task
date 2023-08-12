import 'package:dartz/dartz.dart';
import 'package:task_app/core/failur/failure.dart';
import 'package:task_app/domin/entities/product.dart';

import '../../core/error/exceptions.dart';
import '../../domin/entities/home.dart';
import '../../domin/repostiory/base_repository.dart';
import '../data_source/remote_data_source/remote_data_source.dart';

class Repository extends BaseRepository {
  final BaseRemoteDataSource baseRemoteDataSource;

  Repository(this.baseRemoteDataSource);

  @override
  Future<Either<Failure, Home>> getHomeData() async {
    final result = await baseRemoteDataSource.getHome();

    try {
      return Right(result);
    } on ServerExceptions catch (failure) {
      return Left(ServerFailure(failure.errorMessageModel.statusMessage));
    }
  }

  @override
  Future<Either<Failure, String>> addProduct({product}) async {
    final result = await baseRemoteDataSource.addProduct(product: product);

    try {
      return Right(result);
    } on ServerExceptions catch (failure) {
      return Left(ServerFailure(failure.errorMessageModel.statusMessage));
    }
  }

  @override
  Future<Either<Failure, List<Product>>> getProductsByCategoryId(
      {categoryId}) async {
    final result = await baseRemoteDataSource.getProductsByCategoryId(
        categoryId: categoryId);

    try {
      return Right(result);
    } on ServerExceptions catch (failure) {
      return Left(ServerFailure(failure.errorMessageModel.statusMessage));
    }
  }
  
  @override
  Future<Either<Failure, String>> uploadImages({file})async {
  final result = await baseRemoteDataSource.uploadImages(
        file: file);

    try {
      return Right(result);
    } on ServerExceptions catch (failure) {
      return Left(ServerFailure(failure.errorMessageModel.statusMessage));
    }
  }
}
