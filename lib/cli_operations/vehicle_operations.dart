import 'dart:io';


import 'package:my_parkingapp_new/Repositories/VehicleRepository.dart';
import 'package:my_parkingapp_new/models/vehicle.dart';
import 'package:my_parkingapp_new/utils/validator.dart';

VehicleRepository repository = VehicleRepository.instance;

class VehiclesOperations {
  static create() {
    print('Enter regnr: ');

    var regnr = stdin.readLineSync();

    print('Enter model');
    var model = stdin.readLineSync();
    if (Validator.isString(regnr)&& Validator.isString(model)) {
      Vehicle vehicle = Vehicle(regNr: regnr!, model: model!, id:'');
      repository.create(vehicle);
      print('Vehicle created');
    } else {
      print('Invalid input');
    }
  }

  static list()  {
    List<Vehicle> allVehicles =  repository.getAll();
    for (int i = 0; i < allVehicles.length; i++) {
      print('${i + 1}. ${allVehicles[i].regNr} - ${allVehicles[i].model}');
    }
  }

  static update() {
    print('Pick an index to update: ');
    List<Vehicle> allVehicles = repository.getAll();
    for (int i = 0; i < allVehicles.length; i++) {
      print('${i + 1}. ${allVehicles[i].regNr}');
    }

    String? input = stdin.readLineSync();

    if (Validator.isIndex(input, allVehicles)) {
      int index = int.parse(input!) - 1;
      // ignore: unused_local_variable
      Vehicle vehicle = allVehicles[index];

      print('Enter new regnr: ');
      var regnr = stdin.readLineSync();
      print('Enter new model: ');
      var model = stdin.readLineSync();

      if (Validator.isString(regnr)&& Validator.isString(model)) {
        Vehicle newVehicle = Vehicle(regNr: regnr!, model: model!, id: vehicle.id);
        repository.update(allVehicles[index].regNr, newVehicle);
        print('Vehicle updated');
      } else {
        print('Invalid input');
      }
    } else {
      print('Invalid input');
    }
  }

  static delete() {
    print('Pick an index to delete: ');
    List<Vehicle> allVehicles = repository.getAll();
    for (int i = 0; i < allVehicles.length; i++) {
      print('${i + 1}. ${allVehicles[i].regNr}');
    }

    String? input = stdin.readLineSync();

    if (Validator.isIndex(input, allVehicles)) {
      int index = int.parse(input!) - 1;
      repository.delete(allVehicles[index].regNr);
      print('Vehicle deleted');
    } else {
      print('Invalid input');
    }
  }
}

