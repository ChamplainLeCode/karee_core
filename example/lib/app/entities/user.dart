class User {
  double? id;
  String? firstName;
  String? lastName;
  String? function;
  String? picture;
  DateTime? createdAt;

  @override
  String toString() => {
        'id': id,
        'firstName': firstName,
        'lastName': lastName,
        'picture': picture,
        'function': function,
        'createdAt': createdAt?.toIso8601String()
      }.toString();
}
