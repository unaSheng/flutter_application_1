import 'package:flutter/material.dart';
import 'package:flutter_application_1/normal_feed_list_page.dart';
import 'package:flutter_application_1/visible_test.dart';
import 'custom_widget_list.dart';
import 'user_list.dart';
import 'home.dart';

class TabBarDemoApp extends StatelessWidget {
  const TabBarDemoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: DefaultTabController(
        length: 3,
        child: Scaffold(
          appBar: AppBar(
            bottom: const TabBar(
              tabs: [
                Tab(icon: Icon(Icons.directions_car)),
                Tab(icon: Icon(Icons.directions_transit)),
                Tab(icon: Icon(Icons.directions_bike)),
              ],
            ),
            title: const Text('Tabs Demo'),
          ),
          body: const TabBarView(
            children: [
              MyHomePage(title: ''),
              UserListPage(),
              CustomListPage(),
            ],
          ),
        ),
      ),
    );
  }
}

class BottomNavigationBarPageApp extends StatelessWidget {
  const BottomNavigationBarPageApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
        debugShowCheckedModeBanner: false, home: BottomNavigationBarPage());
  }
}

class BottomNavigationBarPage extends StatefulWidget {
  const BottomNavigationBarPage({super.key});
  @override
  State<BottomNavigationBarPage> createState() =>
      _BottomNavigationBarPageState();
}

class _BottomNavigationBarPageState extends State<BottomNavigationBarPage> {
  int currentIndex = 0;

  static final List<Widget> _widgetOptions = <Widget>[
    const MyHomePage(title: ''),
    VisibilityDetectorDemoPage(),
    const CustomListPage(),
    const NormalFeedListPage()
  ];

  String get customTitle {
    if (currentIndex == 0) {
      return '首页';
    } else if (currentIndex == 1) {
      return '消息';
    } else if (currentIndex == 2) {
      return "我的";
    }
    return '更多';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        scrolledUnderElevation: 0.0,
        title: Text(customTitle),
        backgroundColor: Colors.transparent,
      ),
      body: Center(
        child: _widgetOptions.elementAt(currentIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: Icon(Icons.home), label: '首页'),
          BottomNavigationBarItem(
              icon: Icon(Icons.message_rounded), label: '消息'),
          BottomNavigationBarItem(icon: Icon(Icons.people), label: '我的'),
          BottomNavigationBarItem(icon: Icon(Icons.more), label: '更多'),
        ],
        onTap: onTabChanged,
        selectedItemColor: Colors.amber[800],
        selectedFontSize: 13,
        unselectedFontSize: 13,
      ),
    );
  }

  void onTabChanged(int value) {
    currentIndex = value;
    setState(() {});
  }
}
