import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:uni_links/uni_links.dart';
import 'package:wallet/common/config/wallet_config.dart';
import 'package:wallet/common/service/router_service/router_table.dart';
import 'package:wallet/common/service/wallet_service.dart';
import 'package:wallet/generated/assets.dart';
import 'package:wallet/pages/create_wallet/model/wallet_create_model.dart';
import 'package:wallet/pages/create_wallet/model/wallet_password_model.dart';
import 'package:wallet/slope_widget/button.dart';
import 'package:wallet/theme/app_theme.dart';
import 'package:wallet/widgets/app_bar/wallet_bar.dart';
import 'package:wallet/widgets/loading/loading_util.dart';
import 'package:wd_common_package/wd_common_package.dart';

class WalletCreatePage extends StatefulWidget {
  final WalletCreateRelatedData pageData;

  WalletCreatePage({Key? key, required this.pageData}) : super(key: key);

  @override
  _WalletCreatePageState createState() => _WalletCreatePageState();
}

class _WalletCreatePageState extends State<WalletCreatePage> {
  final _model = WalletCreateModel();

  final _checkTermOfUseNotifier = ValueNotifier<bool>(false);

  PreferredSizeWidget? _buildAppBar() {
    if (isSlopeDex) {
      if (widget.pageData.isCreatePageAppBarShowBack) {
        return WalletBar.back();
      } else {
        return WalletBar.empty();
      }
    } else {
      return WalletBar.slopeWallet();
    }
  }

  ///  context schemeUrl
  void schemeJump(BuildContext context, String schemeUrl) {
    final _jumpUri = Uri.parse(schemeUrl.replaceFirst(
      'dynamictheme://',
      'http://path/',
    ));

  }

  @override
  initState() {
    // WidgetsBinding.instance!.addObserver(this);
    super.initState();
  }



  Future<void> initPlatformStateForStringUniLinks() async {
    String initialLink;
    // Appscheme
    try {
      initialLink = (await getInitialLink())!;
      if (initialLink != null) {
        logger.d('initialLink--$initialLink');
        service.cache.setBool('isJumpNews', true);
      }
    } catch (e) {}

  }

