class UserModel {
  String id;
  String name;
  String email;
  UserModel({required this.email, required this.name, required this.id});

  UserModel.fromJson(Map<String, dynamic> json)
      : this(email: json['email'], name: json['name'], id: json['id']);

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'email': email,
      };
}
