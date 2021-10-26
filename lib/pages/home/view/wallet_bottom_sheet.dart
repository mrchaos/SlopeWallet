import 'dart:io';
import 'dart:typed_data';
import 'dart:ui';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:wallet/common/service/wallet_service.dart';
import 'package:wallet/common/util/string/string_util.dart';
import 'package:wallet/generated/assets.dart';
import 'package:wallet/theme/app_colors.dart';
import 'package:wallet/theme/app_theme.dart';
import 'package:wallet/theme/text_style.dart';
import 'package:wallet/widgets/Dialog/public_dialog.dart';
import 'package:wallet/widgets/alert_dialog.dart';
import 'package:wallet/widgets/coin_image.dart';
import 'package:wallet/widgets/loading/loading_util.dart';
import 'package:wallet/widgets/menu_tile.dart';

class ShareWalletConnectModal {
  static showView({
    required BuildContext context,
    List<String>? titles,
    List<String>? images,
    required void Function(int index) selectCallback,
    required void Function() createCallback,
  }) {
    showModalBottomSheet(
        context: context,
        backgroundColor: Colors.white.withAlpha(0),
        elevation: 0,
        isScrollControlled: true,
        builder: (BuildContext context) {
          return ConnectPage(
            titles: titles,
            images: images,
            selectCallback: selectCallback,
            createCallback: createCallback,
          );
        });
  }
}

class ConnectPage extends StatefulWidget {
  final List<String>? titles;
  final List<String>? images;

  void Function(int index) selectCallback;
  void Function() createCallback;

  ConnectPage({
    Key? key,
    this.titles,
    this.images,
    required this.selectCallback,
    required this.createCallback,
  }) : assert(0 != titles?.length && titles?.length == images?.length);

  @override
  _ConnectPageState createState() => _ConnectPageState();
}

class _ConnectPageState extends State<ConnectPage> {
  @override
  Widget build(BuildContext context) {
    List<String> titles = widget.titles ?? [];
    double width = MediaQuery.of(context).size.width;
    double btnHeight = 48;
    double itemHeight = 56;
    return ClipRRect(
      borderRadius: BorderRadius.only(topLeft: Radius.circular(16), topRight: Radius.circular(16)),
      child: Container(
        width: width,
        color: Colors.white,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Card(
              elevation: 0,
              margin: EdgeInsets.all(20),
              shape: RoundedRectangleBorder(
                  side: BorderSide(
                    color: AppTheme.of(context).currentColors.dividerColor,
                    width: 1.0,
                    style: BorderStyle.solid,
                  ),
                  borderRadius: BorderRadius.all(Radius.circular(16.0))),
              child: Container(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    for (int i = 0; i < titles.length; i++)
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          GestureDetector(
                            behavior: HitTestBehavior.opaque,
                            onTap: () {
                              if (null != widget.selectCallback) widget.selectCallback(i);
                            },
                            child: Container(
                              padding: EdgeInsets.only(left: 20),
                              child: Row(
                                children: [
                                  service.svg.asset(
                                    Assets.assets_svg_wallet_setting_svg,
                                    width: 32,
                                    height: 32,
                                    fit: BoxFit.scaleDown,
                                    // color: Colors.red,
                                  ),
                                  const SizedBox(
                                    width: 12,
                                  ),
                                  Text(
                                    (0 != titles.length && titles.length > i) ? titles[i] : '',
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500,
                                        color: AppTheme.of(context).currentColors.textColor1),
                                  )
                                ],
                              ),
                            ),
                          ),
                          if (i != (titles.length - 1))
                            Divider(
                                height: 1,
                                thickness: 1,
                                indent: 0,
                                endIndent: 0,
                                color: AppTheme.of(context).currentColors.dividerColor),
                        ],
                      ),
                  ],
                ),
              ),
            ),
            Container(
              width: width - 2 * 20,
              child: TextButton(
                onPressed: () {
                  _dismiss(context);
                  widget.createCallback.call();
                },
                child: Text(
                  'Create Wallet',
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: AppTheme.of(context).currentColors.textColor1),
                ),
                style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all(AppTheme.of(context).currentColors.lightGray),
                  elevation: MaterialStateProperty.all(0),
                  shape: MaterialStateProperty.all(
                      RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0))),
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Container(
              width: width - 2 * 20,
              child: TextButton(
                onPressed: () {
                  _dismiss(context);
                },
                child: Text(
                  'Cancel',
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: AppTheme.of(context).currentColors.textColor3),
                ),
                style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all(AppTheme.of(context).currentColors.lightGray),
                  elevation: MaterialStateProperty.all(0),
                  shape: MaterialStateProperty.all(
                      RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0))),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  _dismiss(BuildContext context) {
    Navigator.pop(context);
  }
}

///////////////////////////////////////////////////////////////
//
class ShareWalletQrcodeModal {
  static showView({
    required BuildContext context,
    String? address,
    String? coinName,
    String? coinIcon,
    required void Function(String address) copyCallback,
  }) {
    showModalBottomSheet(
        context: context,
        backgroundColor: Colors.white.withAlpha(0),
        elevation: 0,
        isScrollControlled: true,
        builder: (BuildContext context) {
          return QrCodePage(
            address: address,
            coinName: coinName,
            coinIcon: coinIcon,
            copyCallback: copyCallback,
          );
        });
  }
}

class QrCodePage extends StatefulWidget {
  String? address;
  String? coinName;
  String? coinIcon;
  void Function(String address) copyCallback;

  QrCodePage({
    Key? key,
    this.address,
    this.coinName,
    this.coinIcon,
    required this.copyCallback,
  }) : assert(0 != address?.length);

  @override
  _QrCodePageState createState() => _QrCodePageState();
}

class _QrCodePageState extends State<QrCodePage> {
  void _checkPhotoPermission({
    BuildContext? context,
    VoidCallback? onGranted,
  }) async {
    PermissionStatus status;
    Permission permission = Permission.photos;
    if (Platform.isAndroid) permission = Permission.storage;

    status = await permission.status;

    if (status.isDenied) {
      //
      permission.request().isGranted.then((value) {
        if (value) {
          // getImage(context, source);
          onGranted?.call();
        }
      });

      return;
    }

    if (status.isPermanentlyDenied) {
      // Android：，
      _showPhotoPermissionDialog(context!);
      return;
    }

    if (status.isRestricted || status.isDenied || status.isLimited) {
      // iOS:
      _showPhotoPermissionDialog(context!);

      return;
    }
    if (await permission.shouldShowRequestRationale) {
      // Android:
      _showPhotoPermissionDialog(context!);

      return;
    }
    //
    var result = await permission.request();
    if (result.isGranted) {
      //
      onGranted?.call();
    }
  }

  void _showPhotoPermissionDialog(BuildContext context) {
    var title = 'Allow access your album in ”Settings”->”Privacy”->”Photos”';
    var cancelButtonLabel = 'OK';
    var confirmButtonLabel = 'Go to Setting';
    var confirmPressed = () {
      //
      var isOpen = openAppSettings();
      //dismiss dialog
      Navigator.pop(context);
    };

    showAlertHorizontalButtonDialog(
      context: context,
      title: title,
      cancelButtonLabel: cancelButtonLabel,
      confirmButtonLabel: confirmButtonLabel,
      confirmPressed: confirmPressed,
    );
  }

  void _save2album(BuildContext context) async {
    var showing = true;
    try {
      showLoadingDialog(context: context).whenComplete(() => showing = false);
      RenderRepaintBoundary boundary =
          _globalKey.currentContext!.findRenderObject() as RenderRepaintBoundary;
      //boundary.toImage()ui.Image,，
      var image = await boundary.toImage(pixelRatio: 10.0);
      //imagebyteData
      ByteData byteData = await image.toByteData(format: ImageByteFormat.png) as ByteData;
      //
      Uint8List pngBytes = byteData.buffer.asUint8List();

      final result = await ImageGallerySaver.saveImage(pngBytes);
      if (showing) {
        Navigator.pop(context);
      }
      bool bResult = false;
      String message = 'save success';
      if (Platform.isIOS) {
        bResult = (null != result) ? (result['isSuccess']) : false;
        print(result);
        message = bResult ? 'save success' : 'save failure'; //result['errorMessage'];
      } else {
        bResult = result['isSuccess'];
        message = bResult ? 'save success' : 'save failure';
      }
      showToast(message);
    } catch (e) {
      print(e);
      if (showing) {
        Navigator.pop(context);
      }
    }
  }

  GlobalKey _globalKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    // double height = 446 + MediaQuery.of(context).padding.bottom + 16;
    return ClipRRect(
      borderRadius: BorderRadius.only(topLeft: Radius.circular(16), topRight: Radius.circular(16)),
      child: Stack(
        children: [
          RepaintBoundary(
            child: buildContent(context, true),
            key: _globalKey,
          ),
          buildContent(context, false),
        ],
      ),
    );
  }

  ///
  /// * [saveToImg] 。
  /// （）
  Widget buildContent(BuildContext context, bool saveToImg) {
    double width = MediaQuery.of(context).size.width;
    const qrcodeHeight = 160.0;
    return Container(
      width: width,
      color: AppTheme.of(context).currentColors.backgroundColor,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(height: 8),
          Visibility(
            visible: !saveToImg,
            child: Container(
              width: 48,
              height: 4,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(2.0),
                color: AppTheme.of(context).currentColors.textColor4,
              ),
            ),
          ),
          const SizedBox(height: 24),
          CoinImage(
            icon: widget.coinIcon ?? '',
            radius: 24,
          ),
          const SizedBox(height: 24),
          Container(
            height: 18,
            child: Text(
              'Scan QR code, transfer ${widget.coinName}',
              style: TextStyle(fontSize: 14, color: AppTheme.of(context).currentColors.textColor3),
            ),
          ),
          const SizedBox(height: 16),
          QrImage(
            data: widget.address ?? '',
            version: QrVersions.auto,
            size: qrcodeHeight,
            padding: EdgeInsets.zero,
            backgroundColor: Colors.white,
          ),
          const SizedBox(height: 12),
          Visibility(
            visible: !kIsWeb && !saveToImg,
            child: Container(
              margin: const EdgeInsets.only(bottom: 16),
              child: GestureDetector(
                onTap: () async {
                  if (kIsWeb) {
                    // var downloadElement =
                    //     html.document.createElement('a') as html.AnchorElement;
                    // var img =
                    //     'https://tpc.googlesyndication.com/simgad/16803173489871683615?sqp=4sqPyQQ7QjkqNxABHQAAtEIgASgBMAk4A0DwkwlYAWBfcAKAAQGIAQGdAQAAgD-oAQGwAYCt4gS4AV_FAS2ynT4&rs=AOga4qkJIeP2dQB_eyPtkyV_17564TQLFg';
                    // ;
                    // downloadElement.href = img;
                    // // downloadElement.target = '_blank';
                    // downloadElement.download = '111';
                    // html.document.body!.children.add(downloadElement);
                    // downloadElement.click(); //
                    // html.document.body!.children.remove(downloadElement);
                    // html.Url.revokeObjectUrl(img);
                  } else {
                    _checkPhotoPermission(
                      context: context,
                      onGranted: () => _save2album(context),
                    );
                  }
                },
                child: Text(
                  'Save QRcode',
                  style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: AppTheme.of(context).currentColors.purpleAccent),
                ),
              ),
            ),
          ),
          if (saveToImg)
            Text(
              'Receive - (${(widget.address ?? '').ellAddress()})',
              textAlign: TextAlign.start,
              style: TextStyle(
                color: AppTheme.of(context).currentColors.textColor3,
              ).merge(styleFontSize_14),
            ),
          if (!saveToImg)
            GestureDetector(
              onTap: () => widget.copyCallback(widget.address ?? ''),
              child: Container(
                margin: const EdgeInsets.only(left: 40, right: 40),
                padding: const EdgeInsets.only(left: 10, right: 20),
                decoration: BoxDecoration(
                  color: AppTheme.of(context).themeMode == ThemeMode.light
                      ? AppTheme.of(context).currentColors.lightGray
                      : AppTheme.of(context).currentColors.darkLightGray2,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.only(top: 16, bottom: 16, left: 12),
                        child: Text(
                          //
                          (widget.address ?? ''),
                          textAlign: TextAlign.start,
                          style: TextStyle(
                            color: AppTheme.of(context).currentColors.textColor3,
                          ).merge(styleFontSize_12),
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    service.svg.asset(Assets.assets_svg_wallet_copy_icon_svg),
                  ],
                ),
              ),
            ),
          const SizedBox(height: 16),
          Container(
            height: 32,
            width: width - 40,
            child: Text(
              '*This address only used for ${widget.coinName}. Do not transfer other assets into this address.',
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 12, height: 1.3, color: AppTheme.of(context).currentColors.redAccent),
            ),
          ),
          SizedBox(
            height: 16 + MediaQuery.of(context).padding.bottom,
          ),
        ],
      ),
    );
  }

  _dismiss(BuildContext context) {
    Navigator.pop(context);
  }
}

///////////////////////////////////////////////////////////////
// ，
class SharePayConfirmModal {
  static showView({
    required BuildContext context,
    required String coinName,
    required String payAmount,
    required String feeAmount,
    required String address,
    required void Function() confirmCallback,
  }) {
    showModalBottomSheet(
        context: context,
        backgroundColor: Colors.white.withAlpha(0),
        elevation: 0,
        isScrollControlled: true,
        builder: (BuildContext context) {
          return PayConfirmPage(
            coinName: coinName,
            payAmount: payAmount,
            feeAmount: feeAmount,
            address: address,
            confirmCallback: confirmCallback,
          );
        });
  }
}

class PayConfirmPage extends StatefulWidget {
  String coinName;
  String payAmount;
  String feeAmount;
  String address;
  void Function() confirmCallback;

  PayConfirmPage({
    Key? key,
    required this.coinName,
    required this.payAmount,
    required this.feeAmount,
    required this.address,
    required this.confirmCallback,
  });

  @override
  _PayConfirmPageState createState() => _PayConfirmPageState();
}

class _PayConfirmPageState extends State<PayConfirmPage> {
  late AppColors _appColors;

  //
  Widget headItem(double width, String payAmount, String feeAmount) {
    String totalAmount = payAmount;
    return Container(
      width: width,
      decoration: BoxDecoration(
        color: _appColors.greenAccent,
        borderRadius: BorderRadius.circular(16),
      ),
      padding: EdgeInsets.only(left: 24, right: 24, top: 20, bottom: 20),
      margin: EdgeInsets.only(left: 24, right: 24, top: 20, bottom: 10),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'Actual Send',
            style:
                TextStyle(fontSize: 14, fontWeight: FontWeight.w400, color: _appColors.textColor1),
          ),
          const SizedBox(
            height: 10,
          ),
          Text(
            '$totalAmount ${widget.coinName}',
            style:
                TextStyle(fontSize: 20, fontWeight: FontWeight.w700, color: _appColors.textColor1),
          ),
        ],
      ),
    );
  }

  Widget menuItem(
      {required double width, String itemName = '', String itemValue = '', TextStyle? valueStyle}) {
    return Container(
      width: width,
      padding: EdgeInsets.only(top: 20, bottom: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            itemName,
            style:
                TextStyle(fontSize: 16, fontWeight: FontWeight.w400, color: _appColors.textColor1),
          ),
          Spacer(),
          Text(
            itemValue,
            style: valueStyle,
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    double _width = MediaQuery.of(context).size.width;
    double _widgetWith = _width - 20 * 2 - 20 * 2;
    double _btnHeight = 48;
    double _itemHeight = 60;
    _appColors = context.read<AppTheme>().currentColors;
    return ClipRRect(
      borderRadius: BorderRadius.only(topLeft: Radius.circular(16), topRight: Radius.circular(16)),
      child: Container(
        width: _width,
        color: AppTheme.of(context).currentColors.backgroundColor,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(
              height: 20,
            ),
            Text(
              'Confirm Transaction',
              style: TextStyle(
                  fontSize: 18, fontWeight: FontWeight.w500, color: _appColors.AmountAndPrice),
            ),
            const SizedBox(
              height: 20,
            ),
            Container(
              width: _width - 20 * 2,
              child: Card(
                margin: EdgeInsets.symmetric(horizontal: 0),
                color: Colors.transparent,
                elevation: 0,
                // margin: EdgeInsets.only(left: 24, right: 24),
                shape: RoundedRectangleBorder(
                    side: BorderSide(
                      color: _appColors.dividerColor,
                      width: 1.0,
                      style: BorderStyle.solid,
                    ),
                    borderRadius: BorderRadius.all(Radius.circular(16.0))),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const SizedBox(
                      height: 10,
                    ),
                    //
                    // headItem(_widgetWith, widget.payAmount, widget.feeAmount),
                    // item（60，20）
                    menuItem(
                        width: _widgetWith,
                        itemName: 'Currency',
                        itemValue: widget.coinName,
                        valueStyle: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                            color: _appColors.textColor1)),
                    menuItem(
                        width: _widgetWith,
                        itemName: 'Address',
                        itemValue: widget.address,
                        valueStyle: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                            color: _appColors.textColor1)),
                    menuItem(
                        width: _widgetWith,
                        itemName: 'Total paid',
                        itemValue: '${widget.payAmount} ${widget.coinName}',
                        valueStyle: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w400, color: Color(0xFF1BD1A8))),
                    menuItem(
                        width: _widgetWith,
                        itemName: 'Miner Fee',
                        itemValue: '${widget.feeAmount} SOL',
                        valueStyle: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                            color: _appColors.textColor3)),
                    const SizedBox(
                      height: 10,
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 16,
            ),
            Container(
              padding: EdgeInsets.only(left: 20, right: 20),
              // height: _btnHeight,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    flex: 1,
                    child: Container(
                      height: 48,
                      child: TextButton(
                        onPressed: () {
                          _dismiss(context);
                        },
                        child: Text(
                          'Cancel',
                          style: TextStyle(
                            color: Color(0xFFA7ACB5),
                            fontSize: 16,
                          ),
                        ),
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all(
                              AppTheme.of(context).currentColors.cancelButtonColor),
                          padding: MaterialStateProperty.all(EdgeInsets.only(top: 13, bottom: 13)),
                          elevation: MaterialStateProperty.all(0),
                          shape: MaterialStateProperty.all(
                              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0))),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 12,
                  ),
                  Expanded(
                    flex: 1,
                    child: Container(
                      height: 48,
                      child: TextButton(
                        onPressed: () {
                          _dismiss(context);
                          widget.confirmCallback();
                        },
                        child: Text(
                          'Confirm',
                          style: TextStyle(color: Colors.white, fontSize: 16),
                        ),
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all(_appColors.purpleAccent),
                          padding: MaterialStateProperty.all(EdgeInsets.only(top: 13, bottom: 13)),
                          elevation: MaterialStateProperty.all(0),
                          shape: MaterialStateProperty.all(
                              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0))),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 16 + MediaQuery.of(context).padding.bottom,
            ),
          ],
        ),
      ),
    );
  }

  _dismiss(BuildContext context) {
    Navigator.pop(context);
  }
}

typedef OnCopy = String Function(int index);

///////////////////////////////////////////////////////////////
// Contact us
class ShareContactUsModal {
  static showView({
    required BuildContext context,
    required List<String> contactInfos,
    OnCopy? onCopy,
  }) {
    showModalBottomSheet(
        context: context,
        backgroundColor: Colors.white.withAlpha(0),
        elevation: 0,
        isScrollControlled: true,
        builder: (BuildContext context) {
          return ContactUsPage(
            contactInfos: contactInfos,
            onCopy: onCopy,
          );
        });
  }
}

class ContactUsPage extends StatefulWidget {
  final List<String> contactInfos;
  final OnCopy? onCopy;

  ContactUsPage({
    Key? key,
    required this.contactInfos,
    this.onCopy,
  });

  @override
  _ContactUsPageState createState() => _ContactUsPageState();
}

class _ContactUsPageState extends State<ContactUsPage> {
  late AppColors _appColors;

  Widget makeItem(String url, bool isLast, int index) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        MenuTile(
            paddingSize: 16,
            height: 56,
            title: Text(
              url,
              style: TextStyle(
                  fontSize: 16, fontWeight: FontWeight.w500, color: _appColors.textColor1),
            ),
            trailing: service.svg.asset(Assets.assets_svg_copy_svg,
                fit: BoxFit.scaleDown,
                color: AppTheme.of(context).themeMode == ThemeMode.light
                    ? null
                    : AppTheme.of(context).currentColors.textColor2),
            onPressed: () {
              final copyText = widget.onCopy?.call(index) ?? url;
              Clipboard.setData(ClipboardData(text: copyText));
              showToast('Copy success!');
            }),
        if (!isLast)
          Divider(
              height: 1,
              thickness: 1,
              indent: 0,
              endIndent: 0,
              color: AppTheme.of(context).currentColors.dividerColor),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    _appColors = context.read<AppTheme>().currentColors;
    return ClipRRect(
      borderRadius: BorderRadius.only(topLeft: Radius.circular(16), topRight: Radius.circular(16)),
      child: Container(
        color: AppTheme.of(context).currentColors.backgroundColor,
        padding: EdgeInsets.only(left: 20, right: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(
              height: 20,
            ),
            Text(
              'Contact us',
              style: TextStyle(
                  fontSize: 18, fontWeight: FontWeight.w500, color: _appColors.textColor1),
            ),
            const SizedBox(
              height: 16,
            ),
            Card(
              elevation: 0,
              margin: EdgeInsets.zero,
              shape: RoundedRectangleBorder(
                  side: BorderSide(
                    color: _appColors.dividerColor,
                    width: 1.0,
                    style: BorderStyle.solid,
                  ),
                  borderRadius: BorderRadius.all(Radius.circular(16.0))),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  for (int i = 0; i < widget.contactInfos.length; i++)
                    makeItem(
                      widget.contactInfos[i],
                      i == (widget.contactInfos.length - 1),
                      i,
                    ),
                ],
              ),
            ),
            const SizedBox(
              height: 16,
            ),
            Container(
              height: 48,
              decoration: BoxDecoration(
                color: AppTheme.of(context).currentColors.dividerColor,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: TextButton(
                      child: Text(
                        'Cancel',
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: _appColors.textColor2),
                      ),
                      onPressed: () async {
                        _dismiss(context);
                      },
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 16 + MediaQuery.of(context).padding.bottom,
            ),
          ],
        ),
      ),
    );
  }

  _dismiss(BuildContext context) {
    Navigator.pop(context);
  }
}
