import 'package:api_zabbix/Api.dart';
import 'package:api_zabbix/model/AcknowledgeList.dart';
import 'package:api_zabbix/screens/AcknowledgePage.dart';
import 'package:api_zabbix/screens/LoginPage.dart';
import 'package:api_zabbix/model/Event.dart';
import 'package:api_zabbix/model/EventList.dart';
import 'package:api_zabbix/model/Trigger.dart';
import 'package:flutter/material.dart';
import 'package:api_zabbix/model/TriggerList.dart';
import 'package:intl/intl.dart';

class PageProblem extends StatefulWidget {

  PageProblem({@required this.api});
  final Api api;
  @override
  _PageProblemState createState() => _PageProblemState();
}

class _PageProblemState extends State<PageProblem> {

  bool _isLoading = false;
  EventList listaEventos;
  AcknowledgeList acknowledgeList;
  converterTimestampParaDateTime(String lastChange)
  {
    print(lastChange);
    var date = DateTime.fromMillisecondsSinceEpoch((int.parse(lastChange))*1000,isUtc: false);
    print(date);
    print(DateFormat.yMd().add_jms().format(date));
    return DateFormat.yMd().add_jms().format(date);
  }

  Future<TriggerList>recuperarTriggers() async
  {

    Trigger trigger = Trigger(api: widget.api);
    Event event = Event(api: widget.api);
    //Acknowledge acknowledge = Acknowledge(api: widget.api);
    TriggerList listaTrigger;
    List<String> lastEventList;

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
    print("lista eventos"+listaEventos.events[1].id);
//    List<dynamic> acknowledges = await event.getEventsByEventId(lastEventList);
//    if(acknowledges!=null)
//      {
//        if(event)
//        acknowledgeList = AcknowledgeList.fromJson(acknowledges, widget.api);
//        print("lista eventos"+acknowledgeList.acknowledges[0].message);
//      }

    //print(listaTrigger.triggers[0].host);

    return listaTrigger;
  }

  Color getColorIcon(Trigger trigger)
  {
    if(trigger.priority == "0")
      return Color(0xff97AAB3);
    else if(trigger.priority == "1")
      return Color(0xff7499FF);
    else if(trigger.priority == "2")
      return Color(0xffFFC859);
    else if(trigger.priority == "3")
      return Color(0xffFFA059);
    else if (trigger.priority == "4")
      return Color(0xffE97659);
    else
      return Color(0xffE45959);
  }

  @override
  Widget build(BuildContext context) {
    return Center(
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
                        child: CircularProgressIndicator(
                          valueColor: AlwaysStoppedAnimation<Color>(Colors.red)
                        ),
                      );
                      break;
                    case ConnectionState.active:
                    case ConnectionState.done:
                      if(snapshot.hasError){
                        print("Erro ao carregar");
                      }
                      else{
                        print("Lista carregou");
                        return ListView.separated(
                          separatorBuilder: (context,index)=> Divider(
                            color: Colors.black,
                          ),
                            itemCount: snapshot.data.triggers.length,
                            itemBuilder: (context,index){
                            print(index);
                              TriggerList list = snapshot.data;
                              var trigger = list.triggers[index];
                              return ListTile(
                                contentPadding: EdgeInsets.only(top: 6, bottom: 6),
                                onTap: (){
                                  Navigator.push(context, MaterialPageRoute(builder: (context) => AcknowledgePage(api: widget.api,host: trigger.hosts.hosts[0],trigger: trigger,event: listaEventos.events[index])));
                                },
                                leading: Padding(
                                  padding: EdgeInsets.only(left: 8),
                                  child: Icon(
                                    Icons.warning,
                                    color: getColorIcon(trigger),
                                  ),
                                ),
                                title: Text(trigger.description.replaceAll("{HOST.NAME}", trigger.hosts.hosts[0].nome)),
                                subtitle: Text(trigger.hosts.hosts[0].nome+" "+converterTimestampParaDateTime(trigger.lastChange).toString()),
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
          child: Text("Logout"),
          onPressed: ()async{
            var logout = await widget.api.logout();
            setState(() => _isLoading = true );
            if(logout["result"].toString() == "true")
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => LoginPage()));
          },
        )
        ],
      ),
    );
  }
}
