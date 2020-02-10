import 'package:api_zabbix/screens/LoginPage.dart';
import 'package:flutter/material.dart';


void main()
{
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: LoginPage(),
    theme: ThemeData(
      primaryColor: Color(0xffd40000),
      accentColor: Color(0xffed1414),
      //accentColor: Color(0xfff21a1a)
      //accentColor: Color(0xffff4400)
    ),
  ));
}
