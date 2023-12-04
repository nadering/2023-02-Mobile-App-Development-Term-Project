import 'package:flutter/material.dart';
import 'single_object.dart';

class CategoryPage extends StatefulWidget {
  final String name;

  const CategoryPage({super.key, required this.name});

  @override
  State<CategoryPage> createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.name,
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
