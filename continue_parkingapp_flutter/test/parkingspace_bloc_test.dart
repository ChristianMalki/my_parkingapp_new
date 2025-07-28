// Mock-klasser
import 'package:bloc_test/bloc_test.dart';
import 'package:continue_parkingapp_flutter/blocs/parkingspace_bloc.dart';
import 'package:continue_parkingapp_flutter/repositories/ParkingSpace_Repository.dart';
import 'package:continue_parkingapp_flutter/repositories/ParkingSpace_Repository.dart' as parkingSpaceRepository;
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:shared/shared.dart';

class MockParkingSpaceRepository extends Mock implements ParkingSpaceRepository {}

class FakeParkingSpace extends Fake implements ParkingSpace {}

void main() {
  group('ParkingSpaceBloc', () {
    late ParkingSpaceRepository parkingspaceRepository;

    setUp(() {
      parkingspaceRepository = MockParkingSpaceRepository();
    });

    setUpAll(() {
      registerFallbackValue(FakeParkingSpace());
    });

    group('create test', () {
      final newParkingSpace = ParkingSpace(  adress: 'Salagatan10', id: 'id');

      blocTest<ParkingSpaceBloc, ParkingSpaceState>(
        'should emit [ParkingSpaceLoaded] with new parkingspace when CreateParkingSpace is added',
        setUp: () {
          when(() => parkingSpaceRepository.create(any()))
              .thenAnswer((_) async => newParkingSpace);
               when(() => parkingSpaceRepository.getAll())
              .thenAnswer((_) async => [newParkingSpace]);
        },
        build: () => ParkingSpaceBloc(repository: parkingspaceRepository),
        seed: () => ParkingSpaceLoaded(parkingSpace: []),
        act: (bloc) => bloc.add(CreateParkingSpace(parkingSpace: newParkingSpace)),
        expect: () => [
          ParkingSpaceLoaded(parkingSpace: [newParkingSpace]),
        ],
        verify: (_) {
          verify(() => parkingSpaceRepository.create(newParkingSpace)).called(1);
        },
      );
    });
    group('update test', () {
      final newParkingSpace = ParkingSpace( id: 'id', adress: "Salagatan10");
      final existingParkingSpace = [
        ParkingSpace( id: "id",adress: "Helsingforsgatan1"),
      ];
      blocTest<ParkingSpaceBloc, ParkingSpaceState>(
        'should emit [ParkingSpaceLoaded] with new parkingspace when newParkingSpace is updated',
        setUp: () {
          when(() => parkingSpaceRepository.update(any(),any()))
              .thenAnswer((_) async => newParkingSpace);
               when(() => parkingSpaceRepository.getAll())
              .thenAnswer((_) async => [newParkingSpace]);
      
        },
        build: () => ParkingSpaceBloc(repository: parkingspaceRepository),
        seed: () => ParkingSpaceLoaded(parkingSpace: existingParkingSpace),
        act: (bloc) => bloc.add(UpdateParkingSpace(parkingspace: newParkingSpace)),
        expect: () => [
          ParkingSpaceLoaded(parkingSpace: [newParkingSpace]),
        ],
        verify: (_) {
          verify(() => parkingSpaceRepository.update(newParkingSpace.id, newParkingSpace)).called(1);
          verify(() => parkingSpaceRepository.getAll()).called(1);
        },
      );
    
      
      
      var buildBloc;
      blocTest<ParkingSpaceBloc, ParkingSpaceState>(
         'emits [ParkingSpaceError] when update fails',
         setUp: () {
          when(() => parkingSpaceRepository.update(any(), any()))
              .thenThrow(Exception('Failed to update parkingspace'));
        },
        build: buildBloc,
        seed: () => ParkingSpaceLoaded(parkingSpace: existingParkingSpace),
        act: (bloc) => bloc.add(UpdateParkingSpace(parkingspace: newParkingSpace)),
        expect: () => [
          ParkingSpaceLoaded(
              parkingSpace: [newParkingSpace, existingParkingSpace[1]], pending: newParkingSpace),
          ParkingSpaceError(message: 'Exception: Failed to update parkingspace'),
        ],
      );
    });
     group('delete test', () {
      final newParkingSpace = ParkingSpace( adress: 'Salagatan10', id: 'id');

      blocTest<ParkingSpaceBloc, ParkingSpaceState>(
        'should emit [ParkingSpaceLoaded] with new parkingspace when DeleteParkingSpace is removed',
        setUp: () {
          when(() => parkingSpaceRepository.delete(any()))
              .thenAnswer((_) async => newParkingSpace);
               when(() => parkingSpaceRepository.getAll())
              .thenAnswer((_) async => [newParkingSpace]);
        },
        build: () => ParkingSpaceBloc(repository: parkingspaceRepository),
        seed: () => ParkingSpaceLoaded(parkingSpace: []),
        act: (bloc) => bloc.add(DeleteParkingSpace(parkingSpace: newParkingSpace)),
        expect: () => [
          ParkingSpaceLoaded(parkingSpace: [newParkingSpace]),
        ],
        verify: (_) {
          verify(() => parkingSpaceRepository.delete(newParkingSpace.id)).called(1);
        },
      );
    });
  });
}