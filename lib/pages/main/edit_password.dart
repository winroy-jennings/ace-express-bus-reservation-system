import 'package:ace_express_reservation_system/factory/db_connection.dart';
import 'package:ace_express_reservation_system/presets/presets.dart';
import 'package:flutter/material.dart';

class EditPassword extends StatefulWidget {
  const EditPassword({super.key});

  @override
  State<EditPassword> createState() => _EditPasswordState();
}

class _EditPasswordState extends State<EditPassword> {
  final _formKey = GlobalKey<FormState>();

  TextEditingController? oldPasswordController = TextEditingController();
  TextEditingController? newPasswordController = TextEditingController();
  TextEditingController? verifyPasswordController = TextEditingController();

  static const double textFieldPadding = 15.0;
  static const double textPadding = 120.0;
  static const double textFieldWidth = 420.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Edit Password",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.blue,
      ),
      body: FutureBuilder(
          future: DbConnection.dbPort.execute(
              "SELECT * FROM users WHERE employee_number = '${userInfo['employee_number']}';"),
          builder: (context, snapshot) {
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
                            width: textPadding, child: Text("Old Password*")),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: textFieldPadding),
                          child: SizedBox(
                            width: textFieldWidth,
                            child: TextFormField(
                              controller: oldPasswordController,
                              obscureText: true,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter your current password';
                                }

                                if (!snapshot.data!.rows.any(
                                  (element) {
                                    return element.assoc()['password'] ==
                                        oldPasswordController!.text;
                                  },
                                )) {
                                  return 'Password is incorrect';
                                }

                                return null;
                              },
                            ),
                          ),
                        ),
                      ]),
                      Row(children: [
                        const SizedBox(
                            width: textPadding, child: Text("New Password*")),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: textFieldPadding),
                          child: SizedBox(
                            width: textFieldWidth,
                            child: TextFormField(
                              controller: newPasswordController,
                              obscureText: true,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter your new password';
                                }
                                return null;
                              },
                            ),
                          ),
                        ),
                      ]),
                      Row(children: [
                        const SizedBox(
                            width: textPadding,
                            child: Text("Verify Password*")),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: textFieldPadding),
                          child: SizedBox(
                            width: textFieldWidth,
                            child: TextFormField(
                              controller: verifyPasswordController,
                              obscureText: true,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter your new password';
                                }

                                if (newPasswordController!.text !=
                                    verifyPasswordController!.text) {
                                  return 'Password does not match';
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

      var result = await DbConnection.dbPort.execute(
          "SELECT * FROM users where employee_number = '${userInfo['employee_number']}' and password = '${oldPasswordController!.text}';");

      if (result.rows.isEmpty) {
        if (!mounted) return;

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Old password is incorrect'),
          ),
        );
      } else {
        await DbConnection.dbPort.execute(
            "update users set password = '${newPasswordController!.text}' WHERE employee_number = '${userInfo['employee_number']}'");

        if (!mounted) return;

        final successSnackBar = ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Password updated successfully')),
        );

        await successSnackBar.closed;
        if (!mounted) return;
        Navigator.pop(context);
      }
    }
  }
}
