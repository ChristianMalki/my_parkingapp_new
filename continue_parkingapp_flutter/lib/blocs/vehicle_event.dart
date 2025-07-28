part of 'vehicle_bloc.dart';



sealed class  VehicleEvent {}

class UpdateVehicle extends VehicleEvent {
  final Vehicle vehicle;

  UpdateVehicle({required this.vehicle});
}
class LoadVehicle extends VehicleEvent{

}

class CreateVehicle extends VehicleEvent {
  final Vehicle vehicle;

  CreateVehicle({required this.vehicle});
}

class DeleteVehicle extends VehicleEvent {
  final Vehicle vehicle;

  DeleteVehicle({required this.vehicle});
}

