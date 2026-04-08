import 'classes/machine.dart';
import 'classes/i_coffee.dart';
import 'classes/enums.dart';

void main() {
  print("🚀 === TP10 : Machine à Café OO === 🚀");
  print("--------------------------------------");

  // 1. Création de la machine avec des ressources
  Machine maMachine = Machine(
    water: 1000,
    milk: 1000,
    coffeeBeans: 500,
    cash: 0,
  );

  // 2. Affichage de l'état initial
  print("📊 État initial :");
  maMachine.displayStatus();

  // 3. Premier client : veut un Espresso
  // On utilise la Factory Method pour créer le café !
  print("\n👤 Client 1 : Je voudrais un Espresso.");
  ICoffee commande1 = ICoffee.createCoffee(CoffeeType.espresso);
  maMachine.makeCoffee(commande1);

  // 4. Deuxième client : veut un Cappuccino
  print("\n👤 Client 2 : Je voudrais un Cappuccino.");
  ICoffee commande2 = ICoffee.createCoffee(CoffeeType.cappuccino);
  maMachine.makeCoffee(commande2);

  // 5. Troisième client : veut un Americano
  print("\n👤 Client 3 : Je voudrais un Americano.");
  ICoffee commande3 = ICoffee.createCoffee(CoffeeType.americano);
  maMachine.makeCoffee(commande3);

  // 6. Affichage de l'état final
  print("\n📊 État final après les ventes :");
  maMachine.displayStatus();

  // 7. Test : essayer de faire un café avec une machine vide
  print("\n⚠️ Test : Machine vide...");
  Machine machineVide = Machine(water: 0, milk: 0, coffeeBeans: 0, cash: 0);
  machineVide.makeCoffee(ICoffee.createCoffee(CoffeeType.espresso));
  
  print("\n✅ TP10 terminé avec succès !");
}