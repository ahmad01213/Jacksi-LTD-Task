import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:task_app/core/layout/palette.dart';

import 'package:task_app/core/widgets/cached_image_widget.dart';
import 'package:task_app/domin/entities/category.dart';
import 'package:task_app/presentation/controller/cubit/app_cubit.dart';

import '../../../../core/layout/app_assets.dart';
import '../../../../core/layout/app_fonts.dart';
import '../../../../core/utlis/strings.dart';
import '../../../../core/widgets/texts.dart';

class ListCategoriesWidget extends StatelessWidget {
  final List<Category> categories;
  const ListCategoriesWidget({
    super.key,
    required this.categories,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppCubit, AppState>(
      builder: (context, state) {
        return SizedBox(
          height: 114,
          child: ListView.builder(
              itemCount: 1 + categories.length,
              scrollDirection: Axis.horizontal,
              itemBuilder: ((context, index) {
                return index == 0
                    ? ItemListCategories(
                        image: Container(
                          height: 66,
                          width: 82,
                          decoration: BoxDecoration(
                              color: Palette.mainColor,
                              borderRadius: BorderRadius.circular(10)),
                          child: Center(
                            child: SvgPicture.asset(AppAssets.showAllIcon),
                          ),
                        ),
                        title: Strings.showAll,
                        onTap: () {
                        
                          AppCubit.get(context).getProductsByCategoryId(
                             0);
                        },
                        borderColor: state.categoryIndex == 0
                            ? Palette.mainColor
                            : Colors.white,
                      )
                    : ItemListCategories(
                        borderColor:
                            state.categoryIndex == categories[index - 1].id
                                ? Palette.mainColor
                                : Colors.white,
                        image: ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: CachedNetworkImageWidget(
                                image: categories[index - 1].image,
                                height: 66,
                                width: 82,
                                iconError: const Icon(Icons.error))),
                        title: categories[index - 1].name,
                        onTap: () {
                         

                          AppCubit.get(context).getProductsByCategoryId(
                              categories[index - 1].id);
                        },
                      );
              })),
        );
      },
    );
  }
}

class ItemListCategories extends StatelessWidget {
  final void Function() onTap;
  final Widget image;
  final String title;
  final Color borderColor;
  const ItemListCategories({
    super.key,
    required this.onTap,
    required this.image,
    required this.borderColor,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 114,
        width: 92,
        margin: const EdgeInsets.only(left: 7),
        alignment: Alignment.center,
        decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(width: 1, color: borderColor),
            borderRadius: BorderRadius.circular(10)),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            image,
            const SizedBox(
              height: 12,
            ),
            Texts(
              title: title,
              fontFamily: AppFonts.moR,
              fontSize: 12,
              textColor: Colors.black,
            ),
          ],
        ),
      ),
    );
  }
}
