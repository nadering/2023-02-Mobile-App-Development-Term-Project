import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'single_qna.dart';

class QnaPage extends StatefulWidget {
  const QnaPage({super.key});

  @override
  State<QnaPage> createState() => _QnaPageState();
}

class QnaInfo {
  final String question;
  final String answer;

  QnaInfo({required this.question, required this.answer});

  factory QnaInfo.fromJson(Map<String, dynamic> json) {
    return QnaInfo(
      question: json["question"],
      answer: json["answer"],
    );
  }
  Map<String, dynamic> toJson() {
    return {
      "question": question,
      "answer": answer,
    };
  }
}

class _QnaPageState extends State<QnaPage> {
  Future<List<SingleQna>> _getQnaInfoList() async {
    FirebaseFirestore firestore = FirebaseFirestore.instance;

    QuerySnapshot<Map<String, dynamic>> snapshot =
        await firestore.collection("qna").get();

    List<QnaInfo> fetchResult =
        snapshot.docs.map((e) => QnaInfo.fromJson(e.data())).toList();

    List<SingleQna> result = fetchResult
        .map((info) => SingleQna(
              question: info.question,
              answer: info.answer,
            ))
        .toList();
    return result;
  }

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
          child: FutureBuilder(
              future: _getQnaInfoList(),
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if (snapshot.hasData == false) {
                  return const SizedBox.shrink();
                } else if (snapshot.hasError) {
                  return const Text(
                    "데이터를 불러오는 중 오류가 발생했습니다.",
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w400,
                    ),
                  );
                } else {
                  return Column(
                      children: (snapshot.data as List).map((qna) {
                    return Column(
                      children: [
                        SizedBox(width: double.infinity, child: qna),
                        const SizedBox(
                          height: 12,
                        )
                      ],
                    );
                  }).toList());
                }
              }),
        ),
      ]),
    );
  }
}
