import 'package:flutter/material.dart';

class InfoPage extends StatefulWidget {
  @override
  _InfoPageState createState() => _InfoPageState();
}

class _InfoPageState extends State<InfoPage> {
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
                padding: EdgeInsets.all(15.0),
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
                        child: Center(child: Text('Project Info', style: TextStyle(fontSize: 22.0),))
                    )
                  ],
                ),
              ),
              Expanded(
                child: Container(
                  child: Column(
                    children: [
                      Container(
                        height: 190.0,
                        margin: EdgeInsets.all(8.0),
                        padding: EdgeInsets.symmetric(horizontal: 20.0),
                        decoration: BoxDecoration(
                          color: Colors.black.withOpacity(0.2),
                          border: Border.all(
                            color: Colors.grey,
                            width: 2.0,
                          ),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Guided by : Prof. Vikash Kr. Scientist',
                              style: TextStyle(
                                fontFamily: 'Handlee',
                                fontSize: 26.0,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            Center(
                              child: Container(
                                child: Column(
                                  children: [
                                    Container(
                                      height: 100.0,
                                      width: 100.0,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(100.0),
                                        border: Border.all(color: Colors.grey, width: 2.0),
                                      ),
                                      margin: EdgeInsets.symmetric(horizontal: 15.0, vertical: 5.0),
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(50.0),
                                        child: Image.asset('images/vks.jpg', fit: BoxFit.fill,),
                                      ),
                                    ),
                                    Text('Assitant Professor'),
                                    Text('BIT Sindri')
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.symmetric(vertical: 10.0),
                        width: double.infinity,
                        child: Center(
                          child: Container(
                            width: 310.0,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  'Project Team :',
                                  style: TextStyle(
                                    fontFamily: 'Handlee',
                                    fontSize: 24.0,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                                Container(
                                  child: Row(
                                    children: [
                                      Container(
                                        height: 75.0,
                                        width: 75.0,
                                        padding: EdgeInsets.all(1.0),
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(100.0),
                                          border: Border.all(color: Colors.grey),
                                        ),
                                        margin: EdgeInsets.symmetric(horizontal: 15.0, vertical: 5.0),
                                        child: ClipRRect(
                                          borderRadius: BorderRadius.circular(50.0),
                                          child: Image.asset('images/ab.jpg', fit: BoxFit.fill,),
                                        ),
                                      ),
                                      SizedBox(height: 2.0,),
                                      Text(
                                        'Abhishek Ranjan - (1709001)',
                                        style: TextStyle(
                                          fontFamily: 'Handlee',
                                          fontSize: 19.0,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                      'Kunal Mahajan - (1709013)',
                                      style: TextStyle(
                                        fontFamily: 'Handlee',
                                        fontSize: 19.0,
                                        ),
                                      ),
                                      SizedBox(height: 2.0,),
                                      Container(
                                        height: 75.0,
                                        width: 75.0,
                                        padding: EdgeInsets.all(1.0),
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(100.0),
                                          border: Border.all(color: Colors.grey),
                                        ),
                                        margin: EdgeInsets.symmetric(horizontal: 15.0, vertical: 5.0),
                                        child: ClipRRect(
                                          borderRadius: BorderRadius.circular(50.0),
                                          child: Image.asset('images/km.jpg', fit: BoxFit.fill,),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  child: Row(
                                    children: [
                                      Container(
                                        height: 75.0,
                                        width: 75.0,
                                        padding: EdgeInsets.all(1.0),
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(100.0),
                                          border: Border.all(color: Colors.grey),
                                        ),
                                        margin: EdgeInsets.symmetric(horizontal: 15.0, vertical: 5.0),
                                        child: ClipRRect(
                                          borderRadius: BorderRadius.circular(50.0),
                                          child: Image.asset('images/nks.jpg', fit: BoxFit.fill,),
                                        ),
                                      ),
                                      SizedBox(height: 2.0,),
                                      Text(
                                        'Nikhil Kr. Shandilya - (1709016)',
                                        style: TextStyle(
                                          fontFamily: 'Handlee',
                                          fontSize: 19.0,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        'Nirbhay Anand - (1709018)',
                                        style: TextStyle(
                                          fontFamily: 'Handlee',
                                          fontSize: 19.0,
                                        ),
                                      ),
                                      SizedBox(height: 2.0,),
                                      Container(
                                        height: 75.0,
                                        width: 75.0,
                                        padding: EdgeInsets.all(1.0),
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(100.0),
                                          border: Border.all(color: Colors.grey),
                                        ),
                                        margin: EdgeInsets.symmetric(horizontal: 15.0, vertical: 5.0),
                                        child: ClipRRect(
                                          borderRadius: BorderRadius.circular(50.0),
                                          child: Image.asset('images/na.jpg', fit: BoxFit.fill,),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  child: Row(
                                    children: [
                                      Container(
                                        height: 75.0,
                                        width: 75.0,
                                        padding: EdgeInsets.all(1.0),
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(100.0),
                                          border: Border.all(color: Colors.grey),
                                        ),
                                        margin: EdgeInsets.symmetric(horizontal: 15.0, vertical: 5.0),
                                        child: ClipRRect(
                                          borderRadius: BorderRadius.circular(50.0),
                                          child: Image.asset('images/rk.jpg', fit: BoxFit.fill,),
                                        ),
                                      ),
                                      SizedBox(height: 2.0,),
                                      Text(
                                        'Ravi Kumar - (1709023)',
                                        style: TextStyle(
                                          fontFamily: 'Handlee',
                                          fontSize: 19.0,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
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
