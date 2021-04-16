import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class SignupPage extends StatefulWidget {
  @override
  _SignupPageState createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  String _email, _pw, _nama, _notelp;

  bool _obscureText = true;
  bool checkBoxValue = false;

  final _key = new GlobalKey<FormState>();

  check() {
    final form = _key.currentState;
    if (form.validate()) {
      form.save();
      save();

      //_login();
    }
  }

  save() async {
    final response = await http
        .post("http://192.168.1.1/dbtrashure/api/register.php", body: {
      "nama": _nama,
      "username": _email,
      "notelp": _notelp,
      "password": _pw,
    });

    final _datauser = jsonDecode(response.body);

    int value = _datauser['value'];
    String pesan = _datauser['message'];

    if (value == 1) {
      setState(() {
        Navigator.pop(context);
      });
    } else {
      print(pesan);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFFFFFFF),
      body: Stack(
        children: <Widget>[
          Align(
            alignment: Alignment.topCenter,
            child: Form(
              key: _key,
              child: ListView(
                children: <Widget>[
                  Stack(
                    children: [
                      new Container(
                        margin: EdgeInsets.fromLTRB(30, 49, 30, 0),
                        child: Center(
                            child: new Text(
                          "Daftar",
                          style: TextStyle(
                              fontSize: 24, fontWeight: FontWeight.bold),
                        )),
                      ),
                      Container(
                        margin: EdgeInsets.fromLTRB(13, 50, 0, 0),
                        child: InkWell(
                          onTap: () {
                            Navigator.of(context).pushNamed('/signIN');
                          },
                          child: new Image.asset(
                            "assets/back.png",
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 99,
                  ),
                  Container(
                    decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadius.circular(5)),
                    margin: EdgeInsets.fromLTRB(30, 0, 30, 12),
                    padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                    child: TextFormField(
                      validator: (e) {
                        if (e.isEmpty) {
                          return "Please insert email";
                        }
                      },
                      onSaved: (e) => _nama = e,
                      autofocus: true,
                      decoration: InputDecoration(
                          icon: Container(
                            child: Image.asset("assets/iconNama.png"),
                          ),
                          border: InputBorder.none,
                          hintText: "Nama",
                          labelStyle: TextStyle(
                              color: Color(0xFF7C7C7C),
                              fontFamily: 'sfDisplayPro')),
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadius.circular(5)),
                    margin: EdgeInsets.fromLTRB(30, 0, 30, 12),
                    padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                    child: TextFormField(
                      validator: (e) {
                        if (e.isEmpty) {
                          return "Please insert email";
                        }
                      },
                      onSaved: (e) => _email = e,
                      autofocus: true,
                      decoration: InputDecoration(
                          icon: Container(
                            child: Image.asset("assets/email.png"),
                          ),
                          border: InputBorder.none,
                          hintText: "Email",
                          labelStyle: TextStyle(
                              color: Color(0xFF7C7C7C),
                              fontFamily: 'sfDisplayPro')),
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadius.circular(5)),
                    margin: EdgeInsets.fromLTRB(30, 0, 30, 12),
                    padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                    child: TextFormField(
                      validator: (e) {
                        if (e.isEmpty) {
                          return "Please insert email";
                        }
                      },
                      onSaved: (e) => _notelp = e,
                      autofocus: true,
                      decoration: InputDecoration(
                          icon: Container(
                            child: Image.asset("assets/iconHP.png"),
                          ),
                          border: InputBorder.none,
                          hintText: "Nomor HP",
                          labelStyle: TextStyle(
                              color: Color(0xFF7C7C7C),
                              fontFamily: 'sfDisplayPro')),
                    ),
                  ),
                  Container(
                    //PASSWORD TEXT
                    decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadius.circular(5)),
                    margin: EdgeInsets.fromLTRB(30, 0, 30, 0),
                    padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                    child: TextFormField(
                      validator: (e) {
                        if (e.isEmpty) {
                          return "Please insert email";
                        }
                      },
                      onSaved: (e) => _pw = e,
                      obscureText: _obscureText,
                      //keyboardType: TextInputType.text,
                      //autofocus: true,
                      decoration: InputDecoration(
                        hintText: "Password",
                        icon: Container(
                          child: Image.asset("assets/password.png"),
                        ),
                        //   color: Color(0xFF8BC34A),

                        border: InputBorder.none,
                        suffixIcon: IconButton(
                          icon: Icon(
                            Icons.visibility,
                            color: _obscureText
                                ? Colors.black26
                                : Color(0xFF8BC34A),
                          ),
                          onPressed: () {
                            setState(() {
                              _obscureText = !_obscureText;
                            });
                          },
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 40,
                  ),
                  Container(
                    height: 56,
                    margin: EdgeInsets.fromLTRB(30, 0, 30, 0),
                    child: RaisedButton(
                      child: Text(
                        "DAFTAR",
                        style: TextStyle(
                            color: Color(0xFFFFFFFF),
                            fontFamily: 'sfProDisplay'),
                      ),
                      color: Color(0xFF8BC34A),
                      onPressed: () {
                        check();
                      },
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(4)),
                    ),
                  ),
                  SizedBox(
                    height: 24,
                  ),
                  Container(
                    child: Center(
                        child: Text(
                      "atau daftar dengan",
                      style: TextStyle(color: Colors.black26),
                    )),
                  ),
                  SizedBox(
                    height: 24,
                  ),
                  Container(
                    child: Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Container(
                            height: 56,
                            width: 56,
                            //margin: EdgeInsets.fromLTRB(0, 24, 20, 24),
                            child: RaisedButton(
                              padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                              child: Image.asset(
                                "assets/G+.png",
                              ),
                              color: Color(0xFF8BC34A),
                              onPressed: () {},
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(4)),
                            ),
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          Container(
                            height: 56,
                            width: 56,
                            //margin: EdgeInsets.fromLTRB(0, 24, 0, 24),
                            child: RaisedButton(
                              padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                              child: Image.asset(
                                "assets/facebook.png",
                              ),
                              color: Color(0xFF8BC34A),
                              onPressed: () {},
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(4)),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 38,
                  ),
                  Container(
                    child: Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Container(
                            child: Center(
                                child: Text(
                              "Sudah punya akun Trashure?",
                              style: TextStyle(color: Colors.black),
                            )),
                          ),
                          SizedBox(
                            width: 8.0,
                          ),
                          InkWell(
                            // UNTUK DAFTAR \\
                            onTap: () {
                              Navigator.of(context).pushNamed('/signIN');
                            },
                            child: Center(
                                child: Text(
                              "MASUK",
                              style: TextStyle(
                                color: Color(0xFF416188),
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                              ),
                            )),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
