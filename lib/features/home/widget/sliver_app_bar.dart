import 'package:flutter/material.dart';
import '../../../utils/color_constants.dart';

class SAppBar extends StatelessWidget {
  final Function(String) onSearch;

  const SAppBar({super.key, required this.onSearch});

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      floating: true,
      pinned: true,
      title: const Text('C-MART', style: TextStyle(fontWeight: FontWeight.bold),),
      actions: [
        Padding(
          padding: const EdgeInsets.only(right: 25.0),
          child: Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
                color: const Color(0xFFECF5EF),
                borderRadius: BorderRadius.circular(20)),
            child: IconButton(
                onPressed: () {},
                icon: const Icon(
                  Icons.person,
                )),
          ),
        )
      ],
      centerTitle: true,
      bottom: PreferredSize(
        preferredSize: const Size.fromHeight(70),
        child: AppBar(
            title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Container(
              width: MediaQuery.of(context).size.width * 0.70,
              height: 50,
              decoration: BoxDecoration(
                color: const Color(0xFFECF5EF),
                borderRadius: BorderRadius.circular(10),
              ),
              child: TextFormField(
                onChanged: onSearch,
                decoration: InputDecoration(
                  icon: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Icon(
                      Icons.search,
                      color: MyColors.primaryColor,
                    ),
                  ),
                  hintText: 'Search item...',
                  hintStyle: const TextStyle(fontSize: 14, color: Colors.grey),
                  border: InputBorder.none,
                ),
              ),
            ),
            Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                  color: MyColors.primaryColor,
                  borderRadius: BorderRadius.circular(20)),
              child: IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.filter_list,
                    color: Colors.white,
                  )),
            )
          ],
        )),
      ),
    );
  }
}
