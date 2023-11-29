import 'package:flutter/material.dart';
import 'package:madteamproject/information_page/information_page.dart';

class SingleObject extends StatefulWidget {
  final String name;
  final int categoryId;
  final int objectId;

  const SingleObject(
      {super.key, required this.name, this.categoryId = 0, this.objectId = 0});

  @override
  State<SingleObject> createState() => _SingleObjectState();
}

class _SingleObjectState extends State<SingleObject> {
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
                    )));
      },
    );
  }
}
