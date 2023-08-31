import 'package:aksonhealth/theme.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

// Import for Android features.
class ZoomEvent extends StatelessWidget {
  final _controller = WebViewController()
    ..setJavaScriptMode(JavaScriptMode.unrestricted)
    ..setNavigationDelegate(
      NavigationDelegate(
        onProgress: (int progress) {
          // print the loading progress to the console
          // you can use this value to show a progress bar if you want
          debugPrint("Loading: $progress%");
        },
        onPageStarted: (String url) {},
        onPageFinished: (String url) {},
        onWebResourceError: (WebResourceError error) {},
        onNavigationRequest: (NavigationRequest request) {
          return NavigationDecision.navigate;
        },
      ),
    )
    ..loadRequest(Uri.parse("https://app.studytogether.com/room/622b6c88c30d8c8449adc5af"));
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Zoom Event'),
        backgroundColor: darkBlueColor,
      ),
      body: WebViewWidget(controller: _controller),
    );
  }
}
