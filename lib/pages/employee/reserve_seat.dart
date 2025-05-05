import 'package:ace_express_reservation_system/factory/db_connection.dart';
import 'package:ace_express_reservation_system/presets/presets.dart';
import 'package:flutter/material.dart';
import 'package:mysql_client/mysql_client.dart';

class ReserveSeat extends StatefulWidget {
  const ReserveSeat({super.key});

  @override
  State<ReserveSeat> createState() => _ReserveSeatState();
}

class _ReserveSeatState extends State<ReserveSeat> {
  String selectedBusValue = '';
  ResultSetRow? routeInfo;
  int selectedSeat = 0;
  List<int> seats = [];

  bool once = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Reserve Seat",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.blue,
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton(
              style: ButtonStyle(
                backgroundColor: WidgetStateProperty.all(Colors.deepPurple),
              ),
              onPressed: select,
              child: const Text(
                'Select',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
        ],
      ),
      body: FutureBuilder(
        future: DbConnection.dbPort.execute("SELECT * FROM bus_schedule;"),
        builder: (context, snapshot) {
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

          return FutureBuilder(
              future:
                  DbConnection.dbPort.execute("SELECT * FROM reserved_seats;"),
              builder: (context, snapshotBusSchedule) {
                if (snapshotBusSchedule.connectionState ==
                    ConnectionState.done) {
                  if (!snapshotBusSchedule.hasData) {
                    return const Center(
                      child: Text("No data found"),
                    );
                  }
                } else if (snapshotBusSchedule.connectionState ==
                    ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }

                if (snapshotBusSchedule.data!.rows.any(
                      (element) {
                        return element.assoc()['employee_id'] ==
                            userInfo['employee_number'];
                      },
                    ) &&
                    once == false) {
                  selectedBusValue = snapshotBusSchedule.data!.rows.first
                      .assoc()['bus_number']!;

                  selectedSeat = int.parse(
                    snapshotBusSchedule.data!.rows.firstWhere(
                      (element) {
                        return element.assoc()['employee_id'] ==
                            userInfo['employee_number'];
                      },
                    ).assoc()['seat_number']!,
                  );

                  seats.clear();

                  for (int i = 1; i <= 40; i++) {
                    seats.add(i);
                  }

                  for (ResultSetRow element in snapshotBusSchedule.data!.rows) {
                    if (element.assoc()['bus_number'] == selectedBusValue) {
                      if (int.parse(element.assoc()['seat_number']!) !=
                          selectedSeat) {
                        seats
                            .remove(int.parse(element.assoc()['seat_number']!));
                      }
                    }
                  }

                  routeInfo = snapshot.data!.rows.firstWhere(
                    (element) {
                      return element.assoc()['bus_number'] == selectedBusValue;
                    },
                  );

                  once = true;
                }

                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Row(
                          children: [
                            const Text(
                              "Reserve Bus: ",
                              style: TextStyle(fontSize: 20),
                            ),
                            Expanded(
                              child: DropdownButton<String>(
                                value: selectedBusValue.isEmpty
                                    ? null
                                    : selectedBusValue,
                                isExpanded: true,
                                iconSize: 26,
                                elevation: 20,
                                style:
                                    const TextStyle(color: Colors.deepPurple),
                                onChanged: (String? newValue) async {
                                  setState(() => selectedBusValue = newValue!);
                                  routeInfo = await busRoute(newValue!);
                                  availableSeats(newValue);
                                  selectedSeat = 0;
                                },
                                items: snapshot.data!.rows
                                    .map<DropdownMenuItem<String>>(
                                        (ResultSetRow value) {
                                  return DropdownMenuItem<String>(
                                    value: value.assoc()['bus_number'],
                                    child: Text(
                                      value.assoc()['bus_number']!,
                                      style: const TextStyle(fontSize: 18),
                                    ),
                                  );
                                }).toList(),
                              ),
                            ),
                          ],
                        ),
                        Text(
                          'Bus Route: ${selectedBusValue.isNotEmpty ? routeInfo!.assoc()['route'] : ''}',
                          style: const TextStyle(
                            fontSize: 20,
                          ),
                        ),
                        Text(
                          'Departure Time: ${selectedBusValue.isNotEmpty ? routeInfo!.assoc()['departure_time'] : ''}',
                          style: const TextStyle(
                            fontSize: 20,
                          ),
                        ),
                        Text(
                          'Arrival Time: ${selectedBusValue.isNotEmpty ? routeInfo!.assoc()['arrival_time'] : ''}',
                          style: const TextStyle(
                            fontSize: 20,
                          ),
                        ),
                        Text(
                          'Driver: ${selectedBusValue.isNotEmpty ? routeInfo!.assoc()['driver_name'] : ''}',
                          style: const TextStyle(
                            fontSize: 20,
                          ),
                        ),
                        Row(
                          children: [
                            const Text(
                              "Reserve Seat: ",
                              style: TextStyle(fontSize: 20),
                            ),
                            Expanded(
                              child: DropdownButton<int>(
                                value: selectedSeat == 0 ? null : selectedSeat,
                                isExpanded: true,
                                iconSize: 26,
                                elevation: 20,
                                style:
                                    const TextStyle(color: Colors.deepPurple),
                                onChanged: (int? newValue) async {
                                  setState(() => selectedSeat = newValue!);
                                },
                                items: seats
                                    .map<DropdownMenuItem<int>>((int value) {
                                  return DropdownMenuItem<int>(
                                    value: value,
                                    child: Text(
                                      value.toString(),
                                      style: const TextStyle(fontSize: 18),
                                    ),
                                  );
                                }).toList(),
                              ),
                            ),
                          ],
                        ),
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
                                    DataCell(
                                        Text(row.assoc()['departure_time']!)),
                                    DataCell(
                                        Text(row.assoc()['arrival_time']!)),
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
        },
      ),
    );
  }

  void select() async {
    if (selectedBusValue.isNotEmpty && selectedSeat != 0) {
      final scuccessfulSnackBar = ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Successfully selected seat')),
      );

      var busRoute = await DbConnection.dbPort.execute(
          "SELECT * FROM reserved_seats where employee_id = '${userInfo['employee_number']}';");

      if (busRoute.rows.isEmpty) {
        await DbConnection.dbPort.execute(
            "INSERT INTO reserved_seats(employee_id ,bus_number, seat_number) VALUES('${userInfo['employee_number']}', '$selectedBusValue', $selectedSeat);");
      } else {
        await DbConnection.dbPort.execute(
            "UPDATE reserved_seats SET seat_number = $selectedSeat, bus_number = '$selectedBusValue' WHERE employee_id = '${userInfo['employee_number']}';");
      }

      await scuccessfulSnackBar.closed;
      if (!mounted) return;
      Navigator.pop(context);
    } else {
      final failedSnackBar = ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content: Text('Please select bus route and seat number')),
      );
      await failedSnackBar.closed;
      if (!mounted) return;
    }
  }

  Future<ResultSetRow> busRoute(String busNumber) async {
    var busRoute = await DbConnection.dbPort
        .execute("SELECT * FROM bus_schedule where bus_number = '$busNumber';");

    return busRoute.rows.first;
  }

  void availableSeats(String busNumber) async {
    var availableSeats = await DbConnection.dbPort.execute(
        "SELECT * FROM reserved_seats where bus_number = '$busNumber';");

    seats.clear();

    for (int i = 1; i <= 40; i++) {
      seats.add(i);
    }

    if (availableSeats.rows.isNotEmpty) {
      for (ResultSetRow element in availableSeats.rows) {
        if (seats.contains(int.parse(element.assoc()['seat_number']!))) {
          seats.remove(int.parse(element.assoc()['seat_number']!));
        }
      }
    }
  }
}
