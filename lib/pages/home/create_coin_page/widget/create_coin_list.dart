import 'package:collection/collection.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:slope_solana_client/slope_solana_client.dart';
import 'package:wallet/common/service/wallet_service.dart';
import 'package:wallet/generated/assets.dart';
import 'package:wallet/pages/home/model/wallet_main_model.dart';
import 'package:wallet/theme/app_colors.dart';
import 'package:wallet/theme/app_theme.dart';
import 'package:wallet/wallet_manager/data/wallet_entity.dart';
import 'package:wallet/wallet_manager/service/wallet_manager.dart';
import 'package:wallet/wallet_manager/wallet_encrypt.dart';
import 'package:wallet/widgets/coin_image.dart';
import 'package:wallet/widgets/placeholder/no_data_place_holder.dart';
import 'package:wd_common_package/wd_common_package.dart';

class CreateCoinWidget extends StatefulWidget {
  final List<CoinEntity> contractList;
  final String searchKey;
  final int type;

  /// 0:  1:
  const CreateCoinWidget(
      {Key? key,
      required this.contractList,
      required this.searchKey,
      required this.type})
      : super(key: key);

  @override
  _CreateCoinWidgetState createState() => _CreateCoinWidgetState();
}

class _CreateCoinWidgetState extends State<CreateCoinWidget> {
  AppColors get _appColors => AppTheme.of(context).currentColors;

  late List<CoinEntity> _arrList;

  // token
  Future<String> requestToken(CoinEntity model, bool isCreated) async {
    if (null == WalletMainModel.instance.currentWallet) return "";
    WalletEntity _walletModel = WalletMainModel.instance.currentWallet!;
    String privateKey =
        WalletEncrypt.aesDecrypt(_walletModel.privateKey, walletManager.aesKey);
    // model.contractAddress = 'Df44Qh5TPMLuW527dMtxPb9Ho4kgWxP4mKNGSm21AoDj';
    var temp = await walletManager.createToken(
        privateKey, model.contractAddress, _walletModel.address);
    return temp;
  }

  @override
  Widget build(BuildContext context) {
    List<CoinEntity> _contractList = widget.contractList;
    logger.d('_contractList.first.decimals:${_contractList}');
    var _contractList2222 = _contractList.firstWhereOrNull((element) =>
        element.contractAddress ==
        '7RizW7KJWR7zi13CwMSuTKkvVDLoS9EJyyUshokHJ9tL');
    logger.d('_contractList2222:${_contractList2222}');
    String _searchKey = widget.searchKey;
    List<CoinEntity> list = WalletMainModel.instance.currentWallet?.coins ?? [];
    // if () {
    //
    // }
    for (int i = 0; i < _contractList.length; i++) {
      CoinEntity model = _contractList[i];
      model.isSelected = false;
      for (int j = 0; j < list.length; j++) {
        CoinEntity entity = list[j];
        // SOL，
        if (model.contractAddress == entity.contractAddress) {
          model.isSelected = entity.hide == false;
        }
      }
    }

    ///
    if (0 == _searchKey.length) {
      _arrList = _contractList.toList();
    } else {
      _arrList = [];
      _contractList.forEach((e) {
        if (e.coin.toLowerCase().contains(_searchKey.toLowerCase()))
          _arrList.add(e);
      });
    }

    return _arrList.isNotEmpty
        ? ListView.separated(
            separatorBuilder: (context, index) => const SizedBox(height: 1),
            itemCount: _contractList.isNotEmpty ? _arrList.length : 0,
            itemBuilder: (BuildContext context1, int index1) {
              CoinEntity model;
              if (_contractList.isNotEmpty) {
                model = _arrList[index1];
              } else {
                model = CoinEntity();
              }

              Widget sliver = Container(
                margin: const EdgeInsets.only(
                    left: 24, right: 24, bottom: 12, top: 12),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    CoinImage(icon: model.icon, radius: 16),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        model.coin,
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: _appColors.textColor1,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    StatefulBuilder(builder: (context, refresh) {
                      return GestureDetector(
                        behavior: HitTestBehavior.opaque,
                        onTap: () async {
                          // add token
                        },
                        child: model.isSelected
                            ? service.svg.asset(
                                Assets.assets_svg_ic_checkbox_unselect_svg,
                                fit: BoxFit.scaleDown,
                                color: AppTheme.of(context)
                                    .currentColors
                                    .textColor5)
                            : service.svg.asset(
                                Assets.assets_svg_ic_checkbox_selected_svg,
                                fit: BoxFit.scaleDown,
                                color: AppTheme.of(context)
                                    .currentColors
                                    .textColor1),
                      );
                    }),
                  ],
                ),
              );
              return sliver;
            })
        : NoDataPlaceHolder(
            alignment: Alignment.topCenter,
          );
  }
}
