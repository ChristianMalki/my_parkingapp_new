import 'dart:io';

import 'package:my_parkingapp_new/Menus/main_menu.dart';

Future main(List<String> arguments) async {
  
 await MainMenu.prompt();

  
    
 }

String? prompt(String prompt) {
  stdout.write(prompt);
  final input = stdin.readLineSync();
  return input;
}

class Person {
  final String personNumber;
  final List<Vehicle> ownedVehicles;

  Person({
    required this.personNumber,
    required this.ownedVehicles,
  });
}
class Vehicle {
  final String regNr;

  Vehicle({required this.regNr});
}

class ParkingSpace {
  final String street;
  final int sekPerHour;

  ParkingSpace({required this.street, required this.sekPerHour});
}

class Parking {
  final Vehicle vehicle;
  final ParkingSpace parkingSpace;
  final DateTime starTtime;
  final DateTime? endTime;

  Parking(
    { required this.vehicle,
    required this.parkingSpace,
    required this.starTtime,
    required this.endTime});
}