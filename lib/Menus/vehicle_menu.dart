
import 'package:my_parkingapp_new/cli_operations/vehicle_operations.dart';
import 'package:my_parkingapp_new/utils/console.dart';

class VehiclesMenu {
  static prompt() {
    clearConsole();
    while (true) {
      print('Vehicles Menu');
      print('1. Create Vehicle');
      print('2. List all Vehicles');
      print('3. Update Vehicle');
      print('4. Delete Vehicle');
      print('5. Back to Main Menu');

      var input = choice();

      switch (input) {
        case 1:
          print('Creating Vehicle');
          VehiclesOperations.create();
        case 2:
          print('Listing all Vehicles');
          VehiclesOperations.list();
        case 3:
          print('Updating Vehicle');
          VehiclesOperations.update();
        case 4:
          print('Deleting Vehicle');
          VehiclesOperations.delete();
        case 5:
          return;
        default:
          print('Invalid choice');
      }
      print("\n------------------------------------\n");
    }
  }


}