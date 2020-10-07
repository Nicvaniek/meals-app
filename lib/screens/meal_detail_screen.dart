import 'package:flutter/material.dart';
import 'package:meals_app/data/dummy_data-2.dart';

class MealDetailScreen extends StatelessWidget {
  static const routeName = '/meal-detail';
  final Function _isFavorite;
  final Function _toggleFavorite;

  MealDetailScreen(this._isFavorite, this._toggleFavorite);

  Widget buildSectionTitle(String title, BuildContext ctx) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      child: Text(
        title,
        style: Theme.of(ctx).textTheme.title,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final mealId = ModalRoute.of(context).settings.arguments as String;
    final meal = DUMMY_MEALS.firstWhere((element) => element.id == mealId);

    return Scaffold(
      appBar: AppBar(
        title: Text(meal.title),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            // TODO: Make this image height dynamic based on screen height
            Container(
              height: 300,
              width: double.infinity,
              child: Image.network(meal.imageUrl, fit: BoxFit.cover),
            ),
            buildSectionTitle('Ingredients', context),
            Container(
              decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(15)),
              padding: EdgeInsets.all(8),
              margin: EdgeInsets.all(10),
              height: 200,
              child: ListView.builder(
                itemBuilder: (ctx, index) => Card(
                  color: Theme.of(context).accentColor,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(meal.ingredients[index]),
                  ),
                ),
                itemCount: meal.ingredients.length,
              ),
            ),
            buildSectionTitle('Steps', context),
            ...meal.steps
                .map((step) => Column(
                      children: <Widget>[
                        ListTile(
                          leading: CircleAvatar(
                            child: Text('${meal.steps.indexOf(step) + 1}'),
                          ),
                          title: Text(step),
                        ),
                        Divider()
                      ],
                    ))
                .toList()
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _toggleFavorite(mealId);
        },
        child: Icon(_isFavorite(mealId) ? Icons.star : Icons.star_border),
      ),
    );
  }
}
