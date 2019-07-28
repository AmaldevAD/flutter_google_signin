import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'dart:async';

void main() {
  runApp(Myapp());
}

class Myapp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: " Mapla",
      home: Home(),
    );
  }
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  GoogleSignIn _googleSignIn = GoogleSignIn(scopes: ['email']);
  bool isLoggedin = false;

  login() async {
    try {
      await _googleSignIn.signIn();
      setState(() {
        isLoggedin = true;
      });
    } catch (err) {
      print("############" + err);
    }
  }

  logOut() async {
    _googleSignIn.signOut();
    setState(() {
      isLoggedin = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Mapla"),
      ),
      body: Container(
        child: Column(
          children: <Widget>[
            isLoggedin == true
                ? Column(
                    children: <Widget>[
                      Image.network(_googleSignIn.currentUser.photoUrl),
                      Text(_googleSignIn.currentUser.email),
                      FlatButton(
                        color: Colors.blue,
                        child: Text("Log out"),
                        onPressed: logOut,
                      ),
                    ],
                  )
                : Container(
                    child: Center(
                      child: FlatButton(
                        color: Colors.blue,
                        child: Text("Login with google"),
                        onPressed: login,
                      ),
                    ),
                  )
          ],
        ),
      ),
    );
  }
}
