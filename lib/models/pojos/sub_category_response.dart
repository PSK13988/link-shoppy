/// success : true
/// category : [{"id":"4","user_id":"5","category_id":"2","sub_category_name":"Oil","created_at":"2020-07-05 01:23:45","updated_at":null,"deleted_at":null},{"id":"3","user_id":"5","category_id":"2","sub_category_name":"Paneer","created_at":"2020-07-05 01:23:22","updated_at":null,"deleted_at":null}]

class SubCategoryResponse {
  bool _success;
  List<Category> _category;

  bool get success => _success;
  List<Category> get category => _category;

  SubCategoryResponse({bool success, List<Category> category}) {
    _success = success;
    _category = category;
  }

  SubCategoryResponse.map(dynamic obj) {
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

/// id : "4"
/// user_id : "5"
/// category_id : "2"
/// sub_category_name : "Oil"
/// created_at : "2020-07-05 01:23:45"
/// updated_at : null
/// deleted_at : null

class Category {
  String _id;
  String _userId;
  String _categoryId;
  String _subCategoryName;
  String _createdAt;
  dynamic _updatedAt;
  dynamic _deletedAt;

  String get id => _id;
  String get userId => _userId;
  String get categoryId => _categoryId;
  String get subCategoryName => _subCategoryName;
  String get createdAt => _createdAt;
  dynamic get updatedAt => _updatedAt;
  dynamic get deletedAt => _deletedAt;

  Category(
      {String id,
      String userId,
      String categoryId,
      String subCategoryName,
      String createdAt,
      dynamic updatedAt,
      dynamic deletedAt}) {
    _id = id;
    _userId = userId;
    _categoryId = categoryId;
    _subCategoryName = subCategoryName;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
    _deletedAt = deletedAt;
  }

  Category.map(dynamic obj) {
    _id = obj["id"];
    _userId = obj["user_id"];
    _categoryId = obj["category_dd"];
    _subCategoryName = obj["sub_category_name"];
    _createdAt = obj["created_at"];
    _updatedAt = obj["updated_at"];
    _deletedAt = obj["deleted_at"];
  }

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{};
    map["id"] = _id;
    map["user_id"] = _userId;
    map["category_dd"] = _categoryId;
    map["sub_category_name"] = _subCategoryName;
    map["created_at"] = _createdAt;
    map["updated_at"] = _updatedAt;
    map["deleted_at"] = _deletedAt;
    return map;
  }
}
