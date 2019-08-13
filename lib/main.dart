import 'dart:async';

import 'package:flutter/material.dart';
import 'package:footstep/login_bloc.dart';
import 'package:footstep/tela_login.dart';
import 'package:rxdart/rxdart.dart';
import 'stepController.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'FootStep',
      debugShowCheckedModeBanner: false,
      home: LoginScreen(),
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
  StepController sController;
  Stream<int> counter;
  String imageRunningState;
  IconData iconRunningState;
  bool correndo;
  StepController tController;
  Stream<int> time;

  @override
  void initState() {
    time = new Observable.just(0);
    counter = new Observable.just(0);
    sController = new StepController();
    tController = new StepController();
    imageRunningState = 'assets/imagens/grupo1.png';
    iconRunningState = Icons.play_circle_filled;
    correndo = false;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: new Image.asset(
          'assets/imagens/FootStepBig.png',
          fit: BoxFit.cover,
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: Icon(Icons.menu),
          onPressed: () {},
          color: Colors.black,
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.notifications_none),
            onPressed: () {},
            color: Colors.black,
          ),
        ],
        elevation: 6,
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            Container(
              child: Row(
                children: <Widget>[
                  Container(
                    width: 180,
                    height: 80,
                    margin: EdgeInsets.only(left: 15, right: 15, top: 20),
                    decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.all(Radius.circular(12)),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey[200],
                          blurRadius: 3,
                        )
                      ],
                    ),
                    child: Row(
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.only(left: 10),
                          child: Image.asset('assets/imagens/running.png'),
                        ),
                        Align(
                            alignment: Alignment.topCenter,
                            child: Padding(
                              padding: EdgeInsets.only(top: 10, left: 10),
                              child: Text(
                                "Total de passos",
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 12,
                                ),
                              ),
                            )),
                        Padding(
                          padding: EdgeInsets.only(right: 5),
                          child: Text(''),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    width: 180,
                    height: 80,
                    margin: EdgeInsets.only(left: 15, right: 15, top: 20),
                    decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.all(Radius.circular(12)),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey[200],
                          blurRadius: 3,
                        )
                      ],
                    ),
                    child: Row(
                      children: <Widget>[
                        Padding(
                            padding: EdgeInsets.only(left: 10),
                            child: Image.asset('assets/imagens/alarm.png')),
                        Align(
                          alignment: Alignment.center,
                          child: Column(
                            children: <Widget>[
                              Align(
                                  alignment: Alignment.topCenter,
                                  child: Padding(
                                    padding: EdgeInsets.only(top: 10, left: 10),
                                    child: Text(
                                      "Tempo parado",
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 12,
                                      ),
                                    ),
                                  )),
                              Padding(
                                padding: EdgeInsets.only(top: 5),
                                child: StreamBuilder(
                                  stream: time,
                                  builder: (context, snapshot) {
                                    return new Text('${snapshot.data}',
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 25,
                                        ));
                                  },
                                ),
                              ),
                            ],
                          ),
                        )

                        /* 
                        Align(
                            alignment: Alignment.topCenter,
                            child: Padding(
                              padding: EdgeInsets.only(top: 10, left: 10),
                              child: Text(
                                "Tempo parado",
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 12,
                                ),
                              ),
                            )
                        ) */
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Container(
              width: 330,
              height: 330,
              margin: EdgeInsets.only(top: 30, right: 20),
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.all(Radius.circular(360)),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black,
                    spreadRadius: 5,
                  )
                ],
              ),
              child: Row(
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.only(left: 69, top: 20),
                    child: Image.asset(
                      imageRunningState,
                      scale: 0.78,
                    ),
                  ),
                ],
              ),
            ),
            Container(
              width: 120,
              height: 80,
              margin: EdgeInsets.only(
                left: 200,
              ),
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.all(Radius.circular(50)),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black,
                    spreadRadius: 4,
                  )
                ],
              ),
              child: Padding(
                  padding: EdgeInsets.only(left: 15, top: 10),
                  child: new StreamBuilder(
                      stream: counter,
                      builder: (context, AsyncSnapshot<int> snapshot) {
                        return new Text('${snapshot.data}',
                            style: TextStyle(
                              color: Colors.lightBlue,
                              fontSize: 50,
                            ));
                      })),
            ),
            Padding(
              padding: EdgeInsets.only(right: 20),
              child: IconButton(
                  icon: Icon(iconRunningState, color: Colors.black),
                  iconSize: 90,
                  tooltip: 'Start',
                  onPressed: () {
                    if (!correndo) {
                      setState(() {
                        counter = sController.startCounting();
                        time = tController.startCounting();
                        imageRunningState = 'assets/imagens/grupo2.png';
                        iconRunningState = Icons.pause_circle_filled;
                        correndo = true;
                      });
                    } else {
                      correndo = false;
                    }
                  }),
            ),
          ],
        ),
      ),
    );
  }
}
