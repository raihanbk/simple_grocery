import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:simple_grocery/features/cart/ui/cart_page.dart';
import 'package:simple_grocery/features/wishlist_page/ui/wishlist_page.dart';

import '../bloc/home_bloc.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {

  @override
  void initState() {
     homeBloc.add(HomeInitialEvent());
    super.initState();
  }
  final HomeBloc homeBloc = HomeBloc();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeBloc, HomeState>(
      bloc: homeBloc,
      listenWhen: (previous, current) => current is HomeActionState,
      buildWhen: (previous, current) => current is! HomeActionState,
      listener: (context, state) {
        if (state is HomeNavigateToCartPageActionState) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => const CartPage(),
            ),
          );
        } else if (state is HomeNavigateToWishlistPageActionState) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => const WishListPage(),
            ),
          );
        }
      },
      builder: (context, state) {
        switch (state.runtimeType) {
          case HomeLoadingState():
            return const Scaffold(
              body: Center(
                child: CircularProgressIndicator(),
              ),
            );
          // case HomeLoadedState():
          //   return Scaffold(
          //     appBar: AppBar(
          //       title: const Text(
          //         'Grocery Store',
          //         style: TextStyle(
          //             color: Colors.white, fontWeight: FontWeight.bold),
          //       ),
          //       backgroundColor: Colors.teal.shade300,
          //       actions: [
          //         IconButton(
          //             onPressed: () {
          //               homeBloc.add(HomeWishListButtonNavigateEvent());
          //             },
          //             icon: const Icon(
          //               Icons.favorite_border,
          //               color: Colors.white,
          //             )),
          //         IconButton(
          //             onPressed: () {
          //               homeBloc.add(HomeCartButtonNavigateEvent());
          //             },
          //             icon: const Icon(Icons.add_shopping_cart,
          //                 color: Colors.white))
          //       ],
          //     ),
          //   );
          // case HomeErrorState():
          //   return const Scaffold(
          //     body: Center(
          //       child: Text('An Error Occurred'),
          //     ),
          //   );
          default:
            return const Scaffold(
              body: Center(child: Text('Errorrr'),),
            );
        }
      },
    );
  }
}
