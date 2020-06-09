import 'package:dash_chat/dash_chat.dart';
import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:tcp_clone/model/tcpData.dart';

class HomePage extends StatefulWidget {
  bool isHost;
  TCPData tcpData;

  HomePage({@required this.tcpData, this.isHost = false});
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<String> messages = [];

  @override
  void initState() {
    widget.isHost = false;
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
          onTap: () => Navigator.pop(context),
          child: widget.isHost
            ? Icon(Icons.arrow_back_ios, color: Colors.indigo, size: 18,)
            : Icon(Icons.arrow_back_ios, color: Colors.white, size: 18,),
        ),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'TCP', 
              style: TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.bold,
                color: widget.isHost? Colors.indigo : Colors.white70,
              ),
            ),
            SizedBox(width: 5,),
            Container(
              color: Colors.white70,
              height: 20,
              width: 2,
              child: Text('|', style: TextStyle(color: Colors.transparent),),
            ),
            SizedBox(width: 5,),
            Text(
              'Clone',
              style: TextStyle(
                fontSize: 20,
                // color: Colors.white70
                color: widget.isHost 
                  ? Colors.indigo 
                  : Colors.white70
              ),
            )
          ],
        ),
        automaticallyImplyLeading: false,
        centerTitle: true,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 10.0),
            child: GestureDetector(
              onTap: () => {
                print('tapped'),
                _showBarCode(context)
              },
              child: Icon(Icons.info_outline),
            ),
          )
        ],
      ),
      backgroundColor: Colors.grey[200],
      body: DashChat(
        user: null,
        messages: [],
        inputDecoration: InputDecoration(
          hintText: "Type message here...",
          hintStyle: TextStyle(
            fontSize: 16,
            color: Colors.grey
          ),
        ),
        onSend: null,
      ),
    );
  }

  _showBarCode(BuildContext buildContext) => showDialog(
    context: buildContext,
    builder: (buildContext) {
      return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(10))
      ),
      child: Container(
        width: MediaQuery.of(context).size.width / 1.7,
        height: MediaQuery.of(context).size.height * .40,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Scan to Connect',
              style: TextStyle(
                fontSize: 18,
              ),
            ),
            SizedBox(height: 40,),
            QrImage(
              data: 'This is a simple QR code',
              version: QrVersions.auto,
              padding: EdgeInsets.zero,
              size: 180,
              gapless: false,
              foregroundColor: Colors.indigo,
            ),
            SizedBox(
              height: 20,
            )
          ],
        ),
      ),
    );
    }
  );
}