import 'dart:collection';
import 'dart:io';

import 'package:wallet/common/util/string/string_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:wd_common_package/wd_common_package.dart';

class WebViewForNetwork extends StatefulWidget {
  final String initUrl;
  final String? title;

  const WebViewForNetwork({Key? key, required this.initUrl, this.title})
      : super(key: key);

  @override
  _WebViewForNetworkState createState() => _WebViewForNetworkState();
}

class _WebViewForNetworkState extends State<WebViewForNetwork> {

  final GlobalKey webViewKey = GlobalKey();
  InAppWebViewController? webViewController;
  InAppWebViewGroupOptions options = InAppWebViewGroupOptions(
    crossPlatform: InAppWebViewOptions(
      useShouldOverrideUrlLoading: true,
      mediaPlaybackRequiresUserGesture: false,
    ),
    android: AndroidInAppWebViewOptions(
      useHybridComposition: true,
    ),
    ios: IOSInAppWebViewOptions(
      allowsInlineMediaPlayback: true,
    ),
  );

  late PullToRefreshController pullToRefreshController;
  double progress = 0;
  String url = "";

  @override
  void initState() {
    pullToRefreshController = PullToRefreshController(
      options: PullToRefreshOptions(color: Colors.blue),
      onRefresh: () async {
        if (Platform.isAndroid) {
          webViewController?.reload();
        } else if (Platform.isIOS) {
          webViewController?.loadUrl(
              urlRequest: URLRequest(url: await webViewController?.getUrl()));
        }
      },
    );
    super.initState();
  }

  void _onWebViewCreated(InAppWebViewController controller) {
    webViewController = controller;
  }

  void _onLoadStart(InAppWebViewController controller, Uri? uri) {
    this.url = uri.toString();
    logger.d("webView onLoadStart");
  }

  void _onLoadStop(InAppWebViewController controller, Uri? uri) async {
    pullToRefreshController.endRefreshing();
    this.url = uri.toString();
  }

  void _onLoadError(
      InAppWebViewController controller, Uri? uri, int code, String msg) {
    pullToRefreshController.endRefreshing();
  }

  void _onProgressChanged(InAppWebViewController controller, int progress) {
    if (progress == 100) pullToRefreshController.endRefreshing();
    setState(() {
      this.progress = progress / 100.0;
    });
  }

  void _onUpdateVisitedHistory(
      InAppWebViewController controller, Uri? uri, bool? androidIsReload) {
    this.url = uri.toString();
  }

  void _onConsoleMessage(
      InAppWebViewController controller, ConsoleMessage msg) {
    logger.d(msg.message);
  }

  Future<NavigationActionPolicy?> _shouldOverrideUrlLoading(
      InAppWebViewController controller, NavigationAction action) async {
    var uri = action.request.url!;
    if (![
      "http",
      "https",
      "file",
      "chrome",
      "data",
      "javascript",
      "about",
    ].contains(uri.scheme)) {
      if (await canLaunch(url)) {
        await launch(url);
      }
      return NavigationActionPolicy.CANCEL;
    }
    return NavigationActionPolicy.ALLOW;
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: SafeArea(
        child: Stack(
          children: [
            _buildWebView(),
            _buildProgress(),
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
      key: webViewKey,
      initialUrlRequest: URLRequest(
        url: Uri.parse(widget.initUrl),
      ),
      androidOnPermissionRequest: (controller, origin, resources) async {
        return PermissionRequestResponse(
          resources: resources,
          action: PermissionRequestResponseAction.GRANT,
        );
      },
      initialUserScripts: UnmodifiableListView<UserScript>([]),
      initialOptions: options,
      pullToRefreshController: pullToRefreshController,
      onWebViewCreated: _onWebViewCreated,
      onLoadStart: _onLoadStart,
      shouldOverrideUrlLoading: _shouldOverrideUrlLoading,
      onLoadStop: _onLoadStop,
      onLoadError: _onLoadError,
      onProgressChanged: _onProgressChanged,
      onUpdateVisitedHistory: _onUpdateVisitedHistory,
      onConsoleMessage: _onConsoleMessage,
    );
  }

  Widget _buildProgress() {
    return progress < 1.0
        ? LinearProgressIndicator(value: progress)
        : Container();
  }
}
