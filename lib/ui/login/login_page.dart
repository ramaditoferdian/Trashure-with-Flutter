import 'package:flutter/material.dart';
import 'package:flutter_session/flutter_session.dart';
import 'package:http/http.dart' as http;
import 'package:progress_dialog/progress_dialog.dart';

import 'dart:convert';

import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:trashure_motion/ui/halaman_utama/halaman_utama.dart';

//import 'package:shared_preferences/shared_preferences.dart';

String nama = "";

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

enum LoginStatus {
  notSignIn,
  signIn,
}

class _LoginPageState extends State<LoginPage> {
  LoginStatus _loginStatus =
      LoginStatus.notSignIn; // KONDISI LOGIN ATAU TIDAK LOGIN

  String _email, _pw; // untuk validasi bahwa username dan password tidak KOSONG

  bool _obscureText = true;
  bool checkBoxValue = false;

  bool isLogin = false;

  //WADAH UNTUK MENYIMPAN INPUTAN email DAN password
  TextEditingController eml = new TextEditingController();
  TextEditingController pass = new TextEditingController();
  final _key = new GlobalKey<FormState>();

  check() {
    final form = _key.currentState;
    if (form.validate()) {
      form.save();
      //print("$_email, $_pw");         //CEK INPUTAN
      _login();
    }
  }

  _login() async {
    // ProgressDialog progressDialog = ProgressDialog(context);
    // progressDialog.style(message: " Loading...");
    // progressDialog.show();

    final response =
        await http.post("http://192.168.1.1/dbtrashure/api/login.php", body: {
      "username": _email,
      "password": _pw,
    });

    final _datauser = jsonDecode(response.body);

    int value = _datauser['value'];
    String pesan = _datauser['message'];
    String usernameAPI = _datauser['username'];
    String namaAPI = _datauser['nama'];
    String notelpAPI = _datauser['notelp'];

    if (value == 1) {
      setState(() {
        _loginStatus = LoginStatus.signIn;
        savePref(value, usernameAPI, namaAPI, notelpAPI);
        print(_loginStatus);
      });

      print(pesan);
    } else {
      print(pesan);
    }

    print(_datauser);

    //progressDialog.hide();

    // if (_datauser.length == 0) {
    //   Alert(context: context, title: "Login Gagal", type: AlertType.error)
    //       .show();
    // } else {
    //   Alert(context: context, title: "Login Berhasil", type: AlertType.success)
    //       .show();

    //   if (_datauser[0]['level'] == 'admin') {
    //     print("Anda masuk sebagai ADMIN");
    //     //Navigator.pushReplacementNamed(context, '/jos');
    //     Navigator.of(context)
    //         .pushNamedAndRemoveUntil('/jos', (Route<dynamic> route) => false);
    //   } else if (_datauser[0]['level'] == 'member') {
    //     print("Anda masuk sebagai MEMBER");
    //     Navigator.of(context)
    //         .pushNamedAndRemoveUntil('/jos', (Route<dynamic> route) => false);
    //   }

    //   setState(() {
    //     nama = _datauser[0]['Nama_Pengguna'];
    //   });
    // }
    //return _datauser;
  }

  savePref(int value, String username, String nama, String notelp) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      preferences.setInt("value", value);
      preferences.setString("nama", nama);
      preferences.setString("username", username);
      preferences.setString("notelp", notelp);
      preferences.commit();
    });
  }

  var value;
  getPref() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      value = preferences.getInt("value");

      _loginStatus = value == 1 ? LoginStatus.signIn : LoginStatus.notSignIn;
    });
  }

  signOut() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      preferences.setInt("value", null);
      preferences.commit();
      _loginStatus = LoginStatus.notSignIn;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getPref();
  }

  @override
  Widget build(BuildContext context) {
    switch (_loginStatus) {
      case LoginStatus.notSignIn:
        //return;
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
                      new Container(
                        margin: EdgeInsets.fromLTRB(30, 25, 30, 10),
                        child: Center(
                          child: Image.asset("assets/Logo.png"),
                        ),
                      ),
                      Container(
                        //EMAIL input
                        decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border.all(color: Colors.grey),
                            borderRadius: BorderRadius.circular(5)),
                        margin: EdgeInsets.fromLTRB(30, 80, 30, 12),
                        padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                        child: TextFormField(
                          validator: (e) {
                            if (e.isEmpty) {
                              return "Please insert email";
                            }
                          },
                          onSaved: (e) => _email = e,
                          controller: eml, // UNTUK SIMPAN INPUTAN email
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
                        //PASSWORD input
                        decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border.all(color: Colors.grey),
                            borderRadius: BorderRadius.circular(5)),
                        margin: EdgeInsets.fromLTRB(30, 0, 30, 10),
                        padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                        child: TextFormField(
                          validator: (e) {
                            if (e.isEmpty) {
                              return "Please insert password";
                            }
                          },
                          onSaved: (e) => _pw = e,
                          controller: pass, // UNTUK SIMPAN INPUTAN password
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
                      Container(
                        margin: EdgeInsets.fromLTRB(15, 0, 0, 30),
                        child: Row(
                          children: <Widget>[
                            Container(
                              child: Center(
                                child: Checkbox(
                                    value: checkBoxValue,
                                    activeColor: Color(0xFF8BC34A),
                                    onChanged: (bool newValue) {
                                      setState(() {
                                        checkBoxValue = newValue;
                                      });
                                    }),
                              ),
                            ),
                            Container(
                              child: Text(
                                "Ingat saya",
                                style: TextStyle(fontSize: 14),
                              ),
                            ),
                            SizedBox(
                              width: 105,
                            ),
                            InkWell(
                              //UNTUK LUPA PASSWORD
                              onTap: () {
                                //Navigator.of(context).pushNamed('/jos');
                                Navigator.of(context).pushNamedAndRemoveUntil(
                                    '/jos', (Route<dynamic> route) => false);
                              },
                              child: Text(
                                "LUPA PASSWORD ?",
                                style: TextStyle(
                                  color: Color(0xFF416188),
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        height: 56,
                        margin: EdgeInsets.fromLTRB(30, 0, 30, 24),
                        child: RaisedButton(
                          child: Text(
                            "MASUK",
                            style: TextStyle(
                                color: Color(0xFFFFFFFF),
                                fontFamily: 'sfProDisplay'),
                          ),
                          color: Color(0xFF8BC34A),
                          onPressed: () {
                            //Navigator.of(context).pushNamed('/jos');
                            check(); // SUDAH INCLUDE _login()
                          },
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(4)),
                        ),
                      ),
                      Container(
                        child: Center(
                            child: Text(
                          "atau masuk dengan",
                          style: TextStyle(color: Colors.black26),
                        )),
                      ),
                      Container(
                        child: Center(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Container(
                                height: 56,
                                width: 56,
                                margin: EdgeInsets.fromLTRB(0, 24, 20, 24),
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
                              Container(
                                height: 56,
                                width: 56,
                                margin: EdgeInsets.fromLTRB(0, 24, 0, 24),
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
                      Container(
                        child: Center(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Container(
                                child: Center(
                                    child: Text(
                                  "Belum punya akun Trashure?",
                                  style: TextStyle(color: Colors.black),
                                )),
                              ),
                              SizedBox(
                                width: 8.0,
                              ),
                              InkWell(
                                // UNTUK DAFTAR \\
                                onTap: () {
                                  Navigator.of(context).pushNamed('/signUP');
                                },
                                child: Center(
                                    child: Text(
                                  "DAFTAR",
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
        break;
      case LoginStatus.signIn:
        //return;
        return HalamanUtama();
        break;
    }
  }
}
