import 'package:flutter/material.dart';
import 'package:simple_grocery/features/categories/model/category_model.dart';
import 'package:simple_grocery/features/categories/ui/category_item_screen.dart';

class Categories extends StatefulWidget {
  const Categories({
    super.key,
  });

  @override
  State<Categories> createState() => _CategoriesState();
}

class _CategoriesState extends State<Categories> {
  bool _isSearching = false;
  List<CategoryModel> filteredCategory = [];

  @override
  void initState() {
    filteredCategory = List.from(categoryModel);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: _isSearching
              ? SizedBox(
                  height: 40,
                  child: TextFormField(
                    onChanged: (value) {
                      setState(() {
                        filteredCategory = categoryModel
                            .where((category) => category.categoryName
                                .toLowerCase()
                                .contains(value.toLowerCase()))
                            .toList();
                      });
                    },
                    decoration: const InputDecoration(
                        contentPadding: EdgeInsets.all(10),
                        hintText: 'search...',
                        border: OutlineInputBorder()),
                  ),
                )
              : const Text('Categories', style: TextStyle(fontWeight: FontWeight.bold),),
          actions: [
            IconButton(
                onPressed: () {
                  setState(() {
                    _isSearching = !_isSearching;
                  });
                },
                icon: _isSearching
                    ? const Icon(
                        Icons.close,
                        size: 20,
                        color: Colors.black,
                      )
                    : const Icon(
                        Icons.search,
                        size: 20,
                        color: Colors.black,
                      ))
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(15.0),
          child: GridView.count(
            childAspectRatio: 0.8,
            crossAxisSpacing: 10,
            mainAxisSpacing: 0,
            crossAxisCount: 3,
            children: List.generate(
                filteredCategory.length,
                (index) => Column(
                      children: [
                        InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (_) => CategoryItemsScreen(
                                        categoryId: filteredCategory[index]
                                            .categoryName)));
                          },
                          child: Container(
                            height: 100,
                            decoration: BoxDecoration(
                                border: Border.all(color: Colors.grey),
                                borderRadius: BorderRadius.circular(15),
                                image: DecorationImage(
                                    image: NetworkImage(
                                        filteredCategory[index].categoryImg),
                                    fit: BoxFit.contain)),
                          ),
                        ),
                        Text(
                          filteredCategory[index].categoryName,
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        )
                      ],
                    )),
          ),
        ));
  }
}
