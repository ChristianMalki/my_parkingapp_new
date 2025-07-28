part of 'vehicle_bloc.dart';





sealed class VehicleState extends Equatable{}

class VehicleInitial extends VehicleState {
  @override
  List<Object?> get props => [];
}

class VehicleLoading extends VehicleState {
  @override
  List<Object?> get props => [];
}

class VehicleLoaded extends VehicleState {
  final List<Vehicle> vehicles;

  final Vehicle? pending;

  VehicleLoaded({required this.vehicles, this.pending});

  @override
  List<Object?> get props => [vehicles,pending];
}

class VehicleError extends VehicleState {
  final String message;

  VehicleError({required this.message});

  @override
  List<Object?> get props => [message];
}