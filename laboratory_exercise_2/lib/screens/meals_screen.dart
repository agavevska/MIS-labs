import 'package:flutter/material.dart';
import '../models/meal.dart';
import '../services/favorites_service.dart';
import '../services/meal_service.dart';
import '../widgets/meal_card.dart';
import '../widgets/search_bar.dart';
import 'meal_details_screen.dart';

class MealsScreen extends StatefulWidget {
  final String category;

  const MealsScreen({super.key, required this.category});

  @override
  State<MealsScreen> createState() => _MealsScreenState();
}

class _MealsScreenState extends State<MealsScreen> {
  final MealService _mealService = MealService();
  final FavoritesService _favoritesService = FavoritesService();
  List<Meal> _meals = [];
  List<Meal> _filteredMeals = [];
  bool _isLoading = true;
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadMeals();
  }

  Future<void> _loadMeals() async {
    try {
      final meals = await _mealService.getMealsByCategory(widget.category);
      final favoriteIds = await _favoritesService.loadFavorites();

      setState(() {
        _meals = meals.map((meal) {
          return meal.copyWith(
            isFavorite: favoriteIds.contains(meal.mealId),
          );
        }).toList();
        _filteredMeals = _meals;
        _isLoading = false;
      });
    } catch (e) {
      setState(() => _isLoading = false);
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error: $e')),
        );
      }
    }
  }

  Future<void> _searchMeals(String query) async {
    if (query.isEmpty) {
      setState(() => _filteredMeals = _meals);
      return;
    }

    try {
      final searchResults = await _mealService.searchMeals(query);
      final mealIds = _meals.map((m) => m.mealId).toSet();
      setState(() {
        _filteredMeals = searchResults
            .where((meal) => mealIds.contains(meal.mealId))
            .toList();
      });
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Error')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.category),
        elevation: 0,
      ),
      body: Column(
        children: [
          MealSearchBar(
            controller: _searchController,
            onChanged: _searchMeals,
          ),
          Expanded(
            child: _isLoading
                ? const Center(child: CircularProgressIndicator())
                : _filteredMeals.isEmpty
                ? const Center(
              child: Text(
                'No recipes found',
                style: TextStyle(fontSize: 18),
              ),
            )
                : GridView.builder(
              padding: const EdgeInsets.all(16),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 0.85,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
              ),
              itemCount: _filteredMeals.length,
              itemBuilder: (context, index) {
                final meal = _filteredMeals[index];
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
          ),
        ],
      ),
    );
  }

  Future<void> _toggleFavorite(Meal meal) async {
    setState(() {
      meal.isFavorite = !meal.isFavorite;
    });

    if (meal.isFavorite) {
      await _favoritesService.addFavorite(meal.mealId);
    } else {
      await _favoritesService.removeFavorite(meal.mealId);
    }
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }
}