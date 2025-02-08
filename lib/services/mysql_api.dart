import 'package:http/http.dart' as http;
String url="https://a92c-103-201-140-38.ngrok-free.app/";

Future Getdetails(String Query) async{
  http.Response detailEmail =await http.get(Uri.parse("https://script.google.com/macros/s/AKfycbydFqJfbhQ1Xo-ROghznVXPNjoX7oqOsg4E2s7peB1-5sKz5JrK9_dyL7ldwNKa4IXp/exec?email=$Query"));
  return detailEmail.body;
}
Future GetRole(String query) async{
  http.Response Role =await http.get(Uri.parse("https://script.google.com/macros/s/AKfycbw3ZepcYtuUEHnb8vW8794bmQoeMikSRHPrGN0nIImEwWOnCjeoQ_9LQMoTiPIpCZ2c/exec?mail=$query"));
  return Role.body;
}
Future GetReport(String Query) async{
  http.Response Reseponse =await http.get(Uri.parse("https://vishal6596.pythonanywhere.com/details?email=$Query"));
  return Reseponse.body;
}

Future Getteachers(String course) async{
  http.Response teacher=await http.get(Uri.parse("https://script.google.com/macros/s/AKfycbxf5c4M82Ax1M4aTTK99IsIjgrWt_eJC46v8ehvWlm5OGMX7E9ixTRzdJBRe287NOJULg/exec?course=$course"));
  return teacher.body;
}

Future GetPyq(String selectedSemester) async{
  http.Response teacher=await http.get(Uri.parse("https://script.google.com/macros/s/AKfycbyQvCLwrAkZ2QKkBaiX_oQMRLBdYRphfgCI3vRu5HhsWYt93mxpaKU_Yv1HhD5E9IMpmg/exec?semester_selected=$selectedSemester"));
  return teacher.body;
}
