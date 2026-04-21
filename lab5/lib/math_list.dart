import 'dart:math';
import 'package:flutter/material.dart';

class MathList extends StatelessWidget {
  const MathList({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('3. Math List (2^n)')),
      body: ListView.builder(
        itemCount: 50,
        itemBuilder: (context, index) {
          // pow retourne un double, on le convertit en int
          int result = pow(2, index).toInt();
          return ListTile(
            title: Text('2 в степени $index'),
            subtitle: Text('Résultat: $result'),
            trailing: Text('= $result', style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.blue)),
          );
        },
      ),
    );
  }
}