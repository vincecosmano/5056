class User {
  final String id;
  final String name;
  final String email;
  final String photoUrl;
  final String googleId;
  final bool isPremium;
  final DateTime createdAt;

  User({
    required this.id,
    required this.name,
    required this.email,
    required this.photoUrl,
    required this.googleId,
    required this.isPremium,
    required this.createdAt,
  });
}