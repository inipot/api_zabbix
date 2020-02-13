import 'package:api_zabbix/model/Event.dart';
import 'package:api_zabbix/model/EventList.dart';
import 'package:api_zabbix/model/Host.dart';
import 'package:api_zabbix/model/HostGroup.dart';
import 'package:api_zabbix/model/HostGroupList.dart';
import 'package:api_zabbix/model/Trigger.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../Api.dart';

class AcknowledgePage extends StatefulWidget {

  final Api api;
  final Trigger trigger;
  final Host host;
  final Event event;
  //HostGroup hostGroup;

  AcknowledgePage({this.api,this.trigger,this.host,this.event});

  @override
  _AcknowledgePageState createState() => _AcknowledgePageState();
}


class _AcknowledgePageState extends State<AcknowledgePage> {

  String nome;

  Future<HostGroupList> getHostGroupsByHostname() async
  {
    //List<String> hostIds;
    HostGroup hostGroup = HostGroup(api: widget.api);
    var hostgroups = await hostGroup.getHostGroupsByHostnameToJson(widget.host.id);
    print(hostgroups.toString());
    HostGroupList hostList = HostGroupList.fromJson(hostgroups, widget.api);
    //print("testeHostGroup${hostList.hosts[0].nome}");
    //print(hostList.hostGroups[0].nome+" "+hostList.hostGroups[0].id);
    print(hostList.hostGroups.length);
    return hostList;
  }

  Text grupos(HostGroupList hostGroupList){
    String grupo=hostGroupList.hostGroups[0].nome;
    if(hostGroupList.hostGroups.length>1)
      {
        for(int i = 1; i<hostGroupList.hostGroups.length;i++)
        {
          grupo = grupo +", "+hostGroupList.hostGroups[i].nome;
        }
      }
    return Text(grupo);
  }
  converterTimestampParaDateTime(String lastChange)
  {
    print(lastChange);
    var date = DateTime.fromMillisecondsSinceEpoch((int.parse(lastChange))*1000,isUtc: false);
    print(date);
    print(DateFormat.yMd().add_jms().format(date));
    return DateFormat.yMd().add_jms().format(date);
  }

  String getSeveritie(Trigger trigger)
  {
    if(trigger.priority == "0")
      return "Não informado";
    else if(trigger.priority == "1")
      return "Informaãp";
    else if(trigger.priority == "2")
      return "Aviso";
    else if(trigger.priority == "3")
      return "Média";
    else if (trigger.priority == "4")
      return "Alto";
    else
      return "Disastre";
  }

  getackEvent (EventList eventList)
  {
    for(int i = 0 ; i< eventList.events.length;i++)
      {
        return ListTile(
            title: Text("última mensagem"),
            subtitle: Text(widget.event.acknowledges.acknowledges[0].message)
        );
      }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Detalhes - Problema"),
        backgroundColor: Color(0xffd40000),
      ),
      body: Container(
        child: FutureBuilder<HostGroupList>(
          future: getHostGroupsByHostname(),
          builder: (context,snapshot){
            switch(snapshot.connectionState){
              case ConnectionState.none:
              case ConnectionState.waiting:
                return Center(
                  child: CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.red),
                  ),
                );
                break;
              case ConnectionState.active:
              case ConnectionState.done:
                if (snapshot.hasError){
                  print("Erro ao carregar");
                }
                else{
                  print("carregou os dados");
                  HostGroupList groupList = snapshot.data;
                  grupos(groupList);
                  return Column(
                    children: <Widget>[
                      ListTile(
                        title:Text("Grupos"),
                        subtitle: grupos(groupList),
                      ),
                      ListTile(
                        title: Text("Host"),
                        subtitle: Text(widget.host.nome),
                      ),
                      ListTile(
                        title: Text("Descrição do problema"),
                        subtitle: Text(widget.trigger.description),
                      ),
                      ListTile(
                        title: Text("Severidade do problema"),
                        subtitle: Text(getSeveritie(widget.trigger)),
                      ),
                      ListTile(
                        title: Text("Data e Hora da última alteração"),
                        subtitle: Text(converterTimestampParaDateTime(widget.trigger.lastChange)),
                      ),
                      ListTile(
                        title: Text("Reconhecido ?"),
                        subtitle: widget.event.acknowledged == "0" ? Text("Não") : Text("Sim"),
                      ),
                      //getackEvent(widget.eventList)
                      ListTile(
                        title: Text("última mensagem"),
                        subtitle: widget.event.acknowledges.acknowledges.isEmpty
                            ? Text("----")
                            : Text(widget.event.acknowledges.acknowledges[0].message)
                      ),
                    ],
                  );
//                  return Column(
//                    children: <Widget>[
//                        Padding(
//                          padding: const EdgeInsets.only(top: 16, bottom: 8),
//                          child: Text("Grupos",
//                            style: TextStyle(
//                              fontSize: 20
//                            ),
//                          ),
//                        ),
//                        Expanded(
//                          child: ListView.separated(
//                            separatorBuilder: (context,index)=> Divider(
//                              color: Colors.black,
//                            ),
//                            scrollDirection: Axis.horizontal,
//                              itemCount: snapshot.data.hostGroups.length,
//                              itemBuilder: (context,index){
//                              HostGroupList groupList = snapshot.data;
//                              return Padding(
//                                padding: const EdgeInsets.only(left: 16),
//                                child: Text(groupList.hostGroups[index].nome+" "),
//                              );
//                            }
//                            ),
//                        ),
//                      ],
//                  );
                }
            }
            return CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(Colors.red),
            );
          },
        )
      ),
    );
  }
}
