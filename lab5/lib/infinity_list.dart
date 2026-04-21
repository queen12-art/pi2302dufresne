import 'package:flutter/material.dart';

class InfinityList extends StatelessWidget {
  const InfinityList({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('2. Infinity List')),
      body: ListView.builder(
        itemCount: 100, // Nombre arbitraire pour simuler l'infini
        itemBuilder: (context, index) {
          return ListTile(
            leading: CircleAvatar(child: Text('$index')),
            title: Text('Строка $index'),
            trailing: const Icon(Icons.list),
          );
        },
      ),
    );
  }
}