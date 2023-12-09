import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'single_object.dart';

class CategoryPage extends StatefulWidget {
  final String name;
  final int id;

  const CategoryPage({super.key, required this.name, required this.id});

  @override
  State<CategoryPage> createState() => _CategoryPageState();
}

class ObjectInfo {
  final int id;
  final String image;
  final String name;
  final List<String> method;

  ObjectInfo(
      {required this.id,
      required this.image,
      required this.name,
      required this.method});

  factory ObjectInfo.fromJson(Map<String, dynamic> json) {
    List<String> methodList = List<String>.from(json["method"]);

    return ObjectInfo(
      id: json["id"],
      image: json["image"],
      name: json["name"],
      method: methodList,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "image": image,
      "name": name,
      "method": method,
    };
  }
}

class _CategoryPageState extends State<CategoryPage> {
  Future<List<SingleObject>> _getObjectListInformation() async {
    FirebaseFirestore firestore = FirebaseFirestore.instance;

    // 카테고리
    QuerySnapshot<Map<String, dynamic>> categorySnapshot = await firestore
        .collection("category")
        .where("id", isEqualTo: widget.id)
        .get();

    // 오브젝트
    String docId = categorySnapshot.docs.elementAt(0).id;
    QuerySnapshot<Map<String, dynamic>> objectSnapshot = await firestore
        .collection("category")
        .doc(docId)
        .collection("object")
        .get();

    List<ObjectInfo> fetchResult =
        objectSnapshot.docs.map((e) => ObjectInfo.fromJson(e.data())).toList();

    List<SingleObject> result = fetchResult
        .map((info) => SingleObject(
              categoryId: widget.id,
              objectId: info.id,
              name: info.name,
              imageName: info.image,
              method: info.method,
            ))
        .toList();
    return result;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.name,
          style: const TextStyle(fontSize: 21.28, fontWeight: FontWeight.w600),
        ),
        scrolledUnderElevation: 0,
      ),
      body: FutureBuilder(
          future: _getObjectListInformation(),
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
              return ListView(
                children: snapshot.data,
              );
            }
          }),
    );
  }
}
