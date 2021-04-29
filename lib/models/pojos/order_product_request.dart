/// items : [{"product_id":"1","quantity":"2","price":"40","product_unit_id":"1"},{"product_id":"2","quantity":"2","price":"40","product_unit_id":"1"}]

class OrderProductRequest {
  List<Items> _items;

  List<Items> get items => _items;

  OrderProductRequest({List<Items> items}) {
    _items = items;
  }

  OrderProductRequest.fromJson(dynamic json) {
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
/// quantity : "2"
/// price : "40"
/// product_unit_id : "1"

class Items {
  String _productId;
  String _quantity;
  String _price;
  String _productUnitId;

  String get productId => _productId;

  String get quantity => _quantity;

  String get price => _price;

  String get productUnitId => _productUnitId;

  Items({String productId, String quantity, String price, String productUnitId}) {
    _productId = productId;
    _quantity = quantity;
    _price = price;
    _productUnitId = productUnitId;
  }

  Items.fromJson(dynamic json) {
    _productId = json["product_id"];
    _quantity = json["quantity"];
    _price = json["price"];
    _productUnitId = json["product_unit_id"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["product_id"] = _productId;
    map["quantity"] = _quantity;
    map["price"] = _price;
    map["product_unit_id"] = _productUnitId;
    return map;
  }
}
