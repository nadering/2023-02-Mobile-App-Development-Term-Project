import 'package:flutter/material.dart';
import 'package:madteamproject/search_result_page/searchProvider.dart';
import 'package:madteamproject/search_result_page/search_result_page.dart';
import 'package:provider/provider.dart';

class SearchBarWidget extends StatefulWidget {
  const SearchBarWidget({super.key});

  @override
  State<SearchBarWidget> createState() => _SearchBarWidgetState();
}

class _SearchBarWidgetState extends State<SearchBarWidget> {
  @override
  Widget build(BuildContext context) {
    final searchProvider = Provider.of<SearchProvider>(context);
    return Padding(
      padding: const EdgeInsets.only(top: 20.0, left: 16.0, right: 16.0),
      child: SizedBox(
        height: 140.0,
        child: ListView(children: [
          const Text(
            "모르는 게 있다면 바로 검색해보세요.",
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(
            height: 12.0,
          ),
          SearchAnchor(
            builder: (BuildContext context, SearchController controller) {
              return SearchBar(
                controller: controller,
                backgroundColor: MaterialStateProperty.all(
                    const Color.fromRGBO(194, 245, 179, 1.0)),
                overlayColor: MaterialStateProperty.all(
                    const Color.fromRGBO(200, 252, 184, 1.0)),
                shape: MaterialStateProperty.all(
                    const ContinuousRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(40)))),
                padding: const MaterialStatePropertyAll<EdgeInsets>(
                    EdgeInsets.symmetric(horizontal: 16.0)),
                onSubmitted: (String value) {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              SearchResultPage(searchTarget: value)));
                },
                leading: const Icon(Icons.search),
                trailing: [
                  IconButton(
                      onPressed: () {
                        controller.clear();
                      },
                      icon: const Icon(Icons.close))
                ],
              );
            },
            suggestionsBuilder:
                (BuildContext context, SearchController controller) {
              return List<ListTile>.generate(5, (int index) {
                final String item = 'item $index';
                return ListTile(
                  title: Text(item),
                  onTap: () {
                    setState(() {
                      controller.closeView(item);
                    });
                  },
                );
              });
            },
          )
          ,const SizedBox(height: 12.0)
          ,Row(
            children: [
              Text('최근 검색 : ',
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                  )),
              Text(searchProvider.value,
                  style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w600,
              )),
            ],
          )
        ]),
      ),
    );
  }
}
