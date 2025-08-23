class UserModel {
  String id;
  String name;
  String email;
  List<String> favEventsIds;
  UserModel(
      {required this.email,
      required this.name,
      required this.id,
      required this.favEventsIds});

  UserModel.fromJson(Map<String, dynamic> json)
      : this(
            email: json['email'],
            name: json['name'],
            id: json['id'],
            favEventsIds: (json['favEventsIds'] as List).cast<String>());

  Map<String, dynamic> toJson() => {
        'id': id,
        'favEventsIds': favEventsIds,
        'name': name,
        'email': email,
      };
}
