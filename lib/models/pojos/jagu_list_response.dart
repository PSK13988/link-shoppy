/// items : [{"product_id":"1","product_name":"ParlyG","price":"40"},{"product_id":"2","product_name":"Britania","price":"30"},{"product_id":"3","product_name":"Monaco","price":"50"}]

class JaguListResponse {
  List<Items> _items;

  List<Items> get items => _items;

  JaguListResponse({List<Items> items}) {
    _items = items;
  }

  JaguListResponse.fromJson(dynamic json) {
    if (json["items"] != null) {
      _items = [];
      json["items"].forEach((v) {
        _items.add(Items.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    if (_items != null) {
      map["items"] = _items.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

/// product_id : "1"
/// product_name : "ParlyG"
/// price : "40"

class Items {
  String _productId;
  String _productName;
  String _price;

  String get productId => _productId;
  String get productName => _productName;
  String get price => _price;

  Items({String productId, String productName, String price}) {
    _productId = productId;
    _productName = productName;
    _price = price;
  }

  Items.fromJson(dynamic json) {
    _productId = json["product_id"];
    _productName = json["product_name"];
    _price = json["price"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["product_id"] = _productId;
    map["product_name"] = _productName;
    map["price"] = _price;
    return map;
  }
}
