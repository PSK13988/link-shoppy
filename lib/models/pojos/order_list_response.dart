/// success : true
/// users : [{"id":"1","order_number":"1000","contact_name":"Pankaj Kharche","contact_number":"9595034546"},{"id":"2","order_number":"1001","contact_name":"Pankaj Kharche","contact_number":"9595034546"}]

class OrderListResponse {
  bool _success;
  List<Order> _users;

  bool get success => _success;
  List<Order> get users => _users;

  OrderListResponse({bool success, List<Order> users}) {
    _success = success;
    _users = users;
  }

  OrderListResponse.fromJson(dynamic json) {
    _success = json["success"];
    if (json["users"] != null) {
      _users = [];
      json["users"].forEach((v) {
        _users.add(Order.fromJson(v));
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

/// id : "1"
/// order_number : "1000"
/// contact_name : "Pankaj Kharche"
/// contact_number : "9595034546"

class Order {
  String _id;
  String _orderNumber;
  String _contactName;
  String _contactNumber;

  String get id => _id;
  String get orderNumber => _orderNumber;
  String get contactName => _contactName;
  String get contactNumber => _contactNumber;

  Order(
      {String id,
      String orderNumber,
      String contactName,
      String contactNumber}) {
    _id = id;
    _orderNumber = orderNumber;
    _contactName = contactName;
    _contactNumber = contactNumber;
  }

  Order.fromJson(dynamic json) {
    _id = json["id"];
    _orderNumber = json["order_number"];
    _contactName = json["contact_name"];
    _contactNumber = json["contact_number"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["id"] = _id;
    map["order_number"] = _orderNumber;
    map["contact_name"] = _contactName;
    map["contact_number"] = _contactNumber;
    return map;
  }
}
