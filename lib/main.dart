import 'package:etrike_admin/dashboard/side_navigation_drawer.dart';
import 'package:etrike_admin/pages/login_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: const FirebaseOptions(
        apiKey: "AIzaSyARFxD9Oj7g-IXWLfb4Pq7Apln7gw7S-ps",
        authDomain: "etrikev2.firebaseapp.com",
        databaseURL: "https://etrikev2-default-rtdb.firebaseio.com",
        projectId: "etrikev2",
        storageBucket: "etrikev2.appspot.com",
        messagingSenderId: "722118617533",
        appId: "1:722118617533:web:0b63502775d29798a08ad4"
    ),
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Etrike Admin Panel',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        primaryColor: const Color(0xFF142D53),
        appBarTheme: const AppBarTheme(
          iconTheme: IconThemeData(color: Colors.white),
        ),
      ),
      home: const LoginPage(),
    );
  }
}
