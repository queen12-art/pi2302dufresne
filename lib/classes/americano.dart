import 'i_coffee.dart';

class Americano implements ICoffee {
  @override
  int get water => 200;

  @override
  int get milk => 0;

  @override
  int get coffeeBeans => 50;

  @override
  int get price => 120;
  
  @override  // ← AJOUTE ÇA !
  String get name => 'Americano';  // ← ET ÇA !
}