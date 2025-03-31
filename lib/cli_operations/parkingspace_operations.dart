import 'dart:io';

import 'package:my_parkingapp_new/Repositories/ParkingSpaceRepository.dart';
import 'package:my_parkingapp_new/utils/validator.dart';
import 'package:uuid/uuid.dart';

Parkingspacerepository repository =Parkingspacerepository();


class ParkingSpaceOperations {
  static create() {
    print('Enter adress: ');

    var id = stdin.readLineSync();


    var adress = stdin.readLineSync();
    if (Validator.isString(id)&& Validator.isString(adress)) {
      ParkingSpace parkingSpace = ParkingSpace( Uuid().v4(), adress!);
      repository.create(parkingSpace);
      print('Person created');
    } else {
      print('Invalid input');
    }
  }

  static Future list() async  {
    List<ParkingSpace> allParkingspace = await repository.getAll();
    for (int i = 0; i < allParkingspace.length; i++) {
      print('${i + 1}. ${allParkingspace[i].id} - ${allParkingspace[i].id}');
    }
  }

  static Future update()async {
    print('Pick an index to update: ');
    List<ParkingSpace> allParkingspace = await repository.getAll();
    for (int i = 0; i < allParkingspace.length; i++) {
      print('${i + 1}. ${allParkingspace[i].id}');
    }

    String? input = stdin.readLineSync();

    if (Validator.isIndex(input, allParkingspace)) {
      int index = int.parse(input!) - 1;
      ParkingSpace parkingSpace = allParkingspace[index];

      print('Enter new parkingspace: ');
      var id = stdin.readLineSync();
      print('Enter new adress: ');
      var adress = stdin.readLineSync();

      if (Validator.isString(id)&& Validator.isString(adress)) {
        ParkingSpace newParkingspace = ParkingSpace(parkingSpace.id,adress!);
        repository.update(allParkingspace[index].id, newParkingspace);
        print('Person updated');
      } else {
        print('Invalid input');
      }
    } else {
      print('Invalid input');
    }
  }

  static Future delete()async {
    print('Pick an index to delete: ');
    List<ParkingSpace> allParkingspace = await repository.getAll();
    for (int i = 0; i < allParkingspace.length; i++) {
      print('${i + 1}. ${allParkingspace[i].id}');
    }

    String? input = stdin.readLineSync();

    if (Validator.isIndex(input, allParkingspace)) {
      int index = int.parse(input!) - 1;
      repository.delete(allParkingspace[index].id);
      print('Person deleted');
    } else {
      print('Invalid input');
    }
  }
}