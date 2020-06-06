import 'package:flutter/material.dart';

class ServerStart extends StatefulWidget {
  @override
  _ServerStartState createState() => _ServerStartState();
}

class _ServerStartState extends State<ServerStart> {

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
                color: Colors.indigo
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
              color: Colors.grey
            ),
          ),
          SizedBox(width: 5,),
          Padding(
            padding: EdgeInsets.only(top: 10),
            child: Text(
              'Server',
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey
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
          child: Text('Start Server', style: TextStyle(color: Colors.white70),),
          onPressed: () {},
        ),
      ),
    );
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
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
          SizedBox(height: 150,),
          _buildButton(),
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
        color: Colors.white,
        border: Border.all(
          color: Colors.white,
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
            ? TextStyle(fontSize: 14.0, color: Colors.grey) 
            : TextStyle(fontSize: 14.0, color: Colors.black),
        ),
        textAlign: TextAlign.justify,
        controller: widget.controller,
      ),
    );
  }
}