import 'package:flutter/material.dart';
import 'package:tcp_clone/routes.dart';
import 'package:tcp_clone/views/landing.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'TCP Clone',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'Muli',
        primarySwatch: Colors.indigo,
        primaryColor: Colors.indigo[700],
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: Landing(),
      routes: routes,
    );
  }
}
