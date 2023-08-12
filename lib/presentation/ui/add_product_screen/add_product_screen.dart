import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:task_app/core/helpers/helper_functions.dart';
import 'package:task_app/core/utlis/enums.dart';
import 'package:task_app/core/widgets/cached_image_widget.dart';
import 'package:task_app/core/widgets/circular_progress.dart';
import 'package:task_app/core/widgets/text_field_widget.dart';
import 'package:task_app/domin/entities/product.dart';
import 'package:task_app/presentation/controller/cubit/app_cubit.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';

import '../../../core/layout/app_assets.dart';
import '../../../core/layout/app_fonts.dart';
import '../../../core/layout/palette.dart';
import '../../../core/utlis/strings.dart';
import '../../../core/widgets/custom_button.dart';
import '../../../core/widgets/texts.dart';

import '../../../domin/entities/category.dart';
import 'components/title_field_widget.dart';

class AddProductScreen extends StatefulWidget {
  const AddProductScreen({super.key});

  @override
  State<AddProductScreen> createState() => _AddProductScreenState();
}

class _AddProductScreenState extends State<AddProductScreen> {
  final _controllerName = TextEditingController();

  final _controllerNameStore = TextEditingController();

  final _controllerPrice = TextEditingController();

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _controllerName.dispose();
    _controllerNameStore.dispose();
    _controllerPrice.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // ** app bar
      appBar: AppBar(
        centerTitle: true,
        title: const Texts(
          title: Strings.addProducts,
          textColor: Colors.black,
          fontSize: 20,
          fontFamily: AppFonts.moM,
        ),
        leading: Padding(
          padding: const EdgeInsets.only(right: 10.0, top: 5, bottom: 5),
          child: CustomIconButton(
            height: 50,
            width: 50,
            icon: SvgPicture.asset(AppAssets.backIcon),
            onPressed: () {
              pop(context);
            },
            backgroundColor: Colors.white,
          ),
        ),
      ),
      body: BlocBuilder<AppCubit, AppState>(
        builder: (context, state) {
          return Padding(
            padding: const EdgeInsets.only(
                left: 16.0, right: 16, top: 10, bottom: 0),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  // ** images product
                  const TitleFieldWidget(
                    title: Strings.imagesProduct,
                  ),
                  const SizedBox(
                    height: 16,
                  ),

                  SizedBox(
                    height:state.images.isEmpty?0: 100,
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      children: List.generate(
                          state.images.length,
                          (index) => Container(
                                height: 100,
                                width: 95,
                                margin:
                                    const EdgeInsets.symmetric(horizontal: 1),
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(5)),
                                child: Stack(
                                  children: [
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(5),
                                      child: CachedNetworkImageWidget(
                                          image: state.images[index],
                                          width: double.infinity,
                                          height: double.infinity,
                                          iconError: const Icon(Icons.error)),
                                    ),
                                    Align(
                                      alignment: Alignment.topLeft,
                                      child: GestureDetector(
                                        onTap: () {
                                          AppCubit.get(context)
                                              .removeImage(state.images[index]);
                                        },
                                        child: Container(
                                            height: 25,
                                            width: 25,
                                            padding: const EdgeInsets.all(1),
                                            margin: const EdgeInsets.all(5),
                                            decoration: const BoxDecoration(
                                                shape: BoxShape.circle,
                                                color: Colors.red),
                                            child: const Icon(
                                              Icons.close,
                                              color: Colors.white,
                                              size: 15,
                                            )),
                                      ),
                                    )
                                  ],
                                ),
                              )).toList(),
                    ),
                  ),

