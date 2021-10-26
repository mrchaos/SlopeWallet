import 'package:flutter/material.dart';
import 'package:wallet/common/service/wallet_service.dart';
import 'package:wallet/common/util/string/string_util.dart';
import 'package:wallet/theme/app_colors.dart';
import 'package:wallet/theme/app_theme.dart';

class MenuListItem extends StatefulWidget {
  final String walletName;
  final String address;
  final String cardBg;
  final VoidCallback onTap;

  const MenuListItem(
      {Key? key,
      required this.walletName,
      required this.address,
      required this.cardBg,
      required this.onTap})
      : super(key: key);

  @override
  _MenuListItemState createState() => _MenuListItemState();
}

class _MenuListItemState extends State<MenuListItem> {
  @override
  Widget build(BuildContext context) {
    AppColors appColors = AppTheme.of(context).currentColors;
    return InkWell(
      onTap: () => widget.onTap(),
      child: Container(
        height: 82,
        decoration: BoxDecoration(
          color: appColors.greenAccent,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Stack(
          children: [
            Positioned(
                right: 0,
                bottom: 0,
                child: ClipRRect(
                  borderRadius:
                      BorderRadius.only(bottomRight: Radius.circular(16)),
                  child: service.svg.asset(
                    widget.cardBg,
                    width: 54,
                    height: 43,
                  ),
                )),
            Positioned.fill(
                child: Padding(
              padding: EdgeInsets.all(16),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.walletName.notBreak,
                    style: TextStyle(
                        color: appColors.blackTextInGreenAccent,
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                    textAlign: TextAlign.left,
                  ),
                  Text(widget.address,
                      style: TextStyle(
                        color: appColors.blackTextInGreenAccent,
                        fontSize: 14,
                      ),
                      overflow: TextOverflow.clip,
                      maxLines: 1,
                      textAlign: TextAlign.left),
                ],
              ),
            ))
          ],
        ),
      ),
    );
  }
}
