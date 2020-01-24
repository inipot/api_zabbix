import 'dart:convert';
import 'dart:io';

class Api {

   String url;
   String token;

   Api({this.url,this.token});


   inicializa(Map body) async
  {

    HttpClient client = new HttpClient();
    client.badCertificateCallback =
    ((X509Certificate cert, String host, int port) => true);
    HttpClientRequest request = await client.postUrl(Uri.parse(url));
    request.headers.set('content-type', 'application/json-rpc');
    request.add(utf8.encode(json.encode(body)));
    HttpClientResponse response = await request.close();
    String stringResult = await response.transform(utf8.decoder).join();
    Map mapResult = json.decode(stringResult);
    print(mapResult.toString());
    return mapResult;
  }


   Future<dynamic> login(String user, String password) async {

     Map body = Api().loginToJson(user, password);
     return inicializa(body);

  }
    Future<dynamic> logout() async {
    Map body = logoutToJson();
    return inicializa(body);

  }

   factory Api.fromJson(Map<String, dynamic> parsedJson,Api api){
     Map json = parsedJson;
     return Api(token: json["result"], url: api.url);
   }

   Map loginToJson(String user, String password )
   {
     Map body = {
       "jsonrpc": "2.0",
       "method": "user.login",
       "params": {
         "user": user,
         "password": password
       },
       "id": 1,
     };
     return body;
   }

   Map logoutToJson()
   {
     Map body = {
       "jsonrpc": "2.0",
       "method": "user.logout",
       "params": [],
       "id": 1,
       "auth": token
     };
     return body;
   }

}