import 'package:flutter/material.dart';

class InformationPage extends StatefulWidget {
  final int categoryId;
  final int objectId;
  final String name;
  final String imageName;
  final List<String> method;

  const InformationPage({
    Key? key,
    required this.categoryId,
    required this.objectId,
    required this.name,
    required this.imageName,
    required this.method,
  }) : super(key: key);


  // Override createState method to create an associated State class
  @override
  State<InformationPage> createState() => _InformationPageState();
}



class _InformationPageState extends State<InformationPage> {
  @override
  Widget build(BuildContext context) {
    // Scaffold widget for the page
    return Scaffold(
      appBar: AppBar(
        scrolledUnderElevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 20.0, left: 16.0, right: 16.0),
        child: ListView(
          children: [
            // Displaying the image with AspectRatio
            AspectRatio(
              aspectRatio: 1.5 / 1,
              child: SizedBox(
                width: double.infinity,
                child: Image(
                  image: AssetImage(
                    "assets/images/objectImage/${widget.imageName}",
                  ),
                ),
              ),
            ),
            const SizedBox(height: 8.0),
            // Displaying the name
            Text(
              widget.name,
              style: const TextStyle(
                fontSize: 28.3,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 20.0),
            // Displaying the list of methods
            Padding(
              padding: const EdgeInsets.only(bottom: 40.0),
              child: Column(
                children: widget.method.map((method) {
                  return Column(
                    children: [
                      Text(
                        method,
                        style: const TextStyle(
                          fontSize: 21.28,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      const SizedBox(height: 12),
                    ],
                  );
                }).toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

