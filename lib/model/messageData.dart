import 'package:flutter/foundation.dart';

class Message{
  String message, name;
  int user;

  Message({@required this.message, this.user, this.name});

  Message.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String,dynamic> message = new Map<String, dynamic>();
    message['message'] = this.message;
    message['user'] = this.user;
    return message;
  }
}