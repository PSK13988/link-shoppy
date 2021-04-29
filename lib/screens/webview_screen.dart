import 'dart:async';

import 'package:app/utils/app_constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';

class MyWebView extends StatelessWidget {
  final String title;
  final String selectedUrl;

  MyWebView({
    @required this.title,
    @required this.selectedUrl,
  });

  @override
  Widget build(BuildContext context) {
    return WebviewScaffold(
      url: selectedUrl,
      appBar: AppBar(
        backgroundColor: AppConstants.colorPrimary,
        title: Text(
          title,
          style: TextStyle(
            color: AppConstants.appBarTitleColor,
            letterSpacing: 1.2,
            fontSize: 19.0,
          ),
        ),
        iconTheme: new IconThemeData(color: AppConstants.iconColor),
      ),
      withZoom: true,
      withLocalStorage: true,
      displayZoomControls: true,
      hidden: true,
      initialChild: Container(
        color: Colors.white,
        child: const Center(
          child: Text('Loading please wait...',
              style: TextStyle(
                color: AppConstants.textColor,
                letterSpacing: 1.2,
                fontWeight: FontWeight.bold,
                fontSize: 24.0,
              )),
        ),
      ),
    );
  }
}
