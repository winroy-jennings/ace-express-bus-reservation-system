import 'dart:math';

import 'package:ace_express_reservation_system/factory/db_connection.dart';
import 'package:ace_express_reservation_system/presets/presets.dart';
import 'package:flutter/material.dart';
import 'package:pretty_qr_code/pretty_qr_code.dart';

class ViewQRCodeTicket extends StatefulWidget {
  const ViewQRCodeTicket({super.key});

  @override
  State<ViewQRCodeTicket> createState() => _ViewQRCodeTicketState();
}

class _ViewQRCodeTicketState extends State<ViewQRCodeTicket> {
  double qrCodeSize = 250;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "View QR Code Ticket",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.blue,
      ),
      body: FutureBuilder(
          future: DbConnection.dbPort.execute(
              "SELECT * FROM reserved_seats where employee_id = '${userInfo['employee_number']}';"),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              if (snapshot.data!.rows.isEmpty) {
                return const Center(
                  child: Text("Select bus schedule first"),
                );
              }
            } else if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }

            return FutureBuilder(
                future: DbConnection.dbPort.execute(
                    "SELECT * FROM bus_schedule where bus_number = '${snapshot.data!.rows.first.assoc()['bus_number']}';"),
                builder: (context, snapshotBusSchedule) {
                  if (snapshotBusSchedule.connectionState ==
                      ConnectionState.done) {
                    if (snapshotBusSchedule.data!.rows.isEmpty) {
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

                  return Center(
                    child: Container(
                      height: 300,
                      width: 800,
                      color: Colors.blue,
                      child: Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Row(
                          children: [
                            Expanded(
                              flex: 2,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(16),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        const Text(
                                          'ACE Express Reservation',
                                          style: TextStyle(
                                            fontSize: 22,
                                          ),
                                        ),
                                        const Divider(),
                                        Text(
                                          '${DateTime.now().day.toString()} ${_intToMonthName(DateTime.now().month)}, ${DateTime.now().year.toString()} ${snapshotBusSchedule.data!.rows.first.assoc()['departure_time']} | ${DateTime.now().day.toString()} ${_intToMonthName(DateTime.now().month)}, ${DateTime.now().year.toString()} ${snapshotBusSchedule.data!.rows.first.assoc()['arrival_time']}',
                                          style: const TextStyle(
                                            fontSize: 20,
                                          ),
                                        ),
                                        const Text(
                                          'The Awesome Company',
                                          style: TextStyle(
                                            fontSize: 20,
                                          ),
                                        ),
                                        Text(
                                          'Bus: ${snapshot.data!.rows.first.assoc()['bus_number']}',
                                          style: const TextStyle(
                                            fontSize: 20,
                                          ),
                                        ),
                                        Text(
                                          'Seat: ${_zeroPad(int.parse(snapshot.data!.rows.first.assoc()['seat_number']!))}',
                                          style: const TextStyle(
                                            fontSize: 20,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(16),
                                  ),
                                  child: Column(
                                    children: [
                                      const Padding(
                                        padding: EdgeInsets.all(8.0),
                                        child: Text(
                                          'Admit One',
                                          style: TextStyle(
                                            fontSize: 22,
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 120,
                                        child: PrettyQrView.data(
                                          data:
                                              'ACE Express Reservation QR Code Ticket',
                                          decoration: const PrettyQrDecoration(
                                            shape: PrettyQrSmoothSymbol(
                                              roundFactor: 0.0,
                                            ),
                                          ),
                                        ),
                                      ),
                                      const Padding(
                                        padding: EdgeInsets.all(5.0),
                                        child: Text(
                                          'Ticket Code',
                                          style: TextStyle(
                                            fontSize: 22,
                                          ),
                                        ),
                                      ),
                                      Text(
                                        '${Random().nextInt(1000000)}',
                                        style: const TextStyle(
                                          fontSize: 22,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                });
          }),
    );
  }

  String _intToMonthName(int monthNumber) {
    switch (monthNumber) {
      case 1:
        return 'Jan';
      case 2:
        return 'Feb';
      case 3:
        return 'Mar';
      case 4:
        return 'Apr';
      case 5:
        return 'May';
      case 6:
        return 'Jun';
      case 7:
        return 'Jul';
      case 8:
        return 'Aug';
      case 9:
        return 'Sep';
      case 10:
        return 'Oct';
      case 11:
        return 'Nov';
      case 12:
        return 'Dec';
      default:
        return '';
    }
  }

  String _zeroPad(int number) {
    if (number < 10) {
      return '0$number';
    }
    return '$number';
  }
}
