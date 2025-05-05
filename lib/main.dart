import 'package:ace_express_reservation_system/factory/db_connection.dart';
import 'package:ace_express_reservation_system/pages/dispatcher/create_timetable.dart';
import 'package:ace_express_reservation_system/pages/dispatcher/view_driver_location_pispatcher.dart';
import 'package:ace_express_reservation_system/pages/dispatcher/view_employee_location_dispatcher.dart';
import 'package:ace_express_reservation_system/pages/driver/manage_payment.dart';
import 'package:ace_express_reservation_system/pages/driver/view_payment.dart';
import 'package:ace_express_reservation_system/pages/edit_profile.dart';
import 'package:ace_express_reservation_system/pages/employee/reserve_seat.dart';
import 'package:ace_express_reservation_system/pages/employee/view_driver_location.dart';
import 'package:ace_express_reservation_system/pages/employee/view_qr_code_ticket.dart';
import 'package:ace_express_reservation_system/pages/employee/view_timetable.dart';
import 'package:ace_express_reservation_system/pages/hr_manager/change_password_hr.dart';
import 'package:ace_express_reservation_system/pages/hr_manager/create_profile_hr.dart';
import 'package:ace_express_reservation_system/pages/hr_manager/delete_user_account.dart';
import 'package:ace_express_reservation_system/pages/hr_manager/update_profile_hr.dart';
import 'package:ace_express_reservation_system/pages/main/accountant.dart';
import 'package:ace_express_reservation_system/pages/main/dispatcher.dart';
import 'package:ace_express_reservation_system/pages/main/client_accountant.dart';
import 'package:ace_express_reservation_system/pages/main/driver.dart';
import 'package:ace_express_reservation_system/pages/main/edit_password.dart';
import 'package:ace_express_reservation_system/pages/main/employee.dart';
import 'package:ace_express_reservation_system/pages/main/human_resource.dart';
import 'package:ace_express_reservation_system/pages/main/verifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:window_manager/window_manager.dart';
import 'pages/login.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: '.env');

  // Must add this line.
  await windowManager.ensureInitialized();

  WindowOptions windowOptions = const WindowOptions(
    size: Size(1280, 720),
    center: true,
    backgroundColor: Colors.transparent,
    skipTaskbar: false,
    titleBarStyle: TitleBarStyle.normal,
  );

  windowManager.waitUntilReadyToShow(windowOptions, () async {
    await windowManager.show();
    await windowManager.focus();
  });

  windowManager.setTitle("ACE Express Reservation");
  windowManager.setResizable(false);

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    DbConnection.connect();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ACE Express Reservation',
      theme: ThemeData(
        fontFamily: 'PlayfairDisplay',
        useMaterial3: true,
      ),
      debugShowCheckedModeBanner: false,
      routes: {
        '/login': (context) => const Login(),
        '/accountant': (context) => const Accountant(),
        '/dispatcher': (context) => const Dispatcher(),
        '/employee': (context) => const Employee(),
        '/human_resource': (context) => const HumanResource(),
        '/client_accountant': (context) => const ClientAccountant(),
        '/driver': (context) => const Driver(),
        '/verifier': (context) => const Verifier(),
        // Edit profile routes
        '/edit_profile': (context) => const EditProfile(),
        '/edit_password': (context) => const EditPassword(),
        // Employee routes
        '/seat_selection': (context) => const ReserveSeat(),
        '/view_driver_location': (context) => const ViewDriverLocation(),
        '/view_timetable': (context) => const ViewTimetable(),
        '/view_qr_code_ticket': (context) => const ViewQRCodeTicket(),
        // Driver routes
        '/view_payment': (context) => const ViewPayment(),
        '/manage_payment': (context) => const ManagePayment(),
        // Dispatcher routes
        '/view_employee_location_dispatcher': (context) =>
            const ViewEmployeeLocationDispatcher(),
        '/view_driver_location_dispatcher': (context) =>
            const ViewDriverLocationPispatcher(),
        '/create_timetable': (context) => const CreateTimetable(),
        // Human resource routes
        '/create_profile_hr': (context) => const CreateProfileHR(),
        '/update_profile_hr': (context) => const UpdateProfileHR(),
        '/change_password_hr': (context) => const ChangePasswordHR(),
        '/delete_account_hr': (context) => const DeleteUserAccountHR(),
      },
      home: const Login(),
    );
  }
}
