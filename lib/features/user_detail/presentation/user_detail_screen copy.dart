import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import '../../../database/database_helper.dart';
import '../../../models/user_model.dart'; // Impor model User yang sudah dibuat

class UserDetailScreen extends StatefulWidget {
  final String username;

  const UserDetailScreen({Key? key, required this.username}) : super(key: key);

  @override
  _UserDetailScreenState createState() => _UserDetailScreenState();
}

class _UserDetailScreenState extends State<UserDetailScreen> {
  late Future<Map<String, dynamic>> userDetail;
  late User _user;
  bool _isFavorited = false;

  Future<Map<String, dynamic>> fetchUserDetail(String username) async {
    final Dio dio = Dio();
    final String url = 'https://api.github.com/users/$username';

    try {
      final response = await dio.get(url);
      print("Fetched user data: ${response.data}"); // Print the fetched data
      return response.data;
    } catch (e) {
      throw Exception('Failed to load user data');
    }
  }

  // @override
  // void initState() {
  //   super.initState();
  //   userDetail = fetchUserDetail(widget.username);
  // }
  @override
  void initState() {
    super.initState();
    userDetail = fetchUserDetail(widget.username);
    userDetail.then((data) {
      setState(() {
        _user = User.fromMap(data); // Konversi data ke objek User
      });
    }).catchError((error) {
      // Tangani error jika perlu
      print('Error fetching user details: $error');
    });
  }

// Cek apakah pengguna sudah disimpan sebagai favorit
  void _checkIfFavorited() async {
    final users = await DatabaseHelper().getAllUsers();
    setState(() {
      _isFavorited = users.any((user) => user.username == _user.username);
    });
  }

  // Menandai pengguna sebagai favorit
  void _toggleFavorite() async {
    if (_isFavorited) {
      // Hapus dari favorit
      // final users = await DatabaseHelper().getAllUsers();
      // final user = users.firstWhere((user) => user.username == _user.username);
      // await DatabaseHelper().deleteUser(user.id!);
    } else {
      // Simpan sebagai favorit
      print('User Details: ${_user.toMap()}');
      // await DatabaseHelper().insertUser(_user);
    }

    setState(() {
      _isFavorited = !_isFavorited;
      print(
          'Is Favorited: $_isFavorited'); // Menampilkan nilai _isFavorited ke konsol
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('${widget.username}\'s Profile'),
            IconButton(
              icon: Icon(
                _isFavorited ? Icons.favorite : Icons.favorite_border,
                color: Colors.red,
              ),
              onPressed: () {
                _toggleFavorite(); // Panggil _toggleFavorite untuk mengubah status favorit
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                      content: Text(_isFavorited
                          ? 'Added to favorites!'
                          : 'Removed from favorites!')),
                );
              },
            ),
          ],
        ),
      ),
      body: FutureBuilder<Map<String, dynamic>>(
        future: userDetail,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (snapshot.hasData) {
            final user = snapshot.data!;
            // _checkIfFavorited();
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: ListView(
                children: [
                  Center(
                    child: ClipOval(
                      child: Image.network(
                        user['avatar_url'] ??
                            '', // Provide a fallback for null avatar_url
                        width: 100,
                        height: 100,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Center(
                    child: Text(
                      user['name'] ?? 'N/A', // Provide fallback if name is null
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(user['bio'] ?? 'No bio available'),
                  const Divider(),
                  ListTile(
                    leading: const Icon(Icons.location_on),
                    title: Text(user['location'] ?? 'N/A'),
                  ),
                  ListTile(
                    leading: const Icon(Icons.business),
                    title: Text(user['company'] ?? 'N/A'),
                  ),
                  ListTile(
                    leading: const Icon(Icons.link),
                    title: Text(user['html_url']),
                    onTap: () => _openUrl(user['html_url']),
                  ),
                  ListTile(
                    leading: const Icon(Icons.people),
                    title: Text('Followers: ${user['followers']}'),
                    subtitle: Text('Following: ${user['following']}'),
                  ),
                  ListTile(
                    leading: const Icon(Icons.book),
                    title: Text('Public Repos: ${user['public_repos']}'),
                    subtitle: Text('Public Gists: ${user['public_gists']}'),
                  ),
                ],
              ),
            );
          } else {
            return const Center(child: Text('No data available'));
          }
        },
      ),
    );
  }

  void _openUrl(String url) {
    // Implement URL opening logic here, e.g., using url_launcher package.
  }
}
