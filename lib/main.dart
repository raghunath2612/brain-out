import 'package:flutter/material.dart';
import 'package:flutter_gifimage/flutter_gifimage.dart';

double display = 0;
String fruit = '';
double sizeOfText = 37;
double fontSize = 20;
double sizeOfKey = 0;
bool isSuccessful = false;

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> with TickerProviderStateMixin{
  GifController controller;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller = GifController(vsync: this);
  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: SafeArea(
          child: Container(
            child: Column(
              children: <Widget>[
                RaisedButton(
                  child: Text('click me'),
                  onPressed: (){
                    controller.repeat(min:0,max:29,period:Duration(seconds: 3));
                  },
                ),
                GifImage(image: AssetImage('assets/walk-through-water'), controller: controller),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Column buildSecond() {
    return Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 40.0,horizontal: 50),
                child: Row(
                  children: <Widget>[
                    Text(
                      'Find ',
                      style: TextStyle(
                          fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    Stack(
                      children: <Widget>[
                        GestureDetector(
                          child: AnimatedContainer(
                            width: sizeOfText,
                            duration: Duration(milliseconds: 500),
                            child: Text(
                              'key',
                              style: TextStyle(
                                  fontSize: fontSize,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                          onTap: () {
                            setState(() {
                              sizeOfText = 0;
                              fontSize = 0;
                              sizeOfKey = 37;
                            });
                          },
                        ),
                        AnimatedContainer(
                          width: sizeOfKey,
                          duration: Duration(milliseconds: 500),
                          child: Draggable(
                            data: 'key',
                            feedback: Image.asset(
                              'assets/key-icon.png',
                              width: 70,
                            ),
                            childWhenDragging: Container(),
                            child: !isSuccessful
                                ? Image.asset(
                                    'assets/key-icon.png',
                                  )
                                : Container(),
                          ),
                        )
                      ],
                    ),
                    Text(
                      'to unlock the door',
                      style: TextStyle(
                          fontSize: 20, fontWeight: FontWeight.bold),
                    )
                  ],
                ),
              ),
              Stack(
                children: <Widget>[
                  Align(
                    alignment: Alignment.bottomRight,
                    child: Image.asset('assets/tree-icon.png'),
                  ),
                  DragTarget<String>(
                    builder: (context, candidateData, rejectedData) {
                      return isSuccessful
                          ? Image.asset(
                              'assets/opendoor-icon.png',
                            )
                          : Image.asset('assets/closeddoor-icon.png');
                    },
                    onWillAccept: (data) => data == 'key',
                    onAccept: (data) {
                      print('accepted');
                      setState(() {
                        isSuccessful = true;
                      });
                    },
                  ),
                  Positioned(
                    left: 130,
                    top: 190,
                    child: Draggable(
                      childWhenDragging: Container(),
                      feedback: Image.asset(
                        'assets/dog-icon.png',
                        width: 100,
                      ),
                      child: Image.asset(
                        'assets/dog-icon.png',
                        width: 100,
                      ),
                    ),
                  ),
                  Positioned(
                    top: 190,
                    child: Draggable(
                      childWhenDragging: Container(),
                      feedback: Image.asset(
                        'assets/flower-icon.png',
                        width: 70,
                      ),
                      child: Image.asset(
                        'assets/flower-icon.png',
                        width: 70,
                      ),
                    ),
                  ),
                ],
                overflow: Overflow.visible,
              )
            ],
          );
  }

  Column buildFirst() {
    return Column(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 70.0),
          child: Text(
            'Find the lagest one',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            buildStack('assets/apple-icon.png', 'assets/wrong-icon.png', 80),
            buildStack('assets/banana-icon.png', 'assets/wrong-icon.png', 80)
          ],
        ),
        SizedBox(
          height: 20,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            buildStack(
                'assets/cabbage-icon.png', 'assets/correct-icon.png', 70),
            buildStack('assets/carrot-icon.png', 'assets/wrong-icon.png', 130)
          ],
        )
      ],
    );
  }

  Stack buildStack(String image, String response, double width) {
    return Stack(
      alignment: Alignment.center,
      children: <Widget>[
        GestureDetector(
          child: Image.asset(
            image,
            width: width,
          ),
          onTap: () {
            setState(() {
              display = 70;
              fruit = image;
            });
            Future.delayed(Duration(milliseconds: 500), () {
              setState(() {
                display = 0;
              });
            });
          },
        ),
        AnimatedContainer(
          width: fruit == image ? display : 0,
          child: Image.asset(response),
          duration: Duration(milliseconds: 500),
        )
      ],
    );
  }
}
