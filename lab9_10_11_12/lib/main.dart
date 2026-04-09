import 'classes/machine.dart';
import 'classes/i_coffee.dart';
import 'classes/enums.dart';

// main doit être async pour pouvoir utiliser await
Future<void> main() async {
  print("🚀 === TP11 : Coffee Machine with Asynchronism === 🚀");
  print("---------------------------------------------------");

  // Création de la machine avec des ressources
  Machine maMachine = Machine(
    water: 1000,
    milk: 1000,
    coffeeBeans: 500,
    cash: 0,
  );

  // Affichage de l'état initial
  print("\n📊 Initial state:");
  maMachine.displayStatus();

  // Client 1 : veut un Espresso
  print("\n👤 Client 1: I would like an Espresso.");
  ICoffee commande1 = ICoffee.createCoffee(CoffeeType.espresso);
  await maMachine.makeCoffee(commande1); // ← ATTEND la préparation

  // Client 2 : veut un Cappuccino
  print("\n👤 Client 2: I would like a Cappuccino.");
  ICoffee commande2 = ICoffee.createCoffee(CoffeeType.cappuccino);
  await maMachine.makeCoffee(commande2); // ← ATTEND la préparation

  // Client 3 : veut un Americano
  print("\n👤 Client 3: I would like an Americano.");
  ICoffee commande3 = ICoffee.createCoffee(CoffeeType.americano);
  await maMachine.makeCoffee(commande3); // ← ATTEND la préparation

  // Affichage de l'état final
  print("\n📊 Final state after sales:");
  maMachine.displayStatus();

  // Test : essayer de faire un café avec une machine vide
  print("\n⚠️ Test: Empty machine...");
  Machine machineVide = Machine(water: 0, milk: 0, coffeeBeans: 0, cash: 0);
  await machineVide.makeCoffee(ICoffee.createCoffee(CoffeeType.espresso));
  
  print("\n✅ TP11 completed successfully!");
}