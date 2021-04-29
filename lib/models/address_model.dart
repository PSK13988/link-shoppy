class AddressModel {
  String originatorNo;
  int addressId;
  String addressType;
  String add1;
  String add2;
  String add3;
  String town;
  String county;
  String postcode;
  String country;

  AddressModel(
      {this.originatorNo,
      this.addressId,
      this.addressType,
      this.add1,
      this.add2,
      this.add3,
      this.town,
      this.county,
      this.postcode,
      this.country});

  factory AddressModel.fromJson(dynamic json) {
    return AddressModel(
        originatorNo: json['OriginatorNo'] as String,
        addressId: json['AddressId'] as int,
        addressType: json['AddressType'] as String,
        add1: json['Add1'] as String,
        add2: json['Add2'] as String,
        add3: json['Add3'] as String,
        town: json['Town'] as String,
        county: json['County'] as String,
        postcode: json['Postcode'] as String,
        country: json['Country'] as String);
  }
}
