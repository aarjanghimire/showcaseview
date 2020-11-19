import 'package:flashlight/flashlight.dart';
import 'package:flutter/material.dart';
import 'package:showcaseview/showcaseview.dart';
import 'dart:developer';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: ShowCaseWidget(
          onStart: (index, key) {
            log('onStart: $index, $key');
          },
          onComplete: (index, key) {
            log('onComplete: $index, $key');
          },
          builder: Builder(builder: (context) => MainPage()),
          autoPlay: true,
          autoPlayDelay: Duration(seconds: 3),
          autoPlayLockEnable: true,
        ),
      ),
    );
  }
}

class MainPage extends StatefulWidget{
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage>{

  bool hash = false;

  GlobalKey _one = GlobalKey();
  GlobalKey _two = GlobalKey();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
        ShowCaseWidget.of(context).startShowCase([_one,_two]);
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.red,
            title: Showcase(
              description: 'This is title',
              key: _two,
              child: Text('Torch')
            ),
          ),
          floatingActionButton: Showcase(
            key: _one,
            title: 'Torch',
            description: 'Press to on/off torch',
            child: RawMaterialButton(
              onPressed: () {
                setState(() {
                  hash = !hash;
                });
                light(hash);
              },
              fillColor: Colors.redAccent,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(50.0)
              ),
              constraints: BoxConstraints.tightFor(height: 70.0, width:150.0),
              child: Icon(
                (hash)?Icons.flash_off:Icons.flash_on,
                color: Colors.white,
                size: 40.0,
              ),
            ),
          ),
        );
  }
  void light(hash){
    if (hash) {
      Flashlight.lightOn();
    } 
    else {
      Flashlight.lightOff();
    }
  }
}