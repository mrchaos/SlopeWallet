import 'dart:math';

import 'package:collection/collection.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import 'package:solana/src/base58/base58.dart' as base58;
import 'package:wallet/common/service/router_service/router_table.dart';
import 'package:wallet/common/service/wallet_service.dart';
import 'package:wallet/common/util/number_precision/number_precision.dart';
import 'package:wallet/common/util/string/string_util.dart';
import 'package:wallet/generated/assets.dart';
import 'package:wallet/pages/home/model/wallet_main_model.dart';
import 'package:wallet/pages/home/view/wallet_bottom_sheet.dart';
import 'package:wallet/theme/app_theme.dart';
import 'package:wallet/wallet_manager/data/wallet_entity.dart';
import 'package:wallet/wallet_manager/service/wallet_manager.dart';
import 'package:wallet/wallet_manager/wallet_encrypt.dart';
import 'package:wallet/widgets/Dialog/public_dialog.dart';
import 'package:wallet/widgets/alert_dialog.dart';
import 'package:wallet/widgets/app_bar/wallet_bar.dart';
import 'package:wallet/widgets/coin_image.dart';
import 'package:wallet/widgets/currency_format.dart';
import 'package:wallet/widgets/loading/loading_util.dart';

bool isPublicKey(String pubKey) {
  bool isBase58 = false;
  try {
    //base58
    final list = base58.decode(pubKey);
    isBase58 = list.length == 32;
  } catch (e) {
    isBase58 = false;
  }
  return isBase58;
}

class WalletPayPage extends StatefulWidget {
  final String url;
  final CoinEntity? coinEntity;

  const WalletPayPage({Key? key, this.url = '', this.coinEntity})
      : super(key: key);

  @override
  _WalletPayPageState createState() => _WalletPayPageState();
}

class _WalletPayPageState extends State<WalletPayPage> {
  WalletMainModel _model = WalletMainModel();

  //
  final int _numDigits = 0;

  //
  late CoinEntity _curCoinEntity;

  //
  CoinEntity _callbackEntity = CoinEntity();

  final TextEditingController _toAdrCtrl = TextEditingController();
  final ValueNotifier _inputNotifier = ValueNotifier(false);

  final TextEditingController _amountCtrl = TextEditingController();

  @override
  void initState() {
    super.initState();
    if (null != widget.coinEntity) {
      _curCoinEntity = widget.coinEntity!;
      _balance = widget.coinEntity!.counts.toDouble();
    }

    if (!isStrNullOrEmpty(widget.url)) {
      _toAdrCtrl.text = widget.url;
    }
  }

  double _balance = 0.0;

  void _getAddressBalance() async {
    _balance = await _model.getAddressBalanceFuture(_curCoinEntity);
    if (mounted) setState(() {});
  }

  // SOL
  _transferSol(String fromAddress, String toAddress, String tranAmount,
      String coin, String decryptPrivateKey, int iLamports) {
    ///_transfer Sol
  }

  //
  _transferToken(
      String privateKey,
      String toAddress,
      String tranAmount,
      int decimals,
      String coin,
      String fromSplAddress,
      String toContractAddress) {
    // ，
    //do transfer token
  }

  //
  bool _checkTransferParas(String toAddress, String tranAmount) {
    if (toAddress.isEmpty || !isPublicKey(toAddress)) {
      showToast('Please enter the correct address.');
      return false;
    }

    if (0 == tranAmount.length) {
      showToast('Enter the correct amount!');
      return false;
    }

    int maxLength = tranAmount.contains('.') ? 11 : 10;
    if (maxLength < tranAmount.length) {
      showToast('The number cannot exceed 10 digits!');
      return false;
    }
    return true;
  }

  bool _showing = false;

