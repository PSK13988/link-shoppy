/// success : true
/// message : "Shop setup successfully"

class StatusResponse {
  bool _success;
  String _message;

  bool get success => _success;
  String get message => _message;

  StatusResponse({bool success, String message}) {
    _success = success;
    _message = message;
  }

  StatusResponse.map(dynamic obj) {
    _success = obj["success"];
    _message = obj["message"];
  }

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{};
    map["success"] = _success;
    map["message"] = _message;
    return map;
  }
}
