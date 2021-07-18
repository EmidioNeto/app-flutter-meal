class MealSeries {
  final List<Meal> dataModel;

  MealSeries({required this.dataModel});

  factory MealSeries.fromJson(Map<String, dynamic> json) {
    var list = json['meals'] as List;

    List<Meal> dataList =
        list.map((dataModel) => Meal.fromJson(dataModel)).toList();

    return MealSeries(dataModel: dataList);
  }
}

class IngredientSeries {
  final List<Ingredient> dataModel;
  static const int MAX_INGREDIENTS = 17;

  IngredientSeries({required this.dataModel});

  factory IngredientSeries.fromJson(Map<String, dynamic> json) {
    List<Ingredient> dataList = List.empty(growable: true);

    for (var i = 1; i <= MAX_INGREDIENTS; i++) {
      String ingredientKey = "strIngredient$i";
      String measureKey = "strMeasure$i";
      if (json[ingredientKey] != null && json[ingredientKey] != "") {
        var ingredient = new Ingredient(
            name: json[ingredientKey], measure: json[measureKey] as String);
        dataList.add(ingredient);
      }
    }
    return IngredientSeries(dataModel: dataList);
  }
}

class Ingredient {
  final String name;
  final String measure;
  Ingredient({required this.name, required this.measure});

  factory Ingredient.fromJson(Map<String, dynamic> json) {
    return Ingredient(name: '', measure: '');
  }
}

class Meal {
  final String id;
  final String thumb;
  final String name;
  List<Ingredient> ingredients = new List.empty();
  final String drinkAlternate;
  final String category;
  final String area;
  final String instructions;
  final String tags;
  final String youtube;
  final String source;
  final String imageSource;
  final String creativeCommonsConfirmed;
  final String dateModified;
  Meal(
      {required this.id,
      required this.name,
      required this.thumb,
      required this.drinkAlternate,
      required this.category,
      required this.area,
      required this.instructions,
      required this.tags,
      required this.youtube,
      required this.source,
      required this.imageSource,
      required this.creativeCommonsConfirmed,
      required this.dateModified});

  factory Meal.fromJson(Map<String, dynamic> json) {
    Meal meal = Meal(
        id: json['idMeal'] != null ? json['idMeal'] : "",
        name: json['strMeal'] != null ? json['strMeal'] : "",
        thumb: json['strMealThumb'] != null ? json['strMealThumb'] : "",
        drinkAlternate:
            json['strDrinkAlternate'] != null ? json['strDrinkAlternate'] : "",
        category: json['strCategory'] != null ? json['strCategory'] : "",
        area: json['strArea'] != null ? json['strArea'] : "",
        instructions:
            json['strInstructions'] != null ? json['strInstructions'] : "",
        tags: json['strTags'] != null ? json['strTags'] : "",
        youtube: json['strYoutube'] != null ? json['strYoutube'] : "",
        source: json['strSource'] != null ? json['strSource'] : "",
        imageSource:
            json['strImageSource'] != null ? json['strImageSource'] : "",
        creativeCommonsConfirmed: json['strCreativeCommonsConfirmed'] != null
            ? json['strCreativeCommonsConfirmed']
            : "",
        dateModified: json['dateModified'] != null ? json['dateModified'] : "");

    if (json['strIngredient1'] != null && json['strIngredient1'] != "") {
      meal.ingredients = IngredientSeries.fromJson(json).dataModel;
    }

    return meal;
  }
}
