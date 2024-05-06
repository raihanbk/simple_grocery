import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:simple_grocery/data/cart_items.dart';
import 'package:simple_grocery/features/cart/bloc/cart_bloc.dart';
import 'package:simple_grocery/features/cart/ui/cart_tile_widget.dart';
import 'package:simple_grocery/features/home/models/home_product_data_model.dart';

import '../../../utils/color_constants.dart';
import '../../routes/routes.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

class CartPage extends StatefulWidget {
  final List<ProductDataModel> cartItems;

  const CartPage({
    super.key,
    required this.cartItems,
  });

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  final CartBloc cartBloc = CartBloc();
  late ProductDataModel productDataModel;
  var _razorpay = Razorpay();

  @override
  void initState() {
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
    cartBloc.add(CartInitialEvent());
    super.initState();
  }

  void _handlePaymentSuccess(PaymentSuccessResponse response) {
     showDialog(context: context, builder: (context) {
       return AlertDialog(
         title: const Text('Payment Successful'),
         content: Text(
             'Thank you for your purchase! Your payment was successful.'),
         actions: [
           TextButton(
             onPressed: () {
               Navigator.of(context).pop(); // Close the dialog
             },
             child: Text('OK'),
           ),
         ],
       );
     }
       );
     setState(() {
       cartItems.clear();
     });
    // Do something when payment succeeds
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    // Do something when payment fails
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    // Do something when an external wallet was selected
  }

  @override
  void dispose() {
   _razorpay.clear();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cart Items'),
      ),
      body: BlocConsumer<CartBloc, CartState>(
        bloc: cartBloc,
        listenWhen: (prev, curr) => curr is CartActionState,
        buildWhen: (prev, curr) => curr is! CartActionState,
        listener: (context, state) {},
        builder: (context, state) {
          switch (state.runtimeType) {
            case CartSuccessState:
              final successState = state as CartSuccessState;
              return cartItems.isEmpty
                  ? Padding(
                padding: const EdgeInsets.only(left: 100.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: 200,
                      height: 200,
                      child: Lottie.network(
                          'https://lottie.host/c73f9d2f-68d3-4bce-af15-44c8113f711d/P7dntYQbMl.json'),
                    ),
                    const Text(
                      'Cart is Empty',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    OutlinedButton(
                        onPressed: () {
                          Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(builder: (_) => Routes()),
                                  (route) => false);
                        },
                        child: const Text(
                          'Browse Products',
                          style: TextStyle(color: Colors.black),
                        ))
                  ],
                ),
              )
                  : ListView.builder(
                  itemCount: successState.cartItems.length,
                  itemBuilder: (context, index) {
                    return CartTileWidget(
                      productDataModel: successState.cartItems[index],
                      cartBloc: cartBloc,
                    );
                  });
            default:
          }
          return const SizedBox();
        },
      ),
      bottomNavigationBar: cartItems.isNotEmpty ?
      Container(
        height: 100,
        margin:
        const EdgeInsets.only(top: 20, left: 15, right: 15, bottom: 20),
        child: GestureDetector(
          onTap: () {
            try {
              var options = {
                'key': 'rzp_test_1uq6AF9zIiQOgY',
                'amount': (calculateTotalPrice(cartItems) * 100).toInt(),
                'name': 'Raihan Bk',
                'description': 'Grocery products',
              };
              _razorpay.open(options);
            } catch(e) {
              print('Error initiating Razorpay payment: $e');
            }
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
                    '${cartItems.length.toString()} ${cartItems.length > 1 ? 'items' : 'item'}',
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
                    '₹${calculateTotalPrice(cartItems)}',
                    style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 18),
                  ),
                ),
                const Icon(
                  Icons.shopping_bag,
                  size: 30,
                  color: Colors.white,
                ),
                const Padding(
                  padding: EdgeInsets.only(right: 10.0),
                  child: Text(
                    'Buy Now',
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
      ) : const SizedBox(),
    );
  }
  dynamic calculateTotalPrice(List<ProductDataModel> cartItems) {
    double totalPrice = 0;
    for (var item in cartItems) {
      totalPrice += item.price;
    }
    return totalPrice;
  }
}

//rzp_test_1uq6AF9zIiQOgY
//ymxqqSuAx4x6IhbnvLUVRBRD