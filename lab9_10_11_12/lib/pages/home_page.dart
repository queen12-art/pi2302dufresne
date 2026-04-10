// home_page.dart
import 'package:flutter/material.dart';
import '../classes/machine.dart';
import '../classes/i_coffee.dart';
import '../classes/enums.dart';

class HomePage extends StatefulWidget {
  final Machine machine;
  
  const HomePage({super.key, required this.machine});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> 
    with SingleTickerProviderStateMixin {
  
  late TabController _tabController;
  bool _isPreparing = false;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  // Fonction pour préparer le café
  Future<void> _prepareCoffee(CoffeeType type) async {
    setState(() {
      _isPreparing = true;
    });

    try {
      ICoffee coffee = ICoffee.createCoffee(type);
      await widget.machine.makeCoffee(coffee);
      
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('✅ ${coffee.name} is ready!'),
            backgroundColor: Colors.green,
          ),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('❌ Error: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    } finally {
      setState(() {
        _isPreparing = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Coffee Machine'),
        backgroundColor: const Color.fromARGB(255, 222, 208, 203),
        bottom: TabBar(
          controller: _tabController,
          tabs: const [
            Tab(icon: Icon(Icons.local_cafe), text: 'Resources'),
            Tab(icon: Icon(Icons.shopping_cart), text: 'Order'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          // Page 1: Resources Display
          _buildResourcesPage(),
          // Page 2: Order Page
          _buildOrderPage(),
        ],
      ),
    );
  }

  Widget _buildResourcesPage() {
    return Container(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          const Text(
            'Machine Resources',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 20),
          _buildResourceCard('💧 Water', '${widget.machine.water} ml', Colors.blue),
          _buildResourceCard('🥛 Milk', '${widget.machine.milk} ml', const Color.fromARGB(255, 125, 76, 76)),
          _buildResourceCard('☕ Coffee Beans', '${widget.machine.coffee} g', Colors.brown),
          _buildResourceCard('💰 Cash', '${widget.machine.cash} ₽', Colors.green),
        ],
      ),
    );
  }

  Widget _buildResourceCard(String label, String value, Color color) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: ListTile(
        leading: Text(label, style: const TextStyle(fontSize: 20)),
        title: Text(
          value,
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: color),
          textAlign: TextAlign.right,
        ),
      ),
    );
  }

  Widget _buildOrderPage() {
    if (_isPreparing) {
      return const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircularProgressIndicator(),
            SizedBox(height: 20),
            Text(
              'Preparing your coffee...',
              style: TextStyle(fontSize: 18),
            ),
          ],
        ),
      );
    }

    return Container(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            'Choose your drink:',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 20),
          
          // Button 1: Espresso
          ElevatedButton.icon(
            onPressed: () => _prepareCoffee(CoffeeType.espresso),
            icon: const Icon(Icons.local_cafe),
            label: const Text('Espresso'),
            style: ElevatedButton.styleFrom(
              minimumSize: const Size(double.infinity, 50),
              backgroundColor: Colors.brown,
            ),
          ),
          const SizedBox(height: 10),

          // Button 2: Cappuccino
          ElevatedButton.icon(
            onPressed: () => _prepareCoffee(CoffeeType.cappuccino),
            icon: const Icon(Icons.coffee),
            label: const Text('Cappuccino'),
            style: ElevatedButton.styleFrom(
              minimumSize: const Size(double.infinity, 50),
              backgroundColor: Colors.orange[700],
            ),
          ),
          const SizedBox(height: 10),

          // Button 3: Americano
          ElevatedButton.icon(
            onPressed: () => _prepareCoffee(CoffeeType.americano),
            icon: const Icon(Icons.coffee_maker),
            label: const Text('Americano'),
            style: ElevatedButton.styleFrom(
              minimumSize: const Size(double.infinity, 50),
              backgroundColor: Colors.teal[700],
            ),
          ),
        ],
      ),
    );
  }
}