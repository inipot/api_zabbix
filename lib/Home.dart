import 'package:api_zabbix/Api.dart';
import 'package:api_zabbix/Login.dart';
import 'package:api_zabbix/model/HostGroup.dart';
import 'package:flutter/material.dart';


class Home extends StatefulWidget {

  Home({@required this.api});

  final Api api;
  //final Host host;
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  bool _isLoading = false;
  TextEditingController _hostNameController = TextEditingController();
  var _nomeHost ="Resultado";

  @override
  Widget build(BuildContext context) {


    HostGroup hostGroup = HostGroup(api: widget.api);
    print(widget.api.url+widget.api.token);
    return Scaffold(
      appBar: AppBar(
        title: Text("Home"),
      ),
      body: Center(
        //margin: EdgeInsets.all(16),
        child: _isLoading
            ? CircularProgressIndicator()
            : Column(
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
              onPressed: () async{
                var res = await hostGroup.getHostGroups();
                if(res != null)
                  {
                    HostGroup.fromJson(res);
                  }
              },
            ),
            Text(
                _nomeHost
            ),
            RaisedButton(
              child: Text("Log out"),
              onPressed: () async{
                setState(() => _isLoading = true);
                var logout = await widget.api.logout();
                setState(() => _isLoading = false);
                if(logout["result"].toString() == "true")
                {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => Login()));
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
