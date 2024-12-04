import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:dio/dio.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2, // Jumlah tab
      child: Scaffold(
        appBar: AppBar(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text("Github Apps Demo"),
              IconButton(
                onPressed: () {
                  Modular.to.pushNamed('/profile');
                },
                icon: const Icon(Icons.info),
              ),
            ],
          ),
          bottom: const TabBar(
            tabs: [
              Tab(icon: Icon(Icons.people), text: 'Popular'),
              Tab(icon: Icon(Icons.favorite), text: 'Favorite'),
            ],
          ),
        ),
        body: const TabBarView(
          children: [
            PopularScreen(),
            FavoriteScreen(),
          ],
        ),
      ),
    );
  }
}

class PopularScreen extends StatefulWidget {
  const PopularScreen({Key? key}) : super(key: key);

  @override
  _PopularScreenState createState() => _PopularScreenState();
}

class _PopularScreenState extends State<PopularScreen> {
  final Dio _dio = Dio();
  List<User> _users = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchPopularUsers();
  }

  Future<void> _fetchPopularUsers() async {
    const String url =
        'https://api.github.com/search/users?q=followers%3A%3E%3D1000&ref=searchresults&s=followers&type=Users';
    try {
      final response = await _dio.get(url);
      if (response.statusCode == 200) {
        final List items = response.data['items'];
        setState(() {
          _users = items
              .map((item) => User(
                    username: item['login'],
                    avatarUrl: item['avatar_url'],
                  ))
              .toList();
          _isLoading = false;
        });
      }
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
      print("Error fetching data: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }

    return ListView.builder(
      itemCount: _users.length,
      itemBuilder: (context, index) {
        return ListTile(
          leading: CircleAvatar(
            backgroundImage: NetworkImage(_users[index].avatarUrl),
          ),
          title: Text(_users[index].username),
          subtitle: const Text('User'),
          onTap: () {
            Modular.to.pushNamed('/detail/${_users[index].username}');
          },
        );
      },
    );
  }
}

class FavoriteScreen extends StatelessWidget {
  const FavoriteScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          // title: const Text('Favorites'),
          ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.favorite, size: 100, color: Colors.redAccent),
            const SizedBox(height: 20),
            const Text(
              'No Favorite Users',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            const Text(
              'Add some users to your favorites list',
              style: TextStyle(fontSize: 16, color: Colors.grey),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Refresh logic here
              },
              child: const Text('Refresh'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blueAccent,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.0),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class User {
  final String username;
  final String avatarUrl;

  User({required this.username, required this.avatarUrl});
}
