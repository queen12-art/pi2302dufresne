import 'package:flutter/material.dart';

void main() {
  runApp(const Lab4App());
}

class Lab4App extends StatelessWidget {
  const Lab4App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Lab 4 - Campus',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.green, // Thème vert demandé
        useMaterial3: true,
      ),
      home: const CampusPage(),
    );
  }
}

class CampusPage extends StatelessWidget {
  const CampusPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // 1. Barre verte
      appBar: AppBar(
        title: const Text('Campus KubGAU'),
        backgroundColor: Colors.green[700],
        foregroundColor: Colors.white,
      ),
      // 2. Écran scrollable (SingleChildScrollView)
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 3. Le texte sur les dortoirs (Page 50 du PDF)
            const Text(
              'Студенческий городок или так называемый кампус Кубанского ГАУ состоит из двадцати общежитий, в которых проживает более 8000 студентов, что составляет 96% от всех нуждающихся. Студенты первого курса обеспечены местами в общежитии полностью. В соответствии с Положением о студенческих общежитиях университета, при поселении между администрацией и студентами заключается договор найма жилого помещения. Воспитательная работа в общежитиях направлена на улучшение быта, соблюдение правил внутреннего распорядка, отсутствия асоциальных явлений в молодежной среде. Условия проживания в общежитиях университетского кампуса полностью отвечают санитарным нормам и требованиям: наличие оборудованных кухонь, душевых комнат, прачечных, читальных залов, комнат самоподготовки, помещений для заседаний студенческих советов и наглядной агитации. С целью улучшения условий быта студентов активно работает система студенческого самоуправления- студенческие советы организуют всю работу по самообслуживанию.',
              style: TextStyle(
                fontSize: 16,
                height: 1.5,
                color: Colors.black87,
              ),
              textAlign: TextAlign.justify,
            ),

            const SizedBox(height: 30),

            // 4. Cœur rouge (Page 51 du PDF)
            Center(
              child: InkWell(
                onTap: () {
                  ScaffoldMessenger.of(
                    context,
                  ).showSnackBar(const SnackBar(content: Text('❤️ ❤️ ❤️')));
                },
                child: const Icon(
                  Icons.favorite,
                  size: 60,
                  color: Colors.red, // Cœur rouge demandé
                ),
              ),
            ),

            const SizedBox(height: 30),

            // 5. Les 3 boutons (Позвонить, Маршрут, Поделиться)
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildActionBtn(Icons.call, 'Call', context),
                _buildActionBtn(Icons.directions, 'Route', context),
                _buildActionBtn(Icons.share, 'Share', context),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // Widget pour les boutons verts
  Widget _buildActionBtn(IconData icon, String label, BuildContext context) {
    return ElevatedButton.icon(
      onPressed: () {
        // Feedback visuel pour montrer que le bouton fonctionne
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('Action: $label')));
      },
      icon: Icon(icon, color: Colors.white),
      label: Text(label, style: const TextStyle(color: Colors.white)),
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.green[600], // Boutons verts
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      ),
    );
  }
}
