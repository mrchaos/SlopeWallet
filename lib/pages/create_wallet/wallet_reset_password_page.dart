import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:wallet/pages/create_wallet/model/wallet_password_model.dart';
import 'package:wallet/theme/app_colors.dart';
import 'package:wallet/theme/app_theme.dart';
import 'package:wallet/widgets/app_bar/wallet_bar.dart';
import 'package:wallet/widgets/verification_box/verfication_box.dart';
import 'package:provider/provider.dart';

GlobalKey<VerificationBoxState>? _verifyKey;

class WalletResetPasswordPage extends StatefulWidget {
  final WalletCreateRelatedData pageData;

  WalletResetPasswordPage({Key? key, required this.pageData}) : super(key: key);

  static becomeFirstResponder() {
    _verifyKey?.currentState?.becomeFirstResponder();
  }

  static resignFirstResponder() {
    _verifyKey?.currentState?.resignFirstResponder();
  }

  @override
  State createState() => _WalletResetPasswordPageState();
}

class _WalletResetPasswordPageState extends State<WalletResetPasswordPage> {

  late AppColors _appColors;

  @override
  initState() {
    _appColors = context.read<AppTheme>().currentColors;
    super.initState();
  }


  final double textHeight = 20;

  final double textBottom = 8;

  final double inputFieldHeight = 112;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: WalletBar.backWithTitle("Reset Password"),
      body: Padding(
          padding: EdgeInsets.symmetric(vertical: 48),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: EdgeInsets.only(left: 24),
                height: textHeight,
                child: Text('Enter Slope Wallet Mnemonic',
                  style: TextStyle(
                      fontSize: 16, fontWeight: FontWeight.w400, color: _appColors.textColor1),
                ),
              ),
              SizedBox(height: textBottom),
              Container(
                height: inputFieldHeight,
                margin: EdgeInsets.only(left: 24, right: 24),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(
                      color: _appColors.dividerColor, width: 1),
                ),
                child: TextField(
                  autocorrect: false,
                  enableSuggestions: false,
                  autofocus: true,
                  controller: TextEditingController(),
                  cursorColor: AppTheme.of(context).currentColors.purpleAccent,
                  onChanged: (value) {
                  },
                  maxLines: 10,
                  style: TextStyle(
                    height: 18 / 14,
                    fontSize: 14,
                    color: _appColors.textColor1,
                  ),
                  // cursorHeight: 20,
                  decoration: InputDecoration(
                    hintText:
                    'Please enter mnemonic...',
                    hintStyle: TextStyle(
                      height: 21 / 14,
                      fontSize: 14,
                      color: AppTheme.of(context).themeMode == ThemeMode.light
                          ? _appColors.textColor4
                          : _appColors.textColor3,
                    ),
                    contentPadding: EdgeInsets.only(left: 16, top: 12, right: 16, bottom: 12),
                    border: InputBorder.none,
                  ),
                ),
              ),
              SizedBox(height: textBottom),
              Center(child: ElevatedButton(onPressed: (){}, child: Text('Reset')))
            ],
          )),
    );
  }

}
