
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared/shared.dart';

import '../repositories/Parking_Repository.dart';



part 'parking_state.dart';
part 'parking_event.dart';

class ParkingBloc extends Bloc<ParkingEvent, ParkingState> {
  final ParkingRepository repository;

  ParkingBloc({required this.repository}): super(ParkingInitial()) {
    on<ParkingEvent>((event, emit) async{
      switch (event) {
        case LoadParking():
        emit(ParkingLoading());
        final parking = await repository.getAll();
        emit(ParkingLoaded(parking: parking));

        case UpdateParking(parking: final parking):
        await repository.update( parking);
        final parkings = await repository.getAll();
        emit (ParkingLoaded(parking: parkings));

        case CreateParking(parking: final parking):
        await repository.addParking( parking);
        final parkings = await repository.getAll();
        emit (ParkingLoaded(parking: parkings));

        case DeleteParking(parking: final parking):
        await repository.delete(parking.id, );
        final parkings = await repository.getAll();
        emit (ParkingLoaded(parking: parkings));


      }
    });
  }
}