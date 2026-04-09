// coffee_process.dart
import 'dart:async';

// Function to simulate heating water
// Delay: 3 seconds
Future<void> heatWater() async {
  print('🔥 Heating water...');
  await Future.delayed(Duration(seconds: 3));
  print('✅ Water is hot!');
}

// Function to simulate brewing coffee
// Delay: 5 seconds
Future<void> brewCoffee() async {
  print('☕ Brewing coffee...');
  await Future.delayed(Duration(seconds: 5));
  print('✅ Coffee is brewed!');
}

// Function to simulate frothing milk
// Delay: 5 seconds
Future<void> frothMilk() async {
  print('🥛 Frothing milk...');
  await Future.delayed(Duration(seconds: 5));
  print('✅ Milk is frothed!');
}

// Function to simulate mixing coffee and milk
// Delay: 3 seconds
Future<void> mixCoffeeMilk() async {
  print('🔄 Mixing coffee and milk...');
  await Future.delayed(Duration(seconds: 3));
  print('✅ Drink is ready!');
}
