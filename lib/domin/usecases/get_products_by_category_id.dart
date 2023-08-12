import 'package:dartz/dartz.dart';
import 'package:task_app/domin/entities/product.dart';

import '../../core/failur/failure.dart';

import '../repostiory/base_repository.dart';

class GetProductsByCategoryIdUseCase {
  final BaseRepository repository;

  GetProductsByCategoryIdUseCase(this.repository);

  Future<Either<Failure, List<Product>>> execute({categoryId}) async {
    return await repository.getProductsByCategoryId(categoryId: categoryId);
  }
}
