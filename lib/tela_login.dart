import 'package:flutter/material.dart';
import 'package:footstep/login_bloc.dart';
import 'main.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _loginBloc = LoginBloc();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        alignment: Alignment.center,
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/imagens/rub1.jpg'),
                    fit: BoxFit.cover
                  )
                ),

          ),
          SingleChildScrollView(
              
              child: Container(
                // teste 
            margin: EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Image.asset(
                  'assets/imagens/FootStepBig.png',
                  scale: 0.7,
                ),
                InputField(
                  icon: Icons.person_outline,
                  hint: 'Usuário',
                  obscure: false,
                  stream: _loginBloc.outEmail,
                  onChanged: _loginBloc.changeEmail,
                  
                ),
                InputField(
                  icon: Icons.vpn_key,
                  hint: 'Senha',
                  obscure: true,
                  stream: _loginBloc.outSenha,
                  onChanged: _loginBloc.changeSenha,
                  
                  
                ),
                SizedBox(
                  height: 32,
                  
                ),
                StreamBuilder<bool>(
                    stream: _loginBloc.outSubmitValid,
                    builder: (context, snapshot) {
                      return SizedBox(
                        height: 50,
                        child: RaisedButton(
                          color: Colors.black,
                          child: Text("Logar"),
                          onPressed: snapshot.hasData ? (){ 
                            Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => MyHomePage()));

                          } : null, //se ñ contem dado o botão é desabilitado
                          textColor: Colors.white,
                          disabledColor: Colors.black.withAlpha(150), //deixa o botão "apagadinho"
                        ),
                      );
                    }),
              ],
            ),
          )),
        ],
      ),
    );
  }
}

class InputField extends StatelessWidget {
  final IconData icon;
  final String hint;
  final bool obscure;

  final Stream<String> stream;
  final Function(String) onChanged;

  InputField({this.icon, this.hint, this.obscure, this.stream, this.onChanged});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<String>(
        //Atualiza a tela toda vez q digito algo
        stream: stream,
        builder: (context, snapshot) {
          return TextField(
            onChanged: onChanged,
            decoration: InputDecoration(
              icon: Icon(
                icon,
                color: Colors.grey[800],
              ),
              hintText: hint,
              hintStyle: TextStyle(
                color: Colors.grey[800],
              ),
              focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                color: Colors.black,
              )),
              contentPadding:
                  EdgeInsets.only(left: 5, right: 30, top: 30, bottom: 30),
              errorText: snapshot.hasError
                  ? snapshot.error
                  : null, //vai mostrar se tem erro ou não
            ),
            style: TextStyle(color: Colors.grey[800]),
            obscureText: obscure,
          );
        });
  }
}
