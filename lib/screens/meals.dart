import 'package:flutter/material.dart';
import 'package:meals/models/meal.dart';
import 'package:meals/screens/meal_details.dart';
import 'package:meals/widgets/meal_item.dart';

import 'package:meals/data/dummy_data.dart';

class MealsScreen extends StatelessWidget {
  const MealsScreen({
    super.key,
    this.title,
    required this.meals,
    required this.onToggleMealFavorite,
  });

  final String? title; //marking as optional
  final List<Meal> meals;
  final Function(Meal meal) onToggleMealFavorite;

  void _selectedMeal(BuildContext context, Meal meal) {
    var choosenMeal =
        dummyMeals.where((element) => element.id == meal.id).toList()[0];
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (ctx) => MealDetailsScreen(
          meal: choosenMeal,
          onToggleMealFavorite: onToggleMealFavorite,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Widget mealContents = Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Uh no..... nothing here!',
            style: Theme.of(context).textTheme.headlineLarge!.copyWith(
                  color: Theme.of(context).colorScheme.onBackground,
                ),
          ),
          const SizedBox(
            height: 16,
          ),
          Text(
            'Try selecting different category!',
            style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                  color: Theme.of(context).colorScheme.onBackground,
                ),
          )
        ],
      ),
    );
    if (meals.isNotEmpty) {
      mealContents = ListView.builder(
        itemCount: meals.length,
        itemBuilder: (ctx, index) => MealItem(
          meal: meals[index],
          onMealTap: () {
            _selectedMeal(context, meals[index]);
          },
        ),
      );
    }
    if (title == null) {
      return mealContents;
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(title!),
      ),
      body: mealContents,
    );
  }
}
