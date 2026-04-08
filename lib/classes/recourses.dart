// recourses.dart

class Recourses {
  int water;
  int milk;
  int coffee;
  int cash;

  // Constructeur avec paramètres nommés
  Recourses({
    required this.water,
    required this.milk,
    required this.coffee,
    required this.cash,
  });

  // Vérifie si les ressources actuelles sont suffisantes par rapport à ce qui est demandé
  bool hasEnough(Recourses other) {
    return water >= other.water && milk >= other.milk && coffee >= other.coffee;
  }

  // Retire les ressources utilisées pour préparer un café
  void subtract(Recourses other) {
    water -= other.water;
    milk -= other.milk;
    coffee -= other.coffee;
  }

  // Ajoute des ressources (réapprovisionnement ou encaissement)
  void add(Recourses other) {
    water += other.water;
    milk += other.milk;
    coffee += other.coffee;
    cash += other.cash;
  }
}
