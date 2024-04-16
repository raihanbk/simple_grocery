import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:simple_grocery/data/cart_items.dart';
import 'package:simple_grocery/features/cart/bloc/cart_bloc.dart';
import 'package:simple_grocery/features/cart/ui/cart_tile_widget.dart';

class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  final CartBloc cartBloc = CartBloc();

  @override
  void initState() {
    cartBloc.add(CartInitialEvent());
    super.initState();
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
              return ListView.builder(
                  itemCount: cartItems.length,
                  itemBuilder: (context, index) {
                    return CartTileWidget(
                        productDataModel: successState.cartItems[index],
                        cartBloc: cartBloc);
                  });
            default :
          }
          return const SizedBox();
        },
      ),
    );
  }
}
