
import 'package:continue_parkingapp_flutter/repositories/Vehicle_Repository.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared/shared.dart';

part 'vehicle_state.dart';
part 'vehicle_event.dart';

class VehicleBloc extends Bloc<VehicleEvent, VehicleState> {
  final VehicleRepository repository;

  VehicleBloc({required this.repository}): super(VehicleInitial()) {
    on<VehicleEvent>((event, emit) async{
      switch (event) {
        case LoadVehicle():
        emit(VehicleLoading());
        final vehicles = await repository.getAll();
        emit(VehicleLoaded(vehicles:vehicles));

        case UpdateVehicle(vehicle: final vehicle):
        await repository.update(vehicle );
        final vehicles = await repository.getAll();
        emit (VehicleLoaded(vehicles: vehicles));

        case CreateVehicle(vehicle: final vehicle):
        await repository.addVehicle(vehicle);
        final vehicles = await repository.getAll();
        emit (VehicleLoaded(vehicles: vehicles));

        case DeleteVehicle(vehicle: final vehicle):
        await repository.delete(vehicle.id);
        final vehicles = await repository.getAll();
        emit (VehicleLoaded(vehicles: vehicles));


      }
    });
  }
}