class Auth {
  String token;
  Auth(this.token);

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{'token': token};
    return map;
  }

  Auth.fromMap(Map<String, dynamic> map) {
    token = map['token'];
  }
}
