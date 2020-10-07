import 'package:flutter/material.dart';
import 'package:meals_app/models/meal.dart';
import 'package:meals_app/screens/categories_screen.dart';
import 'package:meals_app/screens/favorites_screen.dart';
import 'package:meals_app/widgets/main_drawer.dart';

class TabsScreen extends StatefulWidget {
  final List<Meal> _favoriteMeals;

  TabsScreen(this._favoriteMeals);

  @override
  State<StatefulWidget> createState() {
    return _TabsScreenState();
  }
}

class _TabsScreenState extends State<TabsScreen> {
  int _selectedTabIndex = 0;
  List<Map<String, Object>> _tabs;

  @override
  void initState() {
    _tabs = [
      {'title': 'Categories', 'screen': CategoriesScreen()},
      {'title': 'Favorites', 'screen': FavoritesScreen(widget._favoriteMeals)}
    ];
    super.initState();
  }

  void _onTabSelect(int index) {
    setState(() {
      _selectedTabIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_tabs[_selectedTabIndex]['title']),
      ),
      drawer: MainDrawer(),
      body: _tabs[_selectedTabIndex]['screen'],
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: Theme.of(context).primaryColor,
        currentIndex: _selectedTabIndex,
        onTap: _onTabSelect,
        items: [
          BottomNavigationBarItem(
              icon: Icon(Icons.category), title: Text('Categories')),
          BottomNavigationBarItem(
              icon: Icon(Icons.star), title: Text('Favorites'))
        ],
      ),
    );
  }
}
