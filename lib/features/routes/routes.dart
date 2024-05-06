import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:simple_grocery/data/cart_items.dart';
import 'package:simple_grocery/features/home/models/home_product_data_model.dart';
import 'package:simple_grocery/utils/color_constants.dart';
import '../cart/bloc/cart_bloc.dart';
import '../cart/ui/cart_page.dart';
import '../categories/ui/categories.dart';
import '../home/ui/home.dart';
import '../wishlist_page/ui/wishlist_page.dart';

class Routes extends StatefulWidget {
  const Routes({super.key});

  @override
  State<Routes> createState() => _RoutesState();
}

class _RoutesState extends State<Routes> {
  late ProductDataModel productDataModel;
  int isSelected = 0;
  static final List _tabs = [
    const Home(),
    const Categories(),
    const WishListPage(),
    const CartPage(
      cartItems: [],
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BlocBuilder<CartBloc, CartState>(
        builder: (context, state) {
          int cartItemCount = 0;
          if(state is CartSuccessState) {
            cartItemCount = state.cartItems.length;
          }
          return NavigationBar(
            indicatorColor: MyColors.primaryColor,
            indicatorShape: const CircleBorder(),
            elevation: 0,
            onDestinationSelected: (index) {
              setState(() {
                isSelected = index;
              });
            },
            selectedIndex: isSelected,
            destinations: [
              const NavigationDestination(
                  selectedIcon: Icon(
                    Icons.home,
                    color: Colors.white,
                  ),
                  icon: Icon(
                    Icons.home_outlined,
                  ),
                  label: "Home"),
              const NavigationDestination(
                  selectedIcon: Icon(
                    Icons.search,
                    color: Colors.white,
                  ),
                  icon: Icon(Icons.search_outlined),
                  label: "Categories"),
              const NavigationDestination(
                  selectedIcon: Icon(
                    Icons.favorite,
                    color: Colors.white,
                  ),
                  icon: Icon(Icons.favorite_border),
                  label: "Wishlist"),
              NavigationDestination(
                  icon: Badge(
                    label: Text(cartItemCount.toString()),
                    child: const Icon(Icons.add_shopping_cart),
                  ),
                  label: "Cart"),
            ],
          );
        },
      ),
      body: _tabs[isSelected],
    );
  }
}
