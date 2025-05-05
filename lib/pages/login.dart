import 'package:ace_express_reservation_system/factory/db_connection.dart';
import 'package:ace_express_reservation_system/presets/presets.dart';
import 'package:flutter/material.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController? usernameController = TextEditingController();
  TextEditingController? passwordController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.blue,
        elevation: 8.0,
        shadowColor: Colors.black,
        centerTitle: true,
        title: const Text(
          "ACE Express Reservation",
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.only(top: 100.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Padding(
                  padding: EdgeInsets.all(50.0),
                  child: Text(
                    "Login Menu",
                    style: TextStyle(
                      fontSize: 32,
                    ),
                  ),
                ),
                const Text("Employee ID",
                    style: TextStyle(
                      fontSize: 24,
                    )),
                SizedBox(
                  width: 360,
                  child: TextFormField(
                    style: const TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                    controller: usernameController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter a valid employee ID';
                      }
                      return null;
                    },
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.only(top: 20),
                  child: Text("Password",
                      style: TextStyle(
                        fontSize: 24,
                      )),
                ),
                SizedBox(
                  width: 360,
                  child: TextFormField(
                    controller: passwordController,
                    obscureText: true,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter a valid password';
                      }
                      return null;
                    },
                  ),
                ),
                SizedBox(
                  width: 260,
                  height: 100,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 55.0),
                    child: ElevatedButton(
                      style: ButtonStyle(
                          backgroundColor:
                              WidgetStateProperty.all(Colors.blue)),
                      onPressed: loginPressed,
                      child: const Text(
                        "Login",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 24,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void loginPressed() async {
    // Validate returns true if the form is valid, or false otherwise.
    if (_formKey.currentState!.validate()) {
      final processingSnackBar = ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Processing Data')),
      );

      await processingSnackBar.closed;

      var result = await DbConnection.dbPort.execute("SELECT * FROM users");

      String usernameVal = usernameController!.text;
      String passwordVal = passwordController!.text;

      int resultIndex = 0;

      for (final row in result.rows) {
        if (row.assoc()['employee_number'] == usernameVal &&
            row.assoc()['password'] == passwordVal) {
          if (!mounted) return;

          userInfo = row.assoc();

          switch (row.assoc()['department']) {
            case "AEB Accountant":
              final scuccessfulSnackBar =
                  ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Login Successful')),
              );

              await scuccessfulSnackBar.closed;
              if (!mounted) return;

              Navigator.popAndPushNamed(context, '/accountant');
              break;
            case "Dispatcher":
              final scuccessfulSnackBar =
                  ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Login Successful')),
              );

              await scuccessfulSnackBar.closed;
              if (!mounted) return;

              Navigator.popAndPushNamed(context, '/dispatcher');
              break;
            case "Sales":
            case "Accounting":
            case "Finance":
            case "IT":
            case "Operations":
              final scuccessfulSnackBar =
                  ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Login Successful')),
              );

              await scuccessfulSnackBar.closed;
              if (!mounted) return;

              Navigator.popAndPushNamed(context, '/employee');
              break;
            case "Human Resource":
              final scuccessfulSnackBar =
                  ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Login Successful')),
              );

              await scuccessfulSnackBar.closed;
              if (!mounted) return;

              Navigator.popAndPushNamed(context, '/human_resource');
              break;
            case "Client Accountant":
              final scuccessfulSnackBar =
                  ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Login Successful')),
              );

              await scuccessfulSnackBar.closed;
              if (!mounted) return;

              Navigator.popAndPushNamed(context, '/client_accountant');
              break;
            case "Driver":
              final scuccessfulSnackBar =
                  ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Login Successful')),
              );

              await scuccessfulSnackBar.closed;
              if (!mounted) return;

              Navigator.popAndPushNamed(context, '/driver');
              break;
            case "Verifier":
              final scuccessfulSnackBar =
                  ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Login Successful')),
              );

              await scuccessfulSnackBar.closed;
              if (!mounted) return;

              Navigator.popAndPushNamed(context, '/verifier');
              break;
            default:
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Login Failed')),
              );
          }

          break;
        } else {
          if (resultIndex == result.rows.length - 1) {
            if (!mounted) return;

            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Login Failed')),
            );
          }

          resultIndex++;
        }
      }
    }
  }
}
