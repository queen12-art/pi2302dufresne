import 'package:flutter/material.dart';

void main() => runApp(const Lab6App());

class Lab6App extends StatelessWidget {
  const Lab6App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Lab 6 - Area Calculator',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.blue, useMaterial3: true),
      home: const AreaCalculatorPage(),
    );
  }
}

class AreaCalculatorPage extends StatefulWidget {
  const AreaCalculatorPage({super.key});

  @override
  State<AreaCalculatorPage> createState() => _AreaCalculatorPageState();
}

class _AreaCalculatorPageState extends State<AreaCalculatorPage> {
  // Ключ формы для управления валидацией (стр. 59 методички)
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _widthController = TextEditingController();
  final TextEditingController _heightController = TextEditingController();

  String _result = '';

  void _calculateArea() {
    // Проверяем валидность всех полей формы
    if (_formKey.currentState!.validate()) {
      final double width = double.parse(_widthController.text);
      final double height = double.parse(_heightController.text);
      final double area = width * height;

      setState(() {
        _result = 'S = $width * $height = $area';
      });

      // Всплывающее уведомление об успехе (стр. 61)
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('✅ Расчет выполнен успешно!'),
          backgroundColor: Colors.green,
          duration: Duration(seconds: 2),
        ),
      );
    }
  }

  @override
  void dispose() {
    _widthController.dispose();
    _heightController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Калькулятор площади'),
        backgroundColor: Colors.blue[700],
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Form(
          key: _formKey, // Привязка ключа к форме
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Поле ввода ширины
              TextFormField(
                controller: _widthController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: 'Ширина',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Пожалуйста, введите ширину';
                  }
                  if (double.tryParse(value) == null) {
                    return 'Введите числовое значение';
                  }
                  return null; // Ошибок нет
                },
              ),
              const SizedBox(height: 16),

              // Поле ввода высоты
              TextFormField(
                controller: _heightController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: 'Высота',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Пожалуйста, введите высоту';
                  }
                  if (double.tryParse(value) == null) {
                    return 'Введите числовое значение';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 24),

              // Кнопка вычисления
              ElevatedButton(
                onPressed: _calculateArea,
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  backgroundColor: Colors.blue[700],
                  foregroundColor: Colors.white,
                ),
                child: const Text('Вычислить', style: TextStyle(fontSize: 18)),
              ),
              const SizedBox(height: 24),

              // Блок с результатом
              if (_result.isNotEmpty)
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.blue[50],
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: Colors.blue[200]!),
                  ),
                  child: Text(
                    _result,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Color.fromARGB(255, 76, 95, 125),
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
