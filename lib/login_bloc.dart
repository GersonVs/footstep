import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:footstep/validador_de_login.dart';
import 'package:rxdart/rxdart.dart';
import 'package:rxdart/subjects.dart';

class LoginBloc extends BlocBase with LoginValidators{ //with traz o login validators

  final _emailController = BehaviorSubject<String>();
  final _senhaController = BehaviorSubject<String>();

  Stream<String> get outEmail => _emailController.stream.transform(validateEmail); //ouve a senha q é digitada e se for valida transforma e retorna
  Stream<String> get outSenha => _senhaController.stream.transform(validateSenha);

  Stream<bool> get outSubmitValid => Observable.combineLatest2(
    outEmail, outSenha, (a , b) => true
    //se contiver dado é valido... 
  ); //coloco minhas duas streams e combino elas , como se fosse um T

  Function(String) get changeEmail => _emailController.sink.add; //o q eu mandar nessa função vai ser mandado para o meu email controller automaticamente
  Function(String) get changeSenha => _senhaController.sink.add;

  @override
  void dispose() {
    _emailController.close();
    _senhaController.close();
    
  }

}