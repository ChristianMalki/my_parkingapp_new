part of 'parking_bloc.dart';



abstract class  ParkingEvent {}

class LoadParking extends ParkingEvent{}

class UpdateParking extends ParkingEvent {
  final Parking parking;

  UpdateParking({required this.parking});
}

class CreateParking extends ParkingEvent {
  final Parking parking;

  CreateParking({required this.parking});
}

class DeleteParking extends ParkingEvent {
  final Parking parking;

  DeleteParking({required this.parking});
}