/// success : true
/// category : [{"id":"2","category_name":"Food","created_at":"2020-06-16 08:06:51","updated_at":"2020-06-16 08:06:51"},{"id":"1","category_name":"stationery","created_at":"2020-06-16 08:06:51","updated_at":"2020-06-16 08:06:51"}]

class CategoryResponse {
  bool _success;
  List<Category> _category;

  bool get success => _success;

  List<Category> get category => _category;

  CategoryResponse({bool success, List<Category> category}) {
    _success = success;
    _category = category;
  }

  CategoryResponse.map(dynamic obj) {
    _success = obj["success"];
    if (obj["category"] != null) {
      _category = [];
      obj["category"].forEach((v) {
        _category.add(Category.map(v));
      });
    }
  }

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{};
    map["success"] = _success;
    if (_category != null) {
      map["category"] = _category.map((v) => v.toMap()).toList();
    }
    return map;
  }
}

/// id : "2"
/// category_name : "Food"
/// created_at : "2020-06-16 08:06:51"
/// updated_at : "2020-06-16 08:06:51"

class Category {
  String _id;
  String _categoryName;
  String _createdAt;
  String _updatedAt;

  String get id => _id;

  String get categoryName => _categoryName;

  String get createdAt => _createdAt;

  String get updatedAt => _updatedAt;

  Category(
      {String id, String category_name, String created_at, String updated_at}) {
    _id = id;
    _categoryName = category_name;
    _createdAt = created_at;
    _updatedAt = updated_at;
  }

  Category.map(dynamic obj) {
    _id = obj["id"];
    _categoryName = obj["category_name"];
    _createdAt = obj["created_at"];
    _updatedAt = obj["updated_at"];
  }

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{};
    map["id"] = _id;
    map["category_name"] = _categoryName;
    map["created_at"] = _createdAt;
    map["updated_at"] = _updatedAt;
    return map;
  }
}
