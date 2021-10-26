import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:wallet/common/service/router_service/router_table.dart';
import 'package:wallet/common/service/wallet_service.dart';
import 'package:wallet/pages/create_wallet/model/wallet_create_model.dart';
import 'package:wallet/pages/create_wallet/model/wallet_password_model.dart';
import 'package:wallet/theme/app_theme.dart';
import 'package:wallet/widgets/menu_tile.dart';

void showCreateWalletSheet(BuildContext context, String chain) {
  showModalBottomSheet(
      context: context,
      builder: (context) {
        return Container(
          padding: EdgeInsets.only(left: 20, right: 20, top: 20, bottom: 16 + MediaQuery.of(context).padding.bottom),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
                topRight: Radius.circular(16), topLeft: Radius.circular(16)),
            color: AppTheme.of(context).currentColors.backgroundColor,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                '$chain Network',
                style: TextStyle(
                    color: AppTheme.of(context).currentColors.textColor3,
                    fontSize: 14,
                    fontWeight: FontWeight.w500),
                strutStyle: StrutStyle(fontSize: 18),
              ),
              SizedBox(height: 16),
              Card(
                elevation: 0,
                margin: EdgeInsets.symmetric(horizontal: 0),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                  side:
                      BorderSide(color: AppTheme.of(context).currentColors.dividerColor, width: 1),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    MenuTile(
                      height: 56,
                      title: Text(
                        'Create New Wallet',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: AppTheme.of(context).currentColors.textColor1,
                            fontSize: 16,
                            fontWeight: FontWeight.w500),
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                        WalletCreateModel().createWallet(WalletCreateRelatedData());
                      },
                    ),
                    Divider(
                      height: 1,
                      color: AppTheme.of(context).currentColors.dividerColor,
                    ),
                    MenuTile(
                      height: 56,
                      title: Text(
                        'Import Wallet',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: AppTheme.of(context).currentColors.textColor1,
                            fontSize: 16,
                            fontWeight: FontWeight.w500),
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                        service.router.pushNamed(RouteName.importSlopeWallet, arguments: WalletCreateRelatedData());
                      },
                    )
                  ],
                ),
              ),
              SizedBox(height: 16),
              Container(
                height: 48,
                width: double.infinity,
                child: TextButton(
                  child: Text(
                    'Cancel',
                    style: TextStyle(
                        fontSize: 16, color: AppTheme.of(context).currentColors.textColor3),
                  ),
                  style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all(AppTheme.of(context).currentColors.dividerColor),
                    elevation: MaterialStateProperty.all(0),
                    shape: MaterialStateProperty.all(
                        RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0))),
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
              ),
            ],
          ),
        );
      });
}
