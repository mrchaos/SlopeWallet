import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:wallet/common/service/router_service/router_table.dart';
import 'package:wallet/common/service/wallet_service.dart';
import 'package:wallet/data/bean/browser_list.dart';
import 'package:wallet/generated/assets.dart';
import 'package:wallet/theme/app_theme.dart';
import 'package:wallet/widgets/loading/loading_util.dart';

const _kDAppTermOfUse = '_kDAppTermOfUse';

void showOpenDAppTermsOfUse({
  required BuildContext context,
  required BrowserItemBean dApp,
}) {
  if (dApp.linkUrl.isEmpty) {
    showToast('For developing');
    return;
  }
  // final value = service.cache.getBool(_getDAppTermUseCacheKey(dApp), defaultValue: false) == true;
  // if (value) return;
  showModalBottomSheet<bool>(
    context: context,
    isDismissible: false,
    enableDrag: false,
    isScrollControlled: true,
    builder: (c) => _DAppTermsOfUse(dApp: dApp),
  ).then((bool? agree) {
    if (true == agree) {
      //DApp
      service.router
          .pushNamed(RouteName.browserCurrencyDetailsPage, arguments: {'browserItemInfo': dApp});
    }
  });
}

//
String _getDAppTermUseCacheKey(BrowserItemBean dApp) {
  final host = Uri.tryParse(dApp.linkUrl)?.host ?? dApp.name;
  return '$_kDAppTermOfUse-$host';
}

class _DAppTermsOfUse<bool> extends StatelessWidget {
  final BrowserItemBean dApp;

  const _DAppTermsOfUse({Key? key, required this.dApp}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    var checked = false;

    return SafeArea(
      top: true,
      child: Container(
        constraints: BoxConstraints(
          maxHeight: mediaQuery.size.height * 10 / 16,
        ),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Terms of use',
              style: TextStyle(
                fontSize: 18,
                height: 22 / 18,
                fontWeight: FontWeight.w500,
                color: context.appColors.textColor1,
              ),
            ),
            Flexible(
              child: Container(
                width: double.infinity,
                margin: const EdgeInsets.symmetric(vertical: 16),
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(
                    color: context.appColors.dividerColor,
                  ),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    service.image.network(
                      dApp.logo,
                      width: 52,
                      height: 52,
                      borderRadius: BorderRadius.circular(14),
                      shape: BoxShape.rectangle,
                    ),
                    Container(
                      margin: const EdgeInsets.symmetric(vertical: 8),
                      child: Text(
                        dApp.name,
                        style: TextStyle(
                          fontSize: 14,
                          height: 18 / 14,
                          color: context.appColors.textColor1,
                        ),
                      ),
                    ),
                    Flexible(
                      child: SingleChildScrollView(
                        scrollDirection: Axis.vertical,
                        child: Text(
                          'Dear user (hereafter referred to as “You”):You will be directed to the website of the third-party DApp ${dApp.name}: ${dApp.linkUrl}.\n\nSlope Wallet does not recommend that you use it. The developer and operator of ${dApp.name} shall be solely responsible for your use of the DApp, user agreement, privacy policy and results.',
                          style: TextStyle(
                            fontSize: 14,
                            height: 18 / 14,
                            color: context.appColors.textColor2,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            StatefulBuilder(builder: (context, setState) {
              return GestureDetector(
                onTap: () {
                  setState(() {
                    checked = !checked;
                  });
                },
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      margin: const EdgeInsets.only(top: 1),
                      child: _CheckButton(
                        value: checked,
                        onChange: (newValue) => checked = newValue,
                      ),
                    ),
                    const SizedBox(width: 9),
                    Expanded(
                      child: Text(
                        'I have fully understood this message and agree.',
                        style: TextStyle(
                          fontSize: 14,
                          height: 18 / 14,
                          color: context.appColors.textColor3,
                        ),
                      ),
                    ),
                  ],
                ),
              );
            }),
            const SizedBox(height: 20),
            Row(
              children: [
                Expanded(
                  child: TextButton(
                    onPressed: () => Navigator.pop(context, false),
                    child: const Text('Cancel'),
                    style: TextButton.styleFrom(
                      backgroundColor: context.appColors.cancelButtonColor,
                      primary: context.isLightTheme
                          ? context.appColors.textColor3
                          : context.appColors.textColor2,
                      fixedSize: Size.fromHeight(48),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                      textStyle: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        fontFamily: 'Roboto',
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: TextButton(
                    onPressed: () {
                      if (checked) {
                        // service.cache.setBool(_getDAppTermUseCacheKey(dApp), true);
                        Navigator.pop(context, true);
                      } else {
                        showToast('Please check the agreement first');
                      }
                    },
                    child: const Text('Done'),
                    style: TextButton.styleFrom(
                      backgroundColor: context.appColors.purpleAccent,
                      primary: Colors.white,
                      fixedSize: Size.fromHeight(48),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                      textStyle: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        fontFamily: 'Roboto',
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _CheckButton extends StatelessWidget {
  bool value;
  final ValueChanged<bool>? onChange;

  _CheckButton({
    Key? key,
    this.value = false,
    this.onChange,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StatefulBuilder(
      builder: (c, setState) => GestureDetector(
        onTap: () {
          setState(() {
            value = !value;
            onChange?.call(value);
          });
        },
        child: AnimatedCrossFade(
          duration: const Duration(milliseconds: 200),
          firstChild: service.svg.asset(
            Assets.assets_svg_ic_terms_of_use_uncheck_svg,
            color: c.appColors.textColor4,
          ),
          secondChild: service.svg.asset(
            context.isLightTheme
                ? Assets.assets_svg_ic_terms_of_use_check_light_svg
                : Assets.assets_svg_ic_terms_of_use_check_dark_svg,
          ),
          crossFadeState: value ? CrossFadeState.showSecond : CrossFadeState.showFirst,
        ),
      ),
    );
  }
}
