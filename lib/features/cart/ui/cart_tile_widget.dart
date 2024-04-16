import 'package:flutter/material.dart';
import 'package:simple_grocery/features/home/bloc/home_bloc.dart';
import 'package:simple_grocery/features/home/models/home_product_data_model.dart';

import '../bloc/cart_bloc.dart';

class CartTileWidget extends StatelessWidget {
  final ProductDataModel productDataModel;
  final CartBloc cartBloc;

  const CartTileWidget(
      {super.key, required this.productDataModel, required this.cartBloc});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(10),
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
          border: Border.all(color: Colors.grey),
          borderRadius: BorderRadius.circular(10)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 200,
            width: double.maxFinite,
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: NetworkImage(productDataModel.img),
                    fit: BoxFit.cover)),
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
                      cartBloc.add(RemoveFromCartEvent(
                          productDataModel: productDataModel));
                    },
                    icon: const Icon(
                      Icons.remove_shopping_cart,
                    )),
                MaterialButton(
                  onPressed: () {

                  },
                  color: Colors.green,
                  textColor: Colors.white,
                  shape: const StadiumBorder(),
                  child: const Text(
                    'Buy Now',
                  ),
                )
              ],
            )
          ])
        ],
      ),
    );
  }
}
