part of 'parkingspace_bloc.dart';





sealed class ParkingSpaceState extends Equatable{}

class ParkingSpaceInitial extends ParkingSpaceState {
  @override
  List<Object?> get props => [];
}

class ParkingSpaceLoading extends ParkingSpaceState {
  @override
  List<Object?> get props => [];
}

class ParkingSpaceLoaded extends ParkingSpaceState {
  final List<ParkingSpace> parkingSpace;

  final ParkingSpace? pending;

  ParkingSpaceLoaded({required this.parkingSpace, this.pending});

  @override
  List<Object?> get props => [parkingSpace,pending];
}

class ParkingSpaceError extends ParkingSpaceState {
  final String message;

  ParkingSpaceError({required this.message});

  @override
  List<Object?> get props => [message];
}