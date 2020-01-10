import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';


class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {


  TextEditingController _urlController = TextEditingController();
  TextEditingController _hostNameController = TextEditingController();
  TextEditingController _userController = TextEditingController();
  TextEditingController __passwordController = TextEditingController();
  String _token;
  

   _login() async {

    var corpo = json.encode(
        {
          "jsonrpc": "2.0",
          "method": "user.login",
          "params": {
            "user": "",
            "password": ""
          },
          "id": 1
        }
    );

    http.Response response = await http.post(
        _urlController.text+"/zabbix/api_jsonrpc.php",
        headers: {
          "Content-Type": "application/json-rpc"
        },
        body: corpo
    );

    print("resposta: ${response.statusCode}");
    print("resposta: ${response.body}");
    Map<String, dynamic> dadosJson = json.decode( response.body );

    _token = dadosJson["result"];

  }

  _logout() async
  {
    var corpo = json.encode(
        {
          "jsonrpc": "2.0",
          "method": "user.logout",
          "params": [],
          "id": 1,
          "auth": _token
        }
    );

    http.Response response = await http.post(
        _urlController.text+"/zabbix/api_jsonrpc.php",
        headers: {
          "Content-Type": "application/json-rpc"
        },
        body: corpo
    );

    print("resposta: ${response.statusCode}");
    print("resposta: ${response.body}");
    Map<String, dynamic> dadosJson = json.decode( response.body );

    _token = dadosJson["result"];
  }

  _getHosts() async {


    var corpo = json.encode(
        {
          "jsonrpc": "2.0",
          "method": "host.get",
          "params": {
            "filter": {
              "host": [
               _hostNameController.text
              ]
            }
          },
          "auth": _token,
          "id": 1
        }
    );

    http.Response response = await http.post(
        _urlController.text+"/zabbix/api_jsonrpc.php",
        headers: {
          "Content-Type": "application/json-rpc"
        },
        body: corpo
    );

    print("resposta: ${response.statusCode}");
    Map<String, dynamic> dadosJson = json.decode(response.body);
    print(dadosJson);
    for(var host in dadosJson["result"])
      {
        print(host["hostid"]+ "-"+host["host"]);
        //_hostNameController = host["host"];
      }
  }



  @override
  Widget build(BuildContext context) {
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
                onPressed: _login,
              ),
              TextField(
                controller: _hostNameController,
                keyboardType: TextInputType.url,
                obscureText: false,
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: "Enter a hostname"
                ),
              ),
              RaisedButton(
                child: Text("Buscar hosts"),
                onPressed: _getHosts,
              ),
              Text(
                _hostNameController.text
              ),
              RaisedButton(
                child: Text("Log out"),
                onPressed: _logout,
              ),
            ],
          ),
        ),
      )
    );
  }
}
