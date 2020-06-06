import 'package:flutter/material.dart';

class ChatStart extends StatefulWidget {
  @override
  _ChatStartState createState() => _ChatStartState();
}

class _ChatStartState extends State<ChatStart> {

  var _ipController = TextEditingController();
  var _portController = TextEditingController();
  var _nameController = TextEditingController();

  _buildHeader() {
    return Container(
      color: Colors.transparent,
      height: 50,
      width: double.infinity,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: Text(
              'TCP',
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Colors.white
              ),
            ),
          ),
          SizedBox(width: 5,),
          Container(
            color: Colors.grey,
            height: 20,
            width: 2,
            child: Text('|', style: TextStyle(color: Colors.transparent),),
          ),
          SizedBox(width: 5,),
          Text(
            'Chat',
            style: TextStyle(
              fontSize: 24,
              color: Colors.white70
            ),
          ),
          SizedBox(width: 5,),
          Padding(
            padding: EdgeInsets.only(top: 10),
            child: Text(
              'Client',
              style: TextStyle(
                fontSize: 16,
                color: Colors.white70
              ),
            ),
          )
        ],
      ),
    );
  }

  _buildTF() {
    return Container(
      child: Column(
        children: [
          InputFields(
            controller: _ipController,
            hintText: "Enter IP Address",
            readOnly: true,
            inputStyle: TextInputType.numberWithOptions(),
          ),
          SizedBox(height: 20,),
          InputFields(
            controller: _portController,
            hintText: "4000",
            readOnly: false,
            inputStyle: TextInputType.number,
          ),
          SizedBox(height: 20,),
          InputFields(
            controller: _nameController,
            hintText: "Enter Name",
            readOnly: true,
            inputStyle: TextInputType.text,
          ),
        ],
      ),
    );
  }

  _buildButton() {
    return Container(
      height: 50,
      width: double.infinity,
      color: Colors.transparent,
      child: Padding(
        padding: const EdgeInsets.only(right: 40, left: 40),
        child: RaisedButton(
          elevation: 0.0,
          color: Colors.indigo,
          child: Text('Connect to Server', style: TextStyle(color: Colors.white70),),
          onPressed: () {},
        ),
      ),
    );
  }

  _buildScanIcon() {
    return GestureDetector(
      onTap: () {},
      child: Container(
        color: Colors.transparent,
        child: Icon(Icons.filter_center_focus, color: Colors.white70,),
      ),
    );
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: ListView(
        shrinkWrap: true,
        children: [
          Padding(
            padding: EdgeInsets.only(top: 100),
            child: _buildHeader(),
          ),
          Padding(
            padding: EdgeInsets.all(40),
            child: _buildTF(),
          ),
          SizedBox(height: 100,),
          _buildButton(),
          SizedBox(height: 50,),
          Center(
            child: _buildScanIcon(),
          )
        ],
      ),
    );
  }
}

class InputFields extends StatefulWidget {
  var controller;
  var hintText;
  var inputStyle;
  var readOnly = true;

  InputFields({this.controller, this.hintText, this.inputStyle, this.readOnly});
  @override
  _InputFieldsState createState() => _InputFieldsState();
}

class _InputFieldsState extends State<InputFields> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      height: 50,
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.indigo,
        ),
        borderRadius: BorderRadius.all(Radius.circular(10))
      ),
      child: TextFormField(
        enabled: widget.readOnly,
        keyboardType: widget.inputStyle,
        maxLines: 1,
        style: TextStyle(color: Colors.white70),
        decoration: InputDecoration(
          border: InputBorder.none,
          hintText: widget.hintText,
          hintStyle: widget.readOnly
            ? TextStyle(fontSize: 14.0, color: Colors.white70) 
            : TextStyle(fontSize: 14.0, color: Colors.white),
        ),
        textAlign: TextAlign.justify,
        controller: widget.controller,
      ),
    );
  }
}