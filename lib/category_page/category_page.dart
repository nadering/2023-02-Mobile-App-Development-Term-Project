import 'package:flutter/material.dart';
import 'single_object.dart';

class CategoryPage extends StatefulWidget {
  final String searchTarget;

  const CategoryPage({super.key, required this.searchTarget});

  @override
  State<CategoryPage> createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.searchTarget,
          style: const TextStyle(fontSize: 21.28, fontWeight: FontWeight.w600),
        ),
        scrolledUnderElevation: 0,
      ),
      body: ListView.builder(
          itemCount: 20,
          itemBuilder: (context, index) {
            return SingleObject(name: "Test name $index");
          }),
    );
  }
}
