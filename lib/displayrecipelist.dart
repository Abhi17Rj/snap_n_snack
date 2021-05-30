import 'dart:async';

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:snapnsnack/recipe.dart';

class RecipeList extends StatefulWidget {
  late final index;
  RecipeList({this.index});
  @override
  _RecipeListState createState() => _RecipeListState();
}

class _RecipeListState extends State<RecipeList> {

  bool spinner = true;

  final firestoreInstance = FirebaseFirestore.instance;

  late var recipeRef;


  String getImageRecipe(var i){
    String compare = i.toString();
    if(compare == '0'){
      return "Brinjal";
    } else if (compare == '1') {
      return "Cabbage";
    } else if (compare == '2') {
      return "Carrot";
    } else if (compare == '3') {
      return "Cauliflower";
    } else if (compare == '4') {
      return "Peas";
    } else if (compare == '5') {
      return "Potato";
    } else {
      return "Tomato";
    }
  }

  late String _positon;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _positon = getImageRecipe(widget.index);
    getRecipeData(_positon);
    secondRefresh();
  }

  getRecipes(){
    recipeRef = FirebaseFirestore.instance.collection(_positon);
    recipeRef.get().then((QuerySnapshot qs) => {
      qs.docs.forEach((DocumentSnapshot ds) {
        print(ds.data());
    })
    });
  }
  List<Widget> itemList = [];
  List<Widget> demo = [];

  getRecipeData(String docId) async{

    await firestoreInstance.collection(docId).get().then((querySnapshot) {
      querySnapshot.docs.forEach((result) {
        print(result.data());
        var data = result.data();
        final name = data["Name"];
        final image = data["Image"];
        final ingredient = data["Ingredients"];
        final procedure = data["Procedure"];

        final taskWidget = TaskMessage(nexPage: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return RecipePage(name: name, image: image, ingredient: ingredient, procedure: procedure);
          }));
        }, name: name, imageURL: image,
        );
        setState(() {
          demo.add(taskWidget);
        });
        print(taskWidget);
      });
    });
    setState(() {
      itemList = demo;
    });
  }

  secondRefresh() {
    Timer(Duration(seconds: 5), () {
      // 5s over, navigate to a new page
      setState(() {
        spinner = false;
      });
      print('Timer');
    });


  }


  @override
  Widget build(BuildContext context) {
    return LoadingOverlay(
      isLoading: spinner,
      child: Scaffold(
        body: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('images/bg.jpg'),
              fit: BoxFit.fill,
              colorFilter: ColorFilter.mode(Colors.black.withOpacity(0.4), BlendMode.dstATop),
            ),
          ),
          constraints: BoxConstraints.expand(),
          child: SafeArea(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                  padding: EdgeInsets.all(20.0),
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.4),
                  ),
                  child: Row(
                    children: [
                      GestureDetector(
                          onTap: (){
                            Navigator.pop(context);
                          },
                          child: Icon(Icons.arrow_back, size: 24.0,)
                      ),
                      Expanded(
                          child: Center(child: Text('Recipes of $_positon', style: TextStyle(fontSize: 22.0),))
                      )
                    ],
                  ),
                ),
                Expanded(
                    child: ListView(
                      children: itemList,
                    )
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class TaskMessage extends StatefulWidget {

  late final String name;
  late final String imageURL;
  late var nexPage;

  TaskMessage({required this.name, required this.imageURL, required this.nexPage});

  @override
  _TaskMessageState createState() => _TaskMessageState();
}

class _TaskMessageState extends State<TaskMessage> {

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.nexPage,
      child: Container(
        margin: EdgeInsets.all(14.0),
        decoration: BoxDecoration(
          color: Colors.black.withOpacity(0.2),
          borderRadius: BorderRadius.circular(20.0),
          border: Border.all(
            color: Colors.grey,
          ),
        ),
        height: 280.0,
        child: Column(
          children: [
            Container(
              height: 230.0,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20.0),
                child: Image.asset('images/${widget.imageURL}', fit: BoxFit.fill,),
              ),
            ),
            SizedBox(height: 10.0,),
            Container(
              child: Center(
                child: Text(widget.name,
                style: TextStyle(fontFamily: 'Handlee', fontSize: 22.0, color: Colors.white, fontWeight: FontWeight.w800),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}