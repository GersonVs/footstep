import 'dart:async';


class LoginValidators{
  //Transforma o objeto q vai sair da Stream em outra coisa...recebe string e retorna string nesse caso...
  final validateEmail= StreamTransformer<String, String>.fromHandlers(
    handleData: (email, sink){
      if(email.contains('@')){
         sink.add(email);
      }else{
        sink.addError('Insira um e-mail valido!');
      }
    }
  );

  final validateSenha = StreamTransformer<String, String>.fromHandlers(
    handleData: (senha, sink){
      if(senha.length>4) {
         sink.add(senha);
      }else{
        sink.addError('Insira uma senha maior!');
      }
    }
  );


}