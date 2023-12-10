import 'package:flutter/material.dart';
import 'package:madteamproject/category_page/single_object.dart';
import 'package:madteamproject/information_page/information_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:madteamproject/search_result_page/searchProvider.dart';
import 'package:provider/provider.dart';

class SingleSearchResult extends StatefulWidget {
  final String name;
  final int categoryId;
  final int objectId;
  //final String imageName;
  //final List<String> method;

  const SingleSearchResult({
    Key? key,
    required this.name,
    // required this.imageName,
    //required this.method,
    this.categoryId = 0,
    this.objectId = 0,
  }) : super(key: key);

  @override
  State<SingleSearchResult> createState() => _SingleSearchResultState();
}

class _SingleSearchResultState extends State<SingleSearchResult> {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  @override
  Widget build(BuildContext context) {
    final searchProvider = Provider.of<SearchProvider>(context);
    return ListTile(
        title: Text(
          widget.name,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
        ),
        trailing: const Icon(Icons.navigate_next),
        onTap: () async {
          // 'category' 컬렉션의 모든 문서를 가져옵니다.
          late ObjectInfo thisObject;
          QuerySnapshot categorySnapshot =
              await firestore.collection('category').get();

          // 각 카테고리에 대해 반복합니다.
          loop:
          for (var categoryDoc in categorySnapshot.docs) {
            // 각 카테고리의 'object' 서브컬렉션을 쿼리합니다.
            QuerySnapshot objectSnapshot =
                await categoryDoc.reference.collection('object').get();

            // 각 객체 문서에 대해 반복합니다.
            for (QueryDocumentSnapshot objectDoc in objectSnapshot.docs) {
              if (widget.name.toLowerCase() ==
                  objectDoc.get('name').toString().toLowerCase()) {
                thisObject = ObjectInfo.fromJson(objectDoc.data() as Map<String, dynamic>);
                break loop;
              }
            }
          }

          if (!mounted) {
            print("mount 에러");
            return;
          }
          searchProvider.setValue(widget.name);
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => InformationPage(
                        categoryId: widget.categoryId,
                        objectId: widget.objectId,
                        name: widget.name,
                        imageName: thisObject.image,
                        method: thisObject.method,
                      )));
        });
  }
}

class SearchResultPage extends StatefulWidget {
  final String searchTarget;

  const SearchResultPage({Key? key, required this.searchTarget})
      : super(key: key);

  @override
  State<SearchResultPage> createState() => _SearchResultPageState();
}

class _SearchResultPageState extends State<SearchResultPage> {
  late List<String> searchResults;
  late TextEditingController searchController;
  late List<SingleObject> objectList;

  Future<List<SingleObject>> _getObjectListInformation() async {
    FirebaseFirestore firestore = FirebaseFirestore.instance;

    // 카테고리
    QuerySnapshot categorySnapshot =
        await firestore.collection('category').get();
    List<SingleObject> result = [];

    for (var categoryDoc in categorySnapshot.docs) {
      QuerySnapshot<Map<String, dynamic>> objectSnapshot =
          await categoryDoc.reference.collection('object').get();

      List<ObjectInfo> fetchResult = objectSnapshot.docs
          .map((e) => ObjectInfo.fromJson(e.data()))
          .toList();

      result.addAll(fetchResult
          .map((info) => SingleObject(
              categoryId: 1,
              objectId: info.id,
              name: info.name,
              imageName: info.image,
              method: info.method))
          .toList());
    }

    return result;
  }

  @override
  void initState() {
    super.initState();
    // Initialize the search results with some dummy data
    searchController = TextEditingController();
    //objectList =  _getObjectListInformation();
    //searchResults = List.generate(20, (index) => objectList[index].name);
  }

  List<String> get filteredSearchResults {
    return searchResults
        .where((item) =>
            item.toLowerCase().contains(widget.searchTarget.toLowerCase()))
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Text(
              widget.searchTarget,
              style:
                  const TextStyle(fontSize: 21.28, fontWeight: FontWeight.w600),
            ),
            const Text(
              " 검색 결과",
              style: TextStyle(fontSize: 21.28, fontWeight: FontWeight.w400),
            )
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              showSearch(
                context: context,
                delegate: CustomSearchDelegate(searchResults, searchController),
              );
            },
          ),
        ],
        scrolledUnderElevation: 0,
      ),
      body: FutureBuilder(
        future: _getObjectListInformation(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasData == false) {
            return const SizedBox.shrink();
          } else if (snapshot.hasError) {
            return const Text("데이터를 불러오는 중 오류가 발생했습니다.");
          } else {
            objectList = snapshot.data;
            searchResults = List.generate(
                objectList.length, (index) => objectList[index].name);
            return ListView.builder(
              itemCount: filteredSearchResults.length,
              itemBuilder: (context, index) {
                return SingleSearchResult(name: filteredSearchResults[index]);
              },
            );
          }
        },
      ),
    );
  }
}

class CustomSearchDelegate extends SearchDelegate<String> {
  final List<String> searchList;
  final TextEditingController searchController;

  CustomSearchDelegate(this.searchList, this.searchController);

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: const Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back),
      onPressed: () {
        close(context, '');
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return _buildSearchResults(query);
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return _buildSearchResults(query);
  }

  Widget _buildSearchResults(String query) {
    final filteredList = searchList
        .where((item) => item.toLowerCase().contains(query.toLowerCase()))
        .toList();

    return ListView.builder(
      itemCount: filteredList.length,
      itemBuilder: (context, index) {
        return SingleSearchResult(name: filteredList[index]);
        },

    );
  }
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
