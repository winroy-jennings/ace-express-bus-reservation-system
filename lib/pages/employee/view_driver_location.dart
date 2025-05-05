import 'package:ace_express_reservation_system/factory/db_connection.dart';
import 'package:ace_express_reservation_system/presets/presets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

class ViewDriverLocation extends StatefulWidget {
  const ViewDriverLocation({super.key});

  @override
  State<ViewDriverLocation> createState() => _ViewDriverLocationState();
}

class _ViewDriverLocationState extends State<ViewDriverLocation> {
  String busNumber = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Driver Location',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.blue,
      ),
      body: FutureBuilder(
          future: DbConnection.dbPort.execute("SELECT * FROM reserved_seats;"),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              if (!snapshot.hasData) {
                return const Center(
                  child: Text("Select bus schedule first"),
                );
              }
            } else if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }

            var result = snapshot.data!.rows.where((element) =>
                element.assoc()['employee_id'] == userInfo['employee_number']);

            if (result.isEmpty) {
              return const Center(
                child: Text("Select Bus Schedule First"),
              );
            }

            busNumber = result.first.assoc()['bus_number']!;

            return FutureBuilder(
                future: DbConnection.dbPort.execute(
                    "SELECT * FROM bus_schedule where bus_number = '$busNumber';"),
                builder: (context, snapshotBusSchedule) {
                  if (snapshotBusSchedule.connectionState ==
                      ConnectionState.done) {
                    if (!snapshotBusSchedule.hasData) {
                      return const Center(
                        child: Text("Select bus schedule first"),
                      );
                    }
                  } else if (snapshotBusSchedule.connectionState ==
                      ConnectionState.waiting) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }

                  return Column(
                    children: [
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.74,
                        // height: 300,
                        width: double.infinity,
                        child: FlutterMap(
                          options: const MapOptions(
                            initialCenter:
                                // LatLng(51.509364, -0.128928), // Center the map over London
                                LatLng(18.01653057691507,
                                    -76.74360940083913), // Center the map over London
                            initialZoom: 17.0,
                          ),
                          children: [
                            TileLayer(
                              // Display map tiles from any source
                              urlTemplate:
                                  'https://tile.openstreetmap.org/{z}/{x}/{y}.png', // OSMF's Tile Server
                            ),
                          ],
                        ),
                      ),
                      Card(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text('Bus Number: $busNumber'),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                        'Driver: ${snapshotBusSchedule.data!.rows.first.assoc()['driver_name']!}'),
                                  ),
                                ],
                              ),
                              const Divider(),
                              Text(
                                  "Driver in route. ${snapshotBusSchedule.data!.rows.first.assoc()['driver_name']!} will arrive shortly.\nApproximate time: 3 minutes."),
                            ],
                          ),
                        ),
                      ),
                    ],
                  );
                });
          }),
    );
  }
}
