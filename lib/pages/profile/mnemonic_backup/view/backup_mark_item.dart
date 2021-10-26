

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:wallet/common/service/wallet_service.dart';
import 'package:wallet/theme/app_theme.dart';

class BackupMarkItem extends StatelessWidget {
  final String svg;
  final String mark;

  const BackupMarkItem({Key? key, required this.svg, required this.mark})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 5),
      decoration: BoxDecoration(
        border: Border.all(color: AppTheme.of(context).currentColors.dividerColor, width: 1),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          Container(
            width: 20,
            height: 20,
            child: service.svg.asset(svg),
          ),
          SizedBox(
            width: 10,
          ),
          Expanded(
              child: Text(
                mark,
                style: TextStyle(
                  color: AppTheme.of(context).currentColors.textColor2,
                  fontSize: 10,
                  height: 14/10,
                ),
                // strutStyle: StrutStyle(fontSize: 14),
              )),
        ],
      ),
    );
  }
}
