

import 'package:my_parkingapp_new/repository.dart';

class Vehicle extends Identifyable {
  final String regNr;
  @override
  final String id;


  Vehicle({required this.regNr, required this.id, required String model});

  get registreringsnummer => null;

  String? get regnr => null;

  get model => null;

  @override
  String toString() {
    //Todo: implement toString
    return "$id-$regNr";
  }
}