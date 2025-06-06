import 'dart:io';


import 'package:my_parkingapp_new/Repositories/VehicleRepository.dart';
import 'package:shared/shared.dart';
import 'package:my_parkingapp_new/utils/validator.dart';
import 'package:uuid/uuid.dart';
import 'package:uuid/v4.dart';

Vehiclerepository repository = Vehiclerepository();

class VehiclesOperations {
  static Future create() async {
    print('Enter regnr: ');

    var regnr = stdin.readLineSync();

    print('Enter model');
    var model = stdin.readLineSync();
    if (Validator.isString(regnr)&& Validator.isString(model)) {
      Vehicle vehicle = Vehicle(regNr: regnr!, model: model!, id:Uuid().v4());
      await repository.create(vehicle);
      print('Vehicle created');
    } else {
      print('Invalid input');
    }
  }

  static Future list() async {
    List<Vehicle> allVehicles = await repository.getAll();
    for (int i = 0; i < allVehicles.length; i++) {
      print('${i + 1}. ${allVehicles[i].regNr} - ${allVehicles[i].model}');
    }
  }

  static Future update() async {
    print('Pick an index to update: ');
    List<Vehicle> allVehicles = await repository.getAll();
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
        await repository.update( newVehicle);
        print('Vehicle updated');
      } else {
        print('Invalid input');
      }
    } else {
      print('Invalid input');
    }
  }

  static Future delete() async {
    print('Pick an index to delete: ');
    List<Vehicle> allVehicles = await repository.getAll();
    for (int i = 0; i < allVehicles.length; i++) {
      print('${i + 1}. ${allVehicles[i].regNr}');
    }

    String? input = stdin.readLineSync();

    if (Validator.isIndex(input, allVehicles)) {
      int index = int.parse(input!) - 1;
      await repository.delete(allVehicles[index].id);
      print('Vehicle deleted');
    } else {
      print('Invalid input');
    }
  }
}

