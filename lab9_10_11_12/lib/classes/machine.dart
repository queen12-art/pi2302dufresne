// machine.dart

import 'recourses.dart';
import 'i_coffee.dart';
import 'coffee_process.dart'; // Import our async functions
import 'dart:async';          // Needed for Future.wait

class Machine {
  Recourses _resources;

  Machine({
    required int water,
    required int milk,
    required int coffeeBeans,
    required int cash,
  }) : _resources = Recourses(
          water: water,
          milk: milk,
          coffee: coffeeBeans,
          cash: cash,
        );

  // --- GETTERS (Accesseurs) ---
  // Permet de lire les valeurs des ressources depuis l'extérieur
  int get water => _resources.water;
  int get milk => _resources.milk;
  int get coffee => _resources.coffee;
  int get cash => _resources.cash;

  void displayStatus() {
    print('💧 Water: ${_resources.water} ml');
    print('🥛 Milk: ${_resources.milk} ml');
    print('☕ Coffee beans: ${_resources.coffee} g');
    print('💰 Cash: ${_resources.cash}');
    print('------------------------');
  }

  // MODIFIED: Now async and returns Future<void>
  Future<void> makeCoffee(ICoffee coffee) async {
    print('👉 Preparing ${coffee.name}...');

    Recourses needed = Recourses(
      water: coffee.water,
      milk: coffee.milk,
      coffee: coffee.coffeeBeans,
      cash: 0,
    );

    if (_resources.hasEnough(needed)) {
      // Consume resources immediately
      _resources.subtract(needed);
      _resources.cash += coffee.price;

      print('🤖 Machine started...');

      // --- ASYNC PROCESS START ---

      // Step 1: Heat water (3 seconds)
      await heatWater();

      // Step 2: Prepare ingredients
      print('⏳ Processing ingredients...');
      
      if (coffee.milk > 0) {
        // Run brewing AND frothing IN PARALLEL (both take 5s, so total = 5s)
        await Future.wait([
          brewCoffee(),
          frothMilk(),
        ]);
      } else {
        // Just brew coffee if no milk needed
        await brewCoffee();
      }

      // Step 3: Mix (only if milk was used)
      if (coffee.milk > 0) {
        await mixCoffeeMilk();
      }

      print('✅ ${coffee.name} is ready!');
      print('------------------------');
      
      // --- ASYNC PROCESS END ---

    } else {
      print('❌ Not enough resources for ${coffee.name}');
      print('------------------------');
    }
  }
}