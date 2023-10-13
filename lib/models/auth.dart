class Auth {
  String? phone;
  String? password;
  String? country;
  Auth({
    required this.phone,
    required this.password,
    required this.country,
  });

  Map toMap() {
    return {'phone': phone, "password": password, "country": country};
  }
}
