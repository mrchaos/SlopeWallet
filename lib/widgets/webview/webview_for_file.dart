

import 'package:wallet/common/util/string/string_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

class WebViewForFile extends StatefulWidget {
  final String filePath;
  final String? title;
  const WebViewForFile({Key? key, required this.filePath, this.title}) : super(key: key);

  @override
  _WebViewForFileState createState() => _WebViewForFileState();
}

class _WebViewForFileState extends State<WebViewForFile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: SafeArea(
        child: Stack(
          children: [
            _buildWebView(),
          ],
        ),
      ),
    );
  }

  PreferredSizeWidget? _buildAppBar() {
    return isStrNullOrEmpty(widget.title)
        ? null
        : AppBar(title: Text(widget.title!));
  }

  Widget _buildWebView() {
    return InAppWebView(
      initialFile: widget.filePath,
    );
  }
}
