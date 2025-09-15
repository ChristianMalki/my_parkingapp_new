
import 'package:continue_parkingapp_flutter/repositories/notifications_repository.dart';
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
        final now = DateTime.now();
        final parkings = await repository.getAll();
        emit (ParkingLoaded(parking: parkings));
        // Schedule notification 30 seconds in the future
        final deliveryTime2Min = now.add(const Duration(seconds: 120));
        print('deliveryTime $deliveryTime2Min');
        scheduleNotification(
          title: parking.adress,
          content: "newparking (30 seconds reminder)",
          startTime: now,
          endTime: deliveryTime2Min,
          id: parking.id.hashCode + 1,
        );
        case DeleteParking(parking: final parking):
        await repository.delete(parking.id, );
        final parkings = await repository.getAll();
        emit (ParkingLoaded(parking: parkings));


      }
    });
  }
}