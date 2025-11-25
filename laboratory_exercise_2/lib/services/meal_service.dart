import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/category.dart';
import '../models/meal.dart';

class MealService {
  static const String baseUrl = 'https://www.themealdb.com/api/json/v1/1';

  Future<List<Category>> getCategories() async {
    final response = await http.get(Uri.parse('$baseUrl/categories.php'));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final List cats = data['categories'];
      return cats.map((c) => Category.fromJson(c))
          .toList();
    }
    throw Exception('Failed to load categories');
  }

  Future<List<Meal>> getMealsByCategory(String category) async {
    final response = await http.get(
        Uri.parse('$baseUrl/filter.php?c=$category')
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      if (data['meals'] != null) {
        return (data['meals'] as List)
            .map((meal) => Meal.fromJson(meal))
            .toList();
      }
    }
    //return [];
    throw Exception('Failed to load meals');
  }

  Future<Meal?> getMealDetails(String id) async {
    final response = await http.get(Uri.parse('$baseUrl/lookup.php?i=$id'));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      if (data['meals'] != null && data['meals'].isNotEmpty) {
        return Meal.fromJson(data['meals'][0]);
      }
    }
    //return null;
    throw Exception('Failed to load meal detail');

  }

  Future<List<Meal>> searchMeals(String query) async {
    final response = await http.get(Uri.parse('$baseUrl/search.php?s=$query'));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      if (data['meals'] != null) {
        return (data['meals'] as List)
            .map((meal) => Meal.fromJson(meal))
            .toList();
      }
    }
    //return [];
    throw Exception('Failed to search meals');
  }

  Future<Meal?> getRandomMeal() async {
    final response = await http.get(Uri.parse('$baseUrl/random.php'));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      if (data['meals'] != null && data['meals'].isNotEmpty) {
        return Meal.fromJson(data['meals'][0]);
      }
    }
    //return null;
    throw Exception('Failed to load random meal');
  }
}