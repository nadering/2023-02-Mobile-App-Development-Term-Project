import 'package:flutter/material.dart';
import 'single_qna.dart';

class QnaPage extends StatefulWidget {
  const QnaPage({super.key});

  @override
  State<QnaPage> createState() => _QnaPageState();
}

class _QnaPageState extends State<QnaPage> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 20.0, left: 16.0, right: 16.0),
      child: ListView(children: [
        const Text(
          "자주 찾는 질문들을 모아뒀어요.",
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(
          height: 12.0,
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: 40.0),
          child: Column(
            children: List.generate(20, (index) {
              return Column(
                children: [
                  SizedBox(
                    width: double.infinity,
                    child:
                        SingleQna(title: "Test title $index", answer: "answer"),
                  ),
                  const SizedBox(
                    height: 12,
                  )
                ],
              );
            }),
          ),
        ),
      ]),
    );
  }
}
