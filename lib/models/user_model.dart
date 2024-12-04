// lib/models/user_model.dart
class User {
  final int id;
  final String username;
  final String avatarUrl;
  final String name;
  final String company;
  final String location;
  final String? bio; // Nullable
  final String? email; // Nullable
  final int followers;
  final int following;
  final int publicRepos;
  final String htmlUrl; // For GitHub profile link

  User({
    required this.id,
    required this.username,
    required this.avatarUrl,
    required this.name,
    required this.company,
    required this.location,
    this.bio,
    this.email,
    required this.followers,
    required this.following,
    required this.publicRepos,
    required this.htmlUrl,
  });

  // Convert from Map to User object
  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      id: map['id'],
      username: map['login'], // Using 'login' from the API response
      avatarUrl: map['avatar_url'],
      name: map['name'] ?? 'N/A', // If 'name' is null, set a default value
      company: map['company'] ?? 'N/A',
      location: map['location'] ?? 'N/A',
      bio: map['bio'], // Nullable field
      email: map['email'], // Nullable field
      followers: map['followers'],
      following: map['following'],
      publicRepos: map['public_repos'],
      htmlUrl: map['html_url'],
    );
  }

  // Convert from User object to Map
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'username': username,
      'avatar_url': avatarUrl,
      'name': name,
      'company': company,
      'location': location,
      'bio': bio,
      'email': email,
      'followers': followers,
      'following': following,
      'public_repos': publicRepos,
      'html_url': htmlUrl,
    };
  }
}
