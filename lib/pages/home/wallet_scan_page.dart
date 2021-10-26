import 'package:flutter/material.dart';
import 'package:scan/scan.dart';
import 'package:wallet/common/service/wallet_service.dart';
import 'package:wallet/generated/assets.dart';
import 'package:wallet/theme/app_theme.dart';

class WalletScanPage extends StatefulWidget {
  const WalletScanPage({Key? key}) : super(key: key);

  @override
  _WalletScanPageState createState() => _WalletScanPageState();
}

class _WalletScanPageState extends State<WalletScanPage> {
  final controller = ScanController();

  @override
  Widget build(BuildContext context) {
    double _padding = MediaQuery.of(context).padding.top;
    return Container(
      width: MediaQuery.of(context).size.width, // custom wrap size
      height: MediaQuery.of(context).size.height,
      child: Stack(
        children: [
          ScanView(
            controller: controller,
            scanAreaScale: .7,
            scanLineColor: AppTheme.of(context).currentColors.purpleAccent,
            onCapture: (data) {
              controller.pause();
              service.router.pop(data);
            },
          ),
          Align(
            alignment: Alignment.topLeft,
            child: GestureDetector(
              onTap: () {
                controller.pause();
                Navigator.maybePop(context);
              },
              child: Container(
                height: 48,
                margin: EdgeInsets.only(left: 24, top: _padding),
                child: service.svg.asset(
                  Assets.assets_svg_ic_back_svg,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
