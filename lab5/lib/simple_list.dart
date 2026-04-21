import 'package:flutter/material.dart';

class SimpleList extends StatelessWidget {
  const SimpleList({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('1. Simple List')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: const [
          ListTile(title: Text('📦 Item 1'), trailing: Icon(Icons.arrow_forward_ios)),
          Divider(),
          ListTile(title: Text('📦 Item 2'), trailing: Icon(Icons.arrow_forward_ios)),
          Divider(),
          ListTile(title: Text('📦 Item 3'), trailing: Icon(Icons.arrow_forward_ios)),
        ],
      ),
    );
  }
}