class CategoryModel {
  String id = '';
  String title = '';
  List<CategoryModel> children = [];

  CategoryModel({
    required this.id,
    required this.title,
    required this.children,
  });

  CategoryModel.empty();

  factory CategoryModel.fromJson(Map<String, dynamic> json) {
    return CategoryModel(
      id: json['data']['_id'] ?? '',
      title: json['data']['title'] ?? '',
      children: json['children'].length > 0
          ? List<CategoryModel>.from(
              json['children'].map((season) => CategoryModel.fromJson(season)),
            )
          : [],
    );
  }
}
