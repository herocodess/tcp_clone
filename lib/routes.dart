import 'package:flutter/material.dart';
import 'package:tcp_clone/views/chatConnect.dart';
import 'package:tcp_clone/views/home.dart';
import 'package:tcp_clone/views/landing.dart';
import 'package:tcp_clone/views/serverPage.dart';

var routes = <String, WidgetBuilder> {
  '/landing': (BuildContext context) => Landing(),
  '/chatStart': (BuildContext context) => ChatStart(),
  '/serverStart': (BuildContext context) => ServerStart(),
  // '/homePage': (BuildContext context) => HomePage()
};