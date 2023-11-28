import 'package:flutter/material.dart';
import 'category_icon.dart';
import 'package:madteamproject/information_page/information_page.dart';

class CategoryList extends StatefulWidget {
  const CategoryList({super.key});

  @override
  State<CategoryList> createState() => _CategoryListState();
}

class _CategoryListState extends State<CategoryList> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 16.0, right: 16.0),
      child: SizedBox(
        height: 400.0,
        child: ListView(
          children: [
            const Text(
              "원하는 카테고리를 찾아볼 수도 있어요.",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(
              height: 12.0,
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 40.0),
              child: SizedBox(
                height: 330.0,
                child: GridView.count(
                  crossAxisCount: 3,
                  mainAxisSpacing: 8,
                  crossAxisSpacing: 8,
                  physics: const ScrollPhysics(),
                  children: List.generate(16, (index) {
                    return CategoryIcon(
                      name: 'Test $index',
                      linkedWidget: const InformationPage(),
                    );
                  }),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
