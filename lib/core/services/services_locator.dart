import 'package:get_it/get_it.dart';
import 'package:task_app/domin/repostiory/base_repository.dart';
import 'package:task_app/domin/usecases/add_product_use_case.dart';
import 'package:task_app/domin/usecases/get_home_use_case.dart';
import 'package:task_app/domin/usecases/get_products_by_category_id.dart';
import 'package:task_app/domin/usecases/upload_images_use_case.dart';
import 'package:task_app/presentation/controller/cubit/app_cubit.dart';

import '../../data/data_source/remote_data_source/remote_data_source.dart';
import '../../data/repository/repository.dart';

final sl = GetIt.instance;

class ServicesLocator {
  void init() {
    // ** bloc
    sl.registerFactory(() => AppCubit(sl(), sl(), sl(), sl()));

    //** */ use Cases
    sl.registerLazySingleton(() => GetHomeUseCase(sl()));
    sl.registerLazySingleton(() => GetProductsByCategoryIdUseCase(sl()));
    sl.registerLazySingleton(() => AddProductUseCase(sl()));
    sl.registerLazySingleton(() => UploadImagesUseCase(sl()));

    // *** repository
    sl.registerLazySingleton<BaseRepository>(() => Repository(sl()));

    // ** data source
    sl.registerLazySingleton<BaseRemoteDataSource>(() => RemoteDataSource());
  }
}
