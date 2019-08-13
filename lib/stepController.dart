import 'package:rxdart/rxdart.dart';
import 'package:bloc_pattern/bloc_pattern.dart';


class StepController extends BlocBase{

  int passos = 0;
  int tempo = 0;

  BehaviorSubject<int> passosSubject = new BehaviorSubject<int>();
  Stream<int> get outPassos => passosSubject.stream;
  Sink<int> get inPassos => passosSubject.sink;
  
  BehaviorSubject<int> tempoSubject = new BehaviorSubject<int>();
  Stream<int> get outTempo => tempoSubject.stream;
  Sink<int> get inTempo => tempoSubject.sink;

  Stream<int> stepsCounter = new Observable.just(0).cast<int>();
  

  stepController(){
    inPassos.add(passos);
    inTempo.add(tempo);
  }

  Stream<int> startCounting(){
    print("Hell");
    return new Observable.periodic(new Duration(seconds: 1), (i) => ++i)
      .take(30)
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