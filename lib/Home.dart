import 'package:api_zabbix/Api.dart';
import 'package:api_zabbix/Login.dart';
import 'package:api_zabbix/model/Event.dart';
import 'package:api_zabbix/model/EventList.dart';
import 'package:api_zabbix/model/Trigger.dart';
import 'package:api_zabbix/model/TriggerList.dart';
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
  //List<String> lastEventList;
  //List<String> listaEvent;



  Future<TriggerList>recuperarTriggers() async
  {

    Trigger trigger = Trigger(api: widget.api);
    Event event = Event(api: widget.api);
    TriggerList listaTrigger;
    List<String> lastEventList;
    EventList listaEventos;
    lastEventList = [];
    //listaEvent = [];
    List<dynamic> triggers = await trigger.getTriggerWithProblemWithLastEvent();
    if(triggers!=null)
    {
       listaTrigger = TriggerList.fromJson(triggers, widget.api);
    }
    for (int i = 0; i < triggers.length; i++ )
    {
      lastEventList.add(listaTrigger.triggers[i].lastEvent);
    }
    List<dynamic> events = await event.getEventsByEventId(lastEventList);
    if(events!=null)
    listaEventos = EventList.fromJson(events, widget.api);
    //print(listaTrigger.triggers[0].host);

  return listaTrigger;
}

  @override
  Widget build(BuildContext context) {

//    @override
//    initState(){
//      recuperarTriggers();
//    }

    return Scaffold(
      appBar: AppBar(
        title: Text("Home"),
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            Expanded(
              child: FutureBuilder<TriggerList>(
                future: recuperarTriggers(),
                builder: (context,snapshot){
                  switch(snapshot.connectionState){
                    case ConnectionState.none:
                    case ConnectionState.waiting:
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                      break;
                    case ConnectionState.active:
                    case ConnectionState.done:
                      if(snapshot.hasError){
                        print("Erro ao carregar");
                      }
                      else{
                        print("Lista carregou");
                        return ListView.builder(
                          itemCount: snapshot.data.triggers.length,
                            itemBuilder: (context,index){
                              TriggerList list = snapshot.data;
                               var trigger = list.triggers[index];
                               return ListTile(
                                 title: Text(trigger.hosts.hosts[0].nome),
                                 subtitle: Text(trigger.description.replaceAll("{HOST.NAME}", trigger.hosts.hosts[0].nome)),
                               );
                            }
                        );
                      }
                  }
                  return CircularProgressIndicator();
                }
              ),
            ),
            RaisedButton(
              child: Text("Log out"),
              onPressed: () async{
                setState(() => _isLoading = true);
                var logout = await widget.api.logout();
                setState(() => _isLoading = false);
                if(logout["result"].toString() == "true")
                {
                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Login()));
                }
              },
            ),
          ],
        ),
        //margin: EdgeInsets.all(16),
//        child: _isLoading
//            ? CircularProgressIndicator()
//            : Column(
//          children: <Widget>[
//            TextField(
//              controller: _hostNameController,
//              keyboardType: TextInputType.url,
//              obscureText: false,
//              decoration: InputDecoration(
//                  border: OutlineInputBorder(),
//                  hintText: "Enter a hostname"
//              ),
//            ),
//            RaisedButton(
//              child: Text("Buscar hosts"),
//              onPressed: () async{
//                List<dynamic> hostgroups = await hostGroup.getHostGroupsToJson();
//                var teste;
//                for ( teste in hostgroups)
//                  {
//                    print(teste["name"]);
//                  }
//                //var res = await host.getHosts();
//                if(hostgroups != null)
//                  {
//                    HostGroupList.fromJson(hostgroups,widget.api);
//                  }
//              },
//            ),
//            RaisedButton(
//              child: Text("Event get"),
//              onPressed: () async{
//                List<dynamic> events = await event.getEventsByEventId(lastEventList);
//                for(var teste in events)
//                  {
//                    print(teste);
//                  }
//                if(events!=null)
//                  {
//                    listaEventos = EventList.fromJson(events, widget.api);
//
//                    for(int i = 0; i < events.length;i++)
//                      {
//                        listaEvent.add(listaEventos.events[i].triggerId);
//                        print(listaEvent[i]);
//                      }
//                  }
//              },
//            ),
//            RaisedButton(
//              child: Text("Trigger get"),
//              onPressed: () async{
//                List<dynamic> triggers = await trigger.getTriggerWithProblemWithLastEvent();
//                for(var teste in triggers)
//                {
//                  //print(teste);
//                }
//                if(triggers!=null)
//                  {
//                    //var lista1;
//                    listaTrigger = TriggerList.fromJson(triggers, widget.api);
//                    int aux = 0;
//                    for (var i in triggers )
//                      {
//                        print(listaTrigger.triggers[aux].lastEvent);
//                        lastEventList.insert(aux, listaTrigger.triggers[aux].lastEvent);
//                        //lastEventList.add(listaTrigger.triggers[aux].lastEvent);
//                        aux++;
//                        //print(listaTrigger.triggers[i].lastEvent);
//                      }
//                  }
//              },
//            ),
//            Text(
//                _nomeHost
//            ),
//            RaisedButton(
//              child: Text("Log out"),
//              onPressed: () async{
//                setState(() => _isLoading = true);
//                var logout = await widget.api.logout();
//                setState(() => _isLoading = false);
//                if(logout["result"].toString() == "true")
//                {
//                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Login()));
//                  //Navigator.pop(context);
//                }
//              },
//            ),
//          ],
//        ),
      ),
    );
  }
}
