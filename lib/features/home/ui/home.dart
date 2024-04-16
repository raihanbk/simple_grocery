import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:simple_grocery/features/cart/ui/cart_page.dart';
import 'package:simple_grocery/features/home/bloc/home_bloc.dart';
import 'package:simple_grocery/features/home/ui/product_tile_widget.dart';
import 'package:simple_grocery/features/wishlist_page/ui/wishlist_page.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final HomeBloc homeBloc = HomeBloc();

  @override
  void initState() {
    homeBloc.add(InitialEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeBloc, HomeState>(
      bloc: homeBloc,
      listenWhen: (previous, current) => current is HomeActionState,
      buildWhen: (previous, current) => current is! HomeActionState,
      listener: (context, state) {
        if (state is NavigateToWishListPageActionState) {
          Navigator.push(
              context, MaterialPageRoute(builder: (_) => const WishListPage()));
        } else if (state is NavigateToCartPageActionState) {
          Navigator.push(
              context, MaterialPageRoute(builder: (_) => const CartPage()));
        } else if (state is ItemWishListedActionState) {
          ScaffoldMessenger.of(context)
              .showSnackBar(const SnackBar(content: Text('Item WishListed')));
        } else if (state is ItemCartedActionState) {
          ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Item Added to Cart')));
        }
      },
      builder: (context, state) {
        switch (state.runtimeType) {
          case LoadingState:
            return const Scaffold(
              body: Center(
                child: CircularProgressIndicator(),
              ),
            );

          case LoadedState:
            final successState = state as LoadedState;
            return Scaffold(
                appBar: AppBar(
                  title: const Text(
                    'Grocery Store',
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                  backgroundColor: Colors.teal.shade300,
                  actions: [
                    IconButton(
                        onPressed: () {
                          homeBloc.add(NavigateToWishListPageEvent());
                        },
                        icon: const Icon(
                          Icons.favorite_border,
                          color: Colors.white,
                        )),
                    IconButton(
                        onPressed: () {
                          homeBloc.add(NavigateToCartPageEvent());
                        },
                        icon: const Icon(Icons.add_shopping_cart,
                            color: Colors.white))
                  ],
                ),
                body: ListView.builder(
                    itemCount: successState.products.length,
                    itemBuilder: (context, index) {
                      return ProductTileWidget(
                        productDataModel: successState.products[index],
                        homeBloc: homeBloc,
                      );
                    }));

          default:
            return const Scaffold(
              body: Center(
                child: Text('Something went wrong!!'),
              ),
            );
        }
      },
    );
  }

  Future<Widget> function() async {
    return Container(
      child: await Future.delayed(const Duration(seconds: 5)),
    );
  }
}
