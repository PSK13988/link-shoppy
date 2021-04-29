/// success : true
/// users : [{"id":"7","name":"Pankaj Kharche","email":"pankajkharche139@gmail.com","phone_number":"9595034546","password":"12345678","user_status":"1","role_id":"0","last_login_at":"2020-07-05 01:32:40","login_count":"2020","created_at":"2020-07-05 01:35:14","updated_at":null,"deleted_at":null,"user_id":"5","category_id":"2","sub_category_id":"4","item_name":"Safola","item_price":"110","item_quantity":"50","other":"Oil packates"},{"id":"8","name":"Pankaj Kharche","email":"pankajkharche139@gmail.com","phone_number":"9595034546","password":"12345678","user_status":"1","role_id":"0","last_login_at":"2020-07-05 01:32:40","login_count":"2020","created_at":"2020-07-05 01:35:27","updated_at":null,"deleted_at":null,"user_id":"5","category_id":"2","sub_category_id":"4","item_name":"Safola Active","item_price":"140","item_quantity":"50","other":"Oil packates"},{"id":"9","name":"Pankaj Kharche","email":"pankajkharche139@gmail.com","phone_number":"9595034546","password":"12345678","user_status":"1","role_id":"0","last_login_at":"2020-07-05 01:32:40","login_count":"2020","created_at":"2020-07-05 01:35:48","updated_at":null,"deleted_at":null,"user_id":"5","category_id":"2","sub_category_id":"4","item_name":"Krati","item_price":"105","item_quantity":"50","other":"Oil packates"},{"id":"10","name":"Pankaj Kharche","email":"pankajkharche139@gmail.com","phone_number":"9595034546","password":"12345678","user_status":"1","role_id":"0","last_login_at":"2020-07-05 01:32:40","login_count":"2020","created_at":"2020-07-05 01:36:00","updated_at":null,"deleted_at":null,"user_id":"5","category_id":"2","sub_category_id":"4","item_name":"Krati Gold","item_price":"130","item_quantity":"50","other":"Oil packates"},{"id":"11","name":"Pankaj Kharche","email":"pankajkharche139@gmail.com","phone_number":"9595034546","password":"12345678","user_status":"1","role_id":"0","last_login_at":"2020-07-05 01:32:40","login_count":"2020","created_at":"2020-07-05 01:36:07","updated_at":null,"deleted_at":null,"user_id":"5","category_id":"2","sub_category_id":"4","item_name":"Mahakosh","item_price":"130","item_quantity":"50","other":"Oil packates"},{"id":"12","name":"Pankaj Kharche","email":"pankajkharche139@gmail.com","phone_number":"9595034546","password":"12345678","user_status":"1","role_id":"0","last_login_at":"2020-07-05 01:32:40","login_count":"2020","created_at":"2020-07-05 01:37:57","updated_at":null,"deleted_at":null,"user_id":"5","category_id":"2","sub_category_id":"4","item_name":"Fortune oil","item_price":"150","item_quantity":"50","other":"Oil packates"}]

class ProductListResponse {
  bool _success;
  List<Products> _users;
  List<Type> _type;

  bool get success => _success;

  List<Products> get users => _users;

  List<Type> get type => _type;

  ProductListResponse({bool success, List<Products> users, List<Type> type}) {
    _success = success;
    _users = users;
    _type = type;
  }

