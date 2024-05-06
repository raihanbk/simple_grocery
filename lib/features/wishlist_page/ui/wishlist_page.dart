import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:simple_grocery/data/wishlist_item.dart';
import 'package:simple_grocery/features/wishlist_page/bloc/wishlist_bloc.dart';
import 'package:simple_grocery/features/wishlist_page/ui/wishlist_tile_widget.dart';

class WishListPage extends StatefulWidget {
  const WishListPage({super.key});

  @override
  State<WishListPage> createState() => _WishListPageState();
}

class _WishListPageState extends State<WishListPage> {
  final WishlistBloc wishlistBloc = WishlistBloc();

  @override
  void initState() {
    wishlistBloc.add(WishlistInitialEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text(
        'Wishlist page',
        style: TextStyle(fontWeight: FontWeight.bold),
      )),
      body: BlocConsumer<WishlistBloc, WishlistState>(
        bloc: wishlistBloc,
        listenWhen: (pre, curr) => curr is WishlistActionState,
        buildWhen: (prev, curr) => curr is! WishlistActionState,
        listener: (context, state) {
          if (state is ItemAddedToCartActionState) {
            ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Item added to cart')));
          }
        },
        builder: (context, state) {
          switch (state.runtimeType) {
            case WishlistSuccessState:
              final successState = state as WishlistSuccessState;
              return wishlistItems.isEmpty
                  ? Center(
                      child: Container(
                          width: 200,
                          height: 200,
                          child: Lottie.network(
                              'https://lottie.host/da388473-71b3-4a4f-9dab-06083697991e/23FqDteZCp.json')))
                  : GridView.builder(
                      shrinkWrap: true,
                      itemCount: successState.wishlistItems.length,
                      itemBuilder: (context, index) {
                        return WishlistTileWidget(
                            productDataModel: successState.wishlistItems[index],
                            wishlistBloc: wishlistBloc);
                      },
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2, childAspectRatio: 0.5),
                    );
          }
          return const SizedBox();
        },
      ),
    );
  }
}
