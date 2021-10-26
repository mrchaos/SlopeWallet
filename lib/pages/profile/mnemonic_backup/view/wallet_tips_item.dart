


import 'package:flutter/material.dart';
import 'package:wallet/theme/app_theme.dart';

class WalletTipsItem extends StatelessWidget {
  final String tips;
  const WalletTipsItem({Key? key, required this.tips}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            children: [
              SizedBox(height: 10,),
              ClipOval(
                child: Container(
                  width: 8,
                  height: 8,
                  color: AppTheme.of(context).currentColors.green,
                ),
              ),
            ],
          ),
          SizedBox(width: 10,),
          Expanded(child: Text(tips, style: TextStyle(color: AppTheme.of(context).currentColors.textColor2, fontSize: 14, height: 1.3),
            strutStyle: StrutStyle(fontSize: 18),)),
        ],
      ),

    );
  }
}
