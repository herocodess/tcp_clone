import 'package:flutter/material.dart';

class Landing extends StatefulWidget {
  @override
  _LandingState createState() => _LandingState();
}

class _LandingState extends State<Landing> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        height: double.infinity,
        width: double.infinity,
        child: Stack(
          children: [
            Center(
              child: Positioned(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'TCP', 
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: Colors.indigo,
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
                      'Clone',
                      style: TextStyle(
                        fontSize: 22,
                        color: Colors.grey
                      ),
                    )
                  ],
                ),
              ),
            ),
            // SizedBox(height: MediaQuery.of(context).size.height/ 1.5),
            Padding(
              padding: const EdgeInsets.only(bottom: 50),
              child: Positioned(
                child: Align(
                  alignment: FractionalOffset.bottomCenter,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Container(
                        color: Colors.indigo,
                        width: 150,
                        height: 40,
                          child: RaisedButton(
                          color: Colors.transparent,
                          child: Text('Connect', style: TextStyle(color: Colors.white),),
                          onPressed: () => Navigator.pushNamed(context, '/chatStart'),
                        ),
                      ),
                      SizedBox(width: 5,),
                      Container(
                        color: Colors.white,
                        width: 150,
                        height: 40,
                          child: RaisedButton(
                          color: Colors.white,
                          child: Text('Start Server', style: TextStyle(color: Colors.indigo),),
                          onPressed: () => Navigator.pushNamed(context, '/serverStart'),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
      
    );
  }
}