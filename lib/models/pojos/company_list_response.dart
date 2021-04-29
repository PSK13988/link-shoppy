/// ContactList : [{"OriginatorNo":"C041","Company Name":"Cooper, Mark Mr C041"},{"OriginatorNo":"P101","Company Name":"Paper Free Solutions Limited P101"},{"OriginatorNo":"Z999","Company Name":"CWM Test Company Ltd Z999"}]

class CompanyListResponse {
  List<ContactList> _contactList;

  List<ContactList> get contactList => _contactList;

  CompanyListResponse({List<ContactList> contactList}) {
    _contactList = contactList;
  }

  CompanyListResponse.fromJson(dynamic json) {
    if (json["ContactList"] != null) {
      _contactList = [];
      json["ContactList"].forEach((v) {
        _contactList.add(ContactList.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    if (_contactList != null) {
      map["ContactList"] = _contactList.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

/// OriginatorNo : "C041"
/// Company Name : "Cooper, Mark Mr C041"

class ContactList {
  String _originatorNo;
  String _companyName;

  String get originatorNo => _originatorNo;
  String get companyName => _companyName;

  ContactList({String originatorNo, String companyName}) {
    _originatorNo = originatorNo;
    _companyName = companyName;
  }

  ContactList.fromJson(dynamic json) {
    _originatorNo = json["OriginatorNo"];
    _companyName = json["Company Name"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["OriginatorNo"] = _originatorNo;
    map["Company Name"] = _companyName;
    return map;
  }
}
