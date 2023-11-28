import 'package:flutter/material.dart';

class CategoryIcon extends StatefulWidget {
  final String name;
  final String imageName;
  final Widget linkedWidget;

  const CategoryIcon({
    super.key,
    required this.name,
    this.imageName = "",
    this.linkedWidget = const Placeholder(),
  });

  @override
  State<CategoryIcon> createState() => _CategoryIconState();
}

class _CategoryIconState extends State<CategoryIcon> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(16.0),
      child: Container(
        constraints: const BoxConstraints(
          minWidth: 70.0,
          maxWidth: 70.0,
          minHeight: 50.0,
        ),
        padding: const EdgeInsets.all(8.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(
                width: 60,
                height: 60,
                child: DecoratedBox(
                    decoration: BoxDecoration(
                  color: Colors.green,
                )),
              ),
              const SizedBox(
                height: 8.0,
              ),
              Text(
                widget.name,
                style: const TextStyle(
                  fontSize: 14.0,
                  fontWeight: FontWeight.w400,
                ),
                textAlign: TextAlign.center,
              )
            ],
          ),
        ),
      ),
      onTap: () {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => widget.linkedWidget));
      },
    );
  }
}
