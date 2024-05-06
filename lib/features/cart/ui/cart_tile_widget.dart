import 'package:flutter/material.dart';
import 'package:simple_grocery/features/home/models/home_product_data_model.dart';
import '../bloc/cart_bloc.dart';

class CartTileWidget extends StatefulWidget {
  final ProductDataModel productDataModel;
  final CartBloc cartBloc;

  const CartTileWidget({
    super.key,
    required this.productDataModel,
    required this.cartBloc,
  });

  @override
  State<CartTileWidget> createState() => _CartTileWidgetState();
}

class _CartTileWidgetState extends State<CartTileWidget> {
  int productCount = 1;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(10),
      padding: const EdgeInsets.only(top: 10, left: 10, bottom: 10, right: 0),
      decoration: BoxDecoration(
          border: Border.all(color: Colors.grey),
          borderRadius: BorderRadius.circular(10)),
      child: ListTile(
        leading: Image.network(
          widget.productDataModel.img,
        ),
        title: Text(
          widget.productDataModel.name,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        // subtitle: Text(widget.productDataModel.description),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              onPressed: () {
                widget.cartBloc.add(RemoveFromCartEvent(
                    productDataModel: widget.productDataModel));
                setState(() {
                  productCount--;

                });
              },
              icon: const Icon(Icons.remove),
            ),
            Text(productCount.toString()),
            IconButton(
              onPressed: () {
                widget.cartBloc.add(AddProductToCartFromCartEvent(
                    productDataModel: widget.productDataModel));
                setState(() {
                  productCount++;
                });
              },
              icon: const Icon(Icons.add),
            ),
            Text('₹${(productCount * widget.productDataModel.price).toStringAsFixed(2)}')
          ],
        ),
      ),
    );
  }
}