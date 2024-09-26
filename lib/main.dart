import 'package:finders_v1_1/routes.dart'; // Import RouteManager
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
      options: const FirebaseOptions(
          apiKey: "AIzaSyB1VfcMZg9QhMu-Xbx8uipRAlPy3qi8Bd8",
          appId: "1:1056042698190:android:2d1a63fba0ba0ae00d979f",
          messagingSenderId: "1056042698190",
          projectId: "findersmvc"));

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Finders App',
      initialRoute: RouteManager.mainPage, // Set initial route
      onGenerateRoute: RouteManager.generateRoute, // Use the route manager
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      debugShowCheckedModeBanner: false,
    );
  }
}
