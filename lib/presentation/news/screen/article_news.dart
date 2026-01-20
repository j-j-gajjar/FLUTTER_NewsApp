import 'dart:async';

import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class ArticleNews extends StatefulWidget {
  const ArticleNews({super.key, required this.newsUrl});

  final String newsUrl;

  @override
  _ArticleNewsState createState() => _ArticleNewsState();
}

class _ArticleNewsState extends State<ArticleNews> {
  final Completer<WebViewController> _completer = Completer<WebViewController>();
  late bool _isLoadingPage;

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
        title: const Text(
          'News',
        ),
      ),
      body: Stack(
        children: [
          WebView(
            initialUrl: widget.newsUrl,
            javascriptMode: JavascriptMode.unrestricted,
            onWebViewCreated: (WebViewController controller) {
              _completer.complete(controller);
            },
            onPageFinished: (String finish) => setState(() => _isLoadingPage = false),
          ),
          if (_isLoadingPage)
            Container(
              alignment: FractionalOffset.center,
              child: const CircularProgressIndicator(
                backgroundColor: Colors.yellow,
              ),
            )
          else
            const SizedBox.shrink()
        ],
      ),
    );
  }
}