                  const SizedBox(
                    height: 14,
                  ),
                  state.images.length == 4
                      ? const SizedBox()
                      : state.uploadImagesState == RequestState.loading
                          ? const SizedBox(
                              height: 60,
                              child: Center(child: CustomCircularProgress()),
                            )
                          : CustomIconButton(
                              backgroundColor: Palette.mainColor,
                              height: 60,
                              width: double.infinity,
                              onPressed: () {
                                AppCubit.get(context).uploadImages();
                              },
                              icon: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  SvgPicture.asset(AppAssets.addPhotoIcon),
                                  const SizedBox(
                                    width: 12,
                                  ),
                                  const Texts(
                                      title: Strings.addPhoto,
                                      textColor: Colors.white,
                                      fontSize: 14,
                                      fontFamily: AppFonts.moL)
                                ],
                              )),
                  const SizedBox(
                    height: 26,
                  ),
                  // **************
                  // *** name Product
                  const TitleFieldWidget(
                    title: Strings.nameProduct,
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  // **
                  TextFieldWidget(
                      hint: Strings.nameProduct,
                      controller: _controllerName,
                      type: TextInputType.text),
                  const SizedBox(
                    height: 21,
                  ),
                  // ********
                  // *** name Stor
                  const TitleFieldWidget(
                    title: Strings.nameStore,
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  // **
                  TextFieldWidget(
                      hint: Strings.nameStore,
                      controller: _controllerNameStore,
                      type: TextInputType.text),
                  const SizedBox(
                    height: 21,
                  ),
                  // ********

                  // *** price Product
                  const TitleFieldWidget(
                    title: Strings.price,
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  // **
                  TextFieldWidget(
                      hint: Strings.price,
                      controller: _controllerPrice,
                      type:  const TextInputType.numberWithOptions(
                            decimal: true,
                            signed: false,
                          ),),
                  const SizedBox(
                    height: 21,
                  ),
                  // ********
                  // ** category
                  const TitleFieldWidget(
                    title: Strings.category,
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  GestureDetector(
                    onTap: () {
                      showBottomSheetWidget(
                          context,
                          Container(
                            padding: const EdgeInsets.only(
                                top: 40, left: 30, right: 30, bottom: 20),
                            decoration: const BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(15),
                                    topRight: Radius.circular(15))),
                            height: 350,
                            width: double.infinity,
                            child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  const Texts(
                                    title: "الأقسام",
                                    fontFamily: AppFonts.moM,
                                    fontSize: 18,
                                    textColor: Colors.black,
                                  ),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  Expanded(
                                      child: ListView.builder(
                                          itemCount:
                                              state.home!.categories.length,
                                          itemBuilder: (ctx, index) {
                                            Category categoryModel =
                                                state.home!.categories[index];
                                            return GestureDetector(
                                              onTap: () {
                                                AppCubit.get(context)
                                                    .changeCurrentCategory(
                                                        categoryModel);
                                                pop(context);
                                              },
                                              child: Container(
                                                height: 60,
                                                alignment: Alignment.center,
                                                decoration: const BoxDecoration(
                                                    border: Border(
                                                        bottom: BorderSide(
                                                            color:
                                                                Colors.black45,
                                                            width: .8))),
                                                child: Row(
                                                  children: [
                                                    Texts(
                                                      title: categoryModel.name,
                                                      fontFamily: AppFonts.moM,
                                                      fontSize: 15,
                                                      textColor: Colors.black,
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            );
                                          }))
                                ]),
                          ));
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      height: 60,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: const Color(0xfffefefe),
                        borderRadius: BorderRadius.circular(10.0),
                        border:
                            Border.all(width: 1.0, color: Palette.borderColor),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Texts(
                              title: state.categorySelected != null
                                  ? state.categorySelected!.name
                                  : Strings.category,
                              textColor: Palette.blueColor,
                              fontSize: 12,
                              fontFamily: AppFonts.moR),
                          SvgPicture.asset(AppAssets.dropIcon)
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 30),
                  // ********
                  // *** button add
                state.addProductState==RequestState.loading?
                const CustomCircularProgress()
                
                :  CustomIconButton(
                      backgroundColor: Palette.mainColor,
                      height: 60,
                      width: double.infinity,
                      onPressed: () {
                        if (isValidate(context, state)) {
                          Product product = Product(
                              id: 0,
                              name: _controllerName.text,
                              nameStore: _controllerNameStore.text,
                              detail: "detail",
                              price: double.parse(_controllerPrice.text),
                              images: state.images.join("#"),
                              categoryId: state.categorySelected!.id,
                              status: 0);
                          AppCubit.get(context).addProduct(product,context: context);
                        }
                      },
                      icon: const Texts(
                          title: Strings.addProduct,
                          textColor: Colors.white,
                          fontSize: 18,
                          fontFamily: AppFonts.moR)),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  bool isValidate(BuildContext context, AppState state) {
    if (_controllerName.text.isEmpty || _controllerName.text == "") {
      showTopMessage(
          context: context,
          customBar: const CustomSnackBar.error(
            backgroundColor: Colors.red,
            message: Strings.enterNameProduct,
            textStyle: TextStyle(fontSize: 16, color: Colors.white),
          ));
      return false;
    } else if (_controllerNameStore.text.isEmpty ||
        _controllerNameStore.text == "") {
      showTopMessage(
          context: context,
          customBar: const CustomSnackBar.error(
            backgroundColor: Colors.red,
            message: Strings.enterNameMarket,
            textStyle: TextStyle(fontSize: 16, color: Colors.white),
          ));
      return false;
    } else if (_controllerPrice.text.isEmpty || _controllerPrice.text == "") {
      showTopMessage(
          context: context,
          customBar: const CustomSnackBar.error(
            backgroundColor: Colors.red,
            message: Strings.enterPrice,
            textStyle: TextStyle(fontSize: 16, color: Colors.white),
          ));
      return false;
    } else if (state.images.isEmpty) {
      showTopMessage(
          context: context,
          customBar: const CustomSnackBar.error(
            backgroundColor: Colors.red,
            message: Strings.selectPhotos,
            textStyle: TextStyle(fontSize: 16, color: Colors.white),
          ));
      return false;
    } else if (state.categorySelected == null) {
      showTopMessage(
          context: context,
          customBar: const CustomSnackBar.error(
            backgroundColor: Colors.red,
            message: Strings.selectCategory,
            textStyle: TextStyle(fontSize: 16, color: Colors.white),
          ));
      return false;
    } else {
      return true;
    }
  }
}
