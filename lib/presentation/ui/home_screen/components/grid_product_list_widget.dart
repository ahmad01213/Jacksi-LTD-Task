import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:task_app/core/widgets/cached_image_widget.dart';

import '../../../../core/layout/app_fonts.dart';
import '../../../../core/layout/palette.dart';
import '../../../../core/utlis/strings.dart';
import '../../../../core/widgets/texts.dart';
import '../../../../domin/entities/product.dart';

class GridProductListWidget extends StatelessWidget {
  final List<Product> products;
  const GridProductListWidget({
    super.key,
    required this.products,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GridView.builder(
          itemCount: products.length,
          gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
              maxCrossAxisExtent: 250,
              childAspectRatio: 2.7 / 4,
              crossAxisSpacing: 1,
              mainAxisSpacing: 1),
          itemBuilder: (BuildContext context, int index) {
            return ItemGridListProduct(product: products[index]);
          }),
    );
  }
}

class ItemGridListProduct extends StatelessWidget {
  final Product product;
  const ItemGridListProduct({
    super.key, required this.product,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 60,
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
        ),
        margin: const EdgeInsets.all(5),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: CachedNetworkImageWidget(
                
                  height: 125,
                  width: double.infinity, image: product.images.split("#")[0], iconError: const Icon(Icons.error),
                 
                )),
            const SizedBox(
              height: 14,
            ),
             Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4),
              child: Texts(
                  title: product.name,
                  textColor: Colors.black,
                  fontSize: 12,
                  fontFamily: AppFonts.moM),
            ),
            const SizedBox(
              height: 12,
            ),
            RichText(
              text:  TextSpan(
                text: '  ${product.price}  ',
                style: const TextStyle(
                    fontSize: 20,
                    color: Palette.mainColor,
                    fontFamily: AppFonts.moM),
                children: const <TextSpan>[
                  TextSpan(
                      text: Strings.dollar,
                      style: TextStyle(
                          fontSize: 12,
                          color: Palette.textColor,
                          fontFamily: AppFonts.moR)),
                ],
              ),
            ),
            const SizedBox(
              height: 12,
            ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 4),
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: const Color.fromARGB(255, 220, 214, 214)),
              child:  Texts(
                  title: product.nameStore,
                  textColor: Colors.grey,
                  fontSize: 10,
                  fontFamily: AppFonts.moL),
            )
          ],
        ));
  }
}
