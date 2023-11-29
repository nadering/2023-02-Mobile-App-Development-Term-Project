import 'package:flutter/material.dart';

class SearchResultPage extends StatefulWidget {
  final String searchTarget;

  const SearchResultPage({super.key, required this.searchTarget});

  @override
  State<SearchResultPage> createState() => _SearchResultPageState();
}

class _SearchResultPageState extends State<SearchResultPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Row(
        children: [
          Text(
            widget.searchTarget,
            style:
                const TextStyle(fontSize: 21.28, fontWeight: FontWeight.w600),
          ),
          const Text(
            " 검색 결과",
            style: TextStyle(fontSize: 21.28, fontWeight: FontWeight.w400),
          )
        ],
      )),
      body: const Placeholder(),
    );
  }
}
