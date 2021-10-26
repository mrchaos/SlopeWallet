import 'package:flutter/material.dart';
import 'package:wallet/common/service/wallet_service.dart';
import 'package:wallet/common/util/string/string_util.dart';
import 'package:wallet/theme/app_colors.dart';
import 'package:wallet/theme/app_theme.dart';
import 'package:wallet/widgets/app_bar/wallet_bar.dart';
import 'package:wd_common_package/wd_common_package.dart';
import 'package:webview_flutter/webview_flutter.dart';

class CommonWebViewPage extends StatefulWidget {
  final String? title;
  final String linkUrl;

  const CommonWebViewPage({Key? key, this.title, required this.linkUrl})
      : super(key: key);

  @override
  _CommonWebViewPageState createState() => _CommonWebViewPageState();
}

class _CommonWebViewPageState extends State<CommonWebViewPage> {
  WebViewController? _controller;

  ValueNotifier<bool> _isShowLoading = ValueNotifier(true);

  void navigationGoBack() {
    _controller?.canGoBack().then((value) {
      if (value) {
        _controller?.goBack();
      } else {
        return service.router.pop(context);
      }
    });
  }



  @override
  Widget build(BuildContext context) {
    AppColors appColors = AppTheme.of(context).currentColors;
    return Scaffold(
      appBar: WalletBar.customBack(
        onPressed: navigationGoBack,
      ),
      body: Stack(
        children: [
          WebView(
            initialUrl: widget.linkUrl,
            onWebViewCreated: (controller) => _controller = controller,
            javascriptMode: JavascriptMode.unrestricted,
            // navigationDelegate: (navigation) {
            //   if (isNetworkUrl(navigation.url) && navigation.isForMainFrame) {
            //     return Future.value(NavigationDecision.prevent);
            //   }
            //   return Future.value(NavigationDecision.navigate);
            // },
            onPageFinished: (url) {
              _isShowLoading.value = false;
            },
          ),
          ValueListenableBuilder<bool>(
            valueListenable: _isShowLoading,
            builder: (context,value, child)=>_isShowLoading.value?LinearProgressIndicator(
              color: appColors.purpleAccent,
              minHeight: 2,
            ):SizedBox())
        ],
      ),
    );
  }
}
