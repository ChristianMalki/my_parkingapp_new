import 'package:bloc_test/bloc_test.dart';
import 'package:continue_parkingapp_flutter/blocs/parking_bloc.dart';
import 'package:continue_parkingapp_flutter/repositories/Parking_Repository.dart';


import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:shared/shared.dart';

// Mock-klasser
class MockParkingRepository extends Mock implements ParkingRepository {}

class FakeParking extends Fake implements Parking {}

void main() {
  group('ParkingBloc', () {
    late ParkingRepository parkingRepository;

    setUp(() {
      parkingRepository = MockParkingRepository();
    });

    setUpAll(() {
      registerFallbackValue(FakeParking());
    });

    group('create test', () {
      final newParking = Parking( regnr: 'ABC123', adress: 'Salagatan10', id: 'id');

      blocTest<ParkingBloc, ParkingState>(
        'should emit [ParkingLoaded] with new parking when CreateParking is added',
        setUp: () {
          when(() => parkingRepository.addParking(any()))
              .thenAnswer((_) async => newParking);
               when(() => parkingRepository.getAll())
              .thenAnswer((_) async => [newParking]);
        },
        build: () => ParkingBloc(repository: parkingRepository),
        seed: () => ParkingLoaded(parking: []),
        act: (bloc) => bloc.add(CreateParking(parking: newParking)),
        expect: () => [
          ParkingLoaded(parking: [newParking]),
        ],
        verify: (_) {
          verify(() => parkingRepository.addParking(newParking)).called(1);
        },
      );
    });
    group('update test', () {
      final newParking = Parking(regnr: 'BMJ05K', id: 'id', adress: "Salagatan10");
      final existingParking = [
        Parking(regnr: "UJW013", id: "id",adress: "Helsingforsgatan1"),
      ];
      blocTest<ParkingBloc, ParkingState>(
        'should emit [ParkingLoaded] with new parking when newParking is updated',
        setUp: () {
          when(() => parkingRepository.update(any()))
              .thenAnswer((_) async => newParking);
               when(() => parkingRepository.getAll())
              .thenAnswer((_) async => [newParking]);
      
        },
        build: () => ParkingBloc(repository: parkingRepository),
        seed: () => ParkingLoaded(parking: existingParking),
        act: (bloc) => bloc.add(UpdateParking(parking: newParking)),
        expect: () => [
          ParkingLoaded(parking: [newParking]),
        ],
        verify: (_) {
          verify(() => parkingRepository.update( newParking)).called(1);
          verify(() => parkingRepository.getAll()).called(1);
        },
      );
    
      
      
      var buildBloc;
      blocTest<ParkingBloc, ParkingState>(
         'emits [ParkingError] when update fails',
         setUp: () {
          when(() => parkingRepository.update(any()))
              .thenThrow(Exception('Failed to update parking'));
        },
        build: buildBloc,
        seed: () => ParkingLoaded(parking: existingParking),
        act: (bloc) => bloc.add(UpdateParking(parking: newParking)),
        expect: () => [
          ParkingLoaded(
              parking: [newParking, existingParking[1]], pending: newParking),
          ParkingError(message: 'Exception: Failed to update parking'),
        ],
      );
    });
     group('delete test', () {
      final newParking = Parking( regnr: 'ABC123', adress: 'Salagatan10', id: 'id');

      blocTest<ParkingBloc, ParkingState>(
        'should emit [ParkingLoaded] with new parking when DeleteParking is removed',
        setUp: () {
          when(() => parkingRepository.delete(any()))
              .thenAnswer((_) async => newParking);
               when(() => parkingRepository.getAll())
              .thenAnswer((_) async => [newParking]);
        },
        build: () => ParkingBloc(repository: parkingRepository),
        seed: () => ParkingLoaded(parking: []),
        act: (bloc) => bloc.add(DeleteParking(parking: newParking)),
        expect: () => [
          ParkingLoaded(parking: [newParking]),
        ],
        verify: (_) {
          verify(() => parkingRepository.delete(newParking.id)).called(1);
        },
      );
    });
  });
}