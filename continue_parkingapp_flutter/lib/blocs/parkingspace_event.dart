part of 'parkingspace_bloc.dart';




sealed class  ParkingSpaceEvent {}

class LoadParking extends ParkingSpaceEvent{}

class UpdateParkingSpace extends ParkingSpaceEvent {
  final ParkingSpace parkingspace;

  UpdateParkingSpace({required this.parkingspace});
}

class CreateParkingSpace extends ParkingSpaceEvent {
  final ParkingSpace parkingSpace;

  CreateParkingSpace({required this.parkingSpace});
}

class DeleteParkingSpace extends ParkingSpaceEvent {
  final ParkingSpace parkingSpace;

  DeleteParkingSpace({required this.parkingSpace});
}