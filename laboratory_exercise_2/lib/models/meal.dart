class Meal {
  final String mealId;
  final String mealName;
  final String mealThumbnail;

  final String? mealCategory;
  final String? mealArea;
  final String? mealInstructions;
  final String? mealYoutube;
  final Map<String, String>? ingredients;
  bool isFavorite;

  Meal({
    required this.mealId,
    required this.mealName,
    required this.mealThumbnail,
    this.mealCategory,
    this.mealArea,
    this.mealInstructions,
    this.mealYoutube,
    this.ingredients,
    this.isFavorite = false,
  });

  factory Meal.fromJson(Map<String, dynamic> json) {
    Map<String, String>? ingredients;

    if (json.containsKey('strIngredient1')) {
      ingredients = {};
      for (int i = 1; i <= 20; i++) {
        String? ingredient = json['strIngredient$i'];
        String? measure = json['strMeasure$i'];
        if (ingredient != null && ingredient.isNotEmpty) {
          ingredients[ingredient] = measure ?? '';
        }
      }
    }

    return Meal(
      mealId: json['idMeal'] ?? '',
      mealName: json['strMeal'] ?? '',
      mealThumbnail: json['strMealThumb'] ?? '',
      mealCategory: json['strCategory'],
      mealArea: json['strArea'],
      mealInstructions: json['strInstructions'],
      mealYoutube: json['strYoutube'],
      ingredients: ingredients,
      isFavorite: json['isFavorite'] ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'idMeal': mealId,
      'strMeal': mealName,
      'strMealThumb': mealThumbnail,
      'strCategory': mealCategory,
      'strArea': mealArea,
      'strInstructions': mealInstructions,
      'strYoutube': mealYoutube,
      'ingredients': ingredients,
      'isFavorite': isFavorite,
    };
  }

  Meal copyWith({
    String? mealId,
    String? mealName,
    String? mealThumbnail,
    String? mealCategory,
    String? mealArea,
    String? mealInstructions,
    String? mealYoutube,
    Map<String, String>? ingredients,
    bool? isFavorite,
  }) {
    return Meal(
      mealId: mealId ?? this.mealId,
      mealName: mealName ?? this.mealName,
      mealThumbnail: mealThumbnail ?? this.mealThumbnail,
      mealCategory: mealCategory ?? this.mealCategory,
      mealArea: mealArea ?? this.mealArea,
      mealInstructions: mealInstructions ?? this.mealInstructions,
      mealYoutube: mealYoutube ?? this.mealYoutube,
      ingredients: ingredients ?? this.ingredients,
      isFavorite: isFavorite ?? this.isFavorite,
    );
  }
}