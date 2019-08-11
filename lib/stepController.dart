import 'package:rxdart/rxdart.dart';
import 'package:bloc_pattern/bloc_pattern.dart';


class stepController extends BlocBase{

  int passos = 0;
  int tempo = 0;

  BehaviorSubject<int> passosSubject = new BehaviorSubject<int>();
  Stream<int> get outPassos => passosSubject.stream;
  Sink<int> get inPassos => passosSubject.sink;
  
  BehaviorSubject<int> tempoSubject = new BehaviorSubject<int>();
  Stream<int> get outTempo => tempoSubject.stream;
  Sink<int> get inTempo => tempoSubject.sink;

  contPassos(int contador){
    passos = passos + contador;
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