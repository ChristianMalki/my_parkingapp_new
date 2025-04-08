

import 'package:shared/shared.dart';

class VehicleRepository{
  // singleton

  VehicleRepository._internal();

  static final VehicleRepository _instance = VehicleRepository._internal();

  static VehicleRepository get instance => _instance;

  final List <Vehicle> _vehicles = [];

  
  Future<Vehicle> create(Vehicle vehicle) async {
    _vehicles.add(vehicle);
    return vehicle;
  }

  
  Future<Vehicle> getByRegnr(String regnr) async{
    return _vehicles.firstWhere((e) => e.regNr == regnr);
  }

  
  Future<List<Vehicle>> getAll() async => List.from(_vehicles);


  Future<Vehicle> update(String regnr, Vehicle newVehicle) async {
    var index = _vehicles.indexWhere((e) => e.regNr == regnr);
    if (index >= 0 && index < _vehicles.length) {
      _vehicles[index] = newVehicle;
      return newVehicle;
    }
    throw RangeError.index(index, _vehicles);
  }

  
  Future<Vehicle> delete(String regnr) async {
    var index = _vehicles.indexWhere((e) => e.regNr == regnr);
    if (index >= 0 && index < _vehicles.length) {
      return _vehicles.removeAt(index);
    }
    throw RangeError.index(index, _vehicles);
  }
}