import 'dart:io';

import 'package:my_parkingapp_new/cli_operations/parkingspace_operations.dart';
class ParkingspaceMenu {
  static Future prompt()async {  while (true) {
    print('\nParking Space Management');
    print('1. Create Parking Space');
    print('2. List Parking Spaces');
    print('3. Update Parking Space');
    print('4. Delete Parking Space');
    print('5. Exit');
    print('Enter your choice: ');

    String? choice = stdin.readLineSync();

    switch (choice) {
      case '1':
      await  ParkingSpaceOperations.create();
        break;
      case '2':
      await  ParkingSpaceOperations.list();
        break;
      case '3':
     await   ParkingSpaceOperations.update();
        break;
      case '4':
      await  ParkingSpaceOperations.delete();
        break;
      case '5':
        print('Exiting...');
        return;
      default:
        print('Invalid choice. Try again.');
    }
  }}
}




