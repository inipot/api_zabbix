import 'package:api_zabbix/Api.dart';
import 'package:api_zabbix/screens/HostPage.dart';
import 'package:api_zabbix/screens/ProblemPage.dart';
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
  int _indexAtual = 0;
  //List<String> lastEventList;
  //List<String> listaEvent;

  Widget telas(int index)
  {
    List<Widget> screens = [
      PageProblem(api: widget.api),
      HostPage()
    ];
    return screens[index];
  }
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text("Zabbix App"),
        backgroundColor: Colors.red,
      ),
      body: Container(
        padding: EdgeInsets.all(10),
        child: telas(_indexAtual),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _indexAtual,
        onTap: (index){
          setState(() {
            _indexAtual = index;
          });
        },
        type: BottomNavigationBarType.fixed,
        fixedColor: Colors.red,
        items: [
          BottomNavigationBarItem(
            title: Text("Problems"),
            icon: Icon(Icons.warning)
          ),
          BottomNavigationBarItem(
              title: Text("Teste"),
              icon: Icon(Icons.add_comment)
          ),
        ],
      ),
    );
  }
}
