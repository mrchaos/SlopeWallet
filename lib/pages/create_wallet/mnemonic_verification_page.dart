import 'dart:ui';

import 'package:collection/collection.dart';
import 'package:date_format/date_format.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import 'package:screen_shot_listen_plugin/screen_shot_listen_plugin.dart';
import 'package:wallet/common/config/app_config/app_config.dart';
import 'package:wallet/common/config/wallet_config.dart';
import 'package:wallet/common/service/wallet_service.dart';
import 'package:wallet/common/service/router_service/router_table.dart';
import 'package:wallet/generated/assets.dart';
import 'package:wallet/pages/create_wallet/model/wallet_create_model.dart';
import 'package:wallet/pages/create_wallet/model/wallet_password_model.dart';
import 'package:wallet/pages/create_wallet/view/mnemonic_select_item.dart';
import 'package:wallet/pages/create_wallet/view/mnemonic_word_item.dart';
import 'package:wallet/pages/create_wallet/view/screenshot_dialog.dart';
import 'package:wallet/theme/app_theme.dart';
import 'package:wallet/wallet_manager/service/wallet_manager.dart';
import 'package:wallet/widgets/Dialog/public_dialog.dart';
import 'package:wallet/widgets/app_bar/wallet_bar.dart';

import '../navigation_page.dart';

class MnemonicVerificationPage extends StatefulWidget {
  final bool isBackup;
  final WalletCreateRelatedData pageData;
  const MnemonicVerificationPage({Key? key, this.isBackup = false, required this.pageData})
      : super(key: key);

  @override
  State createState() => _MnemonicVerificationPageState();
}

class _MnemonicVerificationPageState extends State<MnemonicVerificationPage> {
  bool _showError = false;
  late WalletCreateModel _createModel;

  @override
  void initState() {
    _createModel = WalletCreateModel.instance;
    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
      ScreenShotListenPlugin.instance
        ..startListen()
        ..addScreenShotListener(_screenShotListener)
        ..addNoPermissionListener(_noPermissionListener);
    });
    super.initState();
  }

  @override
  void dispose() {
    ScreenShotListenPlugin.instance.screenShotListener = null;
    ScreenShotListenPlugin.instance.noPermissionListener = null;
    ScreenShotListenPlugin.instance.stopListen();
    super.dispose();
  }

  void _screenShotListener(String path){
    if(isScreenShotDialogShow) return;
    ScreenShotDialog.show(context);
  }
  void _noPermissionListener() {
    Permission.storage.request();
  }

  @override
  Widget build(BuildContext context) {
    String title = "";
    if (widget.isBackup) {
      title = "Slope Wallet";
    } else {
      title = config.app.appType != WalletAppType.slope
          ? _createModel.isFirstWallet
              ? "Slope Wallet"
              : "Create New Wallet"
          : "";
    }

    return Scaffold(
      appBar: WalletBar.backWithTitle(title),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.only(bottom: 24),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ..._buildTips(),
                    ..._buildMnemonic(),
                  ],
                ),
              ),
            ),
            _buildNext()
          ],
        ),
      ),
    );
  }

  List<Widget> _buildTips() {
    return [
      Padding(
        padding: EdgeInsets.only(top: 24, bottom: 16),
        child: Text(
          'Mnemonic Verification',
          style: TextStyle(
              color: AppTheme.of(context).currentColors.textColor1,
              fontSize: 20,
              fontWeight: FontWeight.bold),
        ),
      ),
      Text(
        'Please select the correct word in each position from the list below',
        style: TextStyle(
          color: AppTheme.of(context).currentColors.textColor6,
          fontSize: 14,
        ),
        strutStyle: StrutStyle(fontSize: 22),
      ),
      AnimatedContainer(
        decoration: BoxDecoration(
          color: AppTheme.of(context).currentColors.redAccent.withOpacity(0.08),
          borderRadius: BorderRadius.circular(16),
        ),
        height: _showError ? 40 : 0,
        padding: EdgeInsets.symmetric(horizontal: 10),
        margin: EdgeInsets.symmetric(vertical: 16),
        duration: Duration(milliseconds: 200),
        child: Row(
          children: [
            Container(
              width: 24,
              height: 24,
              // padding: EdgeInsets.all(7.5),
              child: service.svg.asset(
                Assets.assets_svg_ic_red_warning_svg,
              ),
            ),
            SizedBox(
              width: 4,
            ),
            Text(
              "Try again, Please choose in order.",
              style: TextStyle(
                color: AppTheme.of(context).currentColors.redAccent,
                fontSize: 14,
              ),
            )
          ],
        ),
      ),
    ];
  }

  List<Widget> _buildMnemonic() {
    return [
      Builder(builder: (context) {
        return Container(
          margin: EdgeInsets.only(bottom: 16),
          decoration: BoxDecoration(
              border: Border.all(
                  color: _showError
                      ? AppTheme.of(context).currentColors.redAccent
                      : AppTheme.of(context).currentColors.dividerColor,
                  width: 1),
              borderRadius: BorderRadius.circular(16)),
          padding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
          child: GridView.count(
            padding: EdgeInsets.zero,
            physics: NeverScrollableScrollPhysics(),
            childAspectRatio: 2,
            shrinkWrap: true,
            crossAxisCount: 3,
            crossAxisSpacing: 8,
            mainAxisSpacing: 8,
            children: List.generate(
                _createModel.mnemonicMap.length,
                (index) => MnemonicWordItem(
                      onTap: () {
                        if (_createModel.selectedMnemonics.values.toList()[index] !=
                            "") {
                          setState(() {
                            _showError = false;
                            _createModel.resetSelectedMnemonics(index);
                          });
                        }
                      },
                      number: (index + 1).toString(),
                      word: _createModel.selectedMnemonics.values.toList()[index],
                      isWaitingInput: (index + 1).toString() ==
                          _createModel.querySelectingIndex(),
                    )),
          ),
        );
      }),
      Builder(builder: (context) {
        return Container(
          child: GridView.count(
            padding: EdgeInsets.zero,
            physics: NeverScrollableScrollPhysics(),
            childAspectRatio: 2.5,
            shrinkWrap: true,
            crossAxisCount: 3,
            crossAxisSpacing: 8,
            mainAxisSpacing: 8,
            children: List.generate(
                _createModel.randomMnemonics.length,
                (index) => MnemonicSelectItem(
                      word: _createModel.randomMnemonics[index].word,
                      isSelected: _createModel.randomMnemonics[index].isSelected,
                      onTap: () {
                        RandomMnemonicBean bean = _createModel.randomMnemonics[index];
                        if (bean.isSelected) return;
                        bool isLast = _createModel.selectWord(bean);
                        setState(() {
                          if (isLast) {
                            _showError = !_createModel.isVerificationSuccess();
                          } else {
                            _showError = false;
                          }
                        });
                      },
                    )),
          ),
        );
      }),
    ];
  }

  Widget _buildNext() {
    return Builder(
      builder: (context) {
        String title = "";
        if (widget.isBackup) {
          title = "Done";
        } else {
          title = _createModel.isFirstWallet ? 'Next' : 'Done';
        }
        return SafeArea(
          child: Container(
            width: double.infinity,
            height: 56,
            margin: EdgeInsets.only(bottom: 16),
            child: TextButton(
              child: Text(
                title,
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                    color: _createModel.isVerificationSuccess()
                        ? Colors.white
                        : Colors.white.withOpacity(0.5)),
              ),
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(
                    _createModel.isVerificationSuccess()
                        ? AppTheme.of(context).currentColors.purpleAccent
                        : AppTheme.of(context)
                        .currentColors
                        .purpleAccent
                        .withOpacity(0.5)),
                elevation: MaterialStateProperty.all(0),
                shape: MaterialStateProperty.all(RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16.0))),
              ),
              onPressed: () async {
                if (false == _createModel.isVerificationSuccess()) return;
                if (widget.isBackup) {
                  showAlertVerticalButtonDialog(
                      mainButtonPressed: () {
                        service.router.pop();
                        service.router.pop();
                        service.router.pop();
                        service.router.pop();
                        service.router.pop();
                      },
                      context: context,
                      showSubButton: false,
                      barrierColor: Colors.black.withOpacity(0.4),
                      mainButtonLabel: "Done",
                      title: "Backup Success",
                      content:
                      "Mnemonic words backup successfully.\nPlease keep your Slope Wallet safe.");
                } else {
                  if (_createModel.isFirstWallet) {
                    service.router.pushNamed(RouteName.walletPasswordPage,
                        arguments: widget.pageData.copyWith(
                            isSetupPassword: true,
                            wallet: _createModel.walletEntity));
                  } else {
                    bool success = await _createModel.saveWallet(context, widget.pageData);
                    if (success) {
                      service.router.pop();
                      service.router.pop();
                      service.router.pop();
                    }
                  }
                }
              },
            ),
          ),
        );
      },
    );
  }
}
//
// class _WebMnemonicVerificationPageState
//     extends State<MnemonicVerificationPage> {
//   bool _showError = false;
//   late WalletCreateModel _createModel;
//
//   @override
//   Widget build(BuildContext context) {
//     _createModel = WalletCreateModel();
//     String title = "";
//     if (widget.isBackup) {
//       title = "Slope Wallet";
//     } else {
//       title = config.app.appType != WalletAppType.slope
//           ? _createModel.isFirstWallet
//               ? "Slope Wallet"
//               : "Create New Wallet"
//           : "";
//     }
//     return Scaffold(
//       appBar: WalletBar.backWithTitle(title),
//       body: SafeArea(
//         child: Padding(
//           padding: EdgeInsets.symmetric(horizontal: 24),
//           child: Stack(
//             children: [
//               Positioned.fill(
//                   child: SingleChildScrollView(
//                 padding: EdgeInsets.only(
//                     bottom: MediaQueryData.fromWindow(window).padding.bottom +
//                         56 +
//                         21),
//                 child: Column(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     ..._buildTips(),
//                     ..._buildMnemonic(),
//                     const SizedBox(height: 8),
//                     ValueListenableBuilder<bool>(
//                       valueListenable: _verifyNotifier,
//                       builder: (c, success, _) => Visibility(
//                         visible: !success,
//                         child: Text(
//                             'Try again. Please enter the correct mnemonic word in order.',
//                             style: TextStyle(
//                               fontSize: 14,
//                               color:
//                                   AppTheme.of(context).currentColors.redAccent,
//                             )),
//                       ),
//                     ),
//                   ],
//                 ),
//               )),
//               _buildNext(),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
//
//   List<Widget> _buildTips() {
//     return [
//       Padding(
//         padding: EdgeInsets.only(top: 24, bottom: 16),
//         child: Text(
//           'Mnemonic Verification',
//           style: TextStyle(
//               color: AppTheme.of(context).currentColors.textColor1,
//               fontSize: 20,
//               fontWeight: FontWeight.bold),
//         ),
//       ),
//       Text(
//         'Please select the correct word in each position from the list below',
//         style: TextStyle(
//           color: AppTheme.of(context).currentColors.textColor1,
//           fontSize: 14,
//         ),
//         strutStyle: StrutStyle(fontSize: 22),
//       ),
//       AnimatedContainer(
//         decoration: BoxDecoration(
//           color: AppTheme.of(context).currentColors.redAccent.withOpacity(0.08),
//           borderRadius: BorderRadius.circular(16),
//         ),
//         height: _showError ? 40 : 0,
//         padding: EdgeInsets.symmetric(horizontal: 10),
//         margin: EdgeInsets.symmetric(vertical: 16),
//         duration: Duration(milliseconds: 200),
//         child: Row(
//           children: [
//             Container(
//               width: 20,
//               height: 20,
//               // padding: EdgeInsets.all(7.5),
//               child: service.svg.asset(
//                 Assets.assets_svg_wallet_red_warning_border_svg,
//               ),
//             ),
//             SizedBox(
//               width: 4,
//             ),
//             Text(
//               "Try again, Please choose in order.",
//               style: TextStyle(
//                 color: AppTheme.of(context).currentColors.redAccent,
//                 fontSize: 14,
//               ),
//             )
//           ],
//         ),
//       ),
//     ];
//   }
//
//   ValueNotifier<String> _inputNotifier = ValueNotifier('');
//   List<Widget> _buildMnemonic() {
//     return [
//       ValueListenableBuilder<bool>(
//           valueListenable: _verifyNotifier,
//           builder: (context, value, _) {
//             return Container(
//               // margin: EdgeInsets.only(bottom: 16),
//               alignment: Alignment.topCenter,
//               decoration: BoxDecoration(
//                   border: Border.all(
//                       color: value
//                           ? AppTheme.of(context).currentColors.dividerColor
//                           : AppTheme.of(context).currentColors.redAccent,
//                       width: 1),
//                   borderRadius: BorderRadius.circular(16)),
//               padding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
//               constraints: BoxConstraints(minHeight: 140, maxHeight: 140),
//               child: TextField(
//                 decoration: InputDecoration(
//                   border: InputBorder.none,
//                   contentPadding: EdgeInsets.zero,
//                   isDense: true,
//                 ),
//                 style: TextStyle(
//                   fontSize: 14,
//                   fontWeight: FontWeight.w500,
//                   height: 18 / 14,
//                   wordSpacing: 8,
//                 ),
//                 strutStyle: const StrutStyle(
//                   height: 18 / 14,
//                   leading: 12 / 18,
//                 ),
//                 maxLines: 100,
//                 onChanged: (txt) {
//                   _inputNotifier.value = txt;
//                   _verifyNotifier.value = true;
//                 },
//               ),
//             );
//           })
//     ];
//   }
//
//   ValueNotifier<bool> _verifyNotifier = ValueNotifier(true);
//
//   bool isVerificationSuccess() {
//     final inputList = getInputWords();
//     var createList = _createModel.mnemonicMap.entries
//         .map((e) => MapEntry(int.parse(e.key), e.value))
//         .sorted((a, b) => a.key.compareTo(b.key))
//         .map((e) => e.value)
//         .toList();
//     var verifySuccess = DeepCollectionEquality().equals(inputList, createList);
//     return verifySuccess;
//   }
//
//   List<String> getInputWords() {
//     var inputList = _inputNotifier.value.trim().split(RegExp(r'(\s)+'));
//     return inputList;
//   }
//
//   Widget _buildNext() {
//     return Positioned(
//       bottom: 16,
//       left: 0,
//       right: 0,
//       height: 56,
//       child: Builder(
//         builder: (context) {
//           String title = "";
//           if (widget.isBackup) {
//             title = "Done";
//           } else {
//             title = _createModel.isFirstWallet ? 'Next' : 'Done';
//           }
//           return Container(
//               width: double.infinity,
//               child: ValueListenableBuilder<String>(
//                   valueListenable: _inputNotifier,
//                   builder: (c, input, _) => TextButton(
//                         child: Text(
//                           title,
//                           style: TextStyle(
//                               fontSize: 18,
//                               fontWeight: FontWeight.w500,
//                               color: getInputWords().length >=
//                                       _createModel.randomMnemonics.length
//                                   ? Colors.white
//                                   : Colors.white.withOpacity(0.5)),
//                         ),
//                         style: ButtonStyle(
//                           backgroundColor: MaterialStateProperty.all(
//                               getInputWords().length >=
//                                       _createModel.randomMnemonics.length
//                                   ? AppTheme.of(context)
//                                       .currentColors
//                                       .purpleAccent
//                                   : AppTheme.of(context)
//                                       .currentColors
//                                       .purpleAccent
//                                       .withOpacity(0.5)),
//                           elevation: MaterialStateProperty.all(0),
//                           shape: MaterialStateProperty.all(
//                               RoundedRectangleBorder(
//                                   borderRadius: BorderRadius.circular(16.0))),
//                         ),
//                         onPressed: getInputWords().length <
//                                 _createModel.randomMnemonics.length
//                             ? null
//                             : () async {
//                                 _verifyNotifier.value = isVerificationSuccess();
//                                 if (!_verifyNotifier.value) {
//                                   return;
//                                 }
//                                 if (widget.isBackup) {
//                                   showAlertVerticalButtonDialog(
//                                       mainButtonPressed: () {
//                                         if (config.app.appType ==
//                                             WalletAppType.slope) {
//                                           service.router.pop();
//                                           service.router.pop();
//                                           service.router.pop();
//                                           service.router.pop();
//                                           service.router.pop();
//                                         } else {
//                                           service.router.popUntil(
//                                               ModalRoute.withName(
//                                                   RouteName.navigationPage));
//                                         }
//                                       },
//                                       context: context,
//                                       showSubButton: false,
//                                       barrierColor:
//                                           Colors.black.withOpacity(0.4),
//                                       mainButtonLabel: "Done",
//                                       title: "Backup Success",
//                                       content:
//                                           "Mnemonic words backup successfully.\nPlease keep your Slope Wallet safe.");
//                                 } else {
//                                   if (_createModel.isFirstWallet) {
//                                     service.router.pushNamed(
//                                         RouteName.walletPasswordPage,
//                                         arguments: 0);
//                                   } else {
//                                     bool success =
//                                         await _createModel.saveWallet(context, widget.pageData);
//                                     if (success) {
//                                       service.router.pop();
//                                       service.router.pop();
//                                       service.router.pop();
//                                       // if (_createModel.isFromDrawer) {
//                                       //   service.router.popUntil(
//                                       //       ModalRoute.withName(
//                                       //           RouteName.navigationPage));
//                                       //   drawerStateKey.currentState
//                                       //       ?.openDrawer();
//                                       // } else {
//                                       //   service.router.popUntil(
//                                       //       ModalRoute.withName(
//                                       //           RouteName.walletListPage));
//                                       // }
//                                     }
//                                   }
//                                 }
//                               },
//                       )));
//         },
//       ),
//     );
//   }
// }
