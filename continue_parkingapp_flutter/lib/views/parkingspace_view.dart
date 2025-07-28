import 'package:continue_parkingapp_flutter/blocs/parkingspace_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared/shared.dart';
import 'package:uuid/uuid.dart';

class ParkingSpaceView extends StatefulWidget {
  const ParkingSpaceView({super.key});

  @override
  State<ParkingSpaceView> createState() => _ParkingSpaceViewState();
}

class _ParkingSpaceViewState extends State<ParkingSpaceView> {
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<ParkingSpaceBloc,ParkingSpaceState>(
      
        builder: (context, parkingspacestate) {

          return switch (parkingspacestate) {
            // TODO: Handle this case.
            ParkingSpaceInitial() =>  Center(child: CircularProgressIndicator()),
            // TODO: Handle this case.
            ParkingSpaceLoading() =>  Center(child: CircularProgressIndicator()),
            // TODO: Handle this case.
            ParkingSpaceLoaded(:final parkingSpace) =>  ListView.builder(
              itemCount: parkingSpace.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(parkingSpace[index].id),
                  subtitle: Text(parkingSpace[index].adress),
                  trailing: IconButton(
                    onPressed: () async {
                    context.read<ParkingSpaceBloc>().add(DeleteParkingSpace(parkingSpace: parkingSpace[index]));
              
                    },
                    icon: Icon(Icons.delete),
                  ),
                );
              },
            ),
            // TODO: Handle this case.
            ParkingSpaceError() => Center(child: Text("Error: ${parkingspacestate.message}")),
          };
      
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () async {
          ParkingSpace? created = await showDialog<ParkingSpace>(
            context: context,
            builder: (context) {
              String id = "";
               String adress = "";

              return AlertDialog(
                title: Text('Create new parkingspace'),
                content: Column(
                  children: [
                    TextField(
                      decoration: InputDecoration(labelText: 'id'),
                      onChanged: (value) {
                        id = value;
                      },
                    ), TextField(
                      decoration: InputDecoration(labelText: 'adress'),
                      onChanged: (value) {
                        adress = value;
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
                   Navigator.pop(context, ParkingSpace( adress: adress, id:  Uuid().v4()));

                    },

                    child: Text('Create'),
                  ),
                ],
              );
            },
          );
          if (created != null) {
            
            // dispatch create item event
            context.read<ParkingSpaceBloc>().add(CreateParkingSpace(parkingSpace:created));
             
        };      
        }));
  }
  }