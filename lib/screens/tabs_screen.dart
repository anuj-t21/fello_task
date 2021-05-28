import 'package:fello_app/screens/game_screen.dart';
import 'package:fello_app/screens/news_screen.dart';
import 'package:flutter/material.dart';

class TabsScreen extends StatefulWidget {
  static const routeName = '/tabs-screen';

  TabsScreen();

  @override
  _TabsScreenState createState() => _TabsScreenState();
}

class _TabsScreenState extends State<TabsScreen> {
  List<Map<String, Object>> _page;
  int _selectedPageIndex = 0;

  void _selectPage(int index) {
    setState(() {
      _selectedPageIndex = index;
    });
  }

  @override
  void initState() {
    _page = [
      {
        'page': GameScreen(),
        'title': 'Game',
      },
      {
        'page': NewsScreen(),
        'title': 'News',
      },
    ];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.cyan,
      body: Column(
        children: [
          Container(
            margin: EdgeInsets.only(top: deviceSize.height * 0.2),
            child: Text(
              'FELLO APP',
              style: TextStyle(
                fontSize: 30,
                color: Colors.purple,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          _page[_selectedPageIndex]['page'],
        ],
      ),
      bottomNavigationBar: new Theme(
        data: Theme.of(context).copyWith(
          canvasColor: Theme.of(context).primaryColor,
          // sets the active color of the `BottomNavigationBar` if `Brightness` is light
          primaryColor: Colors.red,
          textTheme: Theme.of(context).textTheme.copyWith(
                caption: new TextStyle(color: Colors.yellow),
              ),
        ),
        child: BottomNavigationBar(
          onTap: _selectPage,
//          backgroundColor: Theme.of(context).primaryColor,
//          unselectedItemColor: Colors.white,
          selectedItemColor: Theme.of(context).accentColor,
          currentIndex: _selectedPageIndex,
          items: [
            BottomNavigationBarItem(
              icon: Icon(
                Icons.category,
              ),
              label: 'Game',
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.history,
              ),
              label: 'News',
            ),
          ],
        ),
      ),
    );
  }
}
