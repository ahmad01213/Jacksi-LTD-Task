import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:task_app/core/helpers/helper_functions.dart';
import 'package:task_app/core/layout/app_assets.dart';
import 'package:task_app/core/layout/app_fonts.dart';
import 'package:task_app/core/layout/palette.dart';
import 'package:task_app/core/routers/routers.dart';
import 'package:task_app/core/utlis/enums.dart';
import 'package:task_app/core/utlis/strings.dart';
import 'package:task_app/core/widgets/circular_progress.dart';
import 'package:task_app/core/widgets/custom_button.dart';
import 'package:task_app/core/widgets/texts.dart';
import 'package:task_app/presentation/controller/cubit/app_cubit.dart';

import 'components/grid_product_list_widget.dart';
import 'components/list_categories.dart';
import 'components/list_products.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // ** app bar
      appBar: AppBar(
        centerTitle: true,
        title: const Texts(
          title: Strings.products,
          textColor: Palette.textColor,
          fontSize: 20,
          fontFamily: AppFonts.moB,
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 5),
            child: CustomIconButton(
              height: 50,
              width: 50,
              icon: SvgPicture.asset(AppAssets.iconAdd),
              onPressed: () {
                pushPageRoutName(context, addProduct);
              },
              backgroundColor: Colors.white,
            ),
          ),
        ],
      ),

      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        child: BlocBuilder<AppCubit, AppState>(
          builder: (context, state) {
            return state.getHomeState == RequestState.loaded
                ? Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      // ** list of categories
                      const Row(
                        children: [
                          Texts(
                              title: Strings.categories,
                              textColor: Palette.textColor,
                              fontSize: 16,
                              fontFamily: AppFonts.moM),
                        ],
                      ),
                      const SizedBox(
                        height: 9,
                      ),
                      ListCategoriesWidget(categories: state.home!.categories)
                      // **********************************
                      ,
                      const SizedBox(
                        height: 14,
                      ),
                      // ** showing list or grid
                      CustomIconButton(
                          backgroundColor: Colors.white,
                          height: 36,
                          width: double.infinity,
                          onPressed: () {
                            bool value = !state.isGrid;
                            AppCubit.get(context).changeDisplayList(value);
                          },
                          icon: Row(
                            children: [
                              SvgPicture.asset(AppAssets.showGrid),
                              Texts(
                                  title: state.isGrid
                                      ? Strings.showingGrid
                                      : Strings.showingList,
                                  textColor: Palette.redColor,
                                  fontSize: 12,
                                  fontFamily: AppFonts.moR)
                            ],
                          )),
                      const SizedBox(
                        height: 16,
                      ),

                      // ***  *********

                      //** list products */
                      state.getProductsByIdState == RequestState.loading
                          ? const Expanded(
                              child: Center(
                              child: CustomCircularProgress(fullScreen: false),
                            ))
                          : state.products.isEmpty
                              ? const Expanded(
                                  child: Center(
                                  child: Texts(
                                      title: Strings.notProducts,
                                      textColor: Colors.black,
                                      fontSize: 16,
                                      fontFamily: AppFonts.moM),
                                ))
                              : state.isGrid
                                  ? GridProductListWidget(products: state.products)
                                  : ListProducts(products: state.products),
                    ],
                  )
                : const CustomCircularProgress(
                    fullScreen: true,
                  );
          },
        ),
      ),
    );
  }
}

