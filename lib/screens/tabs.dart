import 'package:flutter/material.dart';
import 'package:meals/data/dummy_data.dart';
import 'package:meals/models/meal.dart';
import 'package:meals/screens/categories.dart';
import 'package:meals/screens/filters.dart';
import 'package:meals/screens/meals.dart';
import 'package:meals/widgets/main_drawer.dart';

const kInitializeFilters = {
  Filter.glutenFree: false,
  Filter.lactoseFree: false,
  Filter.vegeterian: false,
  Filter.vegan: false,
};

class TabsScreen extends StatefulWidget {
  const TabsScreen({super.key});

  @override
  State<TabsScreen> createState() {
    return _TabsScreenState();
  }
}

class _TabsScreenState extends State<TabsScreen> {
  int _setActivePageIndex = 0;
  final List<Meal> _favoritesMeals = [];
  Map<Filter, bool> _selectedFilters = kInitializeFilters;

  void _showInfoMessage(String message) {
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      duration: const Duration(seconds: 3), //default is 4 seconds
      content: Text(message),
    ));
  }

  void _setScreen(String identifier) async {
    Navigator.of(context).pop();
    if (identifier == 'filters') {
      final result = await Navigator.of(context).push<Map<Filter, bool>>(
        MaterialPageRoute(
          builder: (ctx) => FiltersScreen(
            currentFilters: _selectedFilters,
          ),
        ),
      );
      setState(() {
        _selectedFilters = result ??
            kInitializeFilters; //way to check if result is null (kind of terniary operator)
      });
    }
  }

  void _toggleFavoriteStaus(Meal meal) {
    final isExisted = _favoritesMeals.contains(meal);

    if (isExisted) {
      setState(() {
        _favoritesMeals.remove(meal);
      });
      _showInfoMessage("Meal is not longer favorite");
    } else {
      setState(() {
        _favoritesMeals.add(meal);
      });
      _showInfoMessage("Meal is added as favorite!");
    }
  }

  void _selectPage(int index) {
    setState(() {
      _setActivePageIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final List<Meal> availableMeals = dummyMeals.where((meal) {
      if (_selectedFilters[Filter.glutenFree]! && !meal.isGlutenFree) {
        return false;
      }
      if (_selectedFilters[Filter.lactoseFree]! && !meal.isLactoseFree) {
        return false;
      }
      if (_selectedFilters[Filter.vegeterian]! && !meal.isVegetarian) {
        return false;
      }
      if (_selectedFilters[Filter.vegan]! && !meal.isVegan) {
        return false;
      }

      return true;
    }).toList();

    Widget activePage = CategoriesScreen(
      onToggleMealFavorite: _toggleFavoriteStaus,
      availableMeals: availableMeals,
    );
    var activePageTitle = "Choose your category";

    if (_setActivePageIndex == 1) {
      activePage = MealsScreen(
        meals: _favoritesMeals,
        onToggleMealFavorite: _toggleFavoriteStaus,
      );
      activePageTitle = "Your's Favorites";
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(activePageTitle),
      ),
      drawer: MainDrawer(
        onSelectScreen: _setScreen,
      ),
      body: activePage,
      bottomNavigationBar: BottomNavigationBar(
        onTap: _selectPage,
        currentIndex: _setActivePageIndex,
        items: const [
          BottomNavigationBarItem(
              icon: Icon(Icons.set_meal), label: "Categories"),
          BottomNavigationBarItem(icon: Icon(Icons.star), label: "Favorites"),
        ],
      ),
    );
  }
}
