import 'package:api_zabbix/Api.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  TextEditingController _hostNameController = TextEditingController();
  var _nomeHost ="Resultado";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Home"),
      ),
      body: Container(
        margin: EdgeInsets.all(16),
        child: Column(
          children: <Widget>[
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
              onPressed: (){
                Api.getHosts(_hostNameController.text);
              },
            ),
            Text(
                _nomeHost
            ),
            RaisedButton(
              child: Text("Log out"),
              onPressed: (){
                Api.logout();
              },
            ),
          ],
        ),
      ),
    );
  }
}
