class UserModel {
  String label;
  String value;

  UserModel({this.label, this.value});

  @override
  String toString() {
    return 'UserModel{label: $label, value: $value}';
  }
}
