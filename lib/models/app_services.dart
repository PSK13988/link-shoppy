class AppServices {
  String buttonId;
  String buttonName;
  String website;
  String caption;
  String iconName;
  String appIdentifier;
  String iosIdentifier;
  String color;
  int status;
  int isValidate;
  int allowShareInfo;

  AppServices(
      {this.buttonId,
      this.buttonName,
      this.website,
      this.caption,
      this.iconName,
      this.appIdentifier,
      this.iosIdentifier,
      this.color,
      this.status,
      this.isValidate,
      this.allowShareInfo});

  factory AppServices.fromJson(dynamic json) {
    return AppServices(
        buttonId: json['ButtonId'] as String,
        buttonName: json['ButtonName'] as String,
        website: json['Website'] as String,
        caption: json['Caption'] as String,
        iconName: json['IconName'] as String,
        appIdentifier: json['AppIdentifier'] as String,
        iosIdentifier: json['IosIdentifier'] as String,
        color: json['Color'] as String,
        status: json['Status'] as int,
        isValidate: json['IsValidate'] as int,
        allowShareInfo: json['AllowShareInfo'] as int);
  }

  @override
  String toString() {
    return 'AppServices{caption: $caption}';
  }
}
