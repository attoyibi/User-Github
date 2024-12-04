class User {
  int? id;
  String username;
  String? avatarUrl;
  String? name;
  String? bio;
  String? location;
  String? company;
  String? htmlUrl;
  int? followers;
  int? following;
  int? publicRepos;
  int? publicGists;

  User({
    this.id,
    required this.username,
    this.avatarUrl,
    this.name,
    this.bio,
    this.location,
    this.company,
    this.htmlUrl,
    this.followers,
    this.following,
    this.publicRepos,
    this.publicGists,
  });

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      id: map['id'],
      username: map['username'],
      avatarUrl: map['avatar_url'],
      name: map['name'],
      bio: map['bio'],
      location: map['location'],
      company: map['company'],
      htmlUrl: map['html_url'],
      followers: map['followers'],
      following: map['following'],
      publicRepos: map['public_repos'],
      publicGists: map['public_gists'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'username': username,
      'avatar_url': avatarUrl,
      'name': name,
      'bio': bio,
      'location': location,
      'company': company,
      'html_url': htmlUrl,
      'followers': followers,
      'following': following,
      'public_repos': publicRepos,
      'public_gists': publicGists,
    };
  }
}
