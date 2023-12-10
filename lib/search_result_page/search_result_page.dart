import 'package:flutter/material.dart';
import 'package:madteamproject/information_page/information_page.dart';

class SingleSearchResult extends StatefulWidget {
  final String name;
  final int categoryId;
  final int objectId;

  const SingleSearchResult({
    Key? key,
    required this.name,
    this.categoryId = 0,
    this.objectId = 0,
  }) : super(key: key);

  @override
  State<SingleSearchResult> createState() => _SingleSearchResultState();
}

class _SingleSearchResultState extends State<SingleSearchResult> {
  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        widget.name,
        style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
      ),
      trailing: const Icon(Icons.navigate_next),
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => InformationPage(
              categoryId: widget.categoryId,
              objectId: widget.objectId,
              name: "test",
              imageName: "aluminumCan.jpg",
              method: const ["test"],
            ),
          ),
        );
      },
    );
  }
}

class SearchResultPage extends StatefulWidget {
  final String searchTarget;

  const SearchResultPage({Key? key, required this.searchTarget}) : super(key: key);

  @override
  State<SearchResultPage> createState() => _SearchResultPageState();
}

class _SearchResultPageState extends State<SearchResultPage> {
  late List<String> searchResults;
  late TextEditingController searchController;

  @override
  void initState() {
    super.initState();
    // Initialize the search results with some dummy data
    searchResults = List.generate(20, (index) => "Test name $index");
    searchController = TextEditingController();
  }

  List<String> get filteredSearchResults {
    return searchResults
        .where((item) => item.toLowerCase().contains(searchController.text.toLowerCase()))
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
              style: const TextStyle(fontSize: 21.28, fontWeight: FontWeight.w600),
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
      body: ListView.builder(
        itemCount: filteredSearchResults.length,
        itemBuilder: (context, index) {
          return SingleSearchResult(name: filteredSearchResults[index]);
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
        return ListTile(
          title: Text(filteredList[index]),
          onTap: () {
            // Handle item tap, for example, navigate to the detailed page
            // Navigator.push(context, MaterialPageRoute(builder: (context) => DetailPage(item: filteredList[index])));
          },
        );
      },
    );
  }
}
