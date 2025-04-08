

import 'package:my_parkingapp_new/repository.dart';

class Vehicle extends Identifyable {
  final String regNr;
  @override
  final String id;
  final String model;


  Vehicle({required this.regNr, required this.id, required this.model});

  get registreringsnummer => null;



  @override
  String toString() {
    //Todo: implement toString
    return "$id-$regNr";
  }
}