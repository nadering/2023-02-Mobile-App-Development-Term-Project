import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:madteamproject/NewLoginpage.dart';
import 'package:madteamproject/search_result_page/searchProvider.dart';
import 'package:provider/provider.dart';
import 'login_page.dart';
import 'main_page/main_page.dart';
import 'qna_page/qna_page.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(
    ChangeNotifierProvider(
      create: (context) => SearchProvider(),
      child: const App(),
    ),
  );
}

class App extends StatefulWidget {
  const App({Key? key}) : super(key: key);

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  int _selectedTabIndex = 0;
  static List<Widget> pages = <Widget>[
    const MainPage(),
    const QnaPage(),
  ];

  @override
  Widget build(BuildContext context) {
    final ThemeData themeData = ThemeData(
      useMaterial3: true,
      fontFamily: 'Pretendard',
      primaryColor: Colors.green,
      primarySwatch: Colors.green,
      dividerColor: Colors.transparent,
    );

    return MaterialApp(
      theme: themeData,
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: const Text(
            "Hi2Recycle",
            style: TextStyle(
              fontSize: 28.30,
              fontWeight: FontWeight.w600,
            ),
          ),
          actions: [
            Builder(
              builder: (BuildContext context) {
                return IconButton(
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => const LoginPage()),
                    );
                  },
                  icon: const Icon(Icons.person),
                );
              },
            )
          ],
          scrolledUnderElevation: 0,
        ),
        body: pages[_selectedTabIndex],
        bottomNavigationBar: BottomNavigationBar(
          selectedItemColor: Colors.green,
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: "홈"),
            BottomNavigationBarItem(
                icon: Icon(Icons.question_mark), label: "Q&A"),
          ],
          currentIndex: _selectedTabIndex,
          onTap: (int index) {
            setState(() {
              _selectedTabIndex = index;
            });
          },
        ),
      ),
    );
  }
}
