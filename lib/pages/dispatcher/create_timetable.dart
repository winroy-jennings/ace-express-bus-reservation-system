import 'package:ace_express_reservation_system/factory/db_connection.dart';
import 'package:flutter/material.dart';

class CreateTimetable extends StatefulWidget {
  const CreateTimetable({super.key});

  @override
  State<CreateTimetable> createState() => _CreateTimetableState();
}

class _CreateTimetableState extends State<CreateTimetable> {
  final _formKey = GlobalKey<FormState>();

  TextEditingController? busNumberController = TextEditingController();
  TextEditingController? routeController = TextEditingController();
  TextEditingController? departureTimeController = TextEditingController();
  TextEditingController? arrivalTimeController = TextEditingController();
  TextEditingController? driverNameController = TextEditingController();

  static const double textFieldPadding = 15.0;
  static const double textPadding = 120.0;
  static const double textFieldWidth = 420.0;

  bool isSwitched = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Create Timetable Entry",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.blue,
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                const Text(
                  "Add Multiple Timetable Entries?",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16.0,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Switch(
                    activeColor: Colors.white,
                    value: isSwitched,
                    onChanged: (value) {
                      setState(() {
                        isSwitched = value;
                      });
                    },
                  ),
                ),
              ],
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

            return SingleChildScrollView(
              child: Form(
                key: _formKey,
                child: Padding(
                  padding: const EdgeInsets.all(25.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Add Route Schedule to Timetable",
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Row(children: [
                        const SizedBox(
                            width: textPadding, child: Text("Bus Number*")),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: textFieldPadding),
                          child: SizedBox(
                            width: textFieldWidth,
                            child: TextFormField(
                              controller: busNumberController,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter a bus number';
                                }

                                if (snapshot.data!.rows.any(
                                  (element) {
                                    return element.assoc()['bus_number'] ==
                                        busNumberController!.text;
                                  },
                                )) {
                                  return 'Bus Number already exists, try another';
                                }

                                return null;
                              },
                            ),
                          ),
                        ),
                      ]),
                      Row(children: [
                        const SizedBox(
                            width: textPadding, child: Text("Route*")),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: textFieldPadding),
                          child: SizedBox(
                            width: textFieldWidth,
                            child: TextFormField(
                              controller: routeController,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter a route';
                                }
                                return null;
                              },
                            ),
                          ),
                        ),
                      ]),
                      Row(children: [
                        const SizedBox(
                            width: textPadding, child: Text("Departure Time*")),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: textFieldPadding),
                          child: SizedBox(
                            width: textFieldWidth,
                            child: TextFormField(
                              controller: departureTimeController,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter a valid departure time';
                                } else {
                                  final RegExp timeRegex =
                                      RegExp(r"^\d{1,2}:\d{2} (AM|PM)$");

                                  if (!timeRegex.hasMatch(value)) {
                                    return 'Please enter a valid departure time. Format: HH:MM AM/PM';
                                  }
                                }

                                return null;
                              },
                            ),
                          ),
                        ),
                      ]),
                      Row(children: [
                        const SizedBox(
                            width: textPadding, child: Text("Arrival Time*")),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: textFieldPadding),
                          child: SizedBox(
                            width: textFieldWidth,
                            child: TextFormField(
                              controller: arrivalTimeController,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter a valid arrival time';
                                } else {
                                  final RegExp timeRegex =
                                      RegExp(r"^\d{1,2}:\d{2} (AM|PM)$");

                                  if (!timeRegex.hasMatch(value)) {
                                    return 'Please enter a valid arrival time. Format: HH:MM AM/PM';
                                  }
                                }

                                return null;
                              },
                            ),
                          ),
                        ),
                      ]),
                      Row(children: [
                        const SizedBox(
                            width: textPadding, child: Text("Driver Name*")),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: textFieldPadding),
                          child: SizedBox(
                            width: textFieldWidth,
                            child: TextFormField(
                              controller: driverNameController,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter a driver name';
                                }

                                return null;
                              },
                            ),
                          ),
                        ),
                      ]),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 28.0),
                        child: ElevatedButton(
                          style: ButtonStyle(
                            backgroundColor:
                                WidgetStateProperty.all(Colors.deepPurple),
                          ),
                          onPressed: add,
                          child: const Text(
                            "Add",
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          }),
    );
  }

  void add() async {
    if (_formKey.currentState!.validate()) {
      final processingSnackBar = ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Processing Data')),
      );

      await processingSnackBar.closed;

      await DbConnection.dbPort.execute(
          "INSERT INTO bus_schedule(bus_number, route, departure_time, arrival_time, driver_name) values('${busNumberController!.text}', '${routeController!.text}', '${departureTimeController!.text}', '${arrivalTimeController!.text}', '${driverNameController!.text}')");

      if (!mounted) return;

      final successSnackBar = ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Route added to timetable successfully')),
      );

      if (isSwitched) {
        setState(() {
          busNumberController!.text = '';
          routeController!.text = '';
          departureTimeController!.text = '';
          arrivalTimeController!.text = '';
          driverNameController!.text = '';
        });
      } else {
        await successSnackBar.closed;
        if (!mounted) return;
        Navigator.pop(context);
      }
    }
  }
}
