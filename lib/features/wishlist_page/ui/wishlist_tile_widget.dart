import 'package:flutter/material.dart';
import 'package:simple_grocery/features/home/bloc/home_bloc.dart';
import 'package:simple_grocery/features/home/models/home_product_data_model.dart';
import 'package:simple_grocery/features/home/ui/product_detailed_page.dart';

import '../bloc/wishlist_bloc.dart';

class WishlistTileWidget extends StatelessWidget {
  final ProductDataModel productDataModel;
  final WishlistBloc wishlistBloc;

  const WishlistTileWidget(
      {super.key, required this.productDataModel, required this.wishlistBloc});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(10),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
          border: Border.all(color: Colors.grey),
          borderRadius: BorderRadius.circular(10)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          InkWell(
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (_) =>
                  ProductDetails(
                    scaffoldContext: context,
                      productDataModel: productDataModel, homeBloc: HomeBloc())));
            },
            child: Container(
              height: 200,
              width: double.maxFinite,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: NetworkImage(productDataModel.img),
                      fit: BoxFit.cover)),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Text(
            productDataModel.name,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          Text(productDataModel.description),
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Text(
              '\$ ${productDataModel.price}',
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            Row(
              children: [
                IconButton(
                    onPressed: () {
                      wishlistBloc.add(RemoveFromWishListEvent(
                          productDataModel: productDataModel));
                    },
                    icon: const Icon(
                      Icons.remove_circle_outline,
                    )),
                IconButton(
                    onPressed: () {
                      wishlistBloc.add(AddItemFromWishlistToCartEvent(
                          productDataModel: productDataModel));
                    },
                    icon: const Icon(
                      Icons.add_shopping_cart,
                    ))
              ],
            )
          ])
        ],
      ),
    );
  }
}
