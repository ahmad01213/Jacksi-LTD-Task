import 'package:dartz/dartz.dart';

import '../../core/failur/failure.dart';
import '../repostiory/base_repository.dart';

class UploadImagesUseCase{
  final BaseRepository repository;

  UploadImagesUseCase(this.repository);

 Future<Either<Failure,String>> execute({file})async{

    return await repository.uploadImages(file: file);
  }
  
}