class User {
  String username;
  String token;

  User.fromJson(Map<String, dynamic> map, {String username})
      : username = username ?? map['username'],
        token = map['api_token'];

  Map<String, dynamic> toJson() => {"username": username, "api_token": token};
}
