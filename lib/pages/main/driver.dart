import 'package:ace_express_reservation_system/presets/presets.dart';
import 'package:flutter/material.dart';

class Driver extends StatefulWidget {
  const Driver({super.key});

  @override
  State<Driver> createState() => _DriverState();
}

class _DriverState extends State<Driver> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[600],
      appBar: AppBar(
        backgroundColor: Colors.blue,
        elevation: 8.0,
        shadowColor: Colors.black,
        title: const Text(
          "Driver Menu",
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
          )
        ],
      ),
      body: Column(
        children: <Widget>[
          Center(
            child: Padding(
              padding: const EdgeInsets.all(36.0),
              child: Container(
                width: 400,
                height: 272,
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
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(75),
                        ),
                        child: IconButton(
                          iconSize: 75,
                          onPressed: editProfile,
                          icon: const Icon(Icons.person),
                        ),
                      ),
                      Text(
                        "${userInfo["firstname"]} ${userInfo["lastname"]}\n${userInfo["address"]}\n${userInfo["department"]}",
                        style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextButton(
                          onPressed: editProfile,
                          child: const Text("Edit Profile"),
                        ),
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
                    onPressed: viewPayment,
                    child: const Text('View Payment'),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: SizedBox(
                  width: 400,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: managePayment,
                    child: const Text('Manage Payment'),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
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

  void editProfile() {
    debugPrint('Edit profile');
  }

  void viewPayment() {
    Navigator.pushNamed(context, '/view_payment');
  }

  void managePayment() {
    Navigator.pushNamed(context, '/manage_payment');
  }
}
