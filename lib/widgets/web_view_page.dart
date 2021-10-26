import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:wallet/common/service/wallet_service.dart';
import 'package:wallet/common/util/string/string_util.dart';
import 'package:wallet/generated/assets.dart';
import 'package:wallet/theme/app_theme.dart';
import 'package:wallet/widgets/app_bar/wallet_bar.dart';
import 'package:wallet/widgets/button/app_back_button.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:webviewx/webviewx.dart' as webviewxMode;

/// urlWeb
/// * [title] ，，web
/// * [url] url
/// * [canRefresh] 
/// * [canShare] 
class WebViewPage extends StatefulWidget {
  String? url;

  static const String TITLE = 'title';
  final String? title;
  final bool canRefresh;
  final bool canShare;

  WebViewPage({this.title, this.url, this.canRefresh = true, this.canShare = false, Key? key})
      : super(key: key);

  @override
  _WebViewPageState createState() => _WebViewPageState();
}

class _WebViewPageState extends State<WebViewPage> {
  WebViewController? _controller;

  final _loadingNotifier = ValueNotifier<bool>(true);
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
    if (Platform.isAndroid) {
      WebView.platform = SurfaceAndroidWebView();
    }
    pageTitle = widget.title;
  }

  bool _hasArgGet = false;

  @override
  Widget build(BuildContext context) {
    var args = ModalRoute.of(context)!.settings.arguments;
    if (args is String && !_hasArgGet) {
      _hasArgGet = true;
      widget.url = args.toString();
    }
    return Scaffold(
      appBar: WalletBar(
        showBackButton: true,
        title: Text(pageTitle ?? ''),
        leading: AppBackButton(
          onPressed: () async {
            if (null != _controller && await _controller!.canGoBack()) {
              _controller?.goBack();
            } else {
              Navigator.maybePop(context);
            }
          },
        ),
        actions: [
          ValueListenableBuilder<bool>(
            valueListenable: _loadingNotifier,
            builder: (c, loading, child) => Visibility(
              child: child!,
              visible: !loading && widget.canRefresh,
            ),
            child: AnimatedSwitcher(
              duration: Duration(milliseconds: 250),
              child: IconButton(
                icon: const Icon(Icons.refresh),
                onPressed: () => _controller?.reload(),
              ),
            ),
          ),
          if (widget.canShare == true)
            IconButton(
              padding: EdgeInsets.zero,
              icon: Icon(Icons.share),
              onPressed: () => _launchURL(context, this.widget.url!),
            ),
          Builder(builder: (context) {
            return Container(
              margin: const EdgeInsets.only(right: 24),
              child: IconButton(
                icon: service.svg.asset(
                  Assets.assets_svg_ic_close_button_svg,
                  color: context.appColors.textColor1,
                ),
                padding: EdgeInsets.zero,
                iconSize: 28,
                constraints: BoxConstraints(maxWidth: 28, maxHeight: 28),
                onPressed: () => Navigator.pop(context),
              ),
            );
          }),
        ],
      ),
      body: Stack(
        children: [
          !kIsWeb
              ? WebView(
                  initialUrl: widget.url,
                  // initialUrl: 'https://flutter.cn,
                  onWebViewCreated: (controller) => _controller = controller,
                  javascriptMode: JavascriptMode.unrestricted,
                  // javascriptChannels: [_toastJsChannel(context)].toSet(),
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

                    _loadingNotifier.value = false;
                  },
                )
              : webviewxMode.WebViewX(
                  initialContent: '${widget.url}',
                  initialSourceType: webviewxMode.SourceType.URL,
                  onPageFinished: (src) {
                    _loadingNotifier.value = false;
                  },
                ),
          ValueListenableBuilder<bool>(
            valueListenable: _loadingNotifier,
            builder: (c, loading, child) => Visibility(
              child: child!,
              visible: loading,
            ),
            child: LinearProgressIndicator(
              color: Theme.of(context).accentColor,
              minHeight: 2,
            ),
          )
        ],
      ),
    );
  }
}
