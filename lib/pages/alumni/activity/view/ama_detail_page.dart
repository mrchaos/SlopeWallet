import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:wallet/common/util/string/string_util.dart';
import 'package:wallet/pages/alumni/activity/model/ama_model.dart';
import 'package:wallet/theme/app_colors.dart';
import 'package:wallet/theme/app_theme.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:webviewx/webviewx.dart' as webviewxMode;

class AmaDetailPage extends StatefulWidget {
  final Ama amaItemInfo;
  final String? title;

  AmaDetailPage({this.title, Key? key, required this.amaItemInfo}) : super(key: key);

  @override
  _AmaDetailPageState createState() => _AmaDetailPageState();
}

class _AmaDetailPageState extends State<AmaDetailPage> {
  WebViewController? _controller;

  bool _isLoading = true;

  String? pageTitle;

  _launchURL(BuildContext context, String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      print('Could not launch $url');
    }
  }

  @override
  void initState() {
    super.initState();
    pageTitle = widget.title;
  }

  @override
  Widget build(BuildContext context) {
    AppColors appColors = AppTheme.of(context).currentColors;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.close),
          onPressed: () => Navigator.maybePop(context),
        ),
        title: Text(widget.amaItemInfo.name),
      ),
      body: Stack(
        children: [
          !kIsWeb
              ? WebView(
                  initialUrl: widget.amaItemInfo.linkUrl,
                  onWebViewCreated: (controller) => _controller = controller,
                  javascriptMode: JavascriptMode.unrestricted,
                  navigationDelegate: (NavigationRequest request) {
                    if (!isNetworkUrl(request.url)) {
                      debugPrint("navigationDelegate: ${request.url}");
                      _launchURL(context, request.url);
                      return NavigationDecision.prevent;
                    }
                    return NavigationDecision.navigate;
                  },
                  onPageFinished: (url) {
                    if (widget.title == null)
                      _controller?.getTitle().then((title) {
                        if (title?.isNotEmpty ?? false) {
                          if (Platform.isAndroid &&
                              (title?.startsWith('\"') ?? false) &&
                              (title?.endsWith('\"') ?? false)) {
                            title = title?.substring(1, title.length - 1);
                          }
                          setState(() {
                            pageTitle = title;
                          });
                        }
                      });

                    setState(() {
                      _isLoading = false;
                    });
                  },
                )
              : webviewxMode.WebViewX(
                  initialContent: '${widget.amaItemInfo.linkUrl}',
                  initialSourceType: webviewxMode.SourceType.URL,
                  onPageFinished: (src) {
                    setState(() {
                      _isLoading = false;
                    });
                  }),
          if (_isLoading)
            LinearProgressIndicator(
              minHeight: 2,
              color: appColors.purpleAccent,
            ),
        ],
      ),
    );
  }
}
