

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:wallet/common/service/wallet_service.dart';
import 'package:wallet/generated/assets.dart';
import 'package:wallet/theme/app_theme.dart';
import 'package:wallet/widgets/tools.dart';

class WalletListItem extends StatelessWidget {
  final String walletName;
  final String address;
  final String cardBg;
  final bool isEditing;
  final VoidCallback onTap;
  final VoidCallback onDelete;
  const WalletListItem(
      {Key? key,
      required this.walletName,
      required this.address,
      required this.cardBg,
      this.isEditing = false,
        required this.onTap,
        required this.onDelete,
      })
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
        if(isEditing) return;
        onTap();
      },
      child: SizedBox(
        height: 82,
        child: Row(
          children: [
            Expanded(
              child: Card(
                elevation: 0,
                margin: EdgeInsets.all(0),
                color: AppTheme.of(context).currentColors.greenAccent,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                child: Stack(
                  children: [
                    Positioned(
                        right: 0,
                        bottom: 0,
                        child: ClipRRect(
                          borderRadius: BorderRadius.only(bottomRight: Radius.circular(16)),
                          child: service.svg.asset(
                            cardBg,
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
                              Padding(
                                padding: EdgeInsets.only(right: isEditing ? 0 : 30),
                                child: isEditing? Text(
                                  walletName,
                                  style: TextStyle(
                                      color: AppTheme.of(context).currentColors.blackTextInGreenAccent,
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold),
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 1,
                                  textAlign: TextAlign.left,
                                ) : SingleChildScrollView(
                                  scrollDirection: Axis.horizontal,
                                  child: Text(
                                    walletName,
                                    style: TextStyle(
                                        color: AppTheme.of(context).currentColors.blackTextInGreenAccent,
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold),
                                    // overflow: TextOverflow.ellipsis,
                                    maxLines: 1,
                                    textAlign: TextAlign.left,
                                  ),
                                ),
                              ),

                              Text(address,
                                  style: TextStyle(
                                    color: AppTheme.of(context).currentColors.blackTextInGreenAccent,
                                    fontSize: 14,
                                  ),
                                  overflow: TextOverflow.clip,
                                  maxLines: 1,
                                  textAlign: TextAlign.left),
                            ],
                          ),
                    )),
                    isEditing
                        ? Positioned(child: Container())
                        : Positioned(
                            right: 17,
                            top: 24,
                            child: service.svg.asset(
                              Assets.assets_svg_wallet_three_dot_svg,
                              width: 16.5,
                              height: 3.5,
                            ))
                  ],
                ),
              ),
            ),
            isEditing ? _buildDelete(context) : SizedBox(),
          ],
        ),
      ),
    );
  }
  Widget _buildDelete(BuildContext context) {
    return InkWell(
      onTap: () => onDelete(),
      child: Container(
        width: 44,
        child: Row(
          children: [
            SizedBox(width: 20,),
            service.svg.asset(Assets.assets_svg_wallet_delete_svg, width: 24, height: 24,color: AppTheme.of(globalContext).currentColors.red
         ),
          ],
        ),
      ),
    );
  }
}
