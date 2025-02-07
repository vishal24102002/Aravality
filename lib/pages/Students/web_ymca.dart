import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class Web_ymca extends StatefulWidget {
  const Web_ymca({super.key});
  @override
  State<Web_ymca> createState() => _Web_ymcaState();
}

class _Web_ymcaState extends State<Web_ymca> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 90,
        shadowColor: Colors.transparent,
        backgroundColor: Colors.lightGreenAccent,
        title: const Text(
            "Y.M.C.A.",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 25,
            ),
          ),
      ),
        body: Container(
          // margin: EdgeInsets.only(top:100),
          alignment: Alignment.center,
          color: Colors.white,
          width: double.infinity,
          height: double.infinity,
          child: Expanded(
          flex: 1,
          child: Stack(
            children: [
              WebViewWidget(
                controller: WebViewController()
                  ..setJavaScriptMode(JavaScriptMode.unrestricted)
                  ..setBackgroundColor(Colors.white)
                  ..enableZoom(true)
                  ..setNavigationDelegate(
                    NavigationDelegate(
                      onPageStarted: (url) {
                        // Optionally, you can handle page load events here.
                      },
                      onPageFinished: (url) {
                        // Optionally, you can handle page load completion here.
                      },
                    ),
                  )
                  ..loadRequest(Uri.parse('https://jcboseustymca.co.in/Forms/Student/ResultStudents.aspx')),
              ),
              const Positioned(
                child: Center(
                  child: CircularProgressIndicator(), // Show progress indicator while loading
                ),
              ),
            ],
          ),
      ),
        ),
    );
  }
}