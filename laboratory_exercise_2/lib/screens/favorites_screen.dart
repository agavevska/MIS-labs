import 'package:flutter/material.dart';
import 'package:laboratory_exercise_2/services/favorites_service.dart';
import '../models/meal.dart';
import '../services/meal_service.dart';
import '../widgets/meal_card.dart';
import 'meal_details_screen.dart';

class FavoritesScreen extends StatefulWidget {

  const FavoritesScreen({
    super.key,
  });

  @override
  State<FavoritesScreen> createState() => _FavoritesScreenState();
}

class _FavoritesScreenState extends State<FavoritesScreen> {
  final FavoritesService _favoritesService = FavoritesService();
  final MealService _mealService = MealService();
  late List<Meal> _favoriteMeals = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadFavorites();
  }

  Future<void> _loadFavorites() async {
    setState(() => _isLoading = true);

    try {
      final favoriteIds = await _favoritesService.loadFavorites();

      if (favoriteIds.isEmpty) {
        setState(() {
          _favoriteMeals = [];
          _isLoading = false;
        });
        return;
      }

      List<Meal> meals = [];
      for (String mealId in favoriteIds) {
        try {
          final meal = await _mealService.getMealById(mealId);
          if (meal != null) {
            meals.add(meal.copyWith(isFavorite: true));
          }
        } catch (e) {
          print('Error loading meal $mealId: $e');
        }
      }

      setState(() {
        _favoriteMeals = meals;
        _isLoading = false;
      });
    } catch (e) {
      setState(() => _isLoading = false);
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error loading favorites: $e')),
        );
      }
    }
  }

  void _toggleFavorite(Meal meal) async {
    setState(() {
      meal.isFavorite = !meal.isFavorite;
    });

    if (meal.isFavorite) {
      await _favoritesService.addFavorite(meal.mealId);
    } else {
      await _favoritesService.removeFavorite(meal.mealId);
    }

    _loadFavorites();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Favorite Recipes"),
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : _favoriteMeals.isEmpty
          ? const Center(
        child: Text(
          "No favorite recipes yet ❤️",
          style: TextStyle(fontSize: 18),
        ),
      )
          : GridView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: _favoriteMeals.length,
        gridDelegate:
        const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 0.85,
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
        ),
        itemBuilder: (context, index) {
          final meal = _favoriteMeals[index];

          return MealCard(
            meal: meal,
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => MealDetailScreen(
                    mealId: meal.mealId,
                  ),
                ),
              );
            },
            onFavoriteToggle: () => _toggleFavorite(meal),
          );
        },
      ),
    );
  }
}