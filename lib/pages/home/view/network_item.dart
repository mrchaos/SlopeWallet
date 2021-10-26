import 'package:flutter/material.dart';
import 'package:wallet/common/service/wallet_service.dart';
import 'package:wallet/generated/assets.dart';
import 'package:wallet/theme/app_theme.dart';

class NetworkItem extends StatelessWidget {
  final String svg;
  final String name;
  final bool isSelected;
  final bool showSeparator;
  final VoidCallback onTap;

  const NetworkItem({
    Key? key,
    required this.svg,
    required this.name,
    this.isSelected = true,
    this.showSeparator = false,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var trailing = isSelected
        ? service.svg.asset(
            Assets.assets_svg_wallet_icon_selected_svg,
            width: 24,
            height: 24,
          )
        : SizedBox(
            width: 24,
            height: 24,
          );
    return InkWell(
      onTap: () => onTap(),
      child: Column(
        children: [
          Container(
            height: 64,
            child: Row(
              children: [
                service.svg.asset(
                  svg,
                  width: 32,
                  height: 32,
                ),
                SizedBox(
                  width: 12,
                ),
                Text(
                  name,
                  style: TextStyle(
                      color: AppTheme.of(context).currentColors.textColor1,
                      fontSize: 20),
                  strutStyle: StrutStyle(fontSize: 24),
                ),
                Spacer(),
                trailing,
              ],
            ),
          ),
          showSeparator
              ? Divider(
                  height: 1,
                  color: Color(0xFFF3F5F5),
                )
              : SizedBox(
                  height: 1,
                ),
        ],
      ),
    );
  }
}
