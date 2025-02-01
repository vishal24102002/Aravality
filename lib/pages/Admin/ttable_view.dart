import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class ttable_view extends StatefulWidget {
  const ttable_view({super.key});

  @override
  State<ttable_view> createState() => _ttable_viewState();
}

class _ttable_viewState extends State<ttable_view> {
//   Future GetSheetUrl() async {
//     http.Response branch_url=await http.get(Uri.parse("https://vishal6596.pythonanywhere.com/worksheet/urls"));
//     var url=branch_url;
//   }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,title: const Text("TT.View",style: TextStyle(color: Colors.white),),),
      body: WebViewWidget(
        controller: WebViewController()
          ..setJavaScriptMode(JavaScriptMode.unrestricted)
          ..loadRequest(Uri.parse("https://docs.google.com/spreadsheets/d/1JvLXp8yS5rUviW4gEKfmExyki4fmIfIDHQEqZr_161E/edit#gid=84819193")),
      ),
      // extendBody: true,
      extendBodyBehindAppBar: true,

    );
  }
}
