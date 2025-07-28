part of 'parking_bloc.dart';





sealed class ParkingState extends Equatable{}

class ParkingInitial extends ParkingState {
  @override
  List<Object?> get props => [];
}

class ParkingLoading extends ParkingState {
  @override
  List<Object?> get props => [];
}

class ParkingLoaded extends ParkingState {
  final List<Parking> parking;

  final Parking? pending;

  ParkingLoaded({required this.parking, this.pending});

  @override
  List<Object?> get props => [parking,pending];
}

class ParkingError extends ParkingState {
  final String message;

  ParkingError({required this.message});

  @override
  List<Object?> get props => [message];
}