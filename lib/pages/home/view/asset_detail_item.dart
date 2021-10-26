import 'package:flutter/material.dart';
import 'package:wallet/theme/app_theme.dart';
import 'package:wallet/widgets/coin_image.dart';

class AssetDetailItem extends StatelessWidget {
  final String icon;
  final String name;
  final String balance;
  final String usdtBalance;
  final VoidCallback onTap;
  final bool isLast;

  const AssetDetailItem({
    Key? key,
    required this.icon,
    required this.name,
    required this.balance,
    required this.usdtBalance,
    required this.onTap,
    this.isLast = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final appColors = context.appColors;
    return InkWell(
      highlightColor: Colors.transparent, // 
      splashColor: Colors.transparent,
      onTap: onTap,
      child: Container(
        height: 80,
        padding: const EdgeInsets.symmetric(vertical: 18),
        decoration: isLast
            ? null
            : BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    width: 1,
                    color: appColors.dividerColor,
                  ),
                ),
              ),
        child: Row(
          children: [
            CoinImage(icon: icon, radius: 16),
            const SizedBox(width: 12),
            Text(
              name,
              style: TextStyle(
                color: appColors.textColor1,
                fontSize: 16,
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Text(
                      balance,
                      style: TextStyle(
                        color: appColors.textColor1,
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    '≈$usdtBalance USDT',
                    style: TextStyle(
                      color: appColors.textColor3,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
