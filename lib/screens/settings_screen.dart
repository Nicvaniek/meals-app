import 'package:flutter/material.dart';
import 'package:meals_app/widgets/main_drawer.dart';

class SettingsScreen extends StatefulWidget {
  static const String routeName = '/settings';
  final Map<String, bool> filters;
  final Function onUpdateFilters;

  SettingsScreen(this.filters, this.onUpdateFilters);

  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool _isGlutenFree;
  bool _isLactoseFree;
  bool _isVegan;
  bool _isVegetarian;

  @override
  void initState() {
    _isGlutenFree = widget.filters['gluten'];
    _isLactoseFree = widget.filters['lactose'];
    _isVegetarian = widget.filters['veg'];
    _isVegan = widget.filters['vegan'];

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Settings'),
        actions: <Widget>[
          // Using the builder here so that we can switch context in order to show snackbar
          Builder(
              builder: (ctx) => IconButton(
                    icon: Icon(Icons.save),
                    onPressed: () {
                      final snackBar = SnackBar(
                        backgroundColor: Theme.of(context).accentColor,
                        duration: Duration(seconds: 2),
                        content: Text('Settings saved'),
                      );
                      widget.onUpdateFilters({
                        'gluten': _isGlutenFree,
                        'lactose': _isLactoseFree,
                        'veg': _isVegetarian,
                        'vegan': _isVegan
                      });
                      Scaffold.of(ctx).showSnackBar(snackBar);
                    },
                  ))
        ],
      ),
      drawer: MainDrawer(),
      body: Column(
        children: <Widget>[
          Container(
            margin: EdgeInsets.all(20),
            alignment: Alignment.center,
            child: Text(
              'Adjust your meal selection',
              style: Theme.of(context).textTheme.title,
            ),
          ),
          Expanded(
              child: ListView(
            children: <Widget>[
              SwitchListTile.adaptive(
                title: Text('Gluten-free'),
                subtitle: Text('Include gluten-free meals'),
                value: _isGlutenFree,
                onChanged: (newValue) {
                  setState(() {
                    _isGlutenFree = newValue;
                  });
                },
              ),
              SwitchListTile.adaptive(
                title: Text('Lactose-free'),
                subtitle: Text('Include lactose-free meals'),
                value: _isLactoseFree,
                onChanged: (newValue) {
                  setState(() {
                    _isLactoseFree = newValue;
                  });
                },
              ),
              SwitchListTile.adaptive(
                title: Text('Vegetarian'),
                subtitle: Text('Include vegetarian meals'),
                value: _isVegetarian,
                onChanged: (newValue) {
                  setState(() {
                    _isVegetarian = newValue;
                  });
                },
              ),
              SwitchListTile.adaptive(
                title: Text('Vegan'),
                subtitle: Text('Include vegan meals'),
                value: _isVegan,
                onChanged: (newValue) {
                  setState(() {
                    _isVegan = newValue;
                  });
                },
              )
            ],
          ))
        ],
      ),
    );
  }
}
