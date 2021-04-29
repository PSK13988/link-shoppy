/// success : true
/// users : [{"order_id":"2","quantity":"3","price":"60","item_name":"chini"},{"order_id":"2","quantity":"2","price":"40","item_name":"Parlayji"}]

class OrderDetailResponse {
  bool _success;
  List<OrderDetail> _users;

  bool get success => _success;
  List<OrderDetail> get users => _users;

  OrderDetailResponse({bool success, List<OrderDetail> users}) {
    _success = success;
    _users = users;
  }

  OrderDetailResponse.fromJson(dynamic json) {
    _success = json["success"];
    if (json["users"] != null) {
      _users = [];
      json["users"].forEach((v) {
        _users.add(OrderDetail.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["success"] = _success;
    if (_users != null) {
      map["users"] = _users.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

/// order_id : "2"
/// quantity : "3"
/// price : "60"
/// item_name : "chini"

class OrderDetail {
  String _orderId;
  String _quantity;
  String _price;
  String _itemName;

  String get orderId => _orderId;
  String get quantity => _quantity;
  String get price => _price;
  String get itemName => _itemName;

  OrderDetail(
      {String orderId, String quantity, String price, String itemName}) {
    _orderId = orderId;
    _quantity = quantity;
    _price = price;
    _itemName = itemName;
  }

  OrderDetail.fromJson(dynamic json) {
    _orderId = json["order_id"];
    _quantity = json["quantity"];
    _price = json["price"];
    _itemName = json["item_name"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["order_id"] = _orderId;
    map["quantity"] = _quantity;
    map["price"] = _price;
    map["item_name"] = _itemName;
    return map;
  }
}
