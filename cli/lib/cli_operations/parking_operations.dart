import 'dart:io';

import 'package:my_parkingapp_new/Repositories/ParkingRepository.dart';
import 'package:shared/shared.dart';
import 'package:my_parkingapp_new/utils/validator.dart';
import 'package:uuid/uuid.dart';

ParkingRepository repository = ParkingRepository();

class ParkingOperations {
  static Future create() async {
    print('Enter regnr: ');

    var regnr = stdin.readLineSync();

    print('Enter adress');

    var adress = stdin.readLineSync();

    if (Validator.isString(regnr) && Validator.isString(adress)) {
      Parking parking =
          Parking(regnr: regnr!, id: Uuid().v4(), adress: adress!);
      await repository.create(parking);
      print('Vehicle created');
    } else {
      print('Invalid input');
    }
  }

  static Future list() async {
    List<Parking> allParking = await repository.getAll();
    for (int i = 0; i < allParking.length; i++) {
      print('${i + 1}. ${allParking[i].regnr} - ${allParking[i].adress}');
    }
  }

  static Future update() async {
    print('Pick an index to update: ');
    List<Parking> allParking = await repository.getAll();
    for (int i = 0; i < allParking.length; i++) {
      print('${i + 1}. ${allParking[i].regnr}');
    }

    String? input = stdin.readLineSync();

    if (Validator.isIndex(input, allParking)) {
      int index = int.parse(input!) - 1;
      // ignore: unused_local_variable
      Parking parking = allParking[index];

      print('Enter new regnr: ');
      var regnr = stdin.readLineSync();
      print('Enter new adress: ');
      var adress = stdin.readLineSync();

      if (Validator.isString(regnr) && Validator.isString(adress)) {
        Parking newparking =
            Parking(regnr: regnr!, id: parking.id, adress: adress!);
        await repository.update(newparking);
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
    List<Parking> allParking = await repository.getAll();
    for (int i = 0; i < allParking.length; i++) {
      print('${i + 1}. ${allParking[i].regnr}');
    }

    String? input = stdin.readLineSync();

    if (Validator.isIndex(input, allParking)) {
      int index = int.parse(input!) - 1;
      await repository.delete(allParking[index].id);
      print('Vehicle deleted');
    } else {
      print('Invalid input');
    }
  }
}
