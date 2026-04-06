class User {
  final String login;
  final String email;

  User({required this.login, required this.email});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(login: json['name'] ?? '', email: json['email'] ?? '');
  }

  Map<String, dynamic> toJson() => {'name': login, 'email': email};
}
