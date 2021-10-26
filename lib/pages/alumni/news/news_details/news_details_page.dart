import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:wallet/common/service/router_service/router_table.dart';
import 'package:wallet/common/service/wallet_service.dart';
import 'package:wallet/common/util/string/string_util.dart';
import 'package:wallet/data/bean/alumni_news/alumni_news_details_bean.dart';
import 'package:wallet/generated/assets.dart';
import 'package:wallet/pages/alumni/news/alumni_news_model.dart';
import 'package:wallet/theme/app_colors.dart';
import 'package:wallet/theme/app_theme.dart';
import 'package:wallet/utils/date_extends.dart';
import 'package:wallet/widgets/app_bar/wallet_bar.dart';
import 'package:wallet/widgets/loading/loading_util.dart';
import 'package:wallet/widgets/widget_ext.dart';
import 'package:wd_common_package/wd_common_package.dart';
import 'package:webview_flutter/webview_flutter.dart';

import 'news_details_modal_bottom.dart';
import 'share_news.dart';

///News
class NewsDetailsPage extends StatefulWidget {
  final int newsId;

  const NewsDetailsPage({Key? key, required this.newsId}) : super(key: key);

  @override
  _NewsDetailsPageState createState() => _NewsDetailsPageState();
}

// imageUrls: [
//   'https://img.zcool.cn/community/01cfa75cdbaf02a801214168d5a68d.jpg',
//   'https://pic.macw.com/pic/202002/17163720_e2bb6a15c2.jpeg',
//   'https://tse4-mm.cn.bing.net/th/id/OIP.Le46HfnZgiYrqAick1T_xwHaD6?pid=Api&rs=1',
// ],

class _NewsDetailsPageState extends State<NewsDetailsPage> with WidgetsBindingObserver {
  String getHtmlContent(
      {required AlumniNewsDetailsBean detail,
      required String bgColor,
      required String textColor,
      required String titleColor,
      required String authorNameColor}) {
    return '''
       <!DOCTYPE html>
    <html>
    <header>
      <meta name="viewport" content="width=device-width,initial-scale=1, maximum-scale=1, minimum-scale=1, user-scalable=no">
    <header>
      <body>
        <style>
            /*、、、*/
            body{
              font-family: Roboto,'SF UI Text','Source Han Sans CN', -apple-system, BlinkMacSystemFont, 'Segoe UI', 'Microsoft YaHei UI', 'Microsoft YaHei',  'Helvetica Neue', Arial, sans-serif;
              overflow-y:auto;
              padding-left: 24px;
              padding-right: 24px;
              background:${bgColor};

            }

            a {
              word-wrap:break-word;
            }

           .title {
              font-size: 20px;
              line-height: 28px;
              font-weight:700;
              color:${titleColor};
            }

            ol {
              padding-left: 24px;
              padding-right: 24px;
            }

           ul {
              padding-left: 24px;
              padding-right: 24px;
            }

            .subtitle {
              font-size: 12px;
              line-height: 16px;
              font-weight:400;
              color:#5C5F66;
              margin-top: 12px;
              margin-bottom: 24px;
              color:${authorNameColor};
            }

            .content {
              font-size: 16px;
              line-height: 22px;
              color:${textColor};
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
        <div class='title'>${detail.title}</div>
        <div class='subtitle'>
        <span>${detail.author}</span>
        ${detail.releaseStime != null ? DateExtends.format(detail.releaseStime ?? 0) : ""}
        </div>
        <div class='content'>${detail.content}</div>
      </body>
      </html>
        ''';
  }

  setHtmlContentColor({
    required AlumniNewsDetailsBean detail,
    required isDark,
  }) {
    return isDark
        ? getHtmlContent(
            detail: detail,
            bgColor: '#131314',
            textColor: '#E9ECF2',
            titleColor: '#E9ECF2',
            authorNameColor: '#A7ACB5')
        : getHtmlContent(
            detail: detail,
            bgColor: '#ffffff',
            textColor: '#292C33',
            titleColor: '#292C33',
            authorNameColor: '#5C5F66',
          );
  }

  late AlumniNewsModel _alumniNewsModel;
  final ValueNotifier<bool> _isShowBtnNotifier = ValueNotifier<bool>(false);
  String? _shareImgUrl;

  @override
  void initState() {
    _alumniNewsModel = AlumniNewsModel();
    super.initState();
    WidgetsBinding.instance!.addObserver(this);
    if (Platform.isAndroid) {
      WebView.platform = SurfaceAndroidWebView();
    }

    _getNewsDetails();

    initShareSdk();
  }

  void _getNewsDetails() async {
    await _alumniNewsModel.getAlumniNewsDetails(widget.newsId);

    _isShowBtnNotifier.value = _alumniNewsModel.alumniNewsDetails != null;
  }

  num _deviceOffset = 40;
  num _heightTotal = 0;

  // ：【】：app，app，，
  @override
  void dispose() {
    WidgetsBinding.instance!.removeObserver(this);
    super.dispose();
  }

  Widget faqContent(AlumniNewsDetailsBean detail, BuildContext context) {
    return WebView(
      initialMediaPlaybackPolicy: AutoMediaPlaybackPolicy.always_allow,
      navigationDelegate: (navigation) {
        if (isNetworkUrl(navigation.url) && navigation.isForMainFrame) {
          service.router.pushNamed(RouteName.webViewPage, arguments: navigation.url);
          return Future.value(NavigationDecision.prevent);
        }
        return Future.value(NavigationDecision.navigate);
      },

      javascriptMode: JavascriptMode.unrestricted,
      onWebViewCreated: (WebViewController webViewController) {
        _controller = webViewController;
        Future.delayed(Duration(milliseconds: 100), () async {
          await loadHtmlContent(detail, context);
        });
      },

      // ，
      onPageFinished: (String url) {
        print('_NewsDetailsPageState.faqContent');
        _controller?.evaluateJavascript("window.onload").then((value) {
          Future.delayed(Duration(milliseconds: 0), () {
            _controller?.evaluateJavascript("document.body.scrollHeight").then((value) {
              num height = num.tryParse(value) ?? 0;
              if (height > _heightTotal) {
                setState(() {
                  _heightTotal = height + 56;
                });
              }
            });
          });
        });
      },
    );
  }

  Future<void> loadHtmlContent(AlumniNewsDetailsBean detail, BuildContext context) async {
    bool isDark = context.read<AppTheme>().themeMode == ThemeMode.dark;
    final String contentBase64 = base64Encode(
        const Utf8Encoder().convert(setHtmlContentColor(detail: detail, isDark: isDark)));
    await _controller?.loadUrl('data:text/html;charset=utf-8;base64,$contentBase64');
  }

  AppColors get appColor => context.watch<AppTheme>().currentColors;

  ThemeMode get themeMode => context.watch<AppTheme>().themeMode;

  WebViewController? _controller;

  ///
  GlobalKey _shareWidgetKey = GlobalKey();

