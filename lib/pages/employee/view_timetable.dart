import 'package:ace_express_reservation_system/factory/db_connection.dart';
import 'package:flutter/material.dart';
import 'package:mysql_client/mysql_client.dart';

class ViewTimetable extends StatefulWidget {
  const ViewTimetable({super.key});

  @override
  State<ViewTimetable> createState() => _ViewTimetableState();
}

class _ViewTimetableState extends State<ViewTimetable> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: DbConnection.dbPort.execute("SELECT * FROM bus_schedule;"),
        builder: (BuildContext context, AsyncSnapshot<IResultSet> snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (!snapshot.hasData) {
              return const Center(
                child: Text("No data found"),
              );
            }
          } else if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          return Scaffold(
            appBar: AppBar(
              title: const Text(
                "View Timetable",
                style: TextStyle(color: Colors.white),
              ),
              backgroundColor: Colors.blue,
            ),
            body: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  DataTable(
                    columns: const <DataColumn>[
                      DataColumn(
                        label: Text("Bus Number"),
                      ),
                      DataColumn(
                        label: Text("Route"),
                      ),
                      DataColumn(
                        label: Text("Departure Time"),
                      ),
                      DataColumn(
                        label: Text("Arrival Time"),
                      ),
                      DataColumn(
                        label: Text("Driver Name"),
                      ),
                    ],
                    rows: snapshot.data!.rows
                        .map(
                          (row) => DataRow(
                            cells: <DataCell>[
                              DataCell(Text(row.assoc()['bus_number']!)),
                              DataCell(Text(row.assoc()['route']!)),
                              DataCell(Text(row.assoc()['departure_time']!)),
                              DataCell(Text(row.assoc()['arrival_time']!)),
                              DataCell(Text(row.assoc()['driver_name']!)),
                            ],
                          ),
                        )
                        .toList(),
                  ),
                ],
              ),
            ),
          );
        });
  }
}
