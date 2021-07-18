class CategorySeries {
  final List<CategoryItem> dataModel;

  CategorySeries({required this.dataModel});

  factory CategorySeries.fromJson(Map<String, dynamic> json) {
    var list = json['meals'] as List;

    List<CategoryItem> dataList =
        list.map((dataModel) => CategoryItem.fromJson(dataModel)).toList();

    return CategorySeries(dataModel: dataList);
  }
}

class CategoryItem {
  final String name;

  CategoryItem({required this.name});

  factory CategoryItem.fromJson(Map<String, dynamic> json) {
    String name =
        json['strArea'] != null ? json['strArea'] : json['strCategory'];
    return CategoryItem(
      name: name,
    );
  }
}
