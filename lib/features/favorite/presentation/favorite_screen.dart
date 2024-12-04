import 'package:flutter/material.dart';

class FavoriteScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Github Apps Demo'),
        bottom: const TabBar(
          tabs: [
            Tab(icon: Icon(Icons.star), text: 'Popular'),
            Tab(icon: Icon(Icons.favorite), text: 'Favorite'),
          ],
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.thumb_up,
                size: 100,
                color: Colors
                    .green), // Replace with actual clapping hands icon if available
            const SizedBox(height: 20),
            const Text(
              'Yeay, Data Favorit Kosong',
              style: TextStyle(fontSize: 18, color: Colors.green),
            ),
            const SizedBox(height: 10),
            const Text(
              'Silahkan Refresh Page untuk memperbarui data',
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Implement refresh logic here
              },
              child: const Text('Refresh'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.lightBlueAccent,
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
