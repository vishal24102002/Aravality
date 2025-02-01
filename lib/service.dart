import 'package:http/http.dart' as http;
String url="https://af79-2401-4900-1c88-740a-357c-815b-ed0f-73a4.ngrok-free.app";

Future GetReport(query) async{
  http.Response Reseponse =await http.get(Uri.parse(url+query));
  return Reseponse.body;
}

