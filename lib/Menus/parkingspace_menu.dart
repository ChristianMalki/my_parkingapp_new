import 'dart:io';

import 'package:my_parkingapp_new/cli_operations/parkingspace_operations.dart';
class ParkingspaceMenu {
  static void prompt() {  while (true) {
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
        ParkingSpaceOperations.create();
        break;
      case '2':
        ParkingSpaceOperations.list();
        break;
      case '3':
        ParkingSpaceOperations.update();
        break;
      case '4':
        ParkingSpaceOperations.delete();
        break;
      case '5':
        print('Exiting...');
        return;
      default:
        print('Invalid choice. Try again.');
    }
  }}
}




