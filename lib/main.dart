import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutterfirebaseproject/firebase_options.dart';
import 'package:flutterfirebaseproject/pages/login_register_page.dart';
import 'package:flutterfirebaseproject/pages/profile_page.dart';
import 'package:flutterfirebaseproject/pages/widget_tree.dart';

import 'pages/home_page.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Firebase Auth',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const WidgetTree(),
      routes: {
        '/home': (context) => const Home(),
        '/login': (context) => const LoginPage(),
        '/profile': (context) => ProfilePage(),
      },
      
    );
  } 
}
