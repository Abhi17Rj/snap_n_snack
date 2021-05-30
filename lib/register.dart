import 'package:flutter/material.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:alert/alert.dart';
import 'package:snapnsnack/imagepick.dart';


class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {

  var _auth;
  bool spinner = false;
  late String email;
  late String pass = '1111111111';
  late String pass2;

  void createAuth() async{
    await Firebase.initializeApp();
    _auth = FirebaseAuth.instance;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    createAuth();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: LoadingOverlay(
        isLoading: spinner,
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: 50.0,
                width: double.infinity,
                child: Center(child: Text('Snap n\' Snack', style: TextStyle(
                  fontFamily: 'Limelight', fontSize: 42.0,
                ),)),
              ),
              SizedBox(
                height: 18.0,
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 25.0, vertical: 10.0),
                child: TextField(
                  textAlign: TextAlign.center,
                  onChanged: (value) {
                    email = value;
                  },
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                    filled: false,
                    fillColor: Colors.white.withOpacity(0.6),
                    hintText: 'Enter Email Id',
                    hintStyle: TextStyle(color: Colors.white),
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 25.0, vertical: 10.0),
                child: TextField(
                    textAlign: TextAlign.center,
                  onChanged: (value) {
                      setState(() {
                        pass = value;
                      });
                  },
                  obscureText: true,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                    hintText: 'Enter Password',
                    hintStyle: TextStyle(color: Colors.white),
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 25.0, vertical: 10.0),
                child: TextField(
                  textAlign: TextAlign.center,
                  onChanged: (value) {
                    pass2 = value;
                  },
                  obscureText: true,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                    hintText: 'Confirm Password',
                    hintStyle: TextStyle(color: Colors.white),
                  ),
                ),
              ),
              Container(
                height: 15.0,
                child: pass.length < 6 ?
                Text('Password must 6 characters or more', style: TextStyle(color: Colors.red),)
                : Text(" "),
              ),
              GestureDetector(
                onTap: () async{
                  if (pass == pass2) {
                    setState(() {
                      spinner = true;
                    });
                    try {
                      final user = await _auth.createUserWithEmailAndPassword(
                          email: email, password: pass);
                      if (user != null) {
                        Navigator.push(context, MaterialPageRoute(builder: (
                            context) {
                          return ImagePick();
                        }));
                      }

                      setState(() {
                        spinner = false;
                      });
                    } catch (e) {
                      print(e);
                      setState(() {
                        spinner = false;
                      });
                      Alert(message: e.toString(), shortDuration: false).show();
                    }
                  } else {
                    Alert(message: 'Password doesn\'t match', shortDuration: false).show();
                  }
                },
                child: Container(
                  margin: EdgeInsets.symmetric(horizontal: 25.0, vertical: 10.0),
                  padding: EdgeInsets.all(14.0),
                  decoration: BoxDecoration(
                    color: Colors.greenAccent,
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                  width: double.infinity,
                  child: Text(
                    'Sign Up',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 24.0,
                      fontFamily: 'Handlee',
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
