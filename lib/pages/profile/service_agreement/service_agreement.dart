import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:wallet/common/util/string/string_util.dart';
import 'package:wallet/theme/app_theme.dart';
import 'package:wallet/widgets/app_bar/wallet_bar.dart';
import 'package:wallet/widgets/button/app_back_button.dart';
import 'package:wd_common_package/wd_common_package.dart';
import 'package:webview_flutter/webview_flutter.dart';

class ServiceAgreementPage extends StatefulWidget {
  @override
  _ServiceAgreementPageState createState() => _ServiceAgreementPageState();
}

class _ServiceAgreementPageState extends State<ServiceAgreementPage> {
  WebViewController? _webViewController;
  final String filePath = 'assets/service_agreement.html';
  final _loadingNotifier = ValueNotifier<bool>(kIsWeb ? false : true);

  // _loadHtmlFromAssets() async {
  //   _loadingNotifier.value = true;
  //   Future.delayed(const Duration(milliseconds: 300), () async {
  //     String fileHtmlContents = await rootBundle.loadString(filePath);
  //     if (mounted) {
  //       await _webViewController.loadUrl(Uri.dataFromString(fileHtmlContents,
  //               mimeType: 'text/html', encoding: Encoding.getByName('utf-8'))
  //           .toString());
  //       _loadingNotifier.value = false;
  //     }
  //   });
  // }

  @override
  void initState() {
    super.initState();
    if (Platform.isAndroid) {
      WebView.platform = SurfaceAndroidWebView();
    }
  }

  _launchURL(BuildContext context, String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      logger.d('');
      print('ServiceAgreementPage: Could not launch $url');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: WalletBar(
        showBackButton: true,
        title: Text(
          'Terms of use',
          style: TextStyle(color: AppTheme.of(context).currentColors.textColor1),
        ),
        centerTitle: true,
        leading: AppBackButton(
          onPressed: () async {
            if (_webViewController != null && await _webViewController!.canGoBack()) {
              _webViewController!.goBack();
            } else {
              Navigator.maybePop(context);
            }
          },
        ),
      ),
      body: Stack(
        children: [
          WebView(
            initialUrl: 'https://www.slope.finance/protocol.html',
            javascriptMode: JavascriptMode.unrestricted,
            onPageFinished: (String url) => _loadingNotifier.value = false,
            onWebViewCreated: (WebViewController webViewController) {
              _webViewController = webViewController;
              // _loadHtmlFromAssets();
            },
            navigationDelegate: (NavigationRequest request) {
              if (!isNetworkUrl(request.url)) {
                // debugPrint("navigationDelegate: ${request.url}");
                _launchURL(context, request.url);
                return NavigationDecision.prevent;
              }
              return NavigationDecision.navigate;
            },
          ),
          ValueListenableBuilder<bool>(
            valueListenable: _loadingNotifier,
            child: LinearProgressIndicator(minHeight: 2),
            builder: (c, loading, child) => Visibility(
              child: child!,
              visible: loading,
            ),
          ),
        ],
      ),
    );
  }
}
