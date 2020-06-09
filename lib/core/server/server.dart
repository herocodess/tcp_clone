import 'dart:convert';
import 'dart:io';

import 'package:barcode_scan/barcode_scan.dart';
import 'package:barcode_scan/platform_wrapper.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
// import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_ip/get_ip.dart';
import 'package:tcp_clone/model/messageData.dart';
import 'package:tcp_clone/model/tcpData.dart';
import 'package:tcp_clone/views/home.dart';

class Server extends ChangeNotifier{
  List<Message> _msgList = [];
  List<Message> get messageList => _msgList;
  String errorMessage = '';

  // var storage = FlutterSecureStorage();

  ServerSocket _serverSocket;
  //set server instance
  set server(ServerSocket val) {
    _serverSocket = val;
    notifyListeners();
  }
  // get server
  ServerSocket get serverSocket => _serverSocket;

  Socket _socket;
  //set socket instance
  set socket(Socket val) {
    _socket = val;
    notifyListeners();
  }
  // get socket
  Socket get socket => _socket;

  bool _loading = false;
  //set loading
  set loading(bool val) {
    _loading = val;
    notifyListeners();
  }
  // get loading val
  bool get loading => _loading;

  initState() async{
    ipController.text = await GetIp.ipAddress;
    portController.text = '4000';
    errorMessage = '';
  }

  var ipController = TextEditingController();
  var portController = TextEditingController();
  var nameController = TextEditingController();
  var msgController = TextEditingController();

  getConnData() {
    return TCPData(
      ip: ipController.text,
      port: int.parse(portController.text),
      name: nameController.text
    );
  }

  startServer(context) async{
    if (ipController.text == null || ipController.text.isEmpty) {
      errorMessage = "ip address cannot be blank";
      notifyListeners();
    }else if (nameController.text == null || nameController.text.isEmpty) {
      errorMessage = "Name cannot be blank";
      notifyListeners();
    }else if (portController.text == null || portController.text.isEmpty) {
      errorMessage = "Port cannot be blank";
      notifyListeners();
    }else {
      errorMessage = "";
      notifyListeners();
      _serve(context);
    }
  }

  _serve(context) async{
    try{
      _serverSocket = await ServerSocket.bind(
        ipController.text, 
        int.parse(portController.text), 
        shared: true);
        notifyListeners();
        print('server started');

        if (_serverSocket != null) {
          _serverSocket.listen((Socket socket) {
            _socket = socket;
            socket.listen((List<int> msgs) {
              try {
                String data = String.fromCharCodes(msgs);
                if (data.contains('name')) {
                  var message = Message.fromJson(json.decode(data));
                  messageList.insert(0, 
                    Message(
                      message: message.message,
                      name: message.name,
                      user: message.name == getConnData()? 0 : 1
                    ));
                    notifyListeners();
                }
                socket.add(msgs);
              }catch(e) {
                print(e.toString());
              }
              notifyListeners();
             });
          });
          connectToServer(context);
          Navigator.pushReplacement(
            context, 
            MaterialPageRoute(
              fullscreenDialog: false,
              builder: (context) => HomePage(
                tcpData: getConnData(),
                isHost: true,
              )
            )
          );
        }
    }catch(e) {
      print(e.toString());
    }
  }

  connectToServer(context, {bool isHost = true}) async{
    if (ipController.text == null || ipController.text.isEmpty) {
      errorMessage = "ip address cannot be blank";
      notifyListeners();
    }else if (nameController.text == null || nameController.text.isEmpty) {
      errorMessage = "Name cannot be blank";
      notifyListeners();
    }else if (portController.text == null || portController.text.isEmpty) {
      errorMessage = "Port cannot be blank";
      notifyListeners();
    }else {
      errorMessage = "";
      notifyListeners();
      _client(context);
    }
  }

  _client(context, {bool isHost = true}) async{
    try {
      _loading = false;
      notifyListeners();
      _socket = await Socket.connect(ipController.text, int.parse(portController.text))
        .timeout(Duration(seconds: 10), onTimeout: () {
          errorMessage = 'Timeout error';
        });
        notifyListeners();
        print('connected to server');
        _socket.listen((List<int> msgs) { 
          String result = String.fromCharCodes(msgs);

          try {
            if (result.contains('name')) {
            var message = Message.fromJson(json.decode(result));
              messageList.insert(0, 
              Message(
                message: message.message,
                name: message.name,
                user: message.name == getConnData()? 0 : 1
              ));
              notifyListeners();
            }
          }catch(e) {
            print(e.toString());
          }
        });
        if (!isHost) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              fullscreenDialog: false,
              builder: (context) => HomePage(tcpData: TCPData(
                ip: ipController.text,
                name: nameController.text,
                port: int.parse(portController.text)
              )),
            ),
          );
        }
        _loading = false;
        notifyListeners();
    }catch(e) {
      _loading = false;
      notifyListeners();
      print(e.toString());
    }
  }

  close() async{
    await _socket.close();
  }

  @override
  void dispose() {
    close();
    _serverSocket.close();
    super.dispose();
  }

  void sendMessage(context, TCPData tcpData, {bool isHost}) {
    var message = utf8.encode(json.encode(
        Message(message: msgController.text, name: tcpData?.name ?? '').toJson()));

    if (isHost) {
      messageList.insert(
        0,
        Message(message: msgController.text, name: tcpData?.name, user: 0),
      );
      notifyListeners();
    }

    try {
      _socket.add(message);

      msgController.clear();
    } catch (e) {
      // showErrorDialog(context, error: e.toString());
      print(e.toString());
    }
    notifyListeners();
  }

  scan(context) async {
    errorMessage = "";
    try {
      var res = await BarcodeScanner.scan();
      notifyListeners();
      if (res != null) {
        //connect via tcp data
        var tcp =TCPData.fromJson(json.decode(res.rawContent));

        ipController.text = tcp.ip;
        portController.text = tcp.port.toString();
        notifyListeners();

        //connect as a client
        connectToServer(context, isHost: false);
      }
    }on PlatformException catch (e) {
      var result = ScanResult(
        type: ResultType.Error,
        format: BarcodeFormat.unknown,
      );

      if (e.code == BarcodeScanner.cameraAccessDenied) {
        result.rawContent = 'The user did not grant the camera permission!';
      } else {
        result.rawContent = 'Unknown error: $e';
      }
      // showErrorDialog(context, error: result.rawContent);
    }
  }

}