import 'package:api_zabbix/Api.dart';
import 'package:api_zabbix/screens/HomePage.dart';
import 'package:flutter/material.dart';
import 'package:email_validator/email_validator.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  bool _isLoading = false;
  bool testeErro = false;
  TextEditingController _urlController = TextEditingController();
  TextEditingController _userController = TextEditingController();
  TextEditingController __passwordController = TextEditingController();


  @override
  Widget build(BuildContext context) {
    //var _scaffoldKey = new GlobalKey<ScaffoldState>();
    BuildContext _scaffoldContext;

    return Scaffold(
      body: Builder(
        builder: (BuildContext context){
          _scaffoldContext = context;
          return Container(
            decoration: BoxDecoration(color: Color(0xffd40000)),
            padding: EdgeInsets.all(16),
            child: Center(
              child: SingleChildScrollView(
                padding: EdgeInsets.all(8),
                child: _isLoading
                      ? CircularProgressIndicator(valueColor: AlwaysStoppedAnimation<Color>(Colors.white),)
                //Column(
//                    children: <Widget>[
//                      Center(
//                        child: CircularProgressIndicator(
//                            valueColor: AlwaysStoppedAnimation<Color>(Colors.black)
//                        ),
//                      )
//                    ]
//                  )
                      :
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.only(bottom: 32),
                        child: Image.asset("images/zabbix_logo.png"),
                      ),
                      TextField(
                        controller: _urlController,
                        keyboardType: TextInputType.url,
                        obscureText: false,
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.fromLTRB(32, 16, 32, 16),
                          filled: true,
                          fillColor: Colors.white,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(32)
                            ),
                            hintText: "Enter a url",
                            errorText: testeErro ? "verdadeiro" : null
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 8, bottom: 8),
                        child: TextField(
                          controller: _userController,
                          keyboardType: TextInputType.url,
                          decoration: InputDecoration(
                              filled: true,
                              fillColor: Colors.white,
                              contentPadding: EdgeInsets.fromLTRB(32, 16, 32, 16),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(32)
                              ),
                              hintText: "Usuário"
                          ),
                        ),
                      ),
                      TextField(
                        controller: __passwordController,
                        keyboardType: TextInputType.visiblePassword,
                        obscureText: true,
                        decoration: InputDecoration(
                            filled: true,
                            fillColor: Colors.white,
                            contentPadding: EdgeInsets.fromLTRB(32, 16, 32, 16),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(32)
                            ),
                            hintText: "Senha"
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 16, bottom: 10),
                        child: RaisedButton(
                          child: Text("Login",
                            style: TextStyle(color: Colors.white,fontSize: 20),
                          ),
                          padding: EdgeInsets.fromLTRB(32, 16, 32, 16),
                          color: Color(0xffed1414),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(32)
                          ),
                          onPressed: () async{
                            setState(() => _isLoading = true);
                            Api api = Api(url: "https://zabbix.karyon.com.br/api_jsonrpc.php");
                            //Api api = Api(url: "http://infrazbx01.evtec.karyon.com.br/zabbix/api_jsonrpc.php");
                            var res = await api.login("convidado", __passwordController.text);
                            print(api.url);
                            setState(() => _isLoading = false);
                            api = Api.fromJson(res,api);
                            if(api.token!=null){
                              print(api.token);
                              print(api.url);
                              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => HomePage(api: api)));
                            }
                            else{
                              //setState(() => _isLoading = false);
                              Scaffold.of(_scaffoldContext).showSnackBar(SnackBar(content: Text(api.erro)));
                            }
                          },
                        ),
                      ),
                    ],
                  ),
              ),
            ),
          );
        }
      )

    );
  }
}
