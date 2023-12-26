import 'dart:io';

import 'package:flutter/material.dart';
import 'package:hip_quest/Screens/loading.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../Widgets/GlobalAppBar.dart';
import '../util/ColorResources.dart';

class WebviewScreen extends StatefulWidget {
  static String routeKey = '/webview';

  final String url;
  final String title;

  const WebviewScreen({Key? key, required this.title, required this.url})
      : super(key: key);

  @override
  State<WebviewScreen> createState() => _WebviewScreenState();
}

class _WebviewScreenState extends State<WebviewScreen> {
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    // Enable virtual display.
    if (Platform.isAndroid) WebView.platform = AndroidWebView();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: ColorResources.colorSecondary,
      appBar: GlobalAppBar(title: widget.title),
      body: SafeArea(
        bottom: false,
        left: false,
        right: false,
        // child: WebView(
        //   initialUrl: widget.url,
        // )
        child: Stack(
          children: <Widget>[
            WebView(
              initialUrl: widget.url,
              javascriptMode: JavascriptMode.unrestricted,
              onPageFinished: (finish) {
                setState(() {
                  isLoading = false;
                });
              },
            ),
            isLoading ? loading() : Stack(),
          ],
        ),
      ),
    );
  }
}
