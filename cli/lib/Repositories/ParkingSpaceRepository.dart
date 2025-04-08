import 'package:shared/shared.dart';

class Parkingspacerepository {
  List<ParkingSpace> _ParkingSpace = [];
  
  get id => null;

  Future add(ParkingSpace parkingSpace)async {
    _ParkingSpace.add(parkingSpace);
  }
  Future<List<ParkingSpace>> getAll()async {
    return _ParkingSpace;
  }
 Future<ParkingSpace?> getById(int id)async {
    return _ParkingSpace.cast<ParkingSpace?>().firstWhere((space) => space?.id == id, orElse: () => null);
  }
  Future update (ParkingSpace parkingSpace, ParkingSpace newParkingspace) async{
    int index = _ParkingSpace.indexWhere((space) => space.id == parkingSpace.id);
    if (index != -1) {
      _ParkingSpace[index] = newParkingspace;
    }
  }
  Future delete(String id) async{
    _ParkingSpace.removeWhere((space) => space.id == id);
  }

  Future create(ParkingSpace parkingSpace)async {
    _ParkingSpace.add(parkingSpace);
  }
}






