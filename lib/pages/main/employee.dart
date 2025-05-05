import 'package:ace_express_reservation_system/factory/db_connection.dart';
import 'package:ace_express_reservation_system/presets/presets.dart';
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class Employee extends StatefulWidget {
  const Employee({super.key});

  @override
  State<Employee> createState() => _EmployeeState();
}

class _EmployeeState extends State<Employee> {
  String? firstname = "";
  String? lastname = "";
  String? address = "";
  String? department = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[600],
      appBar: AppBar(
        backgroundColor: Colors.blue,
        elevation: 8.0,
        shadowColor: Colors.black,
        title: const Text(
          "Employee Menu",
          style: TextStyle(color: Colors.white),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton(
              style: ButtonStyle(
                backgroundColor: WidgetStateProperty.all(Colors.deepPurple),
              ),
              onPressed: logout,
              child: const Text(
                'Logout',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
        ],
      ),
      body: FutureBuilder(
          future: DbConnection.dbPort.execute(
              "SELECT * FROM users WHERE employee_number = '${userInfo['employee_number']}'"),
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

            firstname = snapshot.data!.rows.first.assoc()['firstname'];
            lastname = snapshot.data!.rows.first.assoc()['lastname'];
            address = snapshot.data!.rows.first.assoc()['address'];
            department = snapshot.data!.rows.first.assoc()['department'];

            return Row(
              children: [
                Column(
                  children: <Widget>[
                    Center(
                      child: Padding(
                        padding: const EdgeInsets.all(28.0),
                        child: Container(
                          width: 400,
                          height: 280,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: Colors.grey[300],
                            borderRadius: BorderRadius.circular(30.0),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 15.0),
                            child: Column(
                              children: [
                                Container(
                                    height: 62,
                                    width: 62,
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(75),
                                    ),
                                    child: const Icon(Icons.person)),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    "$firstname $lastname\n$address\n$department",
                                    style: const TextStyle(
                                      fontSize: 24,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                                TextButton(
                                  onPressed: () => Navigator.pushNamed(
                                      context, '/edit_password'),
                                  child: const Text('Change Password'),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    Column(
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: SizedBox(
                            width: 400,
                            height: 50,
                            child: ElevatedButton(
                              onPressed: seatSelection,
                              child: const Text('Reserve Seat'),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: SizedBox(
                            width: 400,
                            height: 50,
                            child: ElevatedButton(
                              onPressed: viewLocation,
                              child: const Text('View Driver Location'),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: SizedBox(
                            width: 400,
                            height: 50,
                            child: ElevatedButton(
                              onPressed: viewTimetable,
                              child: const Text('View Timetable'),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(right: 25.0),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.blueGrey[200],
                        borderRadius: BorderRadius.circular(30.0),
                      ),
                      width: 420,
                      height: 560,
                      child: TableCalendar(
                        locale: 'en_US',
                        firstDay: DateTime.utc(2010, 10, 16),
                        lastDay: DateTime.utc(2030, 3, 14),
                        focusedDay: DateTime.now(),
                      ),
                    ),
                  ),
                ),
              ],
            );
          }),
    );
  }

  void logout() async {
    final scuccessfulSnackBar = ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Logging Out')),
    );

    await scuccessfulSnackBar.closed;
    if (!mounted) return;

    Navigator.popAndPushNamed(context, '/login');
  }

  void seatSelection() {
    Navigator.pushNamed(context, '/seat_selection');
  }

  void viewLocation() {
    Navigator.pushNamed(context, '/view_driver_location');
  }

  void viewTimetable() {
    Navigator.pushNamed(context, '/view_timetable');
  }
}
