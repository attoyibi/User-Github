import 'package:flutter/material.dart';

class UserDetailScreen extends StatelessWidget {
  final String username;

  const UserDetailScreen({Key? key, required this.username}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('$username\'s Profile'),
            IconButton(
              icon: const Icon(Icons.favorite),
              onPressed: () {
                // Aksi ketika tombol Love ditekan
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Love button clicked!'),
                  ),
                );
              },
            ),
          ],
        ),
      ),
      body: Center(
        child: Text('Detail of user: $username'),
      ),
    );
  }
}
