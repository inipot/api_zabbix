import 'package:api_zabbix/Api.dart';
import 'package:api_zabbix/model/HostGroup.dart';

class Host{

  Api api;
  String id;
  String nome;

  Host({this.id,this.nome,this.api});


  factory Host.fromJson(Map<String, dynamic> parsedJson, Api api){

    Map json = parsedJson["result"];
    return Host(nome: json["name"], id: json["groupid"], api: api);
  }

  List<HostGroup> hostGroups;

  Future<dynamic> getHostsByName(List<String> nomes) async {

    HostGroup h1 = HostGroup(nome: "Zabbix server");
    HostGroup h2 = HostGroup(nome: "KUROMORI");
    hostGroups.add(h1);
    hostGroups.add(h2);

    var teste;
    int i = 0;
    for( teste in hostGroups)
      {
         teste = hostGroups[i].nome;
         i++;
      }

    teste = [hostGroups[0].nome,hostGroups[1].nome];

    print(api.token);
    Map body = {
      "jsonrpc": "2.0",
      "method": "host.get",
      "params": {
        "filter": {
          "host": "KUROMORI"
        }
      },
      "auth": api.token,
      "id": 1
    };

    return api.inicializa(body);
  }
}
