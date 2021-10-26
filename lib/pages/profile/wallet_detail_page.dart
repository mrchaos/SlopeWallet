import 'dart:ui';

import 'package:decimal/decimal.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:wallet/common/service/router_service/router_table.dart';
import 'package:wallet/common/service/wallet_service.dart';
import 'package:wallet/common/util/screen/screen_util.dart';
import 'package:wallet/common/util/string/string_util.dart';
import 'package:wallet/generated/assets.dart';
import 'package:wallet/pages/create_wallet/model/wallet_password_model.dart';
import 'package:wallet/pages/home/model/wallet_ext.dart';
import 'package:wallet/pages/home/model/wallet_main_model.dart';
import 'package:wallet/theme/app_theme.dart';
import 'package:wallet/wallet_manager/data/wallet_entity.dart';
import 'package:wallet/wallet_manager/service/wallet_manager.dart';
import 'package:wallet/widgets/app_bar/wallet_bar.dart';
import 'package:wallet/widgets/currency_format.dart';
import 'package:wallet/widgets/loading/loading_util.dart';
import 'package:wallet/widgets/menu_tile.dart';

class WalletDetailPage extends StatefulWidget {
  final WalletEntity entity;

  const WalletDetailPage({Key? key, required this.entity}) : super(key: key);

  @override
  _WalletDetailPageState createState() => _WalletDetailPageState();
}

class _WalletDetailPageState extends State<WalletDetailPage> {
  bool _isMnemonicValidate = false;
  Decimal _usdtBalance = Decimal.zero;

  @override
  void initState() {
    _isMnemonicValidate = walletManager.validateMnemonic(widget.entity.decryptMnemonic());
    _usdtBalance = widget.entity.totalUsdtBalance;
    _getBalance(widget.entity);

    super.initState();
  }

  void _getBalance(WalletEntity entity) async {
    _usdtBalance = await WalletMainModel.instance.getAWalletUsdtBalance(entity);
    if (mounted) setState(() {});
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double titleAndEditWidth = 34 + widget.entity.walletName.widthByFontSize(22) + 10; //
    double maxWidth = ScreenUtil.width(context) - 48 - 40;
    double resWidth = titleAndEditWidth;
    if (titleAndEditWidth > maxWidth) resWidth = maxWidth;
    // double _balance = context.select<WalletMainModel, double>((value) => value.totalBalance);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: WalletBar.backWithTitle(widget.entity.walletName.notBreak),
      body: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: 24,
        ).copyWith(top: 16),
        child: Column(
          children: [
            Container(
              height: 150,
              decoration: BoxDecoration(
                  color: widget.entity.walletBgColor, borderRadius: BorderRadius.circular(16)),
              child: Stack(
                children: [
                  Positioned.fill(
                    child: Container(
                      padding: EdgeInsets.all(20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Flexible(
                                  child: Text(
                                widget.entity.walletName.notBreak,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.w700,
                                    color:
                                        AppTheme.of(context).currentColors.blackTextInGreenAccent),
                              )),
                              const SizedBox(width: 9),
                              InkWell(
                                onTap: _showChangeName,
                                child: service.svg.asset(Assets.assets_svg_walletname_edit_svg),
                              ),
                              // Spacer()
                            ],
                          ),
                          const SizedBox(height: 8),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Container(
                                child: Text(
                                  widget.entity.address.ellAddress(),
                                  style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400,
                                      color: AppTheme.of(context)
                                          .currentColors
                                          .blackTextInGreenAccent),
                                ),
                              ),
                              const SizedBox(
                                width: 6,
                              ),
                              GestureDetector(
                                onTap: () {
                                  Clipboard.setData(ClipboardData(text: widget.entity.address));
                                  showToast('Copy success!');
                                },
                                child: Opacity(
                                  opacity: 0.9,
                                  child: Container(
                                    height: 18,
                                    width: 40,
                                    // padding: EdgeInsets.only(top: 3),
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    child: Center(
                                      child: Text(
                                        'copy',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            fontSize: 10,
                                            fontWeight: FontWeight.w400,
                                            color: AppTheme.of(context)
                                                .currentColors
                                                .blackTextInGreenAccent),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Spacer(),
                          Text(
                            '${CurrencyFormat.formatUSDT(_usdtBalance, maxDecimalDigits: 2)} USDT',
                            style: TextStyle(
                                fontSize: 28,
                                fontWeight: FontWeight.w700,
                                color: AppTheme.of(context).currentColors.blackTextInGreenAccent),
                          )
                        ],
                      ),
                    ),
                  ),
                  Positioned(
                      right: 0,
                      bottom: 0,
                      child: service.svg.asset(
                        Assets.assets_svg_menu_bg_sol_svg,
                        width: 85,
                        height: 85,
                      )),
                ],
              ),
            ),
            SizedBox(height: 20),
            Card(
              elevation: 0,
              margin: EdgeInsets.symmetric(horizontal: 0),
              shape: RoundedRectangleBorder(
                  side: BorderSide(
                    color: AppTheme.of(context).currentColors.dividerColor,
                    width: 1.0,
                    style: BorderStyle.solid,
                  ),
                  borderRadius: BorderRadius.all(Radius.circular(16.0))),
              child: Column(
                children: [
                  _isMnemonicValidate
                      ? MenuTile(
                          height: 56,
                          borderRadius: BorderRadius.circular(8),
                          title: Text(
                            'Mnemonic backup',
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w400,
                                color: AppTheme.of(context).currentColors.textColor1),
                          ),
                          onPressed: () {
                            service.router.pushNamed(RouteName.walletPasswordPage,
                                arguments: WalletCreateRelatedData(
                                    isMnemonicBackupVerify: true, wallet: widget.entity));
                          },
                          trailing: service.svg.asset(Assets.assets_svg_ic_menu_trailing_svg,
                              fit: BoxFit.scaleDown,
                              color: AppTheme.of(context).currentColors.textColor1),
                        )
                      : SizedBox(),
                  _isMnemonicValidate
                      ? Divider(
                          height: 1,
                          thickness: 1,
                          indent: 0,
                          endIndent: 0,
                          color: AppTheme.of(context).currentColors.dividerColor)
                      : SizedBox(),
                  MenuTile(
                      height: 56,
                      borderRadius: BorderRadius.circular(8),
                      // border: Border.,
                      title: Text(
                        'Export Private key',
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                            color: AppTheme.of(context).currentColors.textColor1),
                      ),
                      onPressed: () {
                        service.router.pushNamed(RouteName.walletPasswordPage,
                            arguments: WalletCreateRelatedData(
                                isKeyBackupVerify: true, wallet: widget.entity));
                        // service.router.pushNamed(RouteName.walletPasswordPage,
                        //     arguments: {"type": 3, "wallet": widget.entity});
                      },
                      trailing: service.svg.asset(Assets.assets_svg_ic_menu_trailing_svg,
                          fit: BoxFit.scaleDown,
                          color: AppTheme.of(context).currentColors.textColor1)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  TextEditingController _controller = TextEditingController();
  bool _isValidName = true;
  int _currentLength = 0;

  bool get _isCanChange =>
      _isValidName && (_controller.text.length > 0 && _controller.text.length < 21);

  String get errStr {
    if (_isValidName == false || _controller.text.length > 19) {
      if (_isValidName == false) {
        return "This name has been created, try another one.";
      } else if (_isValidName && _controller.text.length > 20) {
        return 'No more than 20 characters.';
      }
    }
    return "";
  }

  void _showChangeName() async {
    await showModalBottomSheet(
        // useSafeArea: false,
        // barrierDismissible: true,
        // backgroundColor: Colors.transparent,
        context: context,
        isScrollControlled: true,
        builder: (context) {
          WalletMainModel _mainModel = context.read<WalletMainModel>();
          // double _contentHeight =
          //     176 + 20 + MediaQuery.of(context).padding.bottom;
          // double _keyboardHeight = MediaQuery.of(context).viewInsets.bottom;
          // double _paddingTop = _keyboardHeight > 0
          //     ? ScreenUtil.height(context) - _contentHeight - _keyboardHeight
          //     : ScreenUtil.height(context) - _contentHeight;
          return AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            padding: EdgeInsets.only(bottom: MediaQuery.of(context).padding.bottom),
            // height: ScreenUtil.height(context),

            margin: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
            // color: AppTheme.of(context).currentColors.backgroundColor,
            child: InkWell(
              onTap: () {},
              child: Container(
                // height: _contentHeight,
                padding: EdgeInsets.only(
                  left: 20,
                  right: 20,
                  top: 20,
                  bottom: 20,
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                      topRight: Radius.circular(16), topLeft: Radius.circular(16)),
                  color: AppTheme.of(context).currentColors.backgroundColor,
                ),
                child: StatefulBuilder(builder: (context, _setState) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        'Change Wallet Name',
                        textAlign: TextAlign.left,
                        style: TextStyle(
                            color: AppTheme.of(context).currentColors.textColor1,
                            fontSize: 18,
                            fontWeight: FontWeight.w500),
                        strutStyle: StrutStyle(fontSize: 22),
                      ),
                      SizedBox(height: 16),
                      Container(
                        height: 46,
                        padding: EdgeInsets.symmetric(horizontal: 16),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(
                              color: _isValidName
                                  ? AppTheme.of(context).currentColors.dividerColor
                                  : AppTheme.of(context).currentColors.redAccent,
                              width: 1),
                        ),
                        alignment: Alignment.center,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Expanded(
                                child: TextField(
                              controller: _controller,
                              autocorrect: false,
                              enableSuggestions: false,
                              keyboardType: TextInputType.text,
                              onChanged: (value) {
                                _setState(() {
                                  _currentLength = value.length;
                                  WalletEntity e = _mainModel.allWallets.firstWhere(
                                      (element) => element.walletName == value,
                                      orElse: () => WalletEntity());
                                  _isValidName = isStrNullOrEmpty(e.walletName);
                                });
                              },
                              maxLines: 1,
                              style: TextStyle(
                                  height: 1.5,
                                  fontSize: 14,
                                  color: AppTheme.of(context).currentColors.textColor1),
                              cursorColor: AppTheme.of(context).currentColors.purpleAccent,
                              decoration: InputDecoration(
                                hintText: 'Enter wallet name ...',
                                contentPadding: EdgeInsets.only(bottom: 6),
                                hintStyle: TextStyle(
                                  fontSize: 14,
                                  color: AppTheme.of(context).themeMode == ThemeMode.light
                                      ? AppTheme.of(context).currentColors.textColor3
                                      : AppTheme.of(context).currentColors.textColor4,
                                ),
                                border: InputBorder.none,
                              ),
                              inputFormatters: [
                                LengthLimitingTextInputFormatter(21),
                              ],
                            )),
                            Container(
                              padding: EdgeInsets.only(top: 3),
                              width: 44,
                              height: 22,
                              child: Text(
                                '$_currentLength/20',
                                textAlign: TextAlign.right,
                                style: TextStyle(
                                    color: _currentLength > 20
                                        ? AppTheme.of(context).currentColors.redAccent
                                        : AppTheme.of(context).currentColors.textColor3,
                                    fontSize: 14),
                              ),
                            )
                          ],
                        ),
                      ),
                      AnimatedContainer(
                        margin: EdgeInsets.only(top: 4),
                        duration: Duration(milliseconds: 200),
                        height: _isValidName == false || _controller.text.length > 20 ? 16 : 0,
                        child: Text(errStr,
                            style: TextStyle(
                                fontSize: 12, color: AppTheme.of(context).currentColors.redAccent)),
                      ),
                      SizedBox(height: 16),
                      Row(
                        children: [
                          Expanded(
                            child: Container(
                              height: 48,
                              width: double.infinity,
                              child: TextButton(
                                child: Text(
                                  'Cancel',
                                  style: TextStyle(
                                      fontSize: 16,
                                      color: AppTheme.of(context).currentColors.textColor6),
                                ),
                                style: ButtonStyle(
                                  backgroundColor: MaterialStateProperty.all(
                                      AppTheme.of(context).themeMode == ThemeMode.light
                                          ? Color(0xFFF7F8FA)
                                          : AppTheme.of(context).currentColors.dexCreateBtn),
                                  elevation: MaterialStateProperty.all(0),
                                  shape: MaterialStateProperty.all(RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10.0))),
                                ),
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                              ),
                            ),
                          ),
                          SizedBox(width: 12),
                          Expanded(
                            child: Container(
                              height: 48,
                              width: double.infinity,
                              child: TextButton(
                                child: Text(
                                  'Change',
                                  style: TextStyle(
                                      fontSize: 16,
                                      color: _isCanChange
                                          ? Colors.white
                                          : Colors.white.withOpacity(0.5)),
                                ),
                                style: ButtonStyle(
                                  backgroundColor: MaterialStateProperty.all(_isCanChange
                                      ? AppTheme.of(context).currentColors.purpleAccent
                                      : AppTheme.of(context)
                                          .currentColors
                                          .purpleAccent
                                          .withOpacity(0.5)),
                                  elevation: MaterialStateProperty.all(0),
                                  shape: MaterialStateProperty.all(RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10.0))),
                                ),
                                onPressed: () {
                                  if (false == _isCanChange) return;
                                  setState(() {
                                    widget.entity.walletName = _controller.text;
                                    _mainModel.updateWallet(widget.entity);
                                  });
                                  Navigator.pop(context);
                                },
                              ),
                            ),
                          ),
                        ],
                      ),
                      // Spacer()
                    ],
                  );
                }),
              ),
            ),
          );
        });
    _isValidName = true;
    _currentLength = 0;
    _controller.text = "";
  }
}
