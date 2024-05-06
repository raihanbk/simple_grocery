import 'package:flutter/material.dart';
import 'package:simple_grocery/data/grocery_items.dart';
import 'package:simple_grocery/features/home/bloc/home_bloc.dart';
import 'package:simple_grocery/features/home/models/home_product_data_model.dart';
import 'package:simple_grocery/features/home/ui/product_detailed_page.dart';

import '../../../utils/color_constants.dart';

class CategoryItemsScreen extends StatefulWidget {
  final String categoryId; // ID of the selected category

  const CategoryItemsScreen({super.key, required this.categoryId});

  @override
  State<CategoryItemsScreen> createState() => _CategoryItemsScreenState();
}

class _CategoryItemsScreenState extends State<CategoryItemsScreen> {
  final HomeBloc homeBloc = HomeBloc();

  @override
  Widget build(BuildContext context) {
    // Filter groceryItems based on the selected category ID
    List<Map<String, dynamic>> categoryItems = GroceryData.groceryItems
        .where((item) => item['id'] == widget.categoryId)
        .toList();

    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.categoryId,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: categoryItems.isEmpty
          ? const Center(
              child: Text(
              'The Products will update soon...!',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ))
          : GridView.count(
              childAspectRatio: 0.8,
              crossAxisCount: 2,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
              padding: const EdgeInsets.all(10),
              children: categoryItems.map((item) {
                ProductDataModel product = ProductDataModel.fromMap(item);
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (_) => ProductDetails(
                              scaffoldContext: context,
                                productDataModel: product,
                                homeBloc: homeBloc)));
                  },
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
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
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(
                              top: 8.0, left: 8.0, right: 8.0),
                          child: Container(
                            height: 110,
                            decoration: BoxDecoration(
                                border: Border.all(color: Colors.grey),
                                borderRadius: BorderRadius.circular(15),
                                image: DecorationImage(
                                    image: NetworkImage(product.img),
                                    fit: BoxFit.cover)),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 10.0, top: 3),
                          child: Text(
                            product.name,
                            style: const TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 15),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                            left: 10.0,
                          ),
                          child: Text(product.description),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                            left: 10.0,
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              RichText(
                                text: TextSpan(
                                    text: '₹${product.price}  ',
                                    style: const TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18),
                                    children: [
                                      TextSpan(
                                          text: product.oldPrice ?? '',
                                          style: const TextStyle(
                                              fontWeight: FontWeight.normal,
                                              fontSize: 14,
                                              color: Colors.red,
                                              decoration:
                                                  TextDecoration.lineThrough))
                                    ]),
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              MaterialButton(
                                minWidth: 60,
                                height: 30,
                                color: MyColors.primaryColor,
                                onPressed: () {
                                  homeBloc.add(CartButtonClickedEvent(
                                      clickedProduct: product));
                                },
                                child: const Text(
                                  '+',
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
              }).toList(),
            ),
    );
  }
}