  @override
  Widget build(BuildContext context) {
    const buttonHeight = 56.0;
    return Scaffold(
      appBar: _buildAppBar(),
      body: isSlopeDex ? buildSlopeDexContent() : buildSlopeWalletContent(),
      bottomNavigationBar: Visibility(
        visible: isSlopeWallet,
        child: SafeArea(
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  margin: const EdgeInsets.only(bottom: 16),
                  child: Row(
                    children: [
                      SlopeCheckBox(
                        value: _checkTermOfUseNotifier.value,
                        onChange: (newValue) => _checkTermOfUseNotifier.value = newValue,
                      ),
                      const SizedBox(width: 8),
                      Text.rich(
                        TextSpan(
                          children: [
                            TextSpan(text: 'I have read and agree with the '),
                            TextSpan(
                              text: 'Terms of Use',
                              style: TextStyle(color: AppTheme.of(context).currentColors.purpleAccent),
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {
                                  service.router.pushNamed(RouteName.serviceAgreementPage);
                                },
                            ),
                          ],
                        ),
                        style: TextStyle(
                          fontSize: 14,
                          height: 18 / 14,
                          color: context.appColors.textColor3,
                        ),
                      ),
                    ],
                  ),
                ),
                SlopeConfirmButton(
                  width: double.infinity,
                  height: buttonHeight,
                  margin: const EdgeInsets.only(bottom: 16),
                  backgroundColor: AppTheme.of(context).currentColors.purpleAccent,
                  text: 'Create New Wallet',
                  onPressed: () {
                    if (!_checkTermOfUseNotifier.value) {
                      showToast('Please check the agreement first');
                      return;
                    }

                    if (_model.isCreating) return;
                    _model.createWallet(widget.pageData);
                  },
                ),
                SlopeCancelButton(
                  width: double.infinity,
                  height: buttonHeight,
                  margin: const EdgeInsets.only(bottom: 16),
                  text: 'Import your wallet',
                  onPressed: () {
                    if (!_checkTermOfUseNotifier.value) {
                      showToast('Please check the agreement first');
                      return;
                    }
                    service.router
                        .pushNamed(RouteName.importSlopeWallet, arguments: widget.pageData);
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  ///Slope Wallet
  Widget buildSlopeWalletContent() {
    return Builder(builder: (context) {
      return SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const SizedBox(height: 80),
            service.image.asset(
              context.isLightTheme
                  ? Assets.assets_image_create_wallet_logo_png
                  : Assets.assets_image_dark_create_wallet_logo_png,
              width: 204,
              height: 204,
            ),
            Container(
              alignment: Alignment.center,
              margin: const EdgeInsets.only(top: 4, bottom: 32),
              child: Text(
                'Create your own Slope wallet\nSecure your assets',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: context.appColors.textColor1,
                  fontSize: 14,
                ),
                strutStyle: const StrutStyle(fontSize: 22),
              ),
            ),
            // _buildCreateButton(),
            // _ImportTips(pageData: widget.pageData),
          ],
        ),
      );
    });
  }

  ///Slope Dex
  Widget buildSlopeDexContent() {
    return Builder(builder: (context) {
      return SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            context.isLightTheme
                ? service.image.asset(
                    Assets.assets_image_create_wallet_logo_png,
                    width: 300,
                    height: 200,
                  )
                : AnimatedOpacity(
                    opacity: 0.9,
                    duration: const Duration(milliseconds: 100),
                    child: service.image.asset(
                      Assets.assets_image_dark_create_wallet_logo_png,
                      width: 200,
                      height: 200,
                    ),
                  ),
            const SizedBox(height: 54),
            _buildCreateButton(),
            _ImportTips(pageData: widget.pageData),
          ],
        ),
      );
    });
  }

  Widget _buildCreateButton() {
    return Builder(builder: (context) {
      final buttonLabel = isSlopeDex ? 'Create Wallet' : 'Create';
      return Container(
        width: double.infinity,
        height: 56,
        margin: const EdgeInsets.only(bottom: 16, left: 24, right: 24),
        child: TextButton(
          child: Text(
            buttonLabel,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w500, color: Colors.white),
          ),
          style: TextButton.styleFrom(
            backgroundColor: context.appColors.purpleAccent,
            elevation: 0,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.0)),
          ),
          onPressed: () async {
            if (_model.isCreating) return;
            _model.createWallet(widget.pageData);
          },
        ),
      );
    });
  }
}

///
class _ImportTips extends StatelessWidget {
  final WalletCreateRelatedData pageData;

  const _ImportTips({Key? key, required this.pageData}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget tips;
    if (kIsWeb) {
      tips = buildWebTips(context);
    } else if (isSlopeDex) {
      tips = buildDexTips(context);
    } else {
      tips = buildWalletTips(context);
    }

    return InkWell(
      onTap: () => service.router.pushNamed(RouteName.importSlopeWallet, arguments: pageData),
      child: tips,
    );
  }

  Widget buildWebTips(BuildContext context) {
    return Text(
      "Import your wallet",
      style: TextStyle(
        color: context.appColors.purpleAccent,
        fontSize: 16,
        fontWeight: FontWeight.w500,
      ),
    );
  }

  Widget buildDexTips(BuildContext context) {
    return Text(
      "or import wallet",
      style: TextStyle(
        color: context.appColors.purpleAccent,
        fontSize: 14,
        height: 20 / 14,
      ),
    );
  }

  Widget buildWalletTips(BuildContext context) {
    return Text.rich(
      TextSpan(
        children: [
          TextSpan(
            text: "Already have? ",
            style: TextStyle(color: context.appColors.textColor3, fontSize: 14),
          ),
          TextSpan(
            text: "Import your wallet",
            style: TextStyle(color: context.appColors.purpleAccent, fontSize: 14),
          ),
        ],
      ),
    );
  }
}
