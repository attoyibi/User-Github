import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class UserDetailScreen extends StatefulWidget {
  final String username;

  const UserDetailScreen({Key? key, required this.username}) : super(key: key);

  @override
  _UserDetailScreenState createState() => _UserDetailScreenState();
}

class _UserDetailScreenState extends State<UserDetailScreen> {
  late Future<Map<String, dynamic>> userDetail;

  Future<Map<String, dynamic>> fetchUserDetail(String username) async {
    final Dio dio = Dio();
    final String url = 'https://api.github.com/users/$username';

    try {
      final response = await dio.get(url);
      return response.data;
    } catch (e) {
      throw Exception('Failed to load user data');
    }
  }

  @override
  void initState() {
    super.initState();
    userDetail = fetchUserDetail(widget.username);
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
              icon: const Icon(Icons.favorite),
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Love button clicked!')),
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
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: ListView(
                children: [
                  Center(
                    child: ClipOval(
                      child: Image.network(
                        user['avatar_url'] ?? '',
                        width: 100,
                        height: 100,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Center(
                    child: Text(
                      user['name'] ?? 'N/A',
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
