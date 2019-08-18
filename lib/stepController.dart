import 'dart:async';

import 'package:rxdart/rxdart.dart';
import 'package:bloc_pattern/bloc_pattern.dart';


class StepController extends BlocBase{

  int passos = 0;
  int tempo = 0;
  int soma = 0;

  BehaviorSubject<int> passosSubject = new BehaviorSubject<int>();
  Stream<int> get outPassos => passosSubject.stream;
  Sink<int> get inPassos => passosSubject.sink;
  
  BehaviorSubject<int> tempoSubject = new BehaviorSubject<int>();
  Stream<int> get outTempo => tempoSubject.stream;
  Sink<int> get inTempo => tempoSubject.sink;

  BehaviorSubject<int> somaSubject = new BehaviorSubject<int>();
  Stream<int> get outSoma => somaSubject.stream.map((intput) => intput + intput);
  Sink<int> get inSoma => somaSubject.sink;


  Stream<int> stepsCounter = new Observable.just(0).cast<int>();
  Stream<int> timeCounter = new Observable.just(0).cast<int>();

  stepController(){
    inPassos.add(passos);
    inTempo.add(tempo);
    inSoma.add(soma);
  }


  int somar = 0;
  Stream<int> startCountingSoma(){
    
    for(int i = 0 ; i<10 ; i++){
    
      return new Observable.periodic(new Duration(seconds: 10), (i) => somar = somar + 10)
      .cast<int>();
    }

  }
  Stream<int> stopSoma(){
    somar - 10;
  }
  

  Stream<String> startCountingtime(){
    
    return new Observable.periodic(new Duration(seconds: 1), (i) => ++i)
    .map((i) => '${(i / 60).floor()}m: ${(i % 60).round()}s')
    .cast<String>();
  }


  Stream<int> startCountingstep(){
    return new Observable.periodic(new Duration(seconds: 1), (i) => ++i)
      
      .cast<int>();
  }


  countPassos(int contador){
    passos = passos + contador;
    stepsCounter.listen((i) => i);
    inPassos.add(passos);
  }

  countTempo(int contador){
    tempo = tempo + contador;
    inTempo.add(tempo);
  }


  
  void close() {
    passosSubject.close();
    tempoSubject.close();
  }


}