import 'package:flutter/material.dart';
import 'package:trashure_motion/ui/login/login_page.dart';
import 'package:trashure_motion/ui/navigasi_bar/akun.dart';
import 'package:trashure_motion/ui/navigasi_bar/beranda.dart';
import 'package:trashure_motion/ui/navigasi_bar/harga.dart';
import 'package:trashure_motion/ui/navigasi_bar/penukaran.dart';
import 'package:trashure_motion/ui/navigasi_bar/scan.dart';

class HalamanUtama extends StatefulWidget {
  @override
  HalamanUtamaState createState() => HalamanUtamaState();
}

class HalamanUtamaState extends State<HalamanUtama> {
  int _selectedIndex = 0;
  //int _navigateToScreens;

  final _layoutPage = [
    Beranda(),
    Penukaran(),
    Scan(),
    Harga(),
    Akunn(
        //namaPengguna: nama,
        ),
  ];

  void _onTabItem(int idx) {
    setState(() {
      _selectedIndex = idx;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _layoutPage.elementAt(_selectedIndex),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Color(0xFFFAFAFA),
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: _selectedIndex == 0
                ? new Image.asset(
                    "assets/navigasi_bar/beranda.png",
                    color: Color(0xFF8BC34A),
                  )
                : new Image.asset("assets/navigasi_bar/beranda.png"),
            title: _selectedIndex == 0
                ? new Text(
                    "Beranda",
                    style: TextStyle(
                      color: Color(0xFF8BC34A),
                    ),
                  )
                : new Text(
                    "Beranda",
                    style: TextStyle(
                      color: Color(0xFF737373),
                    ),
                  ),
          ),
          BottomNavigationBarItem(
            icon: _selectedIndex == 1
                ? new Image.asset(
                    "assets/navigasi_bar/penukaran.png",
                    color: Color(0xFF8BC34A),
                  )
                : new Image.asset("assets/navigasi_bar/penukaran.png"),
            title: _selectedIndex == 1
                ? new Text(
                    "Penukaran",
                    style: TextStyle(
                      color: Color(0xFF8BC34A),
                    ),
                  )
                : new Text(
                    "Penukaran",
                    style: TextStyle(
                      color: Color(0xFF737373),
                    ),
                  ),
          ),
          BottomNavigationBarItem(
            icon: _selectedIndex == 2
                ? new Image.asset(
                    "assets/navigasi_bar/scan.png",
                    color: Color(0xFF8BC34A),
                  )
                : new Image.asset("assets/navigasi_bar/scan.png"),
            title: _selectedIndex == 2
                ? new Text(
                    "Scan",
                    style: TextStyle(
                      color: Color(0xFF8BC34A),
                    ),
                  )
                : new Text(
                    "Scan",
                    style: TextStyle(
                      color: Color(0xFF737373),
                    ),
                  ),
          ),
          BottomNavigationBarItem(
            icon: _selectedIndex == 3
                ? new Image.asset(
                    "assets/navigasi_bar/harga.png",
                    color: Color(0xFF8BC34A),
                  )
                : new Image.asset("assets/navigasi_bar/harga.png"),
            title: _selectedIndex == 3
                ? new Text(
                    "Harga",
                    style: TextStyle(
                      color: Color(0xFF8BC34A),
                    ),
                  )
                : new Text(
                    "Harga",
                    style: TextStyle(
                      color: Color(0xFF737373),
                    ),
                  ),
          ),
          BottomNavigationBarItem(
            icon: _selectedIndex == 4
                ? new Image.asset(
                    "assets/navigasi_bar/akun.png",
                    color: Color(0xFF8BC34A),
                  )
                : new Image.asset("assets/navigasi_bar/akun.png"),
            title: _selectedIndex == 4
                ? new Text(
                    "Akun",
                    style: TextStyle(
                      color: Color(0xFF8BC34A),
                    ),
                  )
                : new Text(
                    "Akun",
                    style: TextStyle(
                      color: Color(0xFF737373),
                    ),
                  ),
          ),
        ],
        type: BottomNavigationBarType.fixed,
        currentIndex: _selectedIndex,
        onTap: _onTabItem,
      ),
    );
  }
}
