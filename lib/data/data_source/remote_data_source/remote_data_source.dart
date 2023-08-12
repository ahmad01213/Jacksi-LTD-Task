import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:task_app/data/models/product_model.dart';
import 'package:task_app/domin/entities/product.dart';
import '../../../core/network/error_message_model.dart';
import '../../../core/utlis/api_constatns.dart';
import '../../../core/utlis/strings.dart';
import '../../../domin/entities/home.dart';
import '../../models/home_model.dart';

abstract class BaseRemoteDataSource {
  Future<Home> getHome();
  Future<List<Product>> getProductsByCategoryId({categoryId});
  Future<String> addProduct({product});
  Future<String> uploadImages({file});
}

class RemoteDataSource implements BaseRemoteDataSource {
  @override
  Future<Home> getHome() async {
    final response = await Dio().get(
      ApiConstants.getDataHomePath,
    );
    if (response.statusCode == 200) {
      return HomeModel.fromJson(response.data);
    } else {
      throw ErrorMessageModel(
          statusCode: response.statusCode!,
          statusMessage: "حدث خطأ, حاول مرة أخرى");
    }
  }

  @override
  Future<String> addProduct({product}) async {
    var data = FormData.fromMap({
      'name': product.name,
      'nameStore': product.nameStore,
      'images': product.images,
      'Detail': "datails",
      'Price': product.price.toString(),
      'CategoryId': product.categoryId.toString(),
      'Status': '2'
    });

    var dio = Dio();
    var response = await dio.request(
      ApiConstants.addProductPath,
      options: Options(
        method: 'POST',
      ),
      data: data,
    );

    if (kDebugMode) {
      print(response.statusCode.toString() + " ========> ");
    }
    if (response.statusCode == 200) {
      return Strings.succes;
    } else {
      throw ErrorMessageModel(
          statusCode: response.statusCode!,
          statusMessage: "حدث خطأ, حاول مرة أخرى");
    }
  }

  @override
  Future<List<Product>> getProductsByCategoryId({categoryId}) async {
    var dio = Dio();
    var response = await dio.request(
      '${ApiConstants.getProductsByCategoryIdPath}categoryId=${categoryId.toString()}',
      options: Options(
        method: 'GET',
      ),
    );

    if (response.statusCode == 200) {
      return List<ProductModel>.from(
          (response.data as List).map((e) => ProductModel.fromJson(e)));
    } else {
      throw ErrorMessageModel(
          statusCode: response.statusCode!,
          statusMessage: "حدث خطأ, حاول مرة أخرى");
    }
  }

  @override
  Future<String> uploadImages({file}) async {
    String fileName = file.path.split('/').last;

    FormData data = FormData.fromMap({
      "file": await MultipartFile.fromFile(
        file.path,
        filename: fileName,
      ),
    });

    final response =
        await Dio().post(ApiConstants.uploadImagesPath, data: data);

    if (response.statusCode == 200) {
      return response.data;
    } else {
      throw ErrorMessageModel(
          statusCode: response.statusCode!,
          statusMessage: "حدث خطأ, حاول مرة أخرى");
    }
  }
}
