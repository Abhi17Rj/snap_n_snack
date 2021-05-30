import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:alert/alert.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:snapnsnack/imagepick.dart';
import 'package:snapnsnack/info.dart';
import 'package:snapnsnack/register.dart';


class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  bool spinner = false;
  late String email;
  late String pass;
  var val = false;
  var _auth;

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
    return new WillPopScope(
      onWillPop: () async => false,
      child: LoadingOverlay(
        isLoading: spinner,
        child: Scaffold(
          backgroundColor: Colors.black,
          body: SafeArea(
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
                    keyboardType: TextInputType.emailAddress,
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
                      hintText: ' Email',
                      hintStyle: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 25.0, vertical: 10.0),
                  child: TextField(
                    textAlign: TextAlign.center,
                    onChanged: (value) {
                      pass = value;
                    },
                    obscureText: true,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30.0),
                      ),
                      hintText: 'Password',
                      hintStyle: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () async{
                    setState(() {
                      spinner = true;
                    });
                    try {
                      final user = await _auth.signInWithEmailAndPassword(
                          email: email, password: pass);
                      print("User is : ----> ");
                      print(user);
                      if (user != null){

                        Navigator.push(context, MaterialPageRoute(builder: (context) {
                          return ImagePick() ;
                        }));
                      }
                      setState(() {
                        spinner = false;
                      });
                    }
                    catch(e) {
                      print("Error is : ");
                      print(e);
                      setState(() {
                        spinner = false;
                      });
                      Alert(message: e.toString(), shortDuration: false).show();
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
                      'Sign In',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 24.0,
                        fontFamily: 'Handlee',
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 10,),
                Text('New User ?', style: TextStyle(fontFamily: 'Handlee', fontSize: 24.0, fontWeight: FontWeight.bold),),
                GestureDetector(
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context) {
                      return RegisterPage();
                    }));
                  },
                  child: Text('Sign up', style: TextStyle(fontFamily: 'Handlee', fontSize: 24.0, color: Colors.greenAccent, fontWeight: FontWeight.bold),),
                ),

              ],
            ),
          ),
        ),
      ),
    );
  }
}

