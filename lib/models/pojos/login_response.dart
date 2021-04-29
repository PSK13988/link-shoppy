/// success : true
/// jwt : "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2RhdGEiOnsiaWQiOiI1IiwibmFtZSI6IlBhbmthaiBLaGFyY2hlIiwiZW1haWwiOiJwYW5rYWpraGFyY2hlMTM5QGdtYWlsLmNvbSIsInBob25lX251bWJlciI6Ijk1OTUwMzQ1NDYiLCJwYXNzd29yZCI6IjEyMzQ1Njc4IiwidXNlcl9zdGF0dXMiOiIxIiwicm9sZV9pZCI6IjAiLCJsYXN0X2xvZ2luX2F0IjoiMjAyMC0wNi0yNCAwNDoxNTozOSIsImxvZ2luX2NvdW50IjoiMjAyMCIsImNyZWF0ZWRfYXQiOm51bGwsInVwZGF0ZWRfYXQiOm51bGwsImRlbGV0ZWRfYXQiOm51bGx9LCJjcmVhdGVkIjoxNTkyOTcyMjQ0LCJleHAiOjE1OTU1NjQyNDR9.EwP5s3dEPm0Dxq0RSkH-YfVjH5oxc7AmjnPGxcwXwyE"
/// refresh : "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJqd3QiOiJleUowZVhBaU9pSktWMVFpTENKaGJHY2lPaUpJVXpJMU5pSjkuZXlKMWMyVnlYMlJoZEdFaU9uc2lhV1FpT2lJMUlpd2libUZ0WlNJNklsQmhibXRoYWlCTGFHRnlZMmhsSWl3aVpXMWhhV3dpT2lKd1lXNXJZV3ByYUdGeVkyaGxNVE01UUdkdFlXbHNMbU52YlNJc0luQm9iMjVsWDI1MWJXSmxjaUk2SWprMU9UVXdNelExTkRZaUxDSndZWE56ZDI5eVpDSTZJakV5TXpRMU5qYzRJaXdpZFhObGNsOXpkR0YwZFhNaU9pSXhJaXdpY205c1pWOXBaQ0k2SWpBaUxDSnNZWE4wWDJ4dloybHVYMkYwSWpvaU1qQXlNQzB3TmkweU5DQXdORG94TlRvek9TSXNJbXh2WjJsdVgyTnZkVzUwSWpvaU1qQXlNQ0lzSW1OeVpXRjBaV1JmWVhRaU9tNTFiR3dzSW5Wd1pHRjBaV1JmWVhRaU9tNTFiR3dzSW1SbGJHVjBaV1JmWVhRaU9tNTFiR3g5TENKamNtVmhkR1ZrSWpveE5Ua3lPVGN5TWpRMExDSmxlSEFpT2pFMU9UVTFOalF5TkRSOS5Fd1A1czNkRVBtMER4cTBSU2tILVlmVmpINW94YzdBbWpuUEd4Y3dYd3lFIiwidXNlcl9kYXRhIjp7ImlkIjoiNSIsIm5hbWUiOiJQYW5rYWogS2hhcmNoZSIsImVtYWlsIjoicGFua2Fqa2hhcmNoZTEzOUBnbWFpbC5jb20iLCJwaG9uZV9udW1iZXIiOiI5NTk1MDM0NTQ2IiwicGFzc3dvcmQiOiIxMjM0NTY3OCIsInVzZXJfc3RhdHVzIjoiMSIsInJvbGVfaWQiOiIwIiwibGFzdF9sb2dpbl9hdCI6IjIwMjAtMDYtMjQgMDQ6MTU6MzkiLCJsb2dpbl9jb3VudCI6IjIwMjAiLCJjcmVhdGVkX2F0IjpudWxsLCJ1cGRhdGVkX2F0IjpudWxsLCJkZWxldGVkX2F0IjpudWxsfSwiY3JlYXRlZCI6MTU5Mjk3MjI0NCwiZXhwIjoxNTk2ODYwMjQ0fQ.8SGYRBwzbCXWkDmy-1_xJKL-jDJjgwUmMHjo9wnaaXg"
/// email : "pankajkharche139@gmail.com"
/// user_data : {"id":"5","name":"Pankaj Kharche","email":"pankajkharche139@gmail.com","phone_number":"9595034546","password":"12345678","user_status":"1","role_id":"0","last_login_at":"2020-06-24 04:15:39","login_count":"2020","created_at":null,"updated_at":null,"deleted_at":null}

