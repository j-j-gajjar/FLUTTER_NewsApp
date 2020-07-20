import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'dart:async';

class Artical_News extends StatefulWidget {
  final NewsUrl;

  const Artical_News({Key key, this.NewsUrl}) : super(key: key);
  @override
  _Artical_NewsState createState() => _Artical_NewsState();
}

class _Artical_NewsState extends State<Artical_News> {
  final Completer<WebViewController> _completer =
      Completer<WebViewController>();
  bool _isLoadingPage;
  @override
  void initState() {
    super.initState();
    _isLoadingPage = true;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("News"),
      ),
      body: Container(
        child: Stack(
          children: [
            WebView(
              initialUrl: widget.NewsUrl,
              javascriptMode: JavascriptMode.unrestricted,
              onWebViewCreated: (controller) {
                _completer.complete(controller);
              },
              onPageFinished: (finish) {
                setState(() {
                  _isLoadingPage = false;
                });
              },
            ),
            _isLoadingPage
                ? Container(
                    alignment: FractionalOffset.center,
                    child: CircularProgressIndicator(),
                  )
                : Container(),
          ],
        ),
      ),
    );
  }
}