  ProductListResponse.map(dynamic json) {
    _success = json["success"];
    if (json["users"] != null) {
      _users = [];
      json["users"].forEach((v) {
        _users.add(Products.map(v));
      });
    }
    if (json["type"] != null) {
      _type = [];
      json["type"].forEach((v) {
        _type.add(Type.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{};
    map["success"] = _success;
    if (_users != null) {
      map["users"] = _users.map((v) => v.toMap()).toList();
    }
    if (_type != null) {
      map["type"] = _type.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

/// id : "1"
/// unit_name : "Ltr"

class Type {
  String _id;
  String _unitName;

  String get id => _id;

  String get unitName => _unitName;

  Type({String id, String unitName}) {
    _id = id;
    _unitName = unitName;
  }

  Type.fromJson(dynamic json) {
    _id = json["id"];
    _unitName = json["unit_name"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["id"] = _id;
    map["unit_name"] = _unitName;
    return map;
  }
}

/// id : "7"
/// name : "Pankaj Kharche"
/// email : "pankajkharche139@gmail.com"
/// phone_number : "9595034546"
/// password : "12345678"
/// user_status : "1"
/// role_id : "0"
/// last_login_at : "2020-07-05 01:32:40"
/// login_count : "2020"
/// created_at : "2020-07-05 01:35:14"
/// updated_at : null
/// deleted_at : null
/// user_id : "5"
/// category_id : "2"
/// sub_category_id : "4"
/// item_name : "Safola"
/// item_price : "110"
/// item_quantity : "50"
/// other : "Oil packates"

class Products {
  String _id;
  String _name;
  String _email;
  String _phoneNumber;
  String _password;
  String _image;
  String _userStatus;
  String _roleId;
  String _lastLoginAt;
  String _loginCount;
  String _createdAt;
  dynamic _updatedAt;
  dynamic _deletedAt;
  String _userId;
  String _categoryId;
  String _subCategoryId;
  String _itemName;
  String _itemPrice;
  String _itemQuantity;
  String _other;

  String _enteredQuantity;
  Type _selectedUnit;

  String get id => _id;

  String get name => _name;

  String get email => _email;

  String get phoneNumber => _phoneNumber;

  String get password => _password;

  String get image => _image;

  String get userStatus => _userStatus;

  String get roleId => _roleId;

  String get lastLoginAt => _lastLoginAt;

  String get loginCount => _loginCount;

  String get createdAt => _createdAt;

  dynamic get updatedAt => _updatedAt;

  dynamic get deletedAt => _deletedAt;

  String get userId => _userId;

  String get categoryId => _categoryId;

  String get subCategoryId => _subCategoryId;

  String get itemName => _itemName;

  String get itemPrice => _itemPrice;

  String get itemQuantity => _itemQuantity;

  String get other => _other;

  // ignore: unnecessary_getters_setters
  String get enteredQuantity => _enteredQuantity;

  // ignore: unnecessary_getters_setters
  Type get selectedUnit => _selectedUnit;

  // ignore: unnecessary_getters_setters
  set enteredQuantity(String value) {
    _enteredQuantity = value;
  }

  // ignore: unnecessary_getters_setters
  set selectedUnit(Type value) {
    _selectedUnit = value;
  }

  Products(
      {String id,
      String name,
      String email,
      String phoneNumber,
      String password,
      String image,
      String userStatus,
      String roleId,
      String lastLoginAt,
      String loginCount,
      String createdAt,
      dynamic updatedAt,
      dynamic deletedAt,
      String userId,
      String categoryId,
      String subCategoryId,
      String itemName,
      String itemPrice,
      String itemQuantity,
      String other}) {
    _id = id;
    _name = name;
    _email = email;
    _phoneNumber = phoneNumber;
    _password = password;
    _image = image;
    _userStatus = userStatus;
    _roleId = roleId;
    _lastLoginAt = lastLoginAt;
    _loginCount = loginCount;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
    _deletedAt = deletedAt;
    _userId = userId;
    _categoryId = categoryId;
    _subCategoryId = subCategoryId;
    _itemName = itemName;
    _itemPrice = itemPrice;
    _itemQuantity = itemQuantity;
    _other = other;
  }

  Products.map(dynamic json) {
    _id = json["id"];
    _name = json["name"];
    _email = json["email"];
    _phoneNumber = json["phone_number"];
    _password = json["password"];
    _image = json["image"];
    _userStatus = json["user_status"];
    _roleId = json["role_id"];
    _lastLoginAt = json["last_login_at"];
    _loginCount = json["login_count"];
    _createdAt = json["created_at"];
    _updatedAt = json["updatedAt"];
    _deletedAt = json["deleted_at"];
    _userId = json["user_id"];
    _categoryId = json["category_id"];
    _subCategoryId = json["sub_category_id"];
    _itemName = json["item_name"];
    _itemPrice = json["item_price"];
    _itemQuantity = json["item_quantity"];
    _other = json["other"];
  }

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{};
    map["id"] = _id;
    map["name"] = _name;
    map["email"] = _email;
    map["phone_number"] = _phoneNumber;
    map["password"] = _password;
    map["image"] = _image;
    map["user_status"] = _userStatus;
    map["role_id"] = _roleId;
    map["last_login_at"] = _lastLoginAt;
    map["login_count"] = _loginCount;
    map["created_at"] = _createdAt;
    map["updatedAt"] = _updatedAt;
    map["deleted_at"] = _deletedAt;
    map["user_id"] = _userId;
    map["category_id"] = _categoryId;
    map["sub_category_id"] = _subCategoryId;
    map["item_name"] = _itemName;
    map["item_price"] = _itemPrice;
    map["item_quantity"] = _itemQuantity;
    map["other"] = _other;
    return map;
  }
}
