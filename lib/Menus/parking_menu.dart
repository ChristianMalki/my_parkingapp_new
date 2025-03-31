import 'dart:io';

import 'package:my_parkingapp_new/cli_operations/parking_operations.dart';

class ParkingMenu {
  static Future prompt() async { while (true) {
    print('\nParking Management');
    print('1. Create Parking');
    print('2. List Parking');
    print('3. Update Parking');
    print('4. Delete Parking');
    print('5. Exit');
    print('Enter your choice: ');

    String? choice = stdin.readLineSync();

    switch (choice) {
      case '1':
      await  ParkingOperations.create();
        break;
      case '2':
        await ParkingOperations.list();
        break;
      case '3':
      await  ParkingOperations.update();
        break;
      case '4':
       await ParkingOperations.delete();
        break;
      case '5':
        print('Exiting...');
        return;
      default:
        print('Invalid choice. Try again.');
    }
  }}
}
