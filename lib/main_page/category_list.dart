import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'category_icon.dart';
import 'package:madteamproject/category_page/category_page.dart';

class CategoryInfo {
  final int id;
  final String image;
  final String name;

  CategoryInfo({required this.id, required this.image, required this.name});

  factory CategoryInfo.fromJson(Map<String, dynamic> json) {
    return CategoryInfo(
      id: json["id"],
      image: json["image"],
      name: json["name"],
    );
  }
  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "image": image,
      "name": name,
    };
  }
}

class CategoryList extends StatefulWidget {
  const CategoryList({super.key});

  @override
  State<CategoryList> createState() => _CategoryListState();
}

class _CategoryListState extends State<CategoryList> {
  // Get category list information from firebase.
  Future<List<CategoryIcon>> _getCategoryListInformation() async {
    FirebaseFirestore firestore = FirebaseFirestore.instance;

    QuerySnapshot<Map<String, dynamic>> snapshot =
        await firestore.collection("category").orderBy("id").get();

    List<CategoryInfo> fetchResult =
        snapshot.docs.map((e) => CategoryInfo.fromJson(e.data())).toList();

    List<CategoryIcon> result = fetchResult
        .map((info) => CategoryIcon(
              id: info.id,
              name: info.name,
              imageName: info.image,
              linkedWidget: CategoryPage(name: info.name, id: info.id),
            ))
        .toList();
    return result;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 16.0, right: 16.0),
      child: Column(
        children: [
          const Text(
            "원하는 카테고리를 찾아볼 수도 있어요.",
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
            child: SizedBox(
              height: 330.0,
              child: FutureBuilder(
                  future: _getCategoryListInformation(),
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
                      return GridView.count(
                        crossAxisCount: 3,
                        mainAxisSpacing: 8,
                        crossAxisSpacing: 8,
                        physics: const ScrollPhysics(),
                        children: snapshot.data,
                      );
                    }
                  }),
            ),
          ),
        ],
      ),
    );
  }
}
