import 'package:flutter/material.dart';

void main() => runApp(const Lab7App());

class Lab7App extends StatelessWidget {
  const Lab7App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Lab 7 - Navigation',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.blue, useMaterial3: true),
      home: const FirstScreen(),
    );
  }
}

// --- ÉCRAN 1 ---
class FirstScreen extends StatefulWidget {
  const FirstScreen({super.key});

  @override
  State<FirstScreen> createState() => _FirstScreenState();
}

class _FirstScreenState extends State<FirstScreen> {
  // Fonction asynchrone pour attendre le retour du 2ème écran
  Future<void> _navigateAndGetResult() async {
    // Navigator.push renvoie un Future qui se complète avec la valeur passée à pop()
    final result = await Navigator.push<String>(
      context,
      MaterialPageRoute(builder: (context) => const SecondScreen()),
    );

    // Si un résultat a été renvoyé, on l'affiche dans un SnackBar
    if (result != null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Вы выбрали: $result'),
          backgroundColor: Colors.green,
          duration: const Duration(seconds: 2),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Первый экран'),
        backgroundColor: Colors.blue[700],
        foregroundColor: Colors.white,
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: _navigateAndGetResult,
          style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
            backgroundColor: Colors.blue,
            foregroundColor: Colors.white,
          ),
          child: const Text(
            'Перейти ко второму экрану',
            style: TextStyle(fontSize: 18),
          ),
        ),
      ),
    );
  }
}

// --- ÉCRAN 2 ---
class SecondScreen extends StatelessWidget {
  const SecondScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Второй экран'),
        backgroundColor: Colors.orange[700],
        foregroundColor: Colors.white,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Bouton ОUI -> renvoie 'Да' et ferme l'écran
            ElevatedButton(
              onPressed: () => Navigator.pop(context, 'Да'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(
                  horizontal: 50,
                  vertical: 15,
                ),
              ),
              child: const Text('Да', style: TextStyle(fontSize: 20)),
            ),
            const SizedBox(height: 20),
            // Bouton NON -> renvoie 'Нет' et ferme l'écran
            ElevatedButton(
              onPressed: () => Navigator.pop(context, 'Нет'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(
                  horizontal: 50,
                  vertical: 15,
                ),
              ),
              child: const Text('Нет', style: TextStyle(fontSize: 20)),
            ),
          ],
        ),
      ),
    );
  }
}
