import 'package:flutter_test/flutter_test.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:continue_parkingapp_flutter/blocs/vehicle_bloc.dart';
import 'package:continue_parkingapp_flutter/repositories/Vehicle_Repository.dart';
import 'package:shared/shared.dart';

// Mocks
class MockVehicleRepository extends Mock implements VehicleRepository {}

class FakeVehicle extends Fake implements Vehicle {}

void main() {
  group('VehicleBloc', () {
    late VehicleRepository vehicleRepository;

    setUp(() {
      vehicleRepository = MockVehicleRepository();
    });

    setUpAll(() {
      registerFallbackValue(FakeVehicle());
    });

    group('create test', () {
      final newVehicle = Vehicle(regNr: 'DGF04K', id: 'id', model: 'Vovlo');

      blocTest<VehicleBloc, VehicleState>(
        'should emit [VehicleLoaded] with new vehicle when CreateVehicle is added',
        setUp: () {
          when(() => vehicleRepository.create(any()))
              .thenAnswer((_) async => newVehicle);
               when(() => vehicleRepository.getAll())
              .thenAnswer((_) async => [newVehicle]);
        },
        build: () => VehicleBloc(repository: vehicleRepository),
        seed: () => VehicleLoaded(vehicles: [newVehicle,]),
        act: (bloc) => bloc.add(CreateVehicle(vehicle: newVehicle)),
        expect: () => [
          VehicleLoaded(vehicles: [newVehicle]),
        ],
        verify: (_) {
          verify(() => vehicleRepository.create(newVehicle)).called(1);
        },
      );
    });
    group('update test', () {
      final newVehicle = Vehicle(regNr: 'BMJ05K', id: 'id', model: 'Mercedes');
      final existingVehicle = [
        Vehicle(regNr: "UJW013", id: "id", model: "Mercedes"),
      ];
      blocTest<VehicleBloc, VehicleState>(
        'should emit [VehicleLoaded] with new vehicle when UpdateVehicle is updated',
        setUp: () {
          when(() => vehicleRepository.update(any(),any()))
              .thenAnswer((_) async => newVehicle);
               when(() => vehicleRepository.getAll())
              .thenAnswer((_) async => [newVehicle]);
      
        },
        build: () => VehicleBloc(repository: vehicleRepository),
        seed: () => VehicleLoaded(vehicles: existingVehicle),
        act: (bloc) => bloc.add(UpdateVehicle(vehicle: newVehicle)),
        expect: () => [
          VehicleLoaded(vehicles: [newVehicle]),
        ],
        verify: (_) {
          verify(() => vehicleRepository.update(newVehicle.id, newVehicle)).called(1);
          verify(() => vehicleRepository.getAll()).called(1);
        },
      );
    
      
      
      var buildBloc;
      blocTest<VehicleBloc, VehicleState>(
         'emits [VehicleError] when update fails',
         setUp: () {
          when(() => vehicleRepository.update(any(), any()))
              .thenThrow(Exception('Failed to update vehicle'));
        },
        build: buildBloc,
        seed: () => VehicleLoaded(vehicles: existingVehicle),
        act: (bloc) => bloc.add(UpdateVehicle(vehicle: newVehicle)),
        expect: () => [
          VehicleLoaded(
              vehicles: [newVehicle, existingVehicle[1]], pending: newVehicle),
          VehicleError(message: 'Exception: Failed to update vehicle'),
        ],
      );
    });
     group('delete test', () {
      final newVehicle = Vehicle(regNr: 'DGF04K', id: 'id', model: 'Vovlo');

      blocTest<VehicleBloc, VehicleState>(
        'should emit [VehicleLoaded] with new vehicle when DeliteVehicle is removed',
        setUp: () {
          when(() => vehicleRepository.delete(any()))
              .thenAnswer((_) async => newVehicle);
               when(() => vehicleRepository.getAll())
              .thenAnswer((_) async => []);
        },
        build: () => VehicleBloc(repository: vehicleRepository),
        seed: () => VehicleLoaded(vehicles: [newVehicle]),
        act: (bloc) => bloc.add(DeleteVehicle(vehicle: newVehicle)),
        expect: () => [
          VehicleLoaded(vehicles: []),
        ],
        verify: (_) {
          verify(() => vehicleRepository.delete(newVehicle.id)).called(1);
        },
      );
    });
  });
}