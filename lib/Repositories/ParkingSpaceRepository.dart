import 'package:my_parkingapp_new/cli_operations/parkingspace_operations.dart';

class Parkingspacerepository {
  List<ParkingSpace> _ParkingSpace = [];
  
  get id => null;

  void add(ParkingSpace parkingSpace) {
    _ParkingSpace.add(parkingSpace);
  }
  Future<List<ParkingSpace>> getAll()async {
    return _ParkingSpace;
  }
 Future<ParkingSpace?> getById(int id)async {
    return _ParkingSpace.cast<ParkingSpace?>().firstWhere((space) => space?.id == id, orElse: () => null);
  }
  void update (ParkingSpace parkingSpace, ParkingSpace newParkingspace) {
    int index = _ParkingSpace.indexWhere((space) => space.id == parkingSpace.id);
    if (index != -1) {
      _ParkingSpace[index] = parkingSpace;
    }
  }
  void delete(int id) {
    _ParkingSpace.removeWhere((space) => space.id == id);
  }

  void create(ParkingSpace parkingSpace) {}
}

class ParkingSpace {
  ParkingSpace(id, String s);

  get id => null;
}






