import 'package:ace_express_reservation_system/factory/db_connection.dart';
import 'package:ace_express_reservation_system/presets/presets.dart';
import 'package:flutter/material.dart';

class DeleteUserAccountHR extends StatefulWidget {
  const DeleteUserAccountHR({super.key});

  @override
  State<DeleteUserAccountHR> createState() => _DeleteUserAccountHRState();
}

class _DeleteUserAccountHRState extends State<DeleteUserAccountHR> {
  final _formKey = GlobalKey<FormState>();

  TextEditingController? employeeNumberController = TextEditingController();

  static const double textFieldPadding = 15.0;
  static const double textPadding = 150.0;
  static const double textFieldWidth = 420.0;

  bool isSwitched = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Delete User Account",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.blue,
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                const Text(
                  "Delete Multiple Accounts?",
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
          future: DbConnection.dbPort.execute("SELECT * FROM users;"),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
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
                      Row(children: [
                        const SizedBox(
                            width: textPadding,
                            child: Text("Employee Number*")),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: textFieldPadding),
                          child: SizedBox(
                            width: textFieldWidth,
                            child: TextFormField(
                              controller: employeeNumberController,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter a valid employee number';
                                }

                                if (!snapshot.data!.rows.any(
                                  (element) {
                                    return element.assoc()['employee_number'] ==
                                        employeeNumberController!.text;
                                  },
                                )) {
                                  return 'Employee number does not exists';
                                }

                                if (employeeNumberController!.text ==
                                    userInfo['employee_number']) {
                                  return 'Cannot delete your own account';
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
                          onPressed: submit,
                          child: const Text(
                            "Submit",
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

  void submit() async {
    if (_formKey.currentState!.validate()) {
      final processingSnackBar = ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Processing Data')),
      );

      await processingSnackBar.closed;

      await DbConnection.dbPort.execute(
          "DELETE FROM users WHERE employee_number = '${employeeNumberController!.text}'");

      if (!mounted) return;

      final successSnackBar = ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Account deleted successfully')),
      );

      await successSnackBar.closed;
      if (!mounted) return;

      if (isSwitched) {
        setState(() {
          employeeNumberController!.text = "";
        });
      } else {
        if (!mounted) return;
        Navigator.pop(context);
      }
    }
  }
}
