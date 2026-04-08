// i_coffee.dart

import 'enums.dart'; // Pour utiliser CoffeeType
import 'espresso.dart';
import 'cappuccino.dart';
import 'americano.dart';

abstract class ICoffee {
  int get water;
  int get milk;
  int get coffeeBeans;
  int get price;
  String get name;

  // --- FABRIQUE (FACTORY) ---
  // Cette méthode décide quel objet créer selon le type
  static ICoffee createCoffee(CoffeeType type) {
    switch (type) {
      case CoffeeType.espresso:
        return Espresso();
      case CoffeeType.cappuccino:
        return Cappuccino();
      case CoffeeType.americano:
        return Americano();
    }
  }
}
