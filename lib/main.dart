import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nytimes_test/ui/bookmark_list.dart';
import 'package:nytimes_test/ui/stroy_list.dart';
import 'package:path_provider/path_provider.dart' as path_provider;
import 'package:hive/hive.dart';
import 'models/bookmark.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  //get app directory for hive database
  final appDocumentDir = await path_provider.getApplicationDocumentsDirectory();
  //initalize hive in the app directory
  Hive.init(appDocumentDir.path);
  //register class bbokmark adabter
  Hive.registerAdapter(BookmarkAdapter());
  await Hive.openBox('bookmarks');

  runApp(MaterialApp(
    home: MyApp(),
  ));
}

class MyApp extends StatefulWidget {
  // This widget is the root of your application.
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> with TickerProviderStateMixin {
  //controller for tab
  TabController _controller;
  int _selectedIndex = 0;
  List<Widget> list = [
    Tab(icon: Icon(Icons.list_alt)),
    Tab(icon: Icon(Icons.bookmark)),
  ];
  @override
  void initState() {
    // Create TabController for getting the index of current tab
    _controller = TabController(length: list.length, vsync: this);
    _controller.addListener(() {
      setState(() {
        _selectedIndex = _controller.index;
      });
    });
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    //check platform ios or android to change style depnad on it
    bool isIOS = Theme.of(context).platform == TargetPlatform.iOS;
    return isIOS
        ? CupertinoPageScaffold(
            navigationBar: CupertinoNavigationBar(
              middle: Text('Test'),
            ),
            child: Container(
              child: TabBarView(
                controller: _controller,
                children: [StoryList(), BookmarkList()],
              ),
            ))
        : Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.redAccent,
              title: Text(
                "Test",
                style: TextStyle(
                  fontSize: 28.0,
                  fontWeight: FontWeight.w700,
                  color: Colors.white,
                  letterSpacing: 2.0,
                ),
              ),
              bottom: TabBar(
                controller: _controller,
                tabs: list,
              ),
            ),
            body: TabBarView(
              controller: _controller,
              children: [StoryList(), BookmarkList()],
            ),
          );
  }
}
