import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:image_picker/image_picker.dart';
import 'package:snapnsnack/displayrecipelist.dart';
import 'package:snapnsnack/info.dart';
import 'dart:io';
import 'package:tflite/tflite.dart';
import 'dart:async';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ImagePick extends StatefulWidget {
  @override
  _ImagePickState createState() => _ImagePickState();
}

class _ImagePickState extends State<ImagePick> {

  List? _outputs;
  File? _image;
  bool _loading = false;
  final picker = ImagePicker();

  var _auth;

  void createAuth() async{
    await Firebase.initializeApp();
    _auth = FirebaseAuth.instance;

  }

  @override
  void initState() {
    super.initState();
    _loading = true;
    createAuth();
    loadModel().then((value) {
      setState(() {
        _loading = false;
      });
    });

  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        backgroundColor: Colors.blueGrey,
        body: SafeArea(
          child: _loading
              ? Container(
              alignment: Alignment.center,
                child: CircularProgressIndicator(),
              )
              : Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                child: Padding(
                padding: const EdgeInsets.only(top: 8.0, bottom: 6.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                FlatButton(
                  onPressed: () {
                    print('heloo');
                    Navigator.push(context, MaterialPageRoute(builder: (context) {
                      return InfoPage();
                    }));
                  },
                  child: Icon(
                    Icons.info,
                    size: 30.0,
                  ),
                ),
                Text(
                  'Snap n\' Snack',
                  style: TextStyle(
                    fontFamily: 'Limelight',
                      fontSize: 26.0, fontWeight: FontWeight.w200),
                ),
                FlatButton(
                  onPressed: () async{
                    await _auth.signOut();
                      Navigator.pop(context);
                    print('logout');
                  },
                  child: Icon(
                    Icons.logout,
                    size: 30.0,
                  ),
                ),
              ],
            ),
          ),
          decoration: BoxDecoration(
            color: Colors.black.withOpacity(0.1),
            border: Border(
              bottom: BorderSide(width: 1.0, color: Colors.black),
            ),
          ),
        ),
                    Container(
                        height: 310.0,
                        width: 310.0,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(400),
                          child: _image == null ?
                              Image.asset('images/no-image.jpg', fit: BoxFit.fill)
                              : Image.file(_image!, fit: BoxFit.cover),
                        ),
                    ),
                    _outputs != null ? Text(
                      "${_outputs![0]["label"]}",
                        style: TextStyle(fontSize: 22.0),
                    ) : Container(
                      child: Text('No Image Selected', style: TextStyle(fontSize: 22.0),),
                    ),
                    Container(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          GestureDetector(
                          onTap: getImage,
                          child: Container(
                            height: 110.0,
                            width: 110.0,
                            decoration: BoxDecoration(
                              color: Colors.pinkAccent,
                              borderRadius: BorderRadius.circular(30.0),
                            ),
                            child: Center(
                              child: Icon(
                                Icons.camera_alt,
                                size: 55.0,
                              ),
                            ),
                          ),
                  ),
                          GestureDetector(
                            onTap: pickImage,
                            child: Container(
                              height: 110.0,
                              width: 110.0,
                              decoration: BoxDecoration(
                                color: Colors.pinkAccent,
                                borderRadius: BorderRadius.circular(30.0),
                              ),
                              child: Center(
                                child: Icon(
                                  Icons.insert_drive_file,
                                  size: 55.0,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      child: _outputs != null ?
                      GestureDetector(
                        onTap: (){print(
                            _outputs![0]["index"]);
                            Navigator.push(context, MaterialPageRoute(builder: (context) {
                              return RecipeList(index: _outputs![0]["index"],);
                            }));
                        },
                        child: Container(
                          margin: EdgeInsets.symmetric(horizontal: 20.0, vertical: 5.0),
                          padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 22.0),
                          decoration: BoxDecoration(
                            color: Colors.pinkAccent,
                            borderRadius: BorderRadius.circular(20.0)
                          ),
                          child: Center(
                            child: Text('Show Recipes', style: TextStyle(fontFamily: 'Handlee', fontSize: 21.0),),
                          ),
                        ),
                      ) : Container(),
                    )
                  ],
                ),
            ),
        ),
      ),
    );
  }


  Future getImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.camera);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
        setState(() {
          _loading = true;
          _image = File(pickedFile.path);
          print(_image);
        });
        classifyImage(_image!);
      } else {
        print('No image selected.');
      }
    });
  } // Function to get image from Camera

  pickImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);
    if (pickedFile == null) return null;
    setState(() {
      _loading = true;
      _image = File(pickedFile.path);
    });
    classifyImage(_image!);
  } // Function to get image from gallery

  classifyImage(File image) async {
    var output = await Tflite.runModelOnImage(
      path: image.path,
      numResults: 7,
      threshold: 0.4,
      imageMean: 127.5,
      imageStd: 127.5,
    );
    setState(() {
      _loading = false;
      _outputs = output!;
    });
  }

  loadModel() async {
    await Tflite.loadModel(
      model: "assets/model_unquant.tflite",
      labels: "assets/labels.txt",
    );
  }


  @override
  void dispose() {
    Tflite.close();
    super.dispose();
  }
}
