import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:simple_grocery/features/home/models/home_product_data_model.dart';
import 'package:simple_grocery/utils/dummy_secription.dart';

import '../../../utils/color_constants.dart';
import '../../cart/bloc/cart_bloc.dart';
import '../bloc/home_bloc.dart';

class ProductDetails extends StatefulWidget {
  final BuildContext scaffoldContext;
  final ProductDataModel productDataModel;
  final HomeBloc homeBloc;

  const ProductDetails({
    super.key,
    required this.productDataModel,
    required this.homeBloc,
    required this.scaffoldContext,
  });

  @override
  State<ProductDetails> createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails> {
  bool isExpanded = false;
  int productCount = 0;
  bool isFav = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back_ios_new,
            color: Colors.black,
          ),
        ),
        actions: [
          IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.search,
                color: Colors.black,
                size: 30,
              ))
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Divider(
              color: Colors.grey.shade300,
            ),
            Stack(
              children: [
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height * 0.40,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: Colors.grey,
                      image: DecorationImage(
                          image: NetworkImage(widget.productDataModel.img),
                          fit: BoxFit.fill,
                          filterQuality: FilterQuality.high)),
                ),
                Positioned(
                  left: MediaQuery.of(context).size.width * 0.85,
                  child: Container(
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                        border: Border.all(),
                        borderRadius: BorderRadius.circular(25),
                        color: Colors.white),
                    child: IconButton(
                        onPressed: () {
                          setState(() {
                            isFav = !isFav;
                          });
                          if (isFav == true) {
                            widget.homeBloc.add(WishListButtonClickedEvent(
                                clickedProduct: widget.productDataModel));
                          } else {
                            widget.homeBloc.add(RemoveItemFromWishlistEvent(
                                clickedProduct: widget.productDataModel));
                          }
                        },
                        icon: isFav
                            ? const Icon(
                                Icons.favorite,
                                color: Colors.red,
                                size: 30,
                              )
                            : const Icon(Icons.favorite_outline)),
                  ),
                )
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(
                  top: 15, left: 15, right: 15, bottom: 25),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.productDataModel.name,
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 20),
                  ),
                  Text(widget.productDataModel.description),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Text(
                            '₹${widget.productDataModel.price}'.toString(),
                            style: const TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: 25),
                          ),
                          const SizedBox(
                            width: 20,
                          ),
                          Text(
                            widget.productDataModel.oldPrice ?? '',
                            style: const TextStyle(
                                decoration: TextDecoration.lineThrough,
                                color: Colors.red,
                                fontSize: 20),
                          ),
                        ],
                      ),
                      MaterialButton(
                        minWidth: 140,
                        height: 50,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        color: MyColors.primaryColor,
                        onPressed: () {
                          setState(() {
                            productCount++;
                          });
                          // widget.homeBloc.add(CartButtonClickedEvent(
                          //     clickedProduct: widget.productDataModel));
                          BlocProvider.of<CartBloc>(context).add(
                              AddProductToCartFromCartEvent(productDataModel: widget.productDataModel));
                          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                              duration: Duration(milliseconds: 500),
                              content: Text('Item added to cart')));
                        },
                        child: productCount > 0
                            ? Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  IconButton(
                                      onPressed: () {
                                        setState(() {
                                          if (productCount > 0) {
                                            productCount--;
                                          }
                                        });
                                        widget.homeBloc.add(
                                            RemoveItemFromCartEvent(
                                                clickedProduct:
                                                    widget.productDataModel));
                                      },
                                      icon: const Icon(
                                        Icons.remove,
                                        color: Colors.white,
                                      )),
                                  Text(
                                    productCount.toString(),
                                    style: const TextStyle(
                                        color: Colors.white, fontSize: 20),
                                  ),
                                  IconButton(
                                      onPressed: () {
                                        setState(() {
                                          productCount++;
                                        });
                                        widget.homeBloc.add(
                                            CartButtonClickedEvent(
                                                clickedProduct:
                                                    widget.productDataModel));
                                      },
                                      icon: const Icon(
                                        Icons.add,
                                        color: Colors.white,
                                      )),
                                ],
                              )
                            : const Text(
                                'Add',
                                style: TextStyle(color: Colors.white),
                              ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Divider(
              thickness: 8,
              color: Colors.grey.shade300,
            ),
            ExpansionTile(
              title: const Text('Product Information'),
              trailing: isExpanded
                  ? const Icon(Icons.keyboard_arrow_down)
                  : const Icon(Icons.keyboard_arrow_up),
              onExpansionChanged: (isExpanded) {
                setState(() {
                  isExpanded = isExpanded;
                });
              },
              childrenPadding: const EdgeInsets.all(10),
              shape: const RoundedRectangleBorder(side: BorderSide.none),
              children: const [
                Text(
                  DummyDesc.dummyDesc,
                  style: TextStyle(fontSize: 16.0),
                ),
              ],
            ),
            Divider(
              thickness: 8,
              color: Colors.grey.shade300,
            ),
          ],
        ),
      ),
      bottomNavigationBar: Visibility(
        visible: productCount > 0,
        child: Container(
          height: 100,
          margin:
              const EdgeInsets.only(top: 20, left: 15, right: 15, bottom: 20),
          child: GestureDetector(
            onTap: () {
              widget.homeBloc.add(NavigateToCartPageEvent());
            },
            child: Container(
              width: MediaQuery.of(context).size.width,
              margin: const EdgeInsets.only(
                top: 15,
                bottom: 15,
              ),
              height: 50,
              decoration: BoxDecoration(
                  color: MyColors.primaryColor,
                  borderRadius: BorderRadius.circular(15)),
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 10.0),
                    child: Text(
                      '$productCount item',
                      style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 18),
                    ),
                  ),
                  const VerticalDivider(
                    indent: 20,
                    endIndent: 20,
                    thickness: 3,
                    color: Colors.white,
                  ),
                  Expanded(
                    child: Text(
                      '₹${productCount * widget.productDataModel.price}',
                      style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 18),
                    ),
                  ),
                  const Icon(
                    Icons.shopping_bag_outlined,
                    size: 30,
                    color: Colors.white,
                  ),
                  const Padding(
                    padding: EdgeInsets.only(right: 10.0),
                    child: Text(
                      'View Cart',
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 18),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
