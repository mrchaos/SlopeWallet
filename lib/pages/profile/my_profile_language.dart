import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:path_provider/path_provider.dart';
import 'package:wallet/common/service/wallet_service.dart';
import 'package:wallet/generated/assets.dart';
import 'package:wallet/theme/app_theme.dart';
import 'package:wallet/widgets/app_bar/wallet_bar.dart';
import 'package:wallet/widgets/menu_tile.dart';
import 'package:wallet/pages/profile/readTxt.dart';

class MyProfileLanguagePage extends StatefulWidget {
  @override
  _MyProfileLanguagePageState createState() => _MyProfileLanguagePageState();
}

class _MyProfileLanguagePageState extends State<MyProfileLanguagePage> {
  creatFile() async {
    // var file = await File('assets/english.txt').create(recursive: false);
    var data = await PlatformAssetBundle().load('assets/englist.txt');
    print(data);
  }

  @override
  initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: WalletBar(
        title: Text('Language'),
        showBackButton: true,
      ),
      body: Container(
        margin: EdgeInsets.only(top: 16, left: 25, right: 24),
        // height: auto,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              width: 1,
              color: Color(0xffF3F3F5),
            )),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            MenuTile(
                height: 56,
                borderRadius: BorderRadius.circular(8),
                title: Text(
                  'English',
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                      color: AppTheme.of(context).currentColors.textColor1),
                ),
                onPressed: () {},
                trailing: Row(
                  children: [
                    service.svg.asset(
                      Assets.assets_svg_ic_menu_trailing_svg,
                      fit: BoxFit.scaleDown,
                    ),
                  ],
                )),
            Divider(
                height: 1,
                thickness: 1,
                indent: 0,
                endIndent: 0,
                color: AppTheme.of(context).currentColors.dividerColor),
            MenuTile(
                height: 56,
                borderRadius: BorderRadius.circular(8),
                title: Text(
                  '',
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                      color: AppTheme.of(context).currentColors.textColor1),
                ),
                onPressed: () {},
                trailing: Row(
                  children: [
                    service.svg.asset(
                      Assets.assets_svg_ic_menu_trailing_svg,
                      fit: BoxFit.scaleDown,
                    ),
                  ],
                )),
            Divider(
                height: 1,
                thickness: 1,
                indent: 0,
                endIndent: 0,
                color: AppTheme.of(context).currentColors.dividerColor),
            MenuTile(
                height: 56,
                borderRadius: BorderRadius.circular(8),
                title: Text(
                  '',
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                      color: AppTheme.of(context).currentColors.textColor1),
                ),
                onPressed: () {},
                trailing: Row(
                  children: [
                    service.svg.asset(
                      Assets.assets_svg_ic_menu_trailing_svg,
                      fit: BoxFit.scaleDown,
                    ),
                  ],
                )),
            Divider(
                height: 1,
                thickness: 1,
                indent: 0,
                endIndent: 0,
                color: AppTheme.of(context).currentColors.dividerColor),
            MenuTile(
                height: 56,
                borderRadius: BorderRadius.circular(8),
                title: Text(
                  '',
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                      color: AppTheme.of(context).currentColors.textColor1),
                ),
                onPressed: () {},
                trailing: Row(
                  children: [
                    service.svg.asset(
                      Assets.assets_svg_ic_menu_trailing_svg,
                      fit: BoxFit.scaleDown,
                    ),
                  ],
                )),
            Divider(
                height: 1,
                thickness: 1,
                indent: 0,
                endIndent: 0,
                color: AppTheme.of(context).currentColors.dividerColor),
            MenuTile(
                height: 56,
                borderRadius: BorderRadius.circular(8),
                title: Text(
                  'Français',
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                      color: AppTheme.of(context).currentColors.textColor1),
                ),
                onPressed: () {},
                trailing: Row(
                  children: [
                    service.svg.asset(
                      Assets.assets_svg_ic_menu_trailing_svg,
                      fit: BoxFit.scaleDown,
                    ),
                  ],
                )),
            Divider(
                height: 1,
                thickness: 1,
                indent: 0,
                endIndent: 0,
                color: AppTheme.of(context).currentColors.dividerColor),
          ],
        ),
      ),
    );
  }
}
