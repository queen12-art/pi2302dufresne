import 'recourses.dart';
import 'i_coffee.dart';

class Machine {
  // La machine n'a plus qu'une seule variable "recourses"
  late Recourses _resources;

  // Constructeur pour initialiser la machine avec des ressources
  Machine({
    required int water,
    required int milk,
    required int coffeeBeans,
    required int cash,
  }) {
    _resources = Recourses(
      water: water,
      milk: milk,
      coffee: coffeeBeans, // Attention : dans Recourses, c'est "coffee"
      cash: cash,
    );
  }

  // Méthode pour afficher l'état actuel de la machine
  void displayStatus() {
    print('💧 Eau : ${_resources.water} ml');
    print('🥛 Lait : ${_resources.milk} ml');
    print('☕ Café : ${_resources.coffee} g');
    print('💰 Argent : ${_resources.cash}');
    print('------------------------');
  }

  // MÉTHODE PRINCIPALE : Préparer un café (accepte n'importe quel ICoffee)
  void makeCoffee(ICoffee coffee) {
    print('👉 Préparation de ${coffee.name}...');

    // 1. Créer un objet Recourses avec ce dont le café a besoin
    Recourses needed = Recourses(
      water: coffee.water,
      milk: coffee.milk,
      coffee: coffee.coffeeBeans,
      cash: 0, // Le café ne consomme pas d'argent (il en rapporte)
    );

    // 2. Vérifier si on a assez de ressources
    if (_resources.hasEnough(needed)) {
      // 3. Si oui, on retire les ressources
      _resources.subtract(needed);
      // 4. On ajoute le prix du café à la caisse
      _resources.cash += coffee.price;
      print('✅ ${coffee.name} prêt ! Prix : ${coffee.price}');
    } else {
      print('❌ Pas assez de ressources pour préparer ${coffee.name}');
    }
    print('------------------------');
  }
}
