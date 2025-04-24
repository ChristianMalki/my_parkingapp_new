import 'dart:io';

import 'package:my_server/handlers/parking_handlers.dart';
import 'package:my_server/handlers/parkingspace_handlers.dart';
import 'package:my_server/handlers/person_handlers.dart';
import 'package:my_server/handlers/vehicle_handlers.dart';
import 'package:shelf/shelf.dart';
import 'package:shelf/shelf_io.dart';
import 'package:shelf_router/shelf_router.dart';

void main(List<String> args) async {
  // Use any available host or container IP (usually `0.0.0.0`).
  final ip = InternetAddress.anyIPv4;

  Router router = Router();


  router.post('/parkings', postParkingHandler); // create a bag
  router.get('/parkings', getParkingsHandler); // get all bags
  router.get('/parkings/<id>', getParkingHandler); // get specific bag
  router.put('/parkings/<id>', updateParkingHandler); // update specific bag
  router.delete('/parkings/<id>', deleteParkingHandler); // update specific item

  router.post('/parkingspace', postParkingSpaceHandler); // create a bag
  router.get('/parkingspace', getParkingSpacesHandler); // get all ParkingSpaces
  router.get('/parkingspace/<id>', getParkingSpaceHandler); // get specific bag
  router.put('/parkingspace/<id>', updateParkingSpaceHandler); // update specific bag
  router.delete('/parkingspace/<id>', deleteParkingSpaceHandler); // update specific item

  router.post('/persons', postPersonHandler); // create a bag
  router.get('/persons', getPersonsHandler); // get all persons
  router.get('/persons/<id>', getPersonHandler); // get specific bag
  router.put('/persons/<id>', updatePersonHandler); // update specific bag
  router.delete('/persons/<id>', deletePersonHandler); // update specific item

  router.post('/vehicle', postVehicleHandler); // create a bag
  router.get('/vehicle', getVehiclesHandler); // get all vehicles
  router.get('/vehicle/<id>', getVehicleHandler); // get specific bag
  router.put('/vehicle/<id>', updateVehicleHandler); // update specific bag
  router.delete('/vehicle/<id>', deleteVehicleHandler); // update specific item

  // Configure a pipeline that logs requests.
  final handler =
      Pipeline().addMiddleware(logRequests()).addHandler(router.call);

  // For running in containers, we respect the PORT environment variable.
  final port = int.parse(Platform.environment['PORT'] ?? '8080');
  final server = await serve(handler, ip, port);
  print('Server listening on port ${server.port}');

  // sigint handler

  ProcessSignal.sigint.watch().listen((ProcessSignal signal) {
    print('clean shutdown');
    server.close(force: true);
    exit(0);
  });
}
