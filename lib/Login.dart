import 'package:api_zabbix/Api.dart';
import 'package:api_zabbix/Home.dart';
import 'package:flutter/material.dart';


class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {


  TextEditingController _urlController = TextEditingController();
  TextEditingController _userController = TextEditingController();
  TextEditingController __passwordController = TextEditingController();
  //var _nomeHost = "";


  @override
  Widget build(BuildContext context) {
    // _login();
    return Scaffold(
      appBar: AppBar(
        title: Text("Teste api zabbix"),
      ),
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            children: <Widget>[
              TextField(
                controller: _urlController,
                keyboardType: TextInputType.url,
                obscureText: false,
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: "Enter a url"
                ),
              ),
              TextField(
                controller: _userController,
                keyboardType: TextInputType.url,
                obscureText: false,
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: "Usuário"
                ),
              ),
              TextField(
                controller: __passwordController,
                keyboardType: TextInputType.visiblePassword,
                obscureText: true,
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: "Senha"
                ),
              ),
              RaisedButton(
                child: Text("Login"),
                onPressed: (){
                  Api.login(_urlController.text, _userController.text, __passwordController.text);
                  Navigator.push(context, MaterialPageRoute(builder: (context) => Home()));
                },
              ),
            ],
          ),
        ),
      )
    );
  }
}
