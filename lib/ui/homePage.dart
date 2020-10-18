import 'package:flutter/material.dart';
import 'package:flutter_flashcards/ui/catalogPage.dart';
import 'package:flutter_flashcards/ui/deckListPage.dart';
import 'package:flutter_flashcards/ui/header.dart';
import 'package:flutter_flashcards/ui/statisticPage.dart';
import 'package:flutter_flashcards/ui/settingsPage.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: buildPageView(),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        type: BottomNavigationBarType.fixed,
        items: initBottomNavigationBarItems(),
        onTap: (index) {
          bottomTapped(index);
        },
      )
    );
  }

  PageController pageController = PageController(
    initialPage: 0,
    keepPage: true
  );

  Widget buildPageView() {
    return PageView(
      controller: pageController,
      onPageChanged: (index) {
        pageChanged(index);
      },
      children:[
        DeckListPage(),
        StatisticPage(),
        CatalogPage()
      ],
    );
  }

  void pageChanged(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  void bottomTapped(int index) {
    setState(() {
      _selectedIndex = index;
      pageController.jumpToPage(index);
    });
  }
}

List<BottomNavigationBarItem> initBottomNavigationBarItems() {
  return [
    BottomNavigationBarItem(
      icon: Icon(Icons.home),
      label: 'Home'
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.insert_chart_outlined),
      label: 'Statistics'
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.list),
      label: 'Catalog'
    )
  ];
}