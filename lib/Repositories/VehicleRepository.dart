
import 'package:my_parkingapp_new/models/vehicle.dart';

class VehicleRepository{
  // singleton

  VehicleRepository._internal();

  static final VehicleRepository _instance = VehicleRepository._internal();

  static VehicleRepository get instance => _instance;

  final _vehicles = [];

  
  Vehicle create(Vehicle vehicle) {
    _vehicles.add(vehicle);
    return vehicle;
  }

  
  Vehicle getByRegnr(String regnr) {
    return _vehicles.firstWhere((e) => e.regnr == regnr);
  }

  
  List<Vehicle> getAll() => List.from(_vehicles);


  Vehicle update(String regnr, Vehicle newVehicle) {
    var index = _vehicles.indexWhere((e) => e.regnr == regnr);
    if (index >= 0 && index < _vehicles.length) {
      _vehicles[index] = newVehicle;
      return newVehicle;
    }
    throw RangeError.index(index, _vehicles);
  }

  
  Vehicle delete(String regnr) {
    var index = _vehicles.indexWhere((e) => e.regnr == regnr);
    if (index >= 0 && index < _vehicles.length) {
      return _vehicles.removeAt(index);
    }
    throw RangeError.index(index, _vehicles);
  }
}