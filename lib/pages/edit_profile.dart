import 'package:ace_express_reservation_system/factory/db_connection.dart';
import 'package:ace_express_reservation_system/presets/presets.dart';
import 'package:flutter/material.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({super.key});

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  final _formKey = GlobalKey<FormState>();

  TextEditingController? usernameController = TextEditingController();
  TextEditingController? firstNameController = TextEditingController();
  TextEditingController? lastNameController = TextEditingController();
  TextEditingController? nicknameController = TextEditingController();
  TextEditingController? ageController = TextEditingController();
  TextEditingController? genderController = TextEditingController();
  TextEditingController? locationController = TextEditingController();
  TextEditingController? emailController = TextEditingController();
  TextEditingController? websiteController = TextEditingController();
  TextEditingController? publicInfoController = TextEditingController();

  static const double textFieldPadding = 15.0;
  static const double textPadding = 80.0;
  static const double textFieldWidth = 420.0;

  bool once = false;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: DbConnection.dbPort.execute(
          "SELECT * FROM users where employee_number = ${userInfo['employee_number']};"),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        if (!once) {
          usernameController!.text =
              '${snapshot.data!.rows.first.assoc()['employee_number']}';
          firstNameController!.text =
              '${snapshot.data!.rows.first.assoc()['firstname']}';
          lastNameController!.text =
              '${snapshot.data!.rows.first.assoc()['lastname']}';
          nicknameController!.text =
              '${snapshot.data!.rows.first.assoc()['nickname']}';
          ageController!.text = '${snapshot.data!.rows.first.assoc()['age']}';
          genderController!.text =
              '${snapshot.data!.rows.first.assoc()['gender']}';
          locationController!.text =
              '${snapshot.data!.rows.first.assoc()['address']}';
          emailController!.text =
              '${snapshot.data!.rows.first.assoc()['email']}';
          websiteController!.text =
              '${snapshot.data!.rows.first.assoc()['website']}';
          publicInfoController!.text =
              '${snapshot.data!.rows.first.assoc()['public_info']}';

          once = true;
        }

        return Scaffold(
          appBar: AppBar(
            title: const Text(
              "Edit Profile",
              style: TextStyle(color: Colors.white),
            ),
            backgroundColor: Colors.blue,
          ),
          body: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Padding(
                padding: const EdgeInsets.all(25.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(children: [
                      const SizedBox(
                          width: textPadding, child: Text("Username*")),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: textFieldPadding),
                        child: SizedBox(
                          width: textFieldWidth,
                          child: TextFormField(
                            controller: usernameController,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter some text';
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
                                return 'Please enter some text';
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
                                return 'Please enter some text';
                              }
                              return null;
                            },
                          ),
                        ),
                      ),
                    ]),
                    Row(children: [
                      const SizedBox(
                          width: textPadding, child: Text("Nick Name*")),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: textFieldPadding),
                        child: SizedBox(
                          width: textFieldWidth,
                          child: TextFormField(
                            controller: nicknameController,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter some text';
                              }
                              return null;
                            },
                          ),
                        ),
                      ),
                    ]),
                    Row(children: [
                      const SizedBox(width: textPadding, child: Text("Age*")),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: textFieldPadding),
                        child: SizedBox(
                          width: textFieldWidth,
                          child: TextFormField(
                            controller: ageController,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter a valid age';
                              }

                              if (int.parse(value) < 18 ||
                                  int.parse(value) > 65) {
                                return 'Please enter a valid age. Between 18 and 65';
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
                                return 'Please enter some text';
                              }

                              if (value.toLowerCase() != "male" &&
                                  value.toLowerCase() != "female") {
                                return 'Please enter Male or Female';
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
                            controller: locationController,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter some text';
                              }
                              return null;
                            },
                          ),
                        ),
                      ),
                    ]),
                    Row(children: [
                      const SizedBox(width: textPadding, child: Text("Email*")),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: textFieldPadding),
                        child: SizedBox(
                          width: textFieldWidth,
                          child: TextFormField(
                            controller: emailController,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter some text';
                              }
                              return null;
                            },
                          ),
                        ),
                      ),
                    ]),
                    Row(children: [
                      const SizedBox(
                          width: textPadding, child: Text("Website")),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: textFieldPadding),
                        child: SizedBox(
                          width: textFieldWidth,
                          child: TextFormField(
                            controller: websiteController,
                            // validator: (value) {
                            //   if (value == null || value.isEmpty) {
                            //     return 'Please enter some text';
                            //   }
                            //   return null;
                            // },
                          ),
                        ),
                      ),
                    ]),
                    Row(children: [
                      const SizedBox(
                          width: textPadding, child: Text("Public Info")),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: textFieldPadding),
                        child: SizedBox(
                          width: textFieldWidth,
                          child: TextFormField(
                            maxLines: 3,
                            controller: publicInfoController,
                            // validator: (value) {
                            //   if (value == null || value.isEmpty) {
                            //     return 'Please enter some text';
                            //   }
                            //   return null;
                            // },
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
          ),
        );
      },
    );
  }

  void submit() async {
    if (_formKey.currentState!.validate()) {
      final processingSnackBar = ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Processing Data')),
      );

      await processingSnackBar.closed;

      await DbConnection.dbPort.execute("""
        update users set 
          employee_number = '${usernameController!.text}', 
          firstname = '${firstNameController!.text}', 
          lastname = '${lastNameController!.text}', 
          nickname = '${nicknameController!.text}', 
          age = '${ageController!.text}', 
          gender = '${genderController!.text}', 
          address = '${locationController!.text}', 
          email = '${emailController!.text}', 
          website = '${websiteController!.text}', 
          public_info = '${publicInfoController!.text}'
        where employee_number = '${userInfo['employee_number']}'
      """);

      if (!mounted) return;

      final successSnackBar = ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Profile updated successfully')),
      );

      await successSnackBar.closed;
      if (!mounted) return;
      Navigator.pop(context);
    }
  }
}