  Widget bodyUI(BuildContext context) {
    return Builder(
      builder: (context) {
        return Selector<WalletMainModel, CoinEntity?>(
          selector: (c, vm) {
            WalletEntity? _walletModel = vm.currentWallet;
            if (null != _walletModel) {
              // ，
              if (0 != _callbackEntity.coin.length) {
                _curCoinEntity = _callbackEntity;
              } else {
                if (null == widget.coinEntity) {
                  _curCoinEntity = _walletModel.coins.first;
                  _balance = _curCoinEntity.counts.toDouble();
                }
              }
            }

            return _curCoinEntity;
          },
          shouldRebuild: (p, n) {
            var rebuild = p?.splAddress != n?.splAddress;
            if (rebuild) {
              _getAddressBalance();
            }
            return rebuild;
          },
          builder: (context, coinEntity, child) {
            WalletEntity? _walletModel =
                context.read<WalletMainModel>().currentWallet;

            if (null == _walletModel) return const SizedBox();

            String _sBalance = CurrencyFormat.formatBalance(_balance);
            return SafeArea(
              child: Column(
                children: [
                  Expanded(
                    child: SingleChildScrollView(
                      child: Padding(
                        padding: EdgeInsets.only(top: 8, left: 24, right: 24),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            GestureDetector(
                              behavior: HitTestBehavior.opaque,
                              onTap: () {
                                service.router
                                    .pushNamed(RouteName.selectCoinPage,
                                        arguments: (CoinEntity entity) {
                                  if (entity.coin.toLowerCase() !=
                                      _curCoinEntity.coin.toLowerCase()) {
                                    _toAdrCtrl.text = "";
                                    _amountCtrl.text = "";
                                  }
                                  _callbackEntity = entity;

                                  for (var spl in _walletModel.coins) {
                                    if (spl.splAddress ==
                                        _callbackEntity.splAddress) {
                                      _balance = spl.counts.toDouble();
                                      break;
                                    }
                                  }

                                  setState(() {});
                                });
                              },
                              child: Container(
                                height: 68,
                                child: Row(
                                  children: [
                                    CoinImage(
                                        icon: _curCoinEntity.icon, radius: 18),
                                    const SizedBox(width: 12),
                                    Text(
                                      _curCoinEntity.coin,
                                      style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.w700,
                                          color: AppTheme.of(context)
                                              .currentColors
                                              .textColor1),
                                    ),
                                    SizedBox(width: 4),
                                    service.svg.asset(
                                      Assets.assets_svg_right_arrow_svg,
                                      fit: BoxFit.scaleDown,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Divider(
                                height: 1,
                                thickness: 1,
                                indent: 0,
                                endIndent: 0,
                                color: AppTheme.of(context)
                                    .currentColors
                                    .dividerColor),
                            const SizedBox(
                              height: 32,
                            ),
                            Text(
                              'To',
                              style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w400,
                                  color: AppTheme.of(context)
                                      .currentColors
                                      .textColor1),
                            ),
                            const SizedBox(
                              height: 12,
                            ),
                            Container(
                              decoration: BoxDecoration(
                                border: Border.all(
                                    color: AppTheme.of(context)
                                        .currentColors
                                        .dividerColor,
                                    width: 1),
                                borderRadius: BorderRadius.circular(16),
                              ),
                              alignment: Alignment.center,
                              height: 46,
                              child: TextField(
                                controller: _toAdrCtrl,
                                // focusNode: _focusAddress,
                                autocorrect: false,
                                enableSuggestions: false,
                                cursorColor: Color(0xFF6E66FA),
                                onChanged: (value) {
                                  _inputNotifier.value = !_inputNotifier.value;
                                },
                                maxLines: 1,
                                keyboardType: TextInputType.text,
                                inputFormatters: [
                                  FilteringTextInputFormatter.allow(
                                      RegExp(r"[a-zA-Z0-9]"))
                                ],
                                style: TextStyle(
                                    fontSize: 14,
                                    color: AppTheme.of(context)
                                        .currentColors
                                        .textColor1),
                                decoration: InputDecoration(
                                  hintText: '${_curCoinEntity.coin} Address',
                                  hintStyle: TextStyle(
                                    fontSize: 14,
                                    height: 1,
                                    color: AppTheme.of(context)
                                        .currentColors
                                        .textColor3,
                                  ),
                                  contentPadding: EdgeInsets.only(
                                    left: 16,
                                    right: 16,
                                  ),
                                  isDense: kIsWeb,
                                  border: InputBorder.none,
                                  suffixIconConstraints: BoxConstraints(
                                    maxWidth: kIsWeb ? 0 : 40,
                                  ),
                                  // isDense: true,
                                  suffixIcon: Visibility(
                                    visible: !kIsWeb,
                                    child: GestureDetector(
                                      behavior: HitTestBehavior.opaque,
                                      onTap: () {
                                        checkPhotoPermission(
                                            context: context,
                                            source: ImageSource.camera,
                                            onGranted: () {
                                              //
                                              service.router
                                                  .pushNamed(
                                                      RouteName.walletScanPage)
                                                  .then((value) {
                                                setState(() {
                                                  _toAdrCtrl.text =
                                                      value?.toString() ?? '';
                                                });
                                              });
                                            });
                                      },
                                      child: Container(
                                        width: 24,
                                        margin:
                                            const EdgeInsets.only(right: 16),
                                        child: service.svg.asset(
                                            Assets
                                                .assets_svg_icon_wallet_scan_svg,
                                            fit: BoxFit.scaleDown,
                                            color: AppTheme.of(context)
                                                .currentColors
                                                .textColor1),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 32,
                            ),
                            Text(
                              'Amount',
                              style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w400,
                                  color: AppTheme.of(context)
                                      .currentColors
                                      .textColor1),
                            ),
                            const SizedBox(
                              height: 12,
                            ),
                            Container(
                              decoration: BoxDecoration(
                                border: Border.all(
                                    color: AppTheme.of(context)
                                        .currentColors
                                        .dividerColor,
                                    width: 1),
                                borderRadius: BorderRadius.circular(16),
                              ),
                              height: 46,
                              child: TextField(
                                controller: _amountCtrl,
                                autocorrect: false,
                                enableSuggestions: false,
                                cursorColor: Color(0xFF6E66FA),
                                onChanged: (value) {
                                  _inputNotifier.value = !_inputNotifier.value;
                                },
                                keyboardType: TextInputType.numberWithOptions(
                                    decimal: true),
                                inputFormatters: [
                                  if (0 == _numDigits)
                                    FilteringTextInputFormatter.allow(
                                        RegExp(r'[0-9.]')),
                                  if (_numDigits > 0)
                                    //
                                    FilteringTextInputFormatter.allow(
                                        RegExp(r'[0-9]')),
                                ],
                                maxLines: 1,
                                style: TextStyle(
                                    fontSize: 14,
                                    color: AppTheme.of(context)
                                        .currentColors
                                        .textColor1),
                                decoration: InputDecoration(
                                  hintText: 'Amount',
                                  hintStyle: TextStyle(
                                    fontSize: 14,
                                    color: AppTheme.of(context)
                                        .currentColors
                                        .textColor3,
                                  ),
                                  contentPadding: EdgeInsets.only(
                                      left: 16, right: 16, top: 12),
                                  border: InputBorder.none,
                                  suffixIcon: GestureDetector(
                                    behavior: HitTestBehavior.opaque,
                                    onTap: () {
                                      double fee = 0;
                                      if (_curCoinEntity.isSOL) {
                                        fee = 0.000005;
                                      }
                                      num result = NP.minus(_balance, fee);
                                      if (0 > result) {
                                        showToast('Inefficient balance');
                                        return;
                                      }
                                      _amountCtrl.text =
                                          CurrencyFormat.formatBalance(result);
                                      _inputNotifier.value =
                                          !_inputNotifier.value;
                                      Future.delayed(Duration(milliseconds: 10),
                                          () {
                                        _amountCtrl.selection =
                                            TextSelection.fromPosition(
                                                TextPosition(
                                                    offset: _amountCtrl
                                                        .text.length));
                                      });
                                    },
                                    child: Container(
                                      width: 24,
                                      height: 24,
                                      child: Center(
                                        child: Text(
                                          'All',
                                          style: TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w500,
                                              color: AppTheme.of(context)
                                                  .currentColors
                                                  .textColor1),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 12,
                            ),
                            Text(
                              'Current Available: $_sBalance ${_curCoinEntity.coin}',
                              style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w400,
                                  color: AppTheme.of(context)
                                      .currentColors
                                      .textColor3),
                            ),
                            const SizedBox(
                              height: 4,
                            ),
                            Text(
                              'Miner Fee: 0.000005 SOL',
                              style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w400,
                                  color: AppTheme.of(context)
                                      .currentColors
                                      .textColor3),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      _buildText,
                      Container(
                        margin:
                            EdgeInsets.symmetric(vertical: 16, horizontal: 24),
                        child: ValueListenableBuilder(
                            valueListenable: _inputNotifier,
                            builder: (context, value, child) {
                              String address = _toAdrCtrl.text;
                              String amount = _amountCtrl.text;
                              bool enable = ((0 != address.length) &&
                                  (0 != amount.length));
                              return TextButton(
                                child: Text(
                                  'Send',
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w500,
                                    color: enable
                                        ? Colors.white
                                        : Colors.white.withOpacity(0.5),
                                  ),
                                ),
                                style: ButtonStyle(
                                  backgroundColor: enable
                                      ? MaterialStateProperty.all(
                                          AppTheme.of(context)
                                              .currentColors
                                              .purpleAccent)
                                      : MaterialStateProperty.all(
                                          AppTheme.of(context)
                                              .currentColors
                                              .purpleAccent
                                              .withOpacity(0.5)),
                                  padding: MaterialStateProperty.all(
                                      EdgeInsets.only(top: 20, bottom: 20)),
                                  elevation: MaterialStateProperty.all(0),
                                  shape: MaterialStateProperty.all(
                                      RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(16.0))),
                                ),
                                onPressed: !enable
                                    ? null
                                    : () async {
                                        if (false ==
                                            _checkTransferParas(_toAdrCtrl.text,
                                                _amountCtrl.text)) return;

                                        bool isEnough = _checkBalance();
                                        if (!isEnough) {
                                          _showTransactionFail();
                                          return;
                                        }

                                        // 1，5000(Lamport)，，
                                        num nLamports =
                                            num.parse(_amountCtrl.text);
                                        if (nLamports > _balance) {
                                          showToast('Insufficient balance！');
                                          return;
                                        }

                                        SharePayConfirmModal.showView(
                                            context: context,
                                            coinName: _curCoinEntity.coin,
                                            payAmount: _amountCtrl.text,
                                            feeAmount: '0.000005',
                                            address:
                                                _toAdrCtrl.text.ellAddress(),
                                            confirmCallback: () {
                                              if (_curCoinEntity.isSOL) {
                                                // ，
                                                num banlanLamports =
                                                    nLamports * 1000000000;
                                                int iLamports =
                                                    banlanLamports.toInt();

                                                // SOL
                                                _transferSol(
                                                    _walletModel.address,
                                                    _toAdrCtrl.text,
                                                    _amountCtrl.text,
                                                    _curCoinEntity.coin,
                                                    _walletModel
                                                        .decryptPrivateKey(),
                                                    iLamports);
                                              } else {
                                                if (null ==
                                                    WalletMainModel.instance
                                                        .currentWallet) return;
                                                WalletEntity walletEntity =
                                                    WalletMainModel.instance
                                                        .currentWallet!;
                                                final String prKey =
                                                    WalletEncrypt.aesDecrypt(
                                                        walletEntity.privateKey,
                                                        walletManager.aesKey);

                                                _transferToken(
                                                    prKey,
                                                    _toAdrCtrl.text,
                                                    _amountCtrl.text,
                                                    _curCoinEntity.decimals,
                                                    _curCoinEntity.coin,
                                                    _curCoinEntity.splAddress,
                                                    _curCoinEntity
                                                        .contractAddress);
                                              }
                                            });
                                      },
                              );
                            }),
                      ),
                    ],
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  Widget get _buildText => Visibility(
        ///
        visible: !(MediaQuery.of(context).viewInsets.bottom > 0),
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 24, vertical: 8),
          alignment: Alignment.bottomCenter,
          child: Text(
            '*Please check the ${_curCoinEntity.coin} address when you made the transaction. Once the transaction has been made, you asset cannot be recovered.',
            style: TextStyle(
                fontSize: 12,
                height: 16 / 12,
                fontWeight: FontWeight.w400,
                color: AppTheme.of(context).currentColors.redAccent),
          ),
        ),
      );

  bool _checkBalance() {
    double sendAmount = (num.tryParse(_amountCtrl.text) ?? 0.0).toDouble();
    if (sendAmount > _balance) return false;
    if (null == WalletMainModel.instance.currentWallet) return false;
    WalletEntity currentWallet = WalletMainModel.instance.currentWallet!;
    CoinEntity? solCoin = currentWallet.coins.firstWhereOrNull(
        (element) => element.coin.toLowerCase() == Coins.sol.toLowerCase());
    if (null == solCoin) return false;
    if (_curCoinEntity.coin.toLowerCase() == Coins.sol.toLowerCase()) {
      return solCoin.counts.toDouble() >= (sendAmount + 0.000005);
    }
    return solCoin.counts.toDouble() >= 0.000005;
  }

  void _showTransactionFail() {
    showAlertVerticalButtonDialog(
        context: context,
        title: 'Transaction Fail',
        content:
            'You need import or receive more\nToken to do the transaction.',
        showMainButton: true,
        showSubButton: false,
        mainButtonLabel: 'Done',
        barrierDismissible: false,
        mainButtonPressed: () {
          Navigator.pop(context);
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: WalletBar.backWithTitle('Pay Out'),
      body: bodyUI(context),
    );
  }
}

void checkPhotoPermission({
  BuildContext? context,
  ImageSource? source,
  VoidCallback? onGranted,
}) async {
  PermissionStatus status;
  Permission permission;
  if (source == ImageSource.camera) {
    //
    permission = Permission.camera;
  } else {
    //
    permission = Permission.photos;
  }

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
    _showPhotoPermissionDialog(context!, source);
    return;
  }

  if (status.isRestricted || status.isDenied || status.isLimited) {
    // iOS:
    _showPhotoPermissionDialog(context!, source);

    return;
  }
  if (await permission.shouldShowRequestRationale) {
    // Android:
    _showPhotoPermissionDialog(context!, source);

    return;
  }
  //
  var result = await permission.request();
  if (result.isGranted) {
    //
    // getImage(context, source);
    onGranted?.call();
  }
}

_showPhotoPermissionDialog(BuildContext context, ImageSource? source) {
  var title =
      'Allow access your album in ”Settings”->”Privacy”->”${source == ImageSource.camera ? 'Camera' : 'Photos'}”';
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
