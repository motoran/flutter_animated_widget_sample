import 'package:firebase/firebase.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

GlobalKey<_MyHomePageState> rootKey = GlobalKey<_MyHomePageState>();

void main() {
  runApp(MyApp(key: rootKey));
}

class MyApp extends StatelessWidget {
  MyApp({Key key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Animated Widget sample',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Animated Widget sample'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  static const _alignments = [
    Alignment.topRight,
    Alignment.topCenter,
    Alignment.topLeft,
    Alignment.bottomRight,
    Alignment.bottomCenter,
    Alignment.bottomLeft,
  ];
  int _alignmentButton = 0;
  bool _alignmentSampleCode = false;
  int _containerButton = 0;
  bool _containerSampleCode = false;
  int _textStyleButton = 0;
  bool _textStyleSampleCode = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              SizedBox(height: 50),
              baseUi('AnimatedAlign', animatedAlignSample(), 0),
              baseUi('AnimatedContainer', animatedContainer(), 1),
              baseUi('AnimatedDefaultTextStyle', animatedDefaultTextStyle(), 2),
              SizedBox(height: 50),
            ],
          ),
        ),
      ),
    );
  }

  Widget baseUi(String title, Widget childWidget, int type) {
    return Card(
      color: Colors.white60,
      child: Column(children: <Widget>[
        Text(title,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
        AnimatedContainer(
          height: (isShowSampleCode(type)) ? 900.0 : 450.0,
          width: 480,
          duration: Duration(milliseconds: 200),
          curve: Curves.fastOutSlowIn,
          child: Column(
            children: <Widget>[
              Container(
                height: 380,
                child: Align(alignment: Alignment.center, child: childWidget),
              ),
              Align(
                alignment: Alignment.bottomRight,
                child: Row(children: <Widget>[
                  SizedBox.fromSize(size: Size(300, 10)),
                  RaisedButton(
                      child: Text('サンプルコード'),
                      color: Colors.grey,
                      onPressed: () {
                        setState(() {
                          sampleCodeDisplayedSwitch(type);
                        });
                      }),
                  SizedBox.fromSize(size: Size(10, 10)),
                  Container(
                    width: 50,
                    height: 50,
                    child: RaisedButton(
                      color: Colors.lightBlue,
                      onPressed: () {
                        setState(() {
                          animatedButtonIncrement(type);
                        });
                      },
                      child: Icon(Icons.refresh),
                    ),
                  ),
                ]),
              ),
              if (isShowSampleCode(type)) sampleCode(type),
            ],
          ),
        ),
      ]),
    );
  }

  Widget sampleCode(int type) {
    return Align(
      alignment: Alignment.bottomLeft,
      child: Text(sampleCodeList(type)),
    );
  }

  String sampleCodeList(int type) {
    switch (type) {
      case 0:
        return '\n  static const _alignments = [\n　　　Alignment.topRight,\n　　　Alignment.topCenter,\n　　　Alignment.topLeft,\n　　　Alignment.bottomRight,\n　　　Alignment.bottomCenter,\n　　　Alignment.bottomLeft,\n    ];  \n\n====================\n\nAnimatedAlign(\n　alignment: _alignments[_alignmentButton % 6],\n　duration: const Duration(milliseconds: 100),\n　child: Container(\n  　  width: 50,\n  　  height: 50,\n  　  color: Colors.red,\n    ),\n    curve: Curves.linear,\n );';
      case 1:
        return 'AnimatedContainer(\n        width: (_containerFlag) ? 300.0 : 100.0,\n        height: (_containerFlag) ? 100.0 : 300.0,\n        color: (_containerFlag) ? Colors.red : Colors.blue,\n        alignment: (_containerFlag)\n  　　　  ? Alignment.bottomCenter\n    　　　    : AlignmentDirectional.topCenter,\n        duration: Duration(milliseconds: 500),\n        curve: Curves.fastOutSlowIn,\n        child: FlutterLogo(size: 75),\n);';
      case 2:
        return 'AnimatedDefaultTextStyle(\n        style: (isTextSmall) ? \n　　　TextStyle(\n　　　　　color: Colors.black,\n　　　　　fontSize: 30,\n　　　　　fontWeight: FontWeight.w300)\n            : TextStyle(\n　　　　　color: Colors.blueAccent,\n 　　　　　fontSize: 100,\n　　　　　fontWeight: FontWeight.w900),\n        duration: Duration(milliseconds: 200),\n        child: Text( String() ),\n    );';
    }
    return '';
  }

  void animatedButtonIncrement(int type) {
    switch (type) {
      case 0:
        _alignmentButton++;
        break;
      case 1:
        _containerButton++;
        break;
      case 2:
        _textStyleButton++;
        break;
    }
  }

  bool isShowSampleCode(int type) {
    switch (type) {
      case 0:
        return _alignmentSampleCode;
        break;
      case 1:
        return _containerSampleCode;
        break;
      case 2:
        return _textStyleSampleCode;
        break;
    }
    return false;
  }

  void sampleCodeDisplayedSwitch(int type) {
    switch (type) {
      case 0:
        _alignmentSampleCode = !_alignmentSampleCode;
        break;
      case 1:
        _containerSampleCode = !_containerSampleCode;
        break;
      case 2:
        _textStyleSampleCode = !_textStyleSampleCode;
        break;
    }
  }

  Widget animatedDefaultTextStyle() {
    return AnimatedDefaultTextStyle(
      style: (_textStyleButton % 2 == 0)
          ? TextStyle(
              color: Colors.black, fontSize: 30, fontWeight: FontWeight.w300)
          : TextStyle(
              color: Colors.blueAccent,
              fontSize: 100,
              fontWeight: FontWeight.w900),
      duration: Duration(milliseconds: 200),
      child: Text('HOGE'),
    );
  }

  Widget animatedAlignSample() {
    return AnimatedAlign(
      alignment: _alignments[_alignmentButton % 6],
      duration: const Duration(milliseconds: 100),
      child: Container(
        width: 50,
        height: 50,
        color: Colors.red,
      ),
      curve: Curves.linear,
    );
  }

  //公式サンプル:https://api.flutter.dev/flutter/widgets/AnimatedContainer-class.html
  Widget animatedContainer() {
    return AnimatedContainer(
      width: (_containerButton % 2 == 0) ? 300.0 : 100.0,
      height: (_containerButton % 2 == 0) ? 100.0 : 300.0,
      color: (_containerButton % 2 == 0) ? Colors.red : Colors.blue,
      alignment: (_containerButton % 2 == 0)
          ? Alignment.bottomCenter
          : AlignmentDirectional.topCenter,
      duration: Duration(milliseconds: 500),
      curve: Curves.fastOutSlowIn,
      child: FlutterLogo(size: 75),
    );
  }
}
