import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:simple_grocery/data/cart_items.dart';
import 'package:simple_grocery/features/cart/ui/cart_page.dart';
import 'package:simple_grocery/features/categories/model/category_model.dart';
import 'package:simple_grocery/features/categories/ui/category_item_screen.dart';
import 'package:simple_grocery/features/home/bloc/home_bloc.dart';
import 'package:simple_grocery/features/home/models/home_product_data_model.dart';
import 'package:simple_grocery/features/home/widget/product_tile_widget.dart';
import 'package:simple_grocery/features/home/widget/sliver_app_bar.dart';
import 'package:simple_grocery/features/wishlist_page/ui/wishlist_page.dart';
import 'package:simple_grocery/utils/color_constants.dart';
import 'package:skeletonizer/skeletonizer.dart';

import 'banner.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final HomeBloc homeBloc = HomeBloc();
  late ProductDataModel productDataModel;
  String searchQuery = '';

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
              context,
              MaterialPageRoute(
                  builder: (_) => CartPage(
                        cartItems: cartItems,
                      )));
        } else if (state is ItemWishListedActionState) {
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
              duration: Duration(seconds: 1),
              content: Text('Item WishListed')));
        } else if (state is ItemCartedActionState) {
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
              duration: Duration(seconds: 1),
              content: Text('Item Added to Cart')));
        } else if (state is ItemRemovedFromCartActionState) {
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
              duration: Duration(milliseconds: 500),
              content: Text('Item Removed from Cart')));
        } else if (state is ItemRemovedFromWishlistActionState) {
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
              duration: Duration(milliseconds: 500),
              content: Text('Item Removed from Wishlist')));
        }
      },
      builder: (context, state) {
        switch (state.runtimeType) {
          case LoadingState:
            return Skeletonizer(
              ignoreContainers: false,
              enabled: true,
              child: GridView.count(
                crossAxisCount: 2,
                children: List.generate(
                    8,
                    (index) => const Column(
                          children: [
                            Text('---------------'),
                            Text('----------------'),
                            Text('------------------'),
                          ],
                        )),
              ),
            );

          case LoadedState:
            final successState = state as LoadedState;
            final List<ProductDataModel> filteredProduct = successState.products
                .where((product) => product.name
                    .toLowerCase()
                    .contains(searchQuery.toLowerCase()))
                .toList();

            return Scaffold(
              body: CustomScrollView(
                slivers: [
                  SAppBar(
                    onSearch: (value) {
                      setState(() {
                        searchQuery = value;
                      });
                    },
                  ),
                  SliverToBoxAdapter(
                      child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Banners(),
                      const Padding(
                        padding:
                            EdgeInsets.only(left: 10.0, top: 20, bottom: 10),
                        child: Text(
                          'Top Categories',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 18),
                        ),
                      ),
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: List.generate(
                              5,
                              (index) => Padding(
                                    padding: const EdgeInsets.only(
                                        left: 15.0, top: 10, right: 5),
                                    child: Column(
                                      children: [
                                        InkWell(
                                          onTap: () {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (_) =>
                                                    CategoryItemsScreen(
                                                        categoryId:
                                                            categoryModel[index]
                                                                .categoryName),
                                              ),
                                            );
                                          },
                                          child: Container(
                                            width: 50,
                                            height: 50,
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(15),
                                                image: DecorationImage(
                                                    image: NetworkImage(
                                                        categoryModel[index]
                                                            .categoryImg)),
                                                border: Border.all(
                                                    color:
                                                        MyColors.primaryColor)),
                                          ),
                                        ),
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(top: 10.0),
                                          child: Text(
                                            categoryModel[index].categoryName,
                                            style: const TextStyle(
                                                fontWeight: FontWeight.bold),
                                          ),
                                        )
                                      ],
                                    ),
                                  )),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 10.0, top: 20, right: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              'Exclusive Offer',
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold),
                            ),
                            TextButton(
                                onPressed: () {},
                                child: Text(
                                  'See all',
                                  style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold,
                                      color: MyColors.primaryColor),
                                ))
                          ],
                        ),
                      ),
                      const BannerOffer(),
                      SingleChildScrollView(
                        child: GridView.count(
                            physics: const NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            childAspectRatio: 0.85,
                            crossAxisCount: 2,
                            children: filteredProduct
                                .map((product) => Container(
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          color: Colors.white,
                                          boxShadow: [
                                            BoxShadow(
                                                color: Colors.grey.shade400,
                                                spreadRadius: 1,
                                                blurRadius: 10,
                                                offset: const Offset(1, 10))
                                          ]),
                                      margin: const EdgeInsets.all(10),
                                      child: Column(
                                        children: [
                                          ProductTileWidget(
                                            homeBloc: homeBloc,
                                            productDataModel: product,
                                          ),
                                        ],
                                      ),
                                    ))
                                .toList()),
                      ),
                    ],
                  )
                  ),
                ],
              ),
            );

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
}
