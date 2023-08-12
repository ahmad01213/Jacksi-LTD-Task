import 'package:dartz/dartz.dart';


import '../../core/failur/failure.dart';

import '../repostiory/base_repository.dart';

class AddProductUseCase{
  final BaseRepository repository;

  AddProductUseCase(this.repository);

 Future<Either<Failure,String>> execute({product})async{

    return await repository.addProduct(product: product);
  }
  
}