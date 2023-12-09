import 'package:flutter/material.dart';

class SingleQna extends StatefulWidget {
  final String question;
  final String answer;

  const SingleQna({super.key, required this.question, required this.answer});

  @override
  State<SingleQna> createState() => _SingleQnaState();
}

class _SingleQnaState extends State<SingleQna> {
  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      title: Text(
        widget.question,
        style: const TextStyle(
          fontSize: 21.28,
          fontWeight: FontWeight.w400,
        ),
      ),
      childrenPadding: const EdgeInsets.only(
        top: 4.0,
        right: 28.0,
        bottom: 4.0,
        left: 28.0,
      ),
      children: [
        SizedBox(
          width: double.infinity,
          child: Text(widget.answer,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w400,
              )),
        )
      ],
    );
  }
}
