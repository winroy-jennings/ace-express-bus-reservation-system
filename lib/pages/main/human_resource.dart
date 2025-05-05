import 'package:ace_express_reservation_system/factory/db_connection.dart';
import 'package:ace_express_reservation_system/presets/presets.dart';
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class HumanResource extends StatefulWidget {
  const HumanResource({super.key});

  @override
  State<HumanResource> createState() => _HumanResourceState();
}

class _HumanResourceState extends State<HumanResource> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[600],
      appBar: AppBar(
        backgroundColor: Colors.blue,
        elevation: 8.0,
        shadowColor: Colors.black,
        title: const Text(
          "Human Resource Menu",
          style: TextStyle(
            color: Colors.white,
          ),
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
            "SELECT * FROM users WHERE employee_number = '${userInfo['employee_number']}'",
          ),
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

            return Row(
              children: [
                Column(
                  children: <Widget>[
                    Center(
                      child: Padding(
                        padding: const EdgeInsets.all(28.0),
                        child: Container(
                          width: 400,
                          height: 250,
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
                                  child: const Icon(Icons.person),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    "${snapshot.data!.rows.first.assoc()['firstname']} ${snapshot.data!.rows.first.assoc()['lastname']}\n${snapshot.data!.rows.first.assoc()['address']}\n${snapshot.data!.rows.first.assoc()['department']}",
                                    style: const TextStyle(
                                      fontSize: 24,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
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
                              onPressed: createProfile,
                              child: const Text('Create User Profile'),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: SizedBox(
                            width: 400,
                            height: 50,
                            child: ElevatedButton(
                              onPressed: updateProfile,
                              child: const Text('Update User Profile'),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: SizedBox(
                            width: 400,
                            height: 50,
                            child: ElevatedButton(
                              onPressed: changePasswordHR,
                              child: const Text('Change User Password'),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: SizedBox(
                            width: 400,
                            height: 50,
                            child: ElevatedButton(
                              onPressed: deleteAccountHR,
                              child: const Text('Delete User Account'),
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

  void createProfile() {
    Navigator.pushNamed(context, '/create_profile_hr');
  }

  void updateProfile() {
    Navigator.pushNamed(context, '/update_profile_hr');
  }

  void changePasswordHR() {
    Navigator.pushNamed(context, '/change_password_hr');
  }

  void deleteAccountHR() {
    Navigator.pushNamed(context, '/delete_account_hr');
  }
}
