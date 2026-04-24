import 'package:flutter/material.dart';
import 'photo_gallery.dart';
import 'news_feed.dart';

void main() => runApp(const Lab8App());

class Lab8App extends StatelessWidget {
  const Lab8App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Lab 8 - REST API',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.teal, useMaterial3: true),
      home: const Lab8Home(),
    );
  }
}

class Lab8Home extends StatelessWidget {
  const Lab8Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Lab 8: REST API'),
        backgroundColor: Colors.teal[700],
        foregroundColor: Colors.white,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton.icon(
              onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const PhotoGallery()),
              ),
              icon: const Icon(Icons.photo_library),
              label: const Text('Photo Gallery (jsonplaceholder)'),
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.all(16),
                backgroundColor: Colors.blue,
              ),
            ),
            const SizedBox(height: 24),
            ElevatedButton.icon(
              onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const NewsFeed()),
              ),
              icon: const Icon(Icons.newspaper),
              label: const Text('KubGAU News Feed'),
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.all(16),
                backgroundColor: Colors.green,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