class LoginResponse {
  bool _success;
  String _jwt;
  String _refresh;
  String _email;
  String _userRole;
  dynamic _shopSetup;
  UserData _userData;

  bool get success => _success;
  dynamic get shopSetup => _shopSetup;

  String get userRole => _userRole;
  String get jwt => _jwt;

  String get refresh => _refresh;

  String get email => _email;

  UserData get userData => _userData;

  set userRole(String value) {
    _userRole = value;
  }

  LoginResponse(
      {bool success,
      String jwt,
      String refresh,
      String email,
      String userRole,
      bool shopSetup,
      UserData userData}) {
    _success = success;
    _jwt = jwt;
    _refresh = refresh;
    _email = email;
    _userRole = userRole;
    _shopSetup = shopSetup;
    _userData = userData;
  }

  LoginResponse.map(dynamic obj) {
    _success = obj['success'];
    _jwt = obj['jwt'];
    _refresh = obj['refresh'];
    _email = obj['email'];
    _userRole = obj['user_role'];
    _shopSetup = obj['shop_setup'];
    _userData =
        obj['user_data'] != null ? UserData.map(obj['user_data']) : null;
  }

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{};
    map['success'] = _success;
    map['jwt'] = _jwt;
    map['refresh'] = _refresh;
    map['email'] = _email;
    map['user_role'] = _userRole;
    map['shop_setup'] = _shopSetup;
    if (_userData != null) {
      map['user_data'] = _userData.toMap();
    }
    return map;
  }
}

/// id : '5'
/// name : 'Pankaj Kharche'
/// email : 'pankajkharche139@gmail.com'
/// phone_number : '9595034546'
/// password : '12345678'
/// user_status : '1'
/// role_id : '0'
/// last_login_at : '2020-06-24 04:15:39'
/// login_count : '2020'
/// created_at : null
/// updated_at : null
/// deleted_at : null

class UserData {
  String _id;
  String _name;
  String _email;
  String _phoneNumber;
  String _password;
  String _userStatus;
  String _roleId;
  String _lastLoginAt;
  String _loginCount;
  dynamic _createdAt;
  dynamic _updatedAt;
  dynamic _deletedAt;

  String get id => _id;

  String get name => _name;

  String get email => _email;

  String get phoneNumber => _phoneNumber;

  String get password => _password;

  String get userStatus => _userStatus;

  String get roleId => _roleId;

  String get lastLoginAt => _lastLoginAt;

  String get loginCount => _loginCount;

  dynamic get createdAt => _createdAt;

  dynamic get updatedAt => _updatedAt;

  dynamic get deletedAt => _deletedAt;

  UserData(
      {String id,
      String name,
      String email,
      String phoneNumber,
      String password,
      String userStatus,
      String roleId,
      String lastLoginAt,
      String loginCount,
      dynamic createdAt,
      dynamic updatedAt,
      dynamic deletedAt}) {
    _id = id;
    _name = name;
    _email = email;
    _phoneNumber = phoneNumber;
    _password = password;
    _userStatus = userStatus;
    _roleId = roleId;
    _lastLoginAt = lastLoginAt;
    _loginCount = loginCount;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
    _deletedAt = deletedAt;
  }

  UserData.map(dynamic obj) {
    _id = obj['id'];
    _name = obj['name'];
    _email = obj['email'];
    _phoneNumber = obj['phoneNumber'];
    _password = obj['password'];
    _userStatus = obj['userStatus'];
    _roleId = obj['roleId'];
    _lastLoginAt = obj['lastLoginAt'];
    _loginCount = obj['loginCount'];
    _createdAt = obj['createdAt'];
    _updatedAt = obj['updatedAt'];
    _deletedAt = obj['deletedAt'];
  }

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{};
    map['id'] = _id;
    map['name'] = _name;
    map['email'] = _email;
    map['phoneNumber'] = _phoneNumber;
    map['password'] = _password;
    map['userStatus'] = _userStatus;
    map['roleId'] = _roleId;
    map['lastLoginAt'] = _lastLoginAt;
    map['loginCount'] = _loginCount;
    map['createdAt'] = _createdAt;
    map['updatedAt'] = _updatedAt;
    map['deletedAt'] = _deletedAt;
    return map;
  }
}
