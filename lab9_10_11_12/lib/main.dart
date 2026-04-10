import 'package:flutter/material.dart';
import 'classes/machine.dart';
import 'pages/home_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // Création de la machine avec des ressources initiales
    final Machine coffeeMachine = Machine(
      water: 1000,
      milk: 1000,
      coffeeBeans: 500,
      cash: 0,
    );

    return MaterialApp(
      title: 'Coffee Machine',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.brown,
        useMaterial3: true,
      ),
      home: HomePage(machine: coffeeMachine),
    );
  }
}