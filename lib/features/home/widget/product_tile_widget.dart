import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:simple_grocery/data/cart_items.dart';
import 'package:simple_grocery/features/cart/bloc/cart_bloc.dart';
import 'package:simple_grocery/features/home/bloc/home_bloc.dart';
import 'package:simple_grocery/features/home/models/home_product_data_model.dart';
import 'package:simple_grocery/features/home/ui/product_detailed_page.dart';
import 'package:simple_grocery/utils/color_constants.dart';

class ProductTileWidget extends StatefulWidget {
  final ProductDataModel productDataModel;
  final HomeBloc homeBloc;

  const ProductTileWidget({
    super.key,
    required this.productDataModel,
    required this.homeBloc,
  });

  @override
  State<ProductTileWidget> createState() => _ProductTileWidgetState();
}

class _ProductTileWidgetState extends State<ProductTileWidget> {
  bool isExpanded = false;
  int productCount = 0;
  final CartBloc cartBloc = CartBloc();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CartBloc, CartState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        final cartBloc = BlocProvider.of<CartBloc>(context);
        return Expanded(
          child: InkWell(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (_) => ProductDetails(
                            homeBloc: widget.homeBloc,
                            productDataModel: widget.productDataModel,
                            scaffoldContext: context,
                          )));
            },
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding:
                      const EdgeInsets.only(top: 8.0, left: 8.0, right: 8.0),
                  child: Container(
                    height: 110,
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadius.circular(15),
                        image: DecorationImage(
                            image: NetworkImage(widget.productDataModel.img),
                            fit: BoxFit.cover)),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 10.0, top: 3),
                  child: Text(
                    widget.productDataModel.name,
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 15),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    left: 10.0,
                  ),
                  child: Text(widget.productDataModel.description),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    left: 10.0,
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      RichText(
                        text: TextSpan(
                            text: '₹${widget.productDataModel.price}  ',
                            style: const TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: 18),
                            children: [
                              TextSpan(
                                  text:
                                      "${widget.productDataModel.oldPrice ?? ''}",
                                  style: const TextStyle(
                                      fontWeight: FontWeight.normal,
                                      fontSize: 14,
                                      color: Colors.red,
                                      decoration: TextDecoration.lineThrough))
                            ]),
                      ),
                      const SizedBox(
                        width: 30,
                      ),
                      MaterialButton(
                        minWidth: 60,
                        height: 30,
                        color: MyColors.primaryColor,
                        onPressed: () {
                          // widget.homeBloc.add(CartButtonClickedEvent(
                          //     clickedProduct: widget.productDataModel));
                          cartBloc.add(AddProductToCartFromCartEvent(
                              productDataModel: widget.productDataModel));

                            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                                duration: Duration(milliseconds: 500),
                                content: Text('Item added to cart')));
                          },
                        child: const Text(
                          'Add',
                          style: TextStyle(color: Colors.white),
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
