/// success : true
/// shops : [{"shop_id":"2","user_id":"5","category_id":"2","contact_name":"Pankaj Test","contact_mobile":"9393034546","shop_name":"Psk Food","image":null,"shop_address":"Shivdham, Limbodi","created_at":"2020-06-20 06:06:32","updated_at":null,"deleted_at":null},{"shop_id":"3","user_id":"3","category_id":"2","contact_name":"Pankaj Test","contact_mobile":"9393034576","shop_name":"Psk Food 1","image":null,"shop_address":"Shivdham, Limbodi","created_at":"2020-07-04 05:16:51","updated_at":null,"deleted_at":null}]

class ShopListResponse {
  bool _success;
  List<Shops> _shops;

  bool get success => _success;
  List<Shops> get shops => _shops;

  ShopListResponse({bool success, List<Shops> shops}) {
    _success = success;
    _shops = shops;
  }

  ShopListResponse.fromJson(dynamic json) {
    _success = json["success"];
    if (json["shops"] != null) {
      _shops = [];
      json["shops"].forEach((v) {
        _shops.add(Shops.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["success"] = _success;
    if (_shops != null) {
      map["shops"] = _shops.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

/// shop_id : "2"
/// user_id : "5"
/// category_id : "2"
/// contact_name : "Pankaj Test"
/// contact_mobile : "9393034546"
/// shop_name : "Psk Food"
/// image : null
/// shop_address : "Shivdham, Limbodi"
/// created_at : "2020-06-20 06:06:32"
/// updated_at : null
/// deleted_at : null

class Shops {
  String _shopId;
  String _userId;
  String _categoryId;
  String _contactName;
  String _contactMobile;
  String _shopName;
  dynamic _image;
  String _shopAddress;
  String _createdAt;
  dynamic _updatedAt;
  dynamic _deletedAt;

  String get shopId => _shopId;
  String get userId => _userId;
  String get categoryId => _categoryId;
  String get contactName => _contactName;
  String get contactMobile => _contactMobile;
  String get shopName => _shopName;
  dynamic get image => _image;
  String get shopAddress => _shopAddress;
  String get createdAt => _createdAt;
  dynamic get updatedAt => _updatedAt;
  dynamic get deletedAt => _deletedAt;

  Shops(
      {String shopId,
      String userId,
      String categoryId,
      String contactName,
      String contactMobile,
      String shopName,
      dynamic image,
      String shopAddress,
      String createdAt,
      dynamic updatedAt,
      dynamic deletedAt}) {
    _shopId = shopId;
    _userId = userId;
    _categoryId = categoryId;
    _contactName = contactName;
    _contactMobile = contactMobile;
    _shopName = shopName;
    _image = image;
    _shopAddress = shopAddress;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
    _deletedAt = deletedAt;
  }

  Shops.fromJson(dynamic json) {
    _shopId = json["shop_id"];
    _userId = json["user_id"];
    _categoryId = json["category_id"];
    _contactName = json["contact_name"];
    _contactMobile = json["contact_mobile"];
    _shopName = json["shop_name"];
    _image = json["image"];
    _shopAddress = json["shop_address"];
    _createdAt = json["created_at"];
    _updatedAt = json["updated_at"];
    _deletedAt = json["deleted_at"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["shop_id"] = _shopId;
    map["user_id"] = _userId;
    map["category_id"] = _categoryId;
    map["contact_name"] = _contactName;
    map["contact_mobile"] = _contactMobile;
    map["shop_name"] = _shopName;
    map["image"] = _image;
    map["shop_address"] = _shopAddress;
    map["created_at"] = _createdAt;
    map["updated_at"] = _updatedAt;
    map["deleted_at"] = _deletedAt;
    return map;
  }
}
