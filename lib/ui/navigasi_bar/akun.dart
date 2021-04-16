import 'package:flutter/material.dart';
import 'package:flutter_session/flutter_session.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:trashure_motion/ui/login/login_page.dart';
import 'package:trashure_motion/ui/halaman_utama/halaman_utama.dart';

class Akunn extends StatefulWidget {
  Akunn({this.namaPengguna, this.signOut});
  String namaPengguna;

  final VoidCallback signOut;

  @override
  _AkunnState createState() => _AkunnState();
}

enum LoginStatus {
  notSignIn,
  signIn,
}

class _AkunnState extends State<Akunn> {
  _AkunnState({this.namaPengguna});
  String namaPengguna;

  LoginStatus _loginStatus =
      LoginStatus.signIn; // KONDISI LOGIN ATAU TIDAK LOGIN

  signOut() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      preferences.setInt("value", null);
      preferences.setInt("username", null);
      preferences.setInt("nama", null);
      preferences.setInt("notelp", null);
      preferences.commit();
      _loginStatus = LoginStatus.notSignIn;
      print(_loginStatus);
    });
  }

  String username = "", nama = "", notelp = "";

  dapatPref() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      username = preferences.getString("username");
      nama = preferences.getString("nama");
      notelp = preferences.getString("notelp");
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    dapatPref();
  }

  @override
  Widget build(BuildContext context) {
    // switch (_loginStatus) {
    //   case LoginStatus.notSignIn:
    //     //return
    //     return LoginPage();
    //     break;
    //   case LoginStatus.signIn:
    //     //return
    //     //return HalamanUtama();
    //     break;
    // }

    return Scaffold(
      backgroundColor: Color(0xFF777777),
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            title: Text("Akun ",
                style: TextStyle(
                    fontSize: 28,
                    color: Color(0xE1416188),
                    fontWeight: FontWeight.bold)),
            automaticallyImplyLeading: false,
            backgroundColor: Color(
              0xFFFFFFFF,
            ),
            expandedHeight: 70.0,
            elevation: 1,
            forceElevated: true,
          ),
          SliverToBoxAdapter(
            child: Container(
                padding: const EdgeInsets.fromLTRB(15, 92, 15, 44),
                child: new Container(
                  child: Column(
                    children: [
                      SizedBox(
                        height: 50,
                      ),
                      Container(
                        child: Center(
                          child: Text(
                            // widget.namaPengguna +
                            "$username \n$nama \n$notelp",
                            style: TextStyle(fontSize: 18),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 50,
                      ),
                      SizedBox(
                        height: 50,
                      ),
                      Container(
                        padding: EdgeInsets.fromLTRB(30, 0, 30, 0),
                        child: SizedBox(
                          height: 56,
                          width: 500,
                          child: RaisedButton(
                            child: Text(
                              "Keluar",
                              style: TextStyle(
                                color: Color(0xFFFFFFFF),
                                fontFamily: 'sfProDisplay',
                                fontSize: 18,
                              ),
                            ),
                            color: Color(0xFFFF5722),
                            onPressed: () {
                              setState(() {
                                signOut();
                              });
                              signOut();
                              //Navigator.of(context).pushNamed('/jos');
                              // Navigator.pushReplacementNamed(
                              //     context, '/signIN');
                              Navigator.of(context).pushNamedAndRemoveUntil(
                                  '/signIN', (Route<dynamic> route) => false);
                            },
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(4)),
                          ),
                        ),
                      ),
                    ],
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(4),
                    color: Color(0xFFFFFFFF),
                  ),
                  height: 470,
                )),
          )
        ],
      ),
    );
  }
}
