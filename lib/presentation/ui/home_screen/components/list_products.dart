import 'package:flutter/material.dart';

import '../../../../core/layout/app_fonts.dart';
import '../../../../core/layout/palette.dart';
import '../../../../core/utlis/strings.dart';
import '../../../../core/widgets/cached_image_widget.dart';
import '../../../../core/widgets/texts.dart';
import '../../../../domin/entities/product.dart';

class ListProducts extends StatelessWidget {
  final List<Product> products;
  const ListProducts({super.key, re, required this.products});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
          itemCount: products.length,
          itemBuilder: ((context, index) {
            return ItemListProducts(product: products[index]);
          })),
    );
  }
}

class ItemListProducts extends StatelessWidget {
   final Product product;
  const ItemListProducts({
    super.key, required this.product,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 115,
      margin: const EdgeInsets.only(bottom: 13),
      child: Row(
        children: [
          ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: CachedNetworkImageWidget(
                image: product.images.split("#")[0], iconError: const Icon(Icons.error),
                height: 114,
                width: 115,
               
              )),
          const SizedBox(
            width: 14,
          ),
          Expanded(
              child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 5),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                 Texts(
                    title: product.name,
                    textColor: Colors.black,
                    fontSize: 15,
                    fontFamily: AppFonts.moM),
                RichText(
                  text:  TextSpan(
                    text: '   ${product.price}  ',
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
                Container(
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
            ),
          ))
        ],
      ),
    );
  }
}
