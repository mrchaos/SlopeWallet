import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wallet/pages/home/model/wallet_main_model.dart';
import 'package:wallet/theme/app_colors.dart';
import 'package:wallet/theme/app_theme.dart';
import 'package:wallet/wallet_manager/data/wallet_entity.dart';
import 'package:wallet/widgets/app_bar/wallet_bar.dart';
import 'package:wallet/widgets/button/app_back_button.dart';
import 'package:wallet/widgets/coin_image.dart';

class SelectCoinPage extends StatefulWidget {
  final Function(CoinEntity entity) selectCallback;

  const SelectCoinPage({Key? key, required this.selectCallback})
      : super(key: key);

  @override
  _SelectCoinPageState createState() => _SelectCoinPageState();
}

late AppColors _appColors;

class _SelectCoinPageState extends State<SelectCoinPage> {
  @override
  void initState() {
    _getContractList();
    super.initState();
  }

  List<CoinEntity> contractList = [];

  void _getContractList() async {
    var result = [
      ...?WalletMainModel.instance.currentWallet?.coins,
    ].where((c) => !c.hide);
    setState(() {
      contractList.addAll(result);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Builder(builder: (context) {
      _appColors = context.read<AppTheme>().currentColors;
      return Scaffold(
        appBar: WalletBar(
          showBackButton: true,
          leading: AppBackButton(),
          title: Text(
            "Select Token",
            style: TextStyle(
                color: _appColors.textColor1,
                fontWeight: FontWeight.bold,
                fontSize: 24),
          ),
        ),
        body: ListView.builder(
          itemBuilder: (context, index) {
            return GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTap: () {
                CoinEntity model = contractList[index];
                widget.selectCallback(model);
                Navigator.of(context).maybePop();
              },
              child: Padding(
                padding: EdgeInsets.only(left: 24, top: 12, bottom: 12),
                child: Row(
                  children: [
                    CoinImage(icon: contractList[index].icon, radius: 16),
                    const SizedBox(
                      width: 12,
                    ),
                    Text(
                      contractList[index].coin,
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: _appColors.textColor1),
                    )
                  ],
                ),
              ),
            );
          },
          itemCount: contractList.length,
        ),
      );
    });
  }
}
