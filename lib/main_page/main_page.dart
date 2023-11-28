import 'package:flutter/material.dart';
import 'search_bar.dart';
import 'category_list.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: const [
        SearchBarWidget(),
        SizedBox(
          height: 20.0,
        ),
        CategoryList(),
      ],
    );
  }
}
