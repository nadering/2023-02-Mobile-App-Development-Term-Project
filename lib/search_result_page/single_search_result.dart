import 'package:flutter/material.dart';
import 'package:madteamproject/information_page/information_page.dart';

class SingleSearchResult extends StatefulWidget {
  final String name;
  final int categoryId;
  final int objectId;

  const SingleSearchResult(
      {super.key, required this.name, this.categoryId = 0, this.objectId = 0});

  @override
  State<SingleSearchResult> createState() => _SingleSearchResultState();
}

class _SingleSearchResultState extends State<SingleSearchResult> {
  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(widget.name,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w400)),
      trailing: const Icon(Icons.navigate_next),
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => InformationPage(
                      categoryId: widget.categoryId,
                      objectId: widget.objectId,
                      name: "test",
                      imageName: "aluminumCan.jpg",
                      method: const ["test"],
                    )));
      },
    );
  }
}
