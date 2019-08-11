import 'package:flutter/material.dart';
import 'PrimeiraPagina.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/services.dart';


void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    title: "FootStep",
    home: PrimeiraPagina(),
  ));
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

@override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  void initState() {
    SystemChrome.setEnabledSystemUIOverlays([]);
    super.initState();
    gerarDados();
  }

  Bloc bloc = Bloc();
  int countMedia = 0;

  void gerarDados() async {
    // dados aleatorios
    Random _randon = Random();

    // atualizando a tela
    setState(() {
      Timer.periodic(Duration(seconds: 1), (Timer timer) {
        int batimento = _randon.nextInt(250);
        int oxigenio = _randon.nextInt(100);
        int dCarbonico = _randon.nextInt(100);

        int min = 7, max = 20;
        int pressaoValue1 = min + _randon.nextInt(max - min);

        int min2 = 5, max2 = 11;
        int pressaoValue2 = min2 + _randon.nextInt(max2 - min2);

        int min3 = 20, max3 = 40;
        int temperatura = min3 + _randon.nextInt(max3 - min3);

        bloc.bpmFunction(batimento);
        bloc.bpmFunction(batimento);
        bloc.temperatura(temperatura);
        bloc.pressaoArterial(pressaoValue1, pressaoValue2);
        bloc.o2(oxigenio);
        bloc.co2(dCarbonico);

        // contador do calc da media
        countMedia++;

        if (batimento > 200 || batimento < 40) {
          bloc.paradaCardiaca();
          bloc.pRespiratoria();
        }
        if (countMedia == 10) {
          bloc.bpmMedia();
          countMedia = 0;
          bloc.pRespiratoria();
        }
      });
    });
  }