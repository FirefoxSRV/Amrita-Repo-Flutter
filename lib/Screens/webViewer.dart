import 'dart:async';

import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'dart:io';
import 'dart:math';


class WebViewer extends StatefulWidget {
  const WebViewer({Key? key}) : super(key: key);

  @override
  State<WebViewer> createState() => _WebViewerState();
}

class _WebViewerState extends State<WebViewer> {

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: WebViewStack(),
    );

  }
}


class WebViewStack extends StatefulWidget {
  const WebViewStack({super.key}); // Modify

 // Add this attribute

  @override
  State<WebViewStack> createState() => _WebViewStackState();
}

class _WebViewStackState extends State<WebViewStack> {
  var loadingPercentage = 0;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        WebView(
          initialUrl: 'https://coddyschool.com/upload/Addison_Wesley_The_Object_Orient.pdf',
          onPageStarted: (url) {
            setState(() {
              loadingPercentage = 0;
            });
          },
          onProgress: (progress) {
            setState(() {
              loadingPercentage = progress;
            });
          },
          onPageFinished: (url) {
            setState(() {
              loadingPercentage = 100;
            });
          },
        ),
        if (loadingPercentage < 100)
          Container(
            padding: const EdgeInsets.all(30.0),
            child: Center(
              child: LinearProgressIndicator(
                value: loadingPercentage / 100.0,
              ),
            ),
          ),
      ],
    );
  }
}
//
// class WebViewStack extends StatefulWidget {
//   const WebViewStack({Key? key}) : super(key: key);
//
//   @override
//   State<WebViewStack> createState() => _WebViewStackState();
// }
//
// class _WebViewStackState extends State<WebViewStack> {
//   var loadingPercentage;
//   @override
//   Widget build(BuildContext context) {
//     return Stack(
//       children: [
//         WebView(
//           initialUrl: 'https://docs.google.com/gview?embedded=true&url=https://intranet.cb.amrita.edu/download/DeanEngg/Curriculum_Syllabus/Undergraduate_Programs/B_Tech_02/B_Tech_Computer_Science_And_Engineering(Artificial_Intelligence)-2019.pdf',
//           onPageStarted: (url){
//             setState(() {
//               loadingPercentage=0.0;
//             });
//           },
//           onProgress: (progress){
//             setState(() {
//               loadingPercentage=progress/100.0;
//             });
//           },
//           onPageFinished: (url){
//             loadingPercentage=1.0;
//           },
//         ),
//         if (loadingPercentage < 100)
//           LinearProgressIndicator(
//             value: loadingPercentage,
//             minHeight: 20,
//             color: Colors.blue,
//           ),
//       ],
//     );
//   }
// }
