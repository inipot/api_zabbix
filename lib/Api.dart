import 'dart:convert';
import 'dart:io';

class Api
{
  static String _url;
  static String _token;

  static login(String url,String user,String password) async {

   Api._url  = url;
    HttpClient client = new HttpClient();
    client.badCertificateCallback = ((X509Certificate cert, String host, int port) => true);

    //String url ='https://zabbix.karyon.com.br/api_jsonrpc.php'; //externo

    Map body = {
      "jsonrpc": "2.0",
      "method": "user.login",
      "params": {
        "user": user,
        "password": password
      },
      "id": 1,
    };

    HttpClientRequest request = await client.postUrl(Uri.parse(url));

    request.headers.set('content-type', 'application/json-rpc');

    request.add(utf8.encode(json.encode(body)));

    HttpClientResponse response = await request.close();

    String stringResult = await response.transform(utf8.decoder).join();
    Map mapResult = json.decode(stringResult);
    print(mapResult);
    print(mapResult["result"]);
    _token = mapResult["result"];

  }

  static logout() async
  {

    HttpClient client = new HttpClient();
    client.badCertificateCallback = ((X509Certificate cert, String host, int port) => true);

    //String url ='https://zabbix.karyon.com.br/api_jsonrpc.php'; //externo

    Map body = {
      "jsonrpc": "2.0",
      "method": "user.logout",
      "params": [],
      "id": 1,
      "auth": _token
    };

    HttpClientRequest request = await client.postUrl(Uri.parse(Api._url));

    request.headers.set('content-type', 'application/json-rpc');

    request.add(utf8.encode(json.encode(body)));

    HttpClientResponse response = await request.close();

    String stringResult = await response.transform(utf8.decoder).join();
    Map <String, dynamic> mapResult = json.decode(stringResult);
    print(mapResult["result"]);

  }

  static  getHosts(String nome) async {

    HttpClient client = new HttpClient();
    client.badCertificateCallback = ((X509Certificate cert, String host, int port) => true);

    //String url ='https://zabbix.karyon.com.br/api_jsonrpc.php'; //externo

    Map body = {
      "jsonrpc": "2.0",
      "method": "host.get",
      "params": {
        "filter": {
          "host": [
            nome
          ]
        }
      },
      "auth": _token,
      "id": 1
    };

    HttpClientRequest request = await client.postUrl(Uri.parse(Api._url));

    request.headers.set('content-type', 'application/json-rpc');

    request.add(utf8.encode(json.encode(body)));

    HttpClientResponse response = await request.close();

    String stringResult = await response.transform(utf8.decoder).join();
    Map <String,dynamic> mapResult = json.decode(stringResult);

    for (var host in mapResult["result"])
      {
        print(host["hostid"]);
        return host["hostid"];
      }
  }
}