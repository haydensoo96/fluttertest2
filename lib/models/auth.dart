class Auth {
  String token;

  Auth({required this.token});

  void get() {
    print(token);
  }

  toJSONEncodable() {
    Map<String, dynamic> m = new Map();
    m['token'] = token;
    return m;
  }
}
