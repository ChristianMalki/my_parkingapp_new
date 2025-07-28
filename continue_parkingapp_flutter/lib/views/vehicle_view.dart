


import 'package:continue_parkingapp_flutter/blocs/vehicle_bloc.dart';
import 'package:continue_parkingapp_flutter/repositories/Vehicle_Repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:shared/shared.dart';
import 'package:uuid/uuid.dart';




class VehicleView extends StatefulWidget {
  const VehicleView({super.key});

  @override
  State<VehicleView> createState() => _VehicleViewState();
}

class _VehicleViewState extends State<VehicleView> {
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<VehicleBloc,VehicleState>(
      
        builder: (context, vehiclestate) {

          return switch (vehiclestate) {
            // TODO: Handle this case.
            VehicleInitial() =>  Center(child: CircularProgressIndicator()),
            // TODO: Handle this case.
            VehicleLoading() =>  Center(child: CircularProgressIndicator()),
            // TODO: Handle this case.
            VehicleLoaded(:final vehicles) =>  ListView.builder(
              itemCount: vehicles.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(vehicles[index].regNr),
                  subtitle: Text(vehicles[index].model),
                  trailing: IconButton(
                    onPressed: () async {
                    context.read<VehicleBloc>().add(DeleteVehicle(vehicle: vehicles[index]));
              
                    },
                    icon: Icon(Icons.delete),
                  ),
                );
              },
            ),
            // TODO: Handle this case.
            VehicleError() => Center(child: Text("Error: ${vehiclestate.message}")),
          };
      
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () async {
          Vehicle? created = await showDialog<Vehicle>(
            context: context,
            builder: (context) {
              String regnr = "";
               String model = "";

              return AlertDialog(
                title: Text('Create new vehicle'),
                content: Column(
                  children: [
                    TextField(
                      decoration: InputDecoration(labelText: 'Regnr'),
                      onChanged: (value) {
                        regnr = value;
                      },
                    ), TextField(
                      decoration: InputDecoration(labelText: 'model'),
                      onChanged: (value) {
                        model = value;
                      },
                    ),
                  ],
                ),
                actions: [
                  TextButton(
                    onPressed: () => Navigator.pop(context),

                    child: Text('Cancel'),
                  ),

                  TextButton(
                    onPressed: () {
                      Navigator.pop(context, Vehicle(regNr: regnr, model: model, id: Uuid().v4()));
                    },

                    child: Text('Create'),
                  ),
                ],
              );
            },
          );
          if (created != null) {
            
            // dispatch create item event
            context.read<VehicleBloc>().add(CreateVehicle(vehicle:created));
             
        };      
        }));
  }
  }
