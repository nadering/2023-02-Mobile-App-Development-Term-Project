import 'package:flutter/material.dart';
import 'package:madteamproject/information_page/information_page.dart';

class SingleObject extends StatefulWidget {
  final int categoryId;
  final int objectId;
  final String name;
  final String imageName;
  final List<String> method;

  const SingleObject(
      {super.key,
      required this.categoryId,
      required this.objectId,
      required this.name,
      required this.imageName,
      required this.method});

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
                      name: widget.name,
                      imageName: widget.imageName,
                      method: widget.method,
                    )));
      },
    );
  }
}