  Widget qrCodeShowViewNotRadius({required AlumniNewsDetailsBean detail, GlobalKey? widgetKey}) {
    int timeStamp = new DateTime.now().millisecondsSinceEpoch;
    String shareFormatTime = DateFormat('yyyy-MM-dd EEE', "en_US")
        .format(DateTime.fromMillisecondsSinceEpoch(timeStamp))
        .toLowerCase();
    return RepaintBoundary(
      key: widgetKey != null ? widgetKey : null,
      child: Container(
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: widgetKey == null
                ? BorderRadius.only(
                    topLeft: Radius.circular(8.0),
                    topRight: Radius.circular(8.0),
                    bottomLeft: Radius.circular(16),
                    bottomRight: Radius.circular(16))
                : null,
            image: DecorationImage(
              alignment: Alignment.topLeft,
              image: AssetImage(Assets.assets_image_share_title_background_png),
              fit: BoxFit.fitWidth,
            )),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              children: [
                Text(
                  'NEWS',
                  style: const TextStyle(
                      fontSize: 12, fontWeight: FontWeight.w500, color: Colors.white),
                ).intoPadding(padding: const EdgeInsets.only(left: 16, top: 12, bottom: 12)),
                const Spacer(),
                Text(
                  shareFormatTime,
                  style: const TextStyle(
                      fontSize: 12, fontWeight: FontWeight.w500, color: Colors.white),
                ).intoPadding(padding: const EdgeInsets.only(right: 16)),
              ],
            ),
            Row(
              children: [
                Container(
                  width: MediaQuery.of(context).size.width - 96 - 32,
                  child: Text(
                    detail.title ?? '',
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        height: 24 / 16,
                        color: Color(0xFF292C33)),
                    // ，textcolor1
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                  ),
                )
              ],
            ).intoPadding(padding: const EdgeInsets.only(left: 16, right: 16, top: 20, bottom: 24)),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    service.image.asset(Assets.assets_image_article_share_logo_png),
                    const SizedBox(height: 4),
                    Text(
                      'The Gateway to Solana Eco',
                      style: TextStyle(
                          fontSize: 12,
                          height: 16 / 12,
                          fontWeight: FontWeight.w400,
                          color: Color(0xFF5C5F66)),
                    ),
                  ],
                ),
                QrImage(
                  data: detail.shareUrl ?? '',
                  version: QrVersions.auto,
                  size: 60,
                  padding: EdgeInsets.zero,
                  gapless: true,
                  embeddedImageStyle: QrEmbeddedImageStyle(size: Size(14, 14)),
                )
              ],
            ).intoPadding(padding: EdgeInsets.only(left: 16, right: 16, bottom: 16)),
          ],
        ),
      ),
    );
  }

  Widget qrCodeShowView(AlumniNewsDetailsBean detail) {
    int timeStamp = new DateTime.now().millisecondsSinceEpoch;
    String shareFormatTime = DateFormat('yyyy-MM-dd EEE', "en_US")
        .format(DateTime.fromMillisecondsSinceEpoch(timeStamp))
        .toUpperCase();
    return RepaintBoundary(
      key: _shareWidgetKey,
      child: Container(
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: _isShowRadius ? BorderRadius.all(Radius.circular(16)) : null,
            image: DecorationImage(
              alignment: Alignment.topLeft,
              image: AssetImage(Assets.assets_image_share_title_background_png),
              fit: BoxFit.fitWidth,
            )),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              children: [
                Text(
                  'Solana Nucleus',
                  style: const TextStyle(
                      fontSize: 12, fontWeight: FontWeight.w500, color: Colors.white),
                ).intoPadding(padding: const EdgeInsets.only(left: 16, top: 12, bottom: 12)),
                const Spacer(),
                Text(
                  shareFormatTime,
                  style: const TextStyle(
                      fontSize: 12, fontWeight: FontWeight.w500, color: Colors.white),
                ).intoPadding(padding: const EdgeInsets.only(right: 16)),
              ],
            ),
            Row(
              children: [
                Container(
                  width: MediaQuery.of(context).size.width - 96 - 32,
                  child: Text(
                    detail.title ?? '',
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        height: 24 / 16,
                        color: Color(0xFF292C33)),
                    // ，textcolor1
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                  ),
                )
              ],
            ).intoPadding(padding: const EdgeInsets.only(left: 16, right: 16, top: 20, bottom: 24)),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    service.image.asset(Assets.assets_image_article_share_logo_png),
                    const SizedBox(height: 4),
                    Text(
                      'The Gateway to Solana Eco',
                      style: TextStyle(
                          fontSize: 12,
                          height: 16 / 12,
                          fontWeight: FontWeight.w400,
                          color: Color(0xFF5C5F66)),
                    ),
                  ],
                ),
                QrImage(
                  data: detail.shareUrl ?? '',
                  version: QrVersions.auto,
                  size: 60,
                  padding: EdgeInsets.zero,
                  gapless: true,
                  embeddedImageStyle: QrEmbeddedImageStyle(size: Size(14, 14)),
                )
              ],
            ).intoPadding(padding: EdgeInsets.only(left: 16, right: 16, bottom: 16)),
          ],
        ),
      ),
    );
  }

  ///Widget
  Future<File?> _capture(GlobalKey widgetKey) async {
    try {
      RenderRepaintBoundary boundary =
          widgetKey.currentContext!.findRenderObject() as RenderRepaintBoundary;

      //boundary.toImage()ui.Image,，
      var image = await boundary.toImage(pixelRatio: 10.0);
      //imagebyteData
      ByteData byteData = await image.toByteData(format: ImageByteFormat.png) as ByteData;
      //
      Uint8List pngBytes = byteData.buffer.asUint8List();
      String sTempDir = (await getTemporaryDirectory()).path;
      bool isDirExist = await Directory(sTempDir).exists();
      if (!isDirExist) {
        Directory(sTempDir).create();
      }
      Future<File> file = File(sTempDir + "/share.png").writeAsBytes(pngBytes);
      return await file;
    } catch (e) {
      print(e);
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => _alumniNewsModel,
      child: Scaffold(
        // resizeToAvoidBottomPadding: false,
        appBar: WalletBar(showBackButton: true),
        floatingActionButton: buildShareButton(),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        body: buildNewDetail(),
      ),
    );
  }

  Widget buildNewDetail() {
    return LayoutBuilder(
      builder: (BuildContext context, box) {
        final _detail = context.select((AlumniNewsModel vm) => vm.alumniNewsDetails);
        // if (_isNotLoadingNotifier.value) return const Center(child: CupertinoActivityIndicator());
        if (null == _detail) return Center(child: const CupertinoActivityIndicator());
        return NotificationListener(
          onNotification: (ScrollNotification notification) {
            if (notification is ScrollStartNotification) {
              _isShowBtnNotifier.value = false;
            } else if (notification is ScrollEndNotification) {
              _isShowBtnNotifier.value = true;
            }

            return false;
          },
          child: CustomScrollView(
            slivers: [
              SliverFillViewport(
                //html,CustomSzfcrollView+WevView，WebView
                viewportFraction: (_heightTotal > 0 && box.maxHeight != 0)
                    ? (1.0 *
                        (_heightTotal + _deviceOffset + MediaQuery.of(context).padding.bottom) /
                        box.maxHeight)
                    : 1.0,
                padEnds: false,
                delegate: SliverChildListDelegate([
                  Builder(builder: (context) {
                    return faqContent(_detail, context);
                  }),
                ]),
              ),
            ],
          ),
        );
      },
    );
  }

  ///
  Widget buildShareButton() {
    return ValueListenableBuilder<bool>(
      valueListenable: _isShowBtnNotifier,
      builder: (context, value, child) {
        return InkWell(
          onTap: () => _shareNew(context),
          child: AnimatedOpacity(
            duration: const Duration(milliseconds: 300),
            opacity: _isShowBtnNotifier.value ? 1.0 : 0,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: appColor.dividerColor,
              ),
              padding: const EdgeInsets.only(top: 12, bottom: 12, right: 36, left: 36),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  service.svg.asset(Assets.assets_svg_news_share_svg, color: appColor.textColor1),
                  const SizedBox(width: 8),
                  Text(
                    'Share',
                    style: TextStyle(
                        color: appColor.textColor1, fontSize: 16, fontWeight: FontWeight.w500),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  // int _shareStackIndex = 0;

  bool _isShowRadius = true;

  ///News
  Future<void> _shareNew(BuildContext context) async {
    final _detail = context.read<AlumniNewsModel>().alumniNewsDetails;
    late Function state;
    if (null == _detail) return;
    //
    SharePageModel.showShareView(
      context: context,
      showWidget: Container(
          padding: EdgeInsets.symmetric(horizontal: 48),
          child: StatefulBuilder(
            builder: (BuildContext context, void Function(void Function()) setState) {
              state = setState;
              return qrCodeShowView(_detail);
            },
          )
          // child: IndexedStack(
          //   index: 1,
          //   children: [
          //     qrCodeShowViewNotRadius(detail: _detail,),
          //     // qrCodeShowViewNotRadius(detail: _detail, widgetKey: ),
          //     // qrCodeShowView(_detail),
          //     // qrCodeShowView(_detail),
          //
          //     // qrCodeShowViewNotRadius(detail:_detail, widgetKey: _shareWidgetKey)
          //   ],
          // ),
          ),
      actions: [
        ShareItem(
          name: 'Copy Link',
          icon: context.isLightTheme
              ? Assets.assets_image_news_share_link_png
              : Assets.assets_image_news_share_link_dark_png,
          onPressed: () async {
            if (_detail.shareUrl?.isEmpty ?? false) {
              showToast('the link is empty, copy link failure!');
              return;
            }
            Clipboard.setData(ClipboardData(text: _detail.shareUrl));
            showSuccess('Copy Link');
            //dismiss BottomSheet
            Navigator.pop(context);
            print('EEEEEEE');
          },
        ),
      ],
      shareMenus: [
        ShareItem(
          name: 'Twitter',
          icon: Assets.assets_image_news_share_twitter_png,
          onPressed: () async {
            showLoading(dismissOnTap: false);
            _shareImgUrl ??= await _uploadShareImage(_detail, state);
            dismissLoading();
            if (_shareImgUrl?.isEmpty ?? true) {
              showToast('Network Error. Please try again later.');
              return;
            }
            shareTwitterCustom(context, _detail, _shareImgUrl!); //dismiss BottomSheet
            Navigator.pop(context);
          },
        ),
        // ShareItem(
        //   name: 'Discord',
        //   icon: Assets.assets_image_news_share_discord_png,
        //   onPressed: () async {
        //     //
        //   },
        // ),
        ShareItem(
          name: 'Telegram',
          icon: Assets.assets_image_news_share_telegram_png,
          onPressed: () async {
            print('eeeeeee');
            showLoading(dismissOnTap: false);
            _shareImgUrl ??= await _uploadShareImage(_detail, state);
            dismissLoading();
            if (_shareImgUrl?.isEmpty ?? true) {
              showToast('Network Error. Please try again later.');
              return;
            }
            shareTelegramCustom(context, _detail, _shareImgUrl!); //dismiss BottomSheet
            Navigator.pop(context);
            print('EEEEEEE');
          },
        ),
        ShareItem(
          name: 'Facebook',
          icon: Assets.assets_image_news_share_facebook_png,
          onPressed: () async {
            showLoading(dismissOnTap: false);
            _shareImgUrl ??= await _uploadShareImage(_detail, state);
            // logger.d('_shareImgUrl:${_shareImgUrl}');
            logger.d('_shareImgUrl:${_shareImgUrl}');
            dismissLoading();
            if (_shareImgUrl?.isEmpty ?? true) {
              showToast('Network Error. Please try again later.');
              return;
            }
            shareFacebookCustom(context, _detail, _shareImgUrl!); //dismiss BottomSheet
            Navigator.pop(context);
          },
        ),
      ],
    );
  }

  ///，。 Url
  Future<String?> _uploadShareImage(AlumniNewsDetailsBean _detail, Function state) async {
    state(() {
      _isShowRadius = false;
    });
    try {
      await Future.delayed(Duration(milliseconds: 100));
      final file = await _capture(_shareWidgetKey);
      state(() {
        _isShowRadius = true;
      });
      if (file == null) return '';
      final imgUrl = await _alumniNewsModel.uploadImage(
        account: _detail.title,
        filePath: file.path,
      );
      return imgUrl;
    } catch (e) {
      print(e);
    }
    return null;
  }
}
