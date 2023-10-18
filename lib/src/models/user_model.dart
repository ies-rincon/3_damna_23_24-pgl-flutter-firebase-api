/// A placeholder class that represents an entity or model.
class User {
  final String id;
  final String name;
  final String email;
  final String img;

  User({
    required this.id,
    required this.name,
    required this.email,
    this.img = "",
  });
}
