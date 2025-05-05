import 'package:ace_express_reservation_system/factory/db_connection.dart';
import 'package:flutter/material.dart';

class CreateProfileHR extends StatefulWidget {
  const CreateProfileHR({super.key});

  @override
  State<CreateProfileHR> createState() => _CreateProfileHRState();
}

class _CreateProfileHRState extends State<CreateProfileHR> {
  final _formKey = GlobalKey<FormState>();

  TextEditingController? employeeNumberController = TextEditingController();
  TextEditingController? firstNameController = TextEditingController();
  TextEditingController? lastNameController = TextEditingController();
  TextEditingController? telephoneController = TextEditingController();
  TextEditingController? supervisorFirstNameController =
      TextEditingController();
  TextEditingController? supervisorLastNameController = TextEditingController();
  TextEditingController? passwordController = TextEditingController();
  TextEditingController? genderController = TextEditingController();
  TextEditingController? addressController = TextEditingController();

  static const double textFieldPadding = 15.0;
  static const double textPadding = 100.0;
  static const double textFieldWidth = 420.0;

  bool isSwitched = false;
  String department = "";

  List<String> departments = [
    "Human Resource",
    "Sales",
    "Accounting",
    "Dispatcher",
    'Finance',
    'IT',
    'Operations'
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Create User Profile",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.blue,
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                const Text(
                  "Add Multiple Profiles?",
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
                          width: textPadding, child: Text("Employee Number*")),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: textFieldPadding),
                        child: SizedBox(
                          width: textFieldWidth,
                          child: TextFormField(
                            controller: employeeNumberController,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter a employee number';
                              }

                              if (snapshot.data!.rows.any(
                                (element) {
                                  return element.assoc()['employee_number'] ==
                                      employeeNumberController!.text;
                                },
                              )) {
                                return 'Employee number already exists, try another';
                              }

                              return null;
                            },
                          ),
                        ),
                      ),
                    ]),
                    Row(children: [
                      const SizedBox(
                          width: textPadding, child: Text("First Name*")),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: textFieldPadding),
                        child: SizedBox(
                          width: textFieldWidth,
                          child: TextFormField(
                            controller: firstNameController,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter a first name';
                              }
                              return null;
                            },
                          ),
                        ),
                      ),
                    ]),
                    Row(children: [
                      const SizedBox(
                          width: textPadding, child: Text("Last Name*")),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: textFieldPadding),
                        child: SizedBox(
                          width: textFieldWidth,
                          child: TextFormField(
                            controller: lastNameController,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter a last name';
                              }
                              return null;
                            },
                          ),
                        ),
                      ),
                    ]),
                    Row(children: [
                      const SizedBox(
                          width: textPadding, child: Text("Telephone*")),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: textFieldPadding),
                        child: SizedBox(
                          width: textFieldWidth,
                          child: TextFormField(
                            controller: telephoneController,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter a telephone number';
                              }

                              final RegExp phoneRegex =
                                  RegExp(r"^\+1 \d{3}-\d{3}-\d{4}$");

                              if (!phoneRegex.hasMatch(value)) {
                                return 'Please enter a valid phone number. Format: +1 XXX-XXX-XXXX';
                              }

                              return null;
                            },
                          ),
                        ),
                      ),
                    ]),
                    Row(children: [
                      const SizedBox(
                          width: textPadding, child: Text("Department*")),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(textFieldPadding,
                            textFieldPadding, textFieldPadding, 0),
                        child: SizedBox(
                          width: textFieldWidth,
                          child: DropdownButtonFormField<String>(
                            value: department.isEmpty ? null : department,
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                            ),
                            items: departments
                                .map<DropdownMenuItem<String>>((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                              );
                            }).toList(),
                            onChanged: (String? newValue) {
                              setState(() {
                                department = newValue!;
                              });
                            },
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please select a department';
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
                          child: Text("Supervisor First Name*")),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: textFieldPadding),
                        child: SizedBox(
                          width: textFieldWidth,
                          child: TextFormField(
                            controller: supervisorFirstNameController,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter a first name';
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
                          child: Text("Supervisor Last Name*")),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: textFieldPadding),
                        child: SizedBox(
                          width: textFieldWidth,
                          child: TextFormField(
                            controller: supervisorLastNameController,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter a last name';
                              }

                              return null;
                            },
                          ),
                        ),
                      ),
                    ]),
                    Row(children: [
                      const SizedBox(
                          width: textPadding, child: Text("Password*")),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: textFieldPadding),
                        child: SizedBox(
                          width: textFieldWidth,
                          child: TextFormField(
                            controller: passwordController,
                            obscureText: true,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter a password';
                              }

                              return null;
                            },
                          ),
                        ),
                      ),
                    ]),
                    Row(children: [
                      const SizedBox(
                          width: textPadding, child: Text("Gender*")),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: textFieldPadding),
                        child: SizedBox(
                          width: textFieldWidth,
                          child: TextFormField(
                            controller: genderController,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter a gender';
                              }

                              return null;
                            },
                          ),
                        ),
                      ),
                    ]),
                    Row(children: [
                      const SizedBox(
                          width: textPadding, child: Text("Address*")),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: textFieldPadding),
                        child: SizedBox(
                          width: textFieldWidth,
                          child: TextFormField(
                            controller: addressController,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter a address';
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
        },
      ),
    );
  }

  void submit() async {
    if (_formKey.currentState!.validate()) {
      final processingSnackBar = ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Processing Data')),
      );

      await processingSnackBar.closed;

      await DbConnection.dbPort.execute("""INSERT INTO 
          users(
          employee_number,
          firstname,
          lastname,
          telephone,
          department,
          supervisor_firstname,
          supervisor_lastname,
          password,
          gender,
          address
          )
          VALUES(
          '${employeeNumberController!.text}',
          '${firstNameController!.text}',
          '${lastNameController!.text}',
          '${telephoneController!.text}',
          '$department',
          '${supervisorFirstNameController!.text}',
          '${supervisorLastNameController!.text}',
          '${passwordController!.text}',
          '${genderController!.text}',
          '${addressController!.text}'
          );
          """);

      if (!mounted) return;

      final successSnackBar = ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Profile created successfully')),
      );

      await successSnackBar.closed;

      if (isSwitched) {
        setState(() {
          employeeNumberController!.text = "";
          firstNameController!.text = "";
          lastNameController!.text = "";
          telephoneController!.text = "";
          department = "";
          supervisorFirstNameController!.text = "";
          supervisorLastNameController = TextEditingController();
          passwordController!.text = "";
          genderController!.text = "";
          addressController!.text = "";
        });
      } else {
        if (!mounted) return;
        Navigator.pop(context);
      }
    }
  }
}
