import 'package:api_zabbix/Api.dart';
import 'package:api_zabbix/Home.dart';
import 'package:flutter/material.dart';


class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {

  bool _isLoading = false;
  bool testeErro = false;
  TextEditingController _urlController = TextEditingController();
  TextEditingController _userController = TextEditingController();
  TextEditingController __passwordController = TextEditingController();


  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text("Teste api zabbix"),
      ),
      body:SingleChildScrollView(
          child: Center(
            child: _isLoading
                ? Center(
              child: CircularProgressIndicator(),
            )
                : Column(
              children: <Widget>[
                TextField(
                  controller: _urlController,
                  keyboardType: TextInputType.url,
                  obscureText: false,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: "Enter a url",
                    errorText: testeErro ? "verdadeiro" : null
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
                  onPressed: () async{
                    setState(() => _isLoading = true);
                    Api api = Api(url: "https://zabbix.karyon.com.br/api_jsonrpc.php");
                    //Api api = Api(url: "http://infrazbx01.evtec.karyon.com.br/zabbix/api_jsonrpc.php");
                    var res = await api.login("convidado", __passwordController.text);
                    print(api.url);
                    setState(() => _isLoading = false);
                    api = Api.fromJson(res,api);
                    print(api.token);
                    print(api.url);
                    if (api != null){
                      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Home(api: api)));
                    }
                  },
                ),
              ],
            ),
          )
      ),
    );
  }
}
