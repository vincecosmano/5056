import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'modules/home/home.dart';
import 'modules/login/login.dart';
import 'modules/profile/profile.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Oneapptredie',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: AuthWrapper(),
      routes: {
        '/home': (context) => HomeScreen(),
        '/login': (context) => LoginScreen(),
        '/profile': (context) => ProfileScreen(),
      },
    );
  }
}

class AuthWrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Implement your authentication logic here
    bool isAuthenticated = false; // Replace this with actual authentication check

    if (isAuthenticated) {
      return HomeScreen();
    } else {
      return LoginScreen();
    }
  }
}