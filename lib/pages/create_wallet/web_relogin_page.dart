import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:wallet/common/service/wallet_service.dart';
import 'package:wallet/common/service/router_service/router_table.dart';
import 'package:wallet/generated/assets.dart';
import 'package:wallet/theme/app_theme.dart';
import 'package:wallet/wallet_manager/service/wallet_manager.dart';
import 'package:wallet/widgets/app_bar/wallet_bar.dart';

class WebReLoginPage extends StatefulWidget {
  @override
  _WebReLoginPageState createState() => _WebReLoginPageState();
}

class _WebReLoginPageState extends State<WebReLoginPage> {
  ValueNotifier<String> _pwdNotifier = ValueNotifier("");
  ValueNotifier<bool> _validateNotifier = ValueNotifier(true);
  bool _seePwd = false;

  final formatter = [
    FilteringTextInputFormatter.allow(RegExp('[0-9]')),
    LengthLimitingTextInputFormatter(6),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: WalletBar.title("Slope Wallet"),
      body: SafeArea(
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.only(top: 60, bottom: 30),
              child: service.svg.asset(
                Assets.assets_svg_web_login_icon_svg,
                width: 90,
                height: 90,
              ),
            ),
            Text(
              'Enter your password',
              style: TextStyle(
                  color: AppTheme.of(context).currentColors.textColor1,
                  fontWeight: FontWeight.bold,
                  fontSize: 20),
            ),
            _buildPwdField(),
            _buildWrongTips(),
          ],
        ),
      ),
      bottomSheet: _buildUnlock(),
    );
  }

  Widget _buildPwdField() {
    return ValueListenableBuilder<bool>(
      valueListenable: _validateNotifier,
      builder: (c, value, _) {
        return Container(
          height: 46,
          margin: const EdgeInsets.only(top: 30, left: 24, right: 24),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                color: value ? AppTheme.of(context).currentColors.dividerColor : AppTheme.of(context).currentColors.redAccent,
                width: 1,
              )),
          child: TextField(
            obscureText: !_seePwd,
            decoration: InputDecoration(
              hintText: 'Password',
              hintStyle: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w400,
                color: AppTheme.of(context).currentColors.textColor3,
              ),
              isDense: true,
              contentPadding:
                  EdgeInsets.symmetric(horizontal: 16, vertical: 16),
              border: InputBorder.none,
              suffixIconConstraints: BoxConstraints.tightFor(
                width: 16 + 32,
              ),
              suffixIcon: GestureDetector(
                onTap: () {
                  setState(() {
                    _seePwd = !_seePwd;
                  });
                },
                child: service.svg.asset(
                  _seePwd
                      ? Assets.assets_svg_ic_see_svg
                      : Assets.assets_svg_ic_unsee_svg,
                ),
              ),
            ),
            keyboardType: TextInputType.number,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
            inputFormatters: formatter,
            onChanged: (txt) {
              _pwdNotifier.value = txt;
              _validateNotifier.value = true;
            },
          ),
        );
      },
    );
  }

  Widget _buildWrongTips() {
    return Container(
      margin: const EdgeInsets.only(top: 8, left: 24, right: 24),
      alignment: Alignment.centerLeft,
      child: ValueListenableBuilder<bool>(
        valueListenable: _validateNotifier,
        builder: (c, value, _) => Visibility(
          visible: !value,
          child: Text(
            'Wrong password. Try again.',
            style: TextStyle(fontSize: 14, color: AppTheme.of(context).currentColors.redAccent),
          ),
        ),
      ),
    );
  }

  Widget _buildUnlock() {
    return ValueListenableBuilder<String>(
      valueListenable: _pwdNotifier,
      builder: (c, value, _) {
        return Container(
          height: 108,
          width: double.infinity,
          padding: EdgeInsets.only(top: 16, bottom: 36, left: 24, right: 24),
          child: TextButton(
            child: Text(
              'Unlock',
              style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                  color: Colors.white),
            ),
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(AppTheme.of(context)
                  .currentColors
                  .purpleAccent
                  .withOpacity(value.length == 6 ? 1 : 0.5)),
              elevation: MaterialStateProperty.all(0),
              shape: MaterialStateProperty.all(RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16.0))),
            ),
            onPressed: () async {
              if (value.length != 6) return;
              bool isValidate = walletManager.validatePassword(password: value);
              if (isValidate) {
                service.router.pushReplacementNamed(RouteName.navigationPage);
              } else {
                _validateNotifier.value = false;
              }
            },
          ),
        );
      },
    );
  }
}
