import 'dart:convert';
import 'dart:io';
import 'dart:ui';

import 'package:device_info/device_info.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:wallet/common/util/string/string_util.dart';
import 'package:wallet/theme/app_theme.dart';
import 'package:wallet/widgets/button/app_back_button.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:webviewx/webviewx.dart' as webviewxMode;

import 'my_faq_detail_model.dart';

class MyFaqDetailPage extends StatefulWidget {
  final num detailId;

  const MyFaqDetailPage({Key? key, this.detailId = 0}) : super(key: key);

  @override
  _MyFaqDetailPageState createState() => _MyFaqDetailPageState();
}

/*
* TextStyle(
                                          fontSize: 16,
                                          height: 24 / 16,
                                          fontWeight: FontWeight.w500,
                                          color: AppTheme.of(context).currentColors.textColor1),
* */
class _MyFaqDetailPageState extends State<MyFaqDetailPage> with WidgetsBindingObserver {
  String html(String content, String bgColor, String contentColor, String contentAColor,
      {String? title}) {
    return '''
    <header>
      <meta name="viewport" content="width=device-width,initial-scale=1, maximum-scale=1, minimum-scale=1, user-scalable=no">
    <header>
      <body>
        <style>
            /*、、、*/
            body{
              font-family: Roboto,'SF UI Text','Source Han Sans CN', -apple-system, BlinkMacSystemFont, 'Segoe UI', 'Microsoft YaHei UI', 'Microsoft YaHei',  'Helvetica Neue', Arial, sans-serif;
              background-color:#$bgColor;
              overflow-y:auto;

            }

           .title {
              font-size: 16px;
              line-height: 24px;
              font-weight:500;
              color:#333;
              padding:16px;
            }

            .content {
              font-size: 14px;
              line-height: 22px;
              color: #$contentColor;
              padding: 0 16px;
            }

            .ql-article ol,.ql-article ul{
              margin: 0;
              padding-left: 1.5em;
              counter-reset: list-1;
            }

            .ql-article ol li:not(.ql-direction-rtl) {
              padding-left: 1.5em;
            }

            .ql-article .ql-indent-1:not(.ql-direction-rtl) {
              padding-left: 3em;
            }

            .ql-article .ql-indent-2:not(.ql-direction-rtl) {
              padding-left: 6em;
            }

            .ql-article ol li {
              counter-reset: list-1;
              counter-increment: list-0;
            }

            .ql-article ol>li{
              list-style-type: none;
              position: relative;
            }

            .ql-article li:not(.ql-direction-rtl):before {
              margin-left: -1.5em;
              margin-right: .3em;
              text-align: right;
            }

            .ql-article ol li:before {
              content: counter(list-0,decimal) ". ";
              display: inline-block;
              white-space: nowrap;
              width: 1.2em;
              position: absolute;
            }
            .ql-article ul {
              list-style-type: disc;
            }

            .content img  {
                display: block;
                max-width: 100%;
                margin: 16px auto 0;
            }
            .content * {
              margin-top: 16px;
            }

            .content a {
              color: #$contentAColor;
            }

            pre {
              white-space: pre-wrap;
              word-break: break-all;
              word-wrap: break-word;
            }


            *{
              -webkit-touch-callout:default;
              -webkit-user-select:default;
              -khtml-user-select:default;
              -moz-user-select:default;
              -ms-user-select:default;
              user-select:default;
              margin: 0;
              padding: 0;
            }

        </style>
      ${!kIsWeb ? '' : '<div class="title">$title</div>'}
        <div class='content ql-article '>$content</div>
      </body>''';
  }

  ///js
  String getDetailHtml(String content, {String? title}) =>
      html(content, 'FFFFFF', '292C33', '28C7A7', title: title);
  WebViewController? _controller;

