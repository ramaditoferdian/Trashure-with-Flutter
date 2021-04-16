import 'package:flutter/material.dart';

class Beranda extends StatefulWidget {
  @override
  _BerandaState createState() => _BerandaState();
}

class _BerandaState extends State<Beranda> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF8F8F8),
      body: Stack(
        children: <Widget>[
          Align(
            alignment: Alignment.topCenter,
            child: ListView(
              children: <Widget>[],
            ),
          )
        ],
      ),
      appBar: AppBar(
        title: Text("Trashure",
            style: TextStyle(
                fontSize: 28,
                color: Color(0xE1416188),
                fontWeight: FontWeight.bold)),
        automaticallyImplyLeading: false,

        backgroundColor: Color(
          0xFFF8F8F8,
        ),
        elevation: 0,

        actions: <Widget>[
          IconButton(
              icon: Icon(
                Icons.notifications,
                color: Color(0xFF737373),
              ),
              onPressed: () {}),
          IconButton(icon: Image.asset("assets/gear.png"), onPressed: () {}),
        ],
        //elevation: 50.0,
      ),
    );
  }
}
