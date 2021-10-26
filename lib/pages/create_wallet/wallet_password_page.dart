import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:wallet/common/service/cache_service/cache_keys.dart';
import 'package:wallet/common/service/router_service/router_table.dart';
import 'package:wallet/common/service/wallet_service.dart';
import 'package:wallet/pages/create_wallet/model/wallet_password_model.dart';
import 'package:wallet/pages/navigation_model.dart';
import 'package:wallet/theme/app_theme.dart';
import 'package:wallet/utils/bio_manager.dart';
import 'package:wallet/widgets/verification_box/verfication_box.dart';

GlobalKey<VerificationBoxState>? _verifyKey;

class WalletPasswordPage extends StatefulWidget {
  final WalletCreateRelatedData pageData;

  WalletPasswordPage({Key? key, required this.pageData}) : super(key: key);

  static becomeFirstResponder() {
    _verifyKey?.currentState?.becomeFirstResponder();
  }

  static resignFirstResponder() {
    _verifyKey?.currentState?.resignFirstResponder();
  }

  @override
  State createState() => _WalletPasswordPageState();
}

class _WalletPasswordPageState extends State<WalletPasswordPage> {
  late WalletPasswordModel _model;
  late ValueNotifier<bool> _isPwdRightNotifier;
  late GlobalKey<VerificationBoxState> _verificationKey;

  // 
  final ValueNotifier<bool> _bioNotifier = ValueNotifier(false);

  @override
  initState() {
    _isPwdRightNotifier = ValueNotifier(true);
    _verificationKey = GlobalKey<VerificationBoxState>();

    /// tabwallet_password_pagekey
    if (null == _verifyKey) _verifyKey = _verificationKey;
    _model = WalletPasswordModel(
        widget.pageData, _isPwdRightNotifier, _verificationKey);
    _checkWrongTimes();
    super.initState();
    // ，
    if (_model.checkIfCanInput()) getAuth();
    versionCheck();
  }

  // ，
  versionCheck() {
    if(!_model.pageData.isDeleteWallet) {
      NavigationModel().getVersionInfo().then((data) {
        // ，
        service.cache.setBool(hasNewVersionKey, (null != data) ? true : false);
        if (null != data) {
          // 
          service.cache.setString(newVersionNumberKey, data.lastVersion);
          service.cache.setString(versionUpgradeUrlKey, data.linkUrl);
        }
      });
    }
  }

  getAuth() {
    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) async {
      var showAuth = await enableBiometrics();
      var test = await getAvailableBiometrics();
      if (showAuth) {
        // ()
        bool isOpen = _model.checkBioStatus();
        _bioNotifier.value = isOpen;
        if (!isOpen) return;

        // 
        _verificationKey.currentState!.resignFirstResponder();
        // , 
        bool successCheck = await showGuideThenCheck(context);
        if (successCheck) {
          service.router.pushReplacementNamed(RouteName.navigationPage);
          return;
        }
        // 
        _verificationKey.currentState!.becomeFirstResponder();
      } else {
        _bioNotifier.value = false;
        service.cache.setBool(hasBioBeenSetKey, false);
      }
    });
  }

  void _checkWrongTimes() {


    // if((times == 5 && seconds < 5*60) ||(times == 10 && seconds < 2*60)){
    //   _isPwdRightNotifier.value = false;
    //   _model.inputWrongTimes = 5;
    // }else {
    //   _isPwdRightNotifier.value = true;
    // }

    if(!_model.pageData.isDeleteWallet) {
      int times = getWrongTimes();
      int seconds = getSecondsIntervalWithLastWrongInput();
      if (times >= 5 && seconds < times * 60) {
        _isPwdRightNotifier.value = false;
        _model.inputWrongTimes = times;
      } else if (times == 10) {
        _model.inputWrongTimes = 10;
        _isPwdRightNotifier.value = false;
      } else {
        _isPwdRightNotifier.value = true;
      }
      if (mounted) {
        setState(() {});
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _model.appBar(),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          children: [
            _buildTitle(),
            Offstage(
              offstage: !_model.pageData.isDeleteWallet,
              child: Padding(
                padding: const EdgeInsets.only(bottom: 48.0),
                child: Text('Verify your password to delete wallet.',style: TextStyle(
                    color: AppTheme.of(context).currentColors.textColor1,
                    fontSize: 14,)),
              ),
            ),
            _buildVerify(),
            _buildError(),
          ],
        ),
      ),
    );
  }

  Widget _buildTitle() {
    return Container(
      padding: EdgeInsets.only(top: 80, bottom: _model.pageData.isDeleteWallet ? 16:48),
      child: Text(
        _model.title,
        style: TextStyle(
            color: AppTheme.of(context).currentColors.textColor1,
            fontWeight: FontWeight.w700,
            fontSize: 20,
            height: 24 / 20),
      ),
    );
  }

  Widget _buildVerify() {
    BoxDecoration decoration = BoxDecoration(
      color: AppTheme.of(context).currentColors.dividerColor.withOpacity(0.5),
      borderRadius: BorderRadius.circular(16),
    );
    BoxDecoration errorDecoration = decoration.copyWith(
        border: Border.all(
            color: AppTheme.of(context).currentColors.redAccent, width: 1));
    BoxDecoration focusDecoration = BoxDecoration(
        color: AppTheme.of(context).currentColors.backgroundColor,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
            color: AppTheme.of(context).currentColors.purpleAccent, width: 1));
    TextStyle textStyle = TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w500,
        color: AppTheme.of(context).currentColors.textColor1);
    TextStyle errorStyle = TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w500,
        color: AppTheme.of(context).currentColors.redAccent);
    return Container(
      height: 46,
      margin: EdgeInsets.only(bottom: 24),
      child: VerificationBox(
        key: _verificationKey,
        autoFocus: _model.shouldAutoFocus,
        decoration: decoration,
        errorDecoration: errorDecoration,
        focusDecoration: focusDecoration,
        textStyle: textStyle,
        isDelete: _model.pageData.isDeleteWallet,
        errorStyle: errorStyle,
        reset: () => _isPwdRightNotifier.value = true,
        onSubmitted: (value) => _model.submit(value),
        showCursor: false,
        cursorColor: Colors.transparent,
      ),
    );
  }

  Widget _buildError() {
    return ValueListenableBuilder<bool>(
        valueListenable: _isPwdRightNotifier,
        builder: (ctx, isRight, _) {
          return Offstage(
            offstage: isRight,
            child: Text(
              _model.errStr,
              style: TextStyle(
                color: AppTheme.of(context).currentColors.redAccent,
                fontSize: 14,
              ),
              strutStyle: StrutStyle(fontSize: 18),
            ),
          );
        });
  }
}
