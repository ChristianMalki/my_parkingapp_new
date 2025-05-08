import 'dart:ffi';


import 'package:continue_parkingapp_flutter/repositories/Vehicle_Repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:shared/shared.dart';
import 'package:uuid/uuid.dart';




class VehicleView extends StatefulWidget {
  const VehicleView({super.key});

  @override
  State<VehicleView> createState() => _VehicleViewState();
}

class _VehicleViewState extends State<VehicleView> {
  Future future = VehicleRepository().getAll();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: future,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(snapshot.data![index].id),
                  subtitle: Text(snapshot.data![index].regNr),
                  trailing: IconButton(
                    onPressed: () async {
                      await VehicleRepository().delete(snapshot.data![index].id);
                      setState(() {
                        future = VehicleRepository().getAll();
                      });
                    },
                    icon: Icon(Icons.delete),
                  ),
                );
              },
            );
          } else if (snapshot.hasError) {
            return Center(child: Text("Error: ${snapshot.error}"));
          } else {
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
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
            await VehicleRepository().create(created);
            setState(() {
              future = VehicleRepository().getAll();
            });
          }
        },
        child: Icon(Icons.add),
      ),
    );
  }
}