import 'package:dartz/dartz.dart';

import '../../core/failur/failure.dart';
import '../entities/home.dart';
import '../repostiory/base_repository.dart';

class GetHomeUseCase{
  final BaseRepository repository;

  GetHomeUseCase(this.repository);

 Future<Either<Failure,Home>> execute()async{

    return await repository.getHomeData();
  }
  
}