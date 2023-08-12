import 'dart:io';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:task_app/core/helpers/helper_functions.dart';
import 'package:task_app/core/routers/routers.dart';
import 'package:task_app/core/utlis/enums.dart';
import 'package:task_app/domin/entities/category.dart';
import 'package:task_app/domin/entities/product.dart';
import 'package:task_app/domin/usecases/add_product_use_case.dart';
import 'package:task_app/domin/usecases/get_home_use_case.dart';
import 'package:task_app/domin/usecases/get_products_by_category_id.dart';
import 'package:task_app/domin/usecases/upload_images_use_case.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';

import '../../../domin/entities/home.dart';
part 'app_state.dart';

class AppCubit extends Cubit<AppState> {
  GetHomeUseCase getHomeUseCase;
  AddProductUseCase addProductUseCase;
  UploadImagesUseCase uploadImagesUseCase;
  GetProductsByCategoryIdUseCase getProductsByCategoryIdUseCase;

  AppCubit(this.getHomeUseCase, this.addProductUseCase,
      this.getProductsByCategoryIdUseCase, this.uploadImagesUseCase)
      : super(const AppState());

  static AppCubit get(context) => BlocProvider.of<AppCubit>(context);

  getHomeData() async {
    emit(state.copyWith(getHomeState: RequestState.loading, images: []));
    final result = await getHomeUseCase.execute();
    result.fold(
        (l) => emit(state.copyWith(
            getHomeState: RequestState.error, messageHome: l.message)), (r) {
      emit(state.copyWith(
          getHomeState: RequestState.loaded, home: r, products: r.products));
    });
  }

  changeDisplayList(bool value) {
    print(value);
    emit(state.copyWith(isGrid: value));
  }

  changeCurrentCategory(Category newValue) {
    emit(state.copyWith(categorySelected: newValue));
  }

  addProduct(Product product, {context}) async {
    emit(state.copyWith(addProductState: RequestState.loading));
    final result = await addProductUseCase.execute(product: product);
    result.fold(
        (l) => emit(state.copyWith(
            addProductState: RequestState.error, messageAdd: l.message)), (r) {
      showTopMessage(
          context: context,
          customBar: CustomSnackBar.success(
            backgroundColor: Colors.green,
            message: r,
            textStyle: const TextStyle(fontSize: 16, color: Colors.white),
          ));
          images = [];
      getHomeData();
      pushPageRoutName(context, home);
      emit(state.copyWith(addProductState: RequestState.loaded, images: []));
    });
  }

  getProductsByCategoryId(int categoryId) async {
    emit(state.copyWith(
        getProductsByIdState: RequestState.loading, categoryIndex: categoryId));
    final result =
        await getProductsByCategoryIdUseCase.execute(categoryId: categoryId);
    result.fold(
        (l) => emit(state.copyWith(
            getProductsByIdState: RequestState.error,
            messageProducts: l.message)), (r) {
      images = [];
      emit(state.copyWith(
          getProductsByIdState: RequestState.loaded, products: r, images: []));
    });
  }

  List<String> images = [];
  uploadImages() async {
    File image;
    final picker = ImagePicker();

    var pickedFile = await picker.pickImage(
        source: ImageSource.gallery,
        imageQuality: 50, // <- Reduce Image quality
        maxHeight: 500, // <- reduce the image size
        maxWidth: 500);

    if (pickedFile != null) {
      image = File(pickedFile.path);

      emit(state.copyWith(uploadImagesState: RequestState.loading));
      final result = await uploadImagesUseCase.execute(file: image);
      result.fold(
          (l) => emit(state.copyWith(
              addProductState: RequestState.error,
              messageAdd: l.message)), (r) {
        images.add(r);
        emit(state.copyWith(
            uploadImagesState: RequestState.loaded, images: images));
      });
    }
  }

  removeImage(String image) {
    if (images.isNotEmpty) {
      emit(state.copyWith(uploadImagesState: RequestState.loading));
      images.remove(image);
      emit(state.copyWith(
          images: images, uploadImagesState: RequestState.loaded));
    }
  }
}