  num _deviceOffset = 40;
  num _heightTotal = 0;
  ValueNotifier _pageChangeNotifier = ValueNotifier(false);

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance!.addObserver(this);
    if (!kIsWeb) {
      if (Platform.isAndroid) {
        WebView.platform = SurfaceAndroidWebView();
      }
    }
    var result = getOffset().then((value) {
      _deviceOffset = value;
      _pageChangeNotifier.value = !_pageChangeNotifier.value;
    });
  }

  static String deviceVersion(String version) {
    if (version == 'iPhone3,1') return 'iPhone 4';
    if (version == 'iPhone3,2') return 'iPhone 4';
    if (version == 'iPhone3,3') return 'iPhone 4';
    if (version == 'iPhone4,1') return 'iPhone 4S';
    if (version == 'iPhone5,1') return 'iPhone 5';
    if (version == 'iPhone5,2') return 'iPhone 5 (GSM+CDMA)';
    if (version == 'iPhone5,3') return 'iPhone 5C (GSM)';
    if (version == 'iPhone5,4') return 'iPhone 5C (GSM+CDMA)';
    if (version == 'iPhone6,1') return 'iPhone 5S (GSM)';
    if (version == 'iPhone6,2') return 'iPhone 5S (GSM+CDMA)';
    if (version == 'iPhone7,1') return 'iPhone 6 Plus';
    if (version == 'iPhone7,2') return 'iPhone 6';
    if (version == 'iPhone8,1') return 'iPhone 6s';
    if (version == 'iPhone8,2') return 'iPhone 6s Plus';
    if (version == 'iPhone8,4') return 'iPhone SE';
    // ，FeliCa
    if (version == 'iPhone9,1') return 'iPhone 7';
    if (version == 'iPhone9,2') return 'iPhone 7 Plus';
    if (version == 'iPhone9,3') return 'iPhone 7';
    if (version == 'iPhone9,4') return 'iPhone 7 Plus';
    if (version == 'iPhone10,1') return 'iPhone 8';
    if (version == 'iPhone10,4') return 'iPhone 8';
    if (version == 'iPhone10,2') return 'iPhone 8 Plus';
    if (version == 'iPhone10,5') return 'iPhone 8 Plus';
    if (version == 'iPhone10,3') return 'iPhone X';
    if (version == 'iPhone10,6') return 'iPhone X';
    if (version == 'iPhone11,8') return 'iPhone XR';
    if (version == 'iPhone11,2') return 'iPhone XS';
    if (version == 'iPhone11,4') return 'iPhone XSMax';
    if (version == 'i386') return 'Simulator';
    if (version == 'x86_64') return 'Simulator';
    return 'unknow device!';
  }

  Future<num> getOffset() async {
    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    IosDeviceInfo iosInfo = await deviceInfo.iosInfo;
    String deviceString = deviceVersion(iosInfo.utsname.machine);
    // iphone6，48
    if (deviceString == 'iPhone 6') return 0;
    return 48.0;
  }

  @override
  void dispose() {
    WidgetsBinding.instance!.removeObserver(this);
    super.dispose();
  }

  // ：【】：app，app，，
  bool _showing = false;

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    // if (AppLifecycleState.resumed == state) {
    //   if (_showing) {
    //     // print('_NewsDetailPageState.didChangeAppLifecycleState  ');
    //     Navigator.pop(context, true);
    //     _showing = false;
    //   }
    // }
    // if (AppLifecycleState.inactive == state) {
    //   if (_showing) return;
    //   // print('_NewsDetailPageState.didChangeAppLifecycleState  ');
    //   _showing = true;
    //   showLoading();
    //   // showLoadingDialog(context: context).whenComplete(() => _showing = false);
    // }
  }

  ///Faq
  static const _appJsObj = 'FaqDetailJsChannel';

  JavascriptChannel _appJavascriptChannel(BuildContext context) {
    return JavascriptChannel(
        name: _appJsObj,
        onMessageReceived: (JavascriptMessage message) {
          num height = num.tryParse(message.message) ?? 0;
          if (height > _heightTotal) {
            debugPrint('html  = $height');
            print('_MyFaqDetailPageState._appJavascriptChannel');
            _heightTotal = height;
            _pageChangeNotifier.value = !_pageChangeNotifier.value;
          }
        });
  }

  Future<void> loadHtmlContent(String content, {String? title}) async {
    final String contentBase64 = base64Encode(const Utf8Encoder().convert(getDetailHtml(content)));
    print(contentBase64);
    if (!kIsWeb) {
      _controller?.loadUrl('data:text/html;charset=utf-8;base64,$contentBase64');
    } else {
      try {
        _webViewController!.loadContent(
          getDetailHtml(content),
          webviewxMode.SourceType.HTML,
        );
      } catch (error) {}
    }
  }

  late webviewxMode.WebViewXController? _webViewController;

  ///（html）
  Widget get faqContent => Selector<FaqDetailViewModel, FaqDetailModel?>(
        selector: (c, m) => m.detail,
        builder: (c, detail, child) {
          if (detail?.sContent != null) {
            print('detail?.sContent:${detail?.sContent}');
          }
          loadHtmlContent(detail?.sContent ?? '');
          return WebView(
            navigationDelegate: (navigation) {
              if (isNetworkUrl(navigation.url) && navigation.isForMainFrame) {
                // debugPrint('onPageStarted:${navigation.url}');
                // service.router.pushNamed(routeName);

                // router.pushPage(
                //   context: c,
                //   page: WebViewPage(url: navigation.url),
                // );
                return Future.value(NavigationDecision.prevent);
              }
              return Future.value(NavigationDecision.navigate);
            },
            javascriptMode: JavascriptMode.unrestricted,
            javascriptChannels: [
              _appJavascriptChannel(c),
            ].toSet(),
            onWebViewCreated: (WebViewController webViewController) {
              _controller = webViewController;
              Future.delayed(Duration(milliseconds: 100), () {
                loadHtmlContent(detail?.sContent ?? '');
              });
            },
            // ，
            onPageFinished: (String url) {
              _controller?.evaluateJavascript("window.onload").then((value) {
                Future.delayed(Duration(milliseconds: 1000), () {
                  _controller?.evaluateJavascript("document.body.scrollHeight").then((value) {
                    num height = num.tryParse(value) ?? 0;
                    if (height > _heightTotal) {
                      _heightTotal = height;
                      _pageChangeNotifier.value = !_pageChangeNotifier.value;
                    }
                  });
                });
              });
            },
          );
        },
      );

  _buildwebViewX(FaqDetailModel? detail) {
    return Selector<FaqDetailViewModel, FaqDetailModel?>(
        selector: (c, m) => m.detail,
        builder: (c, detail, _) {
          return Selector<FaqDetailViewModel, bool>(
            selector: (c, m) => m.loadFinished,
            builder: (c, loadFinished, _) {
              return loadFinished
                  ? webviewxMode.WebViewX(
                      initialContent:
                          getDetailHtml(detail!.sContent ?? '', title: detail.sTitle ?? ''),
                      onWebViewCreated: (controller) {},
                      initialSourceType: webviewxMode.SourceType.HTML,
                    )
                  : SizedBox();
            },
          );
        });
  }

  // late AppTheme.of(context).currentColors AppTheme.of(context).currentColors;
  ///html 
  @override
  Widget build(BuildContext context) {
    num id = widget.detailId;
    return Theme(
      data: context.read<AppTheme>().lightThemeData,
      child: ChangeNotifierProvider<FaqDetailViewModel>(
        create: (_) => FaqDetailViewModel()..getDetail(id.toString()),
        // value: FaqDetailViewModel()..getDetail('84'),
        child: Builder(builder: (context) {
          // AppTheme.of(context).currentColors = context.AppTheme.of(context).currentColors;
          return Scaffold(
            appBar: AppBar(
                leading: AppBackButton(
                  color: Colors.white,
                ),
                title: const Text(
                  'FAQ',
                  style: TextStyle(color: Colors.white),
                ),
                brightness: Brightness.dark,
                backgroundColor: (AppTheme.of(context).currentColors.darkMediumGray)),
            body: LayoutBuilder(
              builder: (c, box) {
                return !kIsWeb
                    ? CustomScrollView(
                        slivers: [
                          SliverToBoxAdapter(
                            child: Selector<FaqDetailViewModel, FaqDetailModel?>(
                              selector: (c, m) => m.detail,
                              builder: (c, detail, _) => Padding(
                                padding: EdgeInsets.all(16),
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      detail?.sTitle ?? '',
                                      style: TextStyle(
                                          fontSize: 16,
                                          height: 24 / 16,
                                          fontWeight: FontWeight.w500,
                                          color: AppTheme.of(context).currentColors.blackTextInFAQ),
                                    ),
                                    Selector<FaqDetailViewModel, bool>(
                                      selector: (c, m) => m.loadFinished,
                                      child: const Center(child: CupertinoActivityIndicator()),
                                      builder: (c, loadDetailFinish, child) => Visibility(
                                        visible: !loadDetailFinish,
                                        child: child!,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          ValueListenableBuilder(
                            valueListenable: _pageChangeNotifier,
                            builder: (c, value, _) => SliverFillViewport(
                              //html,CustomSzfcrollView+WevView，WebView
                              viewportFraction: (_heightTotal > 0 && box.maxHeight != 0)
                                  ? (1.0 * (_heightTotal + _deviceOffset) / box.maxHeight)
                                  : 1.0,
                              padEnds: false,
                              delegate: SliverChildListDelegate([faqContent]),
                            ),
                          ),
                        ],
                      )
                    : Selector<FaqDetailViewModel, FaqDetailModel?>(
                        selector: (c, m) => m.detail,
                        builder: (c, detail, child) => Stack(
                          children: [
                            Selector<FaqDetailViewModel, bool>(
                              selector: (c, m) => m.loadFinished,
                              child: const Center(child: CupertinoActivityIndicator()),
                              builder: (c, loadDetailFinish, child) => Visibility(
                                visible: !loadDetailFinish,
                                child: child!,
                              ),
                            ),
                            _buildwebViewX(detail)
                          ],
                        ),
                      );
              },
            ),
          );
        }),
      ),
    );
  }
}
