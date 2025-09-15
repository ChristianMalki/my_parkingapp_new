


import 'package:my_parkingapp_new/Menus/parking_menu.dart';
import 'package:my_parkingapp_new/Menus/parkingspace_menu.dart';
import 'package:my_parkingapp_new/Menus/person_menu.dart';
import 'package:my_parkingapp_new/Menus/vehicle_menu.dart';

import 'package:my_parkingapp_new/utils/console.dart';

class MainMenu {
  static Future prompt() async {
    clearConsole();

    while (true) {
      // clear the console

      // prompt options to edit vehicle, regnr, or exit
      print('Main Menu');
      print('1. Manage ParkingSpace');
      print('2. Manage Parking');
      print('3. Manage Person');
      print('4. Manage Vehicle');
      print('5. Exit');
      var input = choice();
      switch (input) {
        case 1:
       await  ParkingspaceMenu.prompt();
        case 2:
       await ParkingMenu.prompt();
        case 3:
     await  PersonMenu.prompt();
        case 4:
       await VehiclesMenu.prompt();
        case 5:
        exit();
          return;
        default:
          print('Invalid choice');
      }
      print("\n------------------------------------\n");
    }
  }

}

class exit {
}

