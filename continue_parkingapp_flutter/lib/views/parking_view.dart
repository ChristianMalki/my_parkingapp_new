
import 'dart:ffi';


import 'package:continue_parkingapp_flutter/repositories/Parking_Repository.dart';
import 'package:continue_parkingapp_flutter/repositories/Vehicle_Repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:shared/shared.dart';
import 'package:uuid/uuid.dart';




class ParkingView extends StatefulWidget {
  const ParkingView({super.key});

  @override
  State<ParkingView> createState() => _ParkingViewState();
}

class _ParkingViewState extends State<ParkingView> {
  Future future = ParkingRepository().getAll();

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
                  subtitle: Text(snapshot.data![index].regnr),
                  trailing: IconButton(
                    onPressed: () async {
                      await ParkingRepository().delete(snapshot.data![index].id);
                      setState(() {
                        future = ParkingRepository().getAll();
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
          Parking? created = await showDialog<Parking>(
            context: context,
            builder: (context) {
              String regnr = "";
               String adress = "";

              return AlertDialog(
                title: Text('Create new Parking'),
                content: Column(
                  children: [
                    TextField(
                      decoration: InputDecoration(labelText: 'Regnr'),
                      onChanged: (value) {
                        regnr = value;
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
                      Navigator.pop(context, Parking(regnr: regnr,adress: adress,  id: Uuid().v4()));
                    },

                    child: Text('Create'),
                  ),
                ],
              );
            },
          );
          if (created != null) {
            // dispatch create item event
            await ParkingRepository().create(created);
            setState(() {
              future = ParkingRepository().getAll();
            });
          }
        },
        child: Icon(Icons.add),
      ),
    );
  }
}