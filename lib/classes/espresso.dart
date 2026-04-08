import 'i_coffee.dart';

class Espresso implements ICoffee {
  @override
  int get water => 100;

  @override
  int get milk => 0;

  @override
  int get coffeeBeans => 50;

  @override
  int get price => 100;

  @override
  String get name => 'Espresso';  // ← AJOUTÉ !
}