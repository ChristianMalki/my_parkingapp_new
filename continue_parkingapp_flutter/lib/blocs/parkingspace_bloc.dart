

import 'package:continue_parkingapp_flutter/repositories/ParkingSpace_Repository.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:shared/shared.dart';

part 'parkingspace_state.dart';
part 'parkingspace_event.dart';

class ParkingSpaceBloc extends Bloc<ParkingSpaceEvent, ParkingSpaceState> {
  final ParkingSpaceRepository repository;

  ParkingSpaceBloc({required this.repository}) : super(ParkingSpaceInitial()) {
  on<ParkingSpaceEvent>((event, emit) async {
    switch (event) {
      case LoadParkingSpace():
        emit(ParkingSpaceLoading());
        final parkingSpaces = await repository.getAll();
        emit(ParkingSpaceLoaded(parkingSpace: parkingSpaces));

      case UpdateParkingSpace(parkingspace: final parkingspace):
        await repository.update( parkingspace);
        final parkingSpaces = await repository.getAll();
        emit(ParkingSpaceLoaded(parkingSpace: parkingSpaces));

      case CreateParkingSpace(parkingSpace: final newParkingSpace):
        await repository.addParkingSpace(newParkingSpace);
        final parkingSpaces = await repository.getAll();
        emit(ParkingSpaceLoaded(parkingSpace: parkingSpaces));

      case DeleteParkingSpace(parkingSpace: final toDelete):
        await repository.delete(toDelete.id);
        final parkingSpaces = await repository.getAll();
        emit(ParkingSpaceLoaded(parkingSpace: parkingSpaces));
      case LoadParking():
        // TODO: Handle this case.
        throw UnimplementedError();
    }
  });
}


}

class LoadParkingSpace {
}