import 'i_coffee.dart';

class Cappuccino implements ICoffee {
  @override
  int get water => 100;

  @override
  int get milk => 250;

  @override
  int get coffeeBeans => 50;

  @override
  int get price => 150;

  @override
  String get name => 'Cappuccino';  // ← AJOUTÉ !
}