import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class RecipePage extends StatefulWidget {
  late final name;
  late final image;
  late final ingredient;
  late final procedure;

  RecipePage({required this.name, required this.image, required this.ingredient, required this.procedure});
  @override
  _RecipePageState createState() => _RecipePageState();
}

class _RecipePageState extends State<RecipePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                        child: Center(child: Text(widget.name, style: TextStyle(fontSize: 22.0),))
                    )
                  ],
                ),
              ),
              Expanded(
                  child: ListView(
                    children: [
                      Container(
                        height: 300.0,
                        width: double.infinity,
                        child: ClipRect(
                          child: Image.asset('images/${widget.image}', fit: BoxFit.cover,),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.all(8.0),
                        padding: EdgeInsets.symmetric(vertical: 5.0, horizontal: 8.0),
                        decoration: BoxDecoration(
                          color: Colors.black.withOpacity(0.4),
                          border: Border.all(
                            color: Colors.grey,
                          ),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Ingredients :',
                              style: TextStyle(
                                fontFamily: 'Handlee',
                                fontSize: 26.0,
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                            SizedBox(height: 6.0,),
                            Text(
                              widget.ingredient,
                              style: TextStyle(
                                fontSize: 20.0,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.all(8.0),
                        padding: EdgeInsets.symmetric(vertical: 5.0, horizontal: 8.0),
                        decoration: BoxDecoration(
                          color: Colors.black.withOpacity(0.4),
                          border: Border.all(
                            color: Colors.grey,
                          ),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Procedure :',
                              style: TextStyle(
                                fontFamily: 'Handlee',
                                fontSize: 26.0,
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                            SizedBox(height: 6.0,),
                            Text(
                              widget.procedure,
                              style: TextStyle(
                                fontSize: 20.0,
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  )
              ),
            ],
          ),
        ),
      ),
    );
  }
}
