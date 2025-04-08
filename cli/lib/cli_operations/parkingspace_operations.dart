import 'dart:io';

import 'package:my_parkingapp_new/Repositories/ParkingSpaceRepository.dart';
import 'package:shared/shared.dart';
import 'package:my_parkingapp_new/utils/validator.dart';
import 'package:uuid/uuid.dart';

Parkingspacerepository repository =Parkingspacerepository();


class ParkingSpaceOperations {
  static Future create() async {
    print('Enter adress: ');


    var adress = stdin.readLineSync();
    if (Validator.isString(adress)) {
      ParkingSpace parkingSpace = ParkingSpace(id: Uuid().v4(), adress:  adress!);
      await repository.create(parkingSpace);
      print('ParkingSpace created');
    } else {
      print('Invalid input');
    }
  }

  static Future list() async  {
    List<ParkingSpace> allParkingspace = await repository.getAll();
    for (int i = 0; i < allParkingspace.length; i++) {
      print('${i + 1}. ${allParkingspace[i].adress} - ${allParkingspace[i].id}');
    }
  }

  static Future update()async {
    print('Pick an index to update: ');
    List<ParkingSpace> allParkingspace = await repository.getAll();
    for (int i = 0; i < allParkingspace.length; i++) {
      print('${i + 1}. ${allParkingspace[i].adress}');
    }

    String? input = stdin.readLineSync();

    if (Validator.isIndex(input, allParkingspace)) {
      int index = int.parse(input!) - 1;
      ParkingSpace parkingSpace = allParkingspace[index];

     
      print('Enter new adress: ');
      var adress = stdin.readLineSync();

      if (Validator.isString(adress)) {
        ParkingSpace newParkingspace = ParkingSpace(id:parkingSpace.id,adress:  adress!);
        await repository.update(allParkingspace[index], newParkingspace);
        print('ParkingSpace updated');
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
      print('${i + 1}. ${allParkingspace[i].id} -${allParkingspace[i].adress}');
    }

    String? input = stdin.readLineSync();

    if (Validator.isIndex(input, allParkingspace)) {
      int index = int.parse(input!) - 1;
      await repository.delete(allParkingspace[index].id);
      print('ParkingSapce deleted');
    } else {
      print('Invalid input');
    }
  }
}