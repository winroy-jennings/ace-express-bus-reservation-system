# ACE Express Reservation Application - Flutter

[![Flutter](https://img.shields.io/badge/Flutter-%2302569B.svg?style=flat&logo=flutter&logoColor=white)](https://flutter.dev)
![B2B Transport](https://img.shields.io/badge/Service-B2B%20Transport-informational)
![Database](https://img.shields.io/badge/DB-MySQL-4479A1)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)

## Overview

ACE Express Reservation Application is a mobile platform built with Flutter to streamline daily employee commutes for companies utilizing the ACE Express transport service. This application provides a user-friendly interface for authorized personnel (dispatchers, employees, human resources, drivers, verifiers, and client accountants) to manage routes, reservations, user information, and ensure efficient transportation of staff between their homes and workplaces. The application utilizes a MySQL database for data persistence and incorporates environment variables for secure database connection management.

## Features

Based on the provided documentation and code analysis, the application offers the following key functionalities:

* **Secure User Authentication:** Ensures only authorized personnel can access the system with secure login.
* **Role-Based Access Control:** Presents tailored interfaces and features based on user roles:
    * **Dispatcher:**
        * Manages routes, schedules, employee locations, and driver locations.
        * Creates timetables.
        * Routes: `/view_employee_location_dispatcher`, `/view_driver_location_dispatcher`, `/create_timetable`
    * **Employee:**
        * Views available routes and timetables.
        * Reserves seats.
        * Views driver location.
        * Views QR code ticket.
        * Routes: `/seat_selection`, `/view_driver_location`, `/view_timetable`, `/view_qr_code_ticket`
    * **Human Resource:**
        * Manages employee accounts.
        * Creates, updates, and deletes employee profiles.
        * Changes employee passwords.
        * Routes: `/create_profile_hr`, `/update_profile_hr`, `/change_password_hr`, `/delete_account_hr`
    * **Driver:**
        * Views payment information.
        * Manages payment records.
        * Routes: `/view_payment`, `/manage_payment` [`driver.dart`]
    * **Verifier:**
        * User role for verification purposes. [`verifier.dart`]
    * **Client Accountant:**
        * User role for client accounting tasks. [`client_accountant.dart`]
* **User Profile Management:** Allows users to edit their profile and change their password. Routes: `/edit_profile`, `/edit_password`
* **Secure Logout:** Provides a secure way for users to exit the application.
* **Database Connectivity:** Uses the `mysql_client` package to connect to a MySQL database, with connection details managed via `.env` files for security [ `db_connection.dart`].

## Technologies Used

* **Framework:** Flutter [https://flutter.dev]
* **Language:** Dart [https://dart.dev]
* **State Management:** Implicitly managed with `setState` (Consider updating to a more robust solution for larger apps)
* **Database:** MySQL (via `mysql_client` package) [https://pub.dev/packages/mysql_client] [ `db_connection.dart`]
* **Environment Variables:** `flutter_dotenv` package for managing `.env` files [https://pub.dev/packages/flutter_dotenv] [ `db_connection.dart`]
* **UI Components:** `table_calendar` package for calendar functionality [https://pub.dev/packages/table_calendar]
* **Global Data:** `presets.dart` for storing global variables like `userInfo`.

## Prerequisites

Before running the application, ensure you have the following:

1.  **Flutter SDK:** Make sure you have the Flutter SDK installed on your development machine. Installation instructions can be found here: [https://flutter.dev/docs/get-started/install](https://flutter.dev/docs/get-started/install).
2.  **Development Environment:** Set up your preferred Flutter development environment:
    * **Android Studio:** [https://developer.android.com/studio](https://developer.android.com/studio)
    * **Xcode:** [https://developer.apple.com/xcode/](https://developer.apple.com/xcode/) (for iOS development)
    * **VS Code with Flutter Extension:** [https://marketplace.visualstudio.com/items?itemName=Dart-Code.flutter](https://marketplace.visualstudio.com/items?itemName=Dart-Code.flutter)
3.  **MySQL Database:**
    * Set up a MySQL database server.
    * Create the necessary database and tables as defined in the **Database Design** section of the documentation.
    * Obtain the database connection details (host, port, username, password, database name).
4.  **.env File:**
    * Create a `.env` file at the root of your project.
    * Add the following environment variables to the `.env` file, replacing the placeholders with your actual database connection details:

    ```
    HOST=your_mysql_host
    PORT=your_mysql_port
    USER=your_mysql_username
    PASSWORD=your_mysql_password
    DATABASE=your_mysql_database_name
    ```

    * Ensure that the `.env` file is added to your `.gitignore` to prevent committing sensitive information.

## Setup & Installation

1.  **Clone the Repository (if applicable):**

    ```bash
    git clone <your-repository-url>
    cd ace_express_reservation
    ```

    *(Replace `<your-repository-url>` with the actual URL of your project's Git repository)*

2.  **Navigate to the Project Directory:**

    ```bash
    cd ace_express_reservation
    ```

3.  **Get Dependencies:**

    ```bash
    flutter pub get
    ```

4.  **Load Environment Variables:**

    * Ensure the `flutter_dotenv` package is added to your `pubspec.yaml`
    * In `main.dart`, load the `.env` file before running the app:

    ```dart
    import 'package:flutter_dotenv/flutter_dotenv.dart';

    Future<void> main() async {
      await dotenv.load(fileName: '.env'); // Load the .env file
      runApp(const MyApp());
    }
    ```

5.  **Run the Application:**

    ```bash
    flutter run
    ```

    This command will build and run the application on your connected device or emulator.

## User Manual

For detailed instructions on how to use the application, please refer to the **ACE Express Reservation Application User Manual** starting on page 89 of the provided documentation. This manual covers:

* **Login Overview**
* **Dispatcher Overview**
* **Employee Overview**
* **Human Resource Overview**
* **How to create a user profile**
* **How to update user profile**
* **How to Change user password**
* **How to Delete User Account**
* **How to logout**

## Software Testing

Details regarding the software testing procedures and methodologies employed for this application can be found in the **Software Testing** section of the documentation, starting on page 40.

## Database Design

Information about the structure and design of the application's database is available in the **Database Design** section, starting on page 87.

## Programme Manual

For a comprehensive guide to the application's architecture, procedural designs, and pseudocodes, please refer to the **Programme Manual** section, starting on page 74.

## Contributing

[Optional] If you would like others to contribute to this project, add guidelines here on how to fork the repository, create branches, submit pull requests, etc.

## License

This project is licensed under the MIT License. See the `LICENSE` file for more details.
