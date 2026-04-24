import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

// Contournement des certificats SSL
class _MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback = (X509Certificate cert, String host, int port) => true;
  }
}

class News {
  final String title;
  final String content;
  final String date;
  
  News({required this.title, required this.content, required this.date});

  factory News.fromJson(Map<String, dynamic> json) {
    // Essayez différents noms de champs possibles
    return News(
      title: json['title'] ?? json['name'] ?? json['NAME'] ?? 'Sans titre',
      content: json['text'] ?? json['content'] ?? json['TEXT'] ?? json['DETAIL_TEXT'] ?? '',
      date: json['date'] ?? json['created_at'] ?? json['DATE'] ?? json['TIMESTAMP'] ?? '',
    );
  }
}

class NewsFeed extends StatefulWidget {
  const NewsFeed({super.key});
  
  @override
  State<NewsFeed> createState() => _NewsFeedState();
}

class _NewsFeedState extends State<NewsFeed> {
  Future<List<News>> fetchNews() async {
    // Activation du contournement SSL
    HttpOverrides.global = _MyHttpOverrides();
    
    try {
      final response = await http.get(
        Uri.parse('https://kubsau.ru/api/getNews.php?key=6df2f5d38d4e16b5a923a6d4873e2ee295d0ac90'),
        headers: {'Content-Type': 'application/json'},
      ).timeout(const Duration(seconds: 10));
      
      print('Status code: ${response.statusCode}');
      print('Response body: ${response.body}');
      
      if (response.statusCode == 200) {
        final dynamic data = jsonDecode(response.body);
        print('Parsed data type: ${data.runtimeType}');
        
        // L'API peut retourner une liste ou un objet contenant une clé "news"
        final List<dynamic> list;
        if (data is List) {
          list = data;
        } else if (data is Map && data.containsKey('news')) {
          list = data['news'];
        } else if (data is Map && data.containsKey('items')) {
          list = data['items'];
        } else {
          list = [];
        }
        
        print('Number of news: ${list.length}');
        if (list.isNotEmpty) {
          print('First news keys: ${list[0].keys}');
        }
        
        return list.map((json) => News.fromJson(json)).toList();
      } else {
        throw Exception('Erreur HTTP: ${response.statusCode}');
      }
    } catch (e) {
      print('Error fetching news: $e');
      rethrow;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('News KubGAU'),
        backgroundColor: Colors.green[700],
        foregroundColor: Colors.white,
      ),
      body: FutureBuilder<List<News>>(
        future: fetchNews(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator(color: Colors.green));
          } else if (snapshot.hasError) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.error_outline, size: 64, color: Colors.red),
                  const SizedBox(height: 16),
                  Text('Erreur: ${snapshot.error}', style: const TextStyle(color: Colors.red)),
                ],
              ),
            );
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('Aucune news disponible'));
          }
          
          final newsList = snapshot.data!;
          return ListView.builder(
            padding: const EdgeInsets.all(12),
            itemCount: newsList.length,
            itemBuilder: (context, index) {
              final news = newsList[index];
              // Nettoyage des balises HTML avec intl
              final cleanTitle = Bidi.stripHtmlIfNeeded(news.title);
              final cleanContent = Bidi.stripHtmlIfNeeded(news.content);
              
              return Card(
                margin: const EdgeInsets.only(bottom: 12),
                elevation: 3,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        cleanTitle, 
                        style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.green),
                      ),
                      if (news.date.isNotEmpty) ...[
                        const SizedBox(height: 8),
                        Text(news.date, style: const TextStyle(fontSize: 12, color: Colors.grey)),
                      ],
                      if (cleanContent.isNotEmpty) ...[
                        const Divider(height: 16),
                        Text(cleanContent, style: const TextStyle(fontSize: 14, height: 1.4)),
                      ],
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}