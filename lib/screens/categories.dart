import 'package:flutter/material.dart';
import 'package:meals/models/category.dart';
import 'package:meals/models/meal.dart';
import 'package:meals/screens/meals.dart';
import 'package:meals/widgets/category_grid_item.dart';

import 'package:meals/data/dummy_data.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen(
      {super.key,
      required this.onToggleMealFavorite,
      required this.availableMeals});

  final List<Meal> availableMeals;
  final Function(Meal meal) onToggleMealFavorite;
//in statelesswidget , builderContext is NOT available everywhere, so we have to pass.
  void _selectedCategory(BuildContext context, Category category) {
    var mealsOfCategory = availableMeals
        .where((meal) => meal.categories.contains(category.id))
        .toList();
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (ctx) => MealsScreen(
            title: category.title,
            meals: mealsOfCategory,
            onToggleMealFavorite: onToggleMealFavorite),
      ),
    ); //OR Navigator.push(context, route);
  }

  @override
  Widget build(BuildContext context) {
    return GridView(
      padding: const EdgeInsets.all(24),
      //creating grid view
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2, //how many cloumn on each row
        childAspectRatio: 3 / 2,
        crossAxisSpacing: 20, //row spacing
        mainAxisSpacing: 20, //column spacing
      ),
      children: availableCategories
          .map(
            (category) => CategoryGridItem(
              category: category,
              onCategoryTap: () {
                _selectedCategory(context, category);
              },
            ),
          )
          .toList(),
      //or we can use for loop like
      // children: [
      //   for (final category in availableCategories)
      //     CategoryGridItem(category: category)
      // ],
    );
  }
}
