import 'package:flutter/material.dart';
import 'package:wallet/data/bean/browser_list.dart';
import 'package:wallet/pages/alumni/activity/model/ama_model.dart';
import 'package:wallet/pages/alumni/activity/model/ido_model.dart';
import 'package:wallet/theme/app_colors.dart';
import 'package:wallet/widgets/load_network_image.dart';

class IdoApprovePage extends StatelessWidget {
  final AppColors appColors;

  final bool isLightTheme;

  final List<Widget> transactionInfo;

  final GestureTapCallback approveCallback;

  final Ido siteInfo;

  final GestureTapCallback cancelCallback;

  const IdoApprovePage(
      {Key? key,
      required this.appColors,
      required this.isLightTheme,
      required this.transactionInfo,
      required this.approveCallback,
      required this.siteInfo,
      required this.cancelCallback})
      : super(key: key);

  Widget _buildApproveBtn(String text,
      {GestureTapCallback? onPress, bool isApprove = false, Color? btnColor}) {
    return GestureDetector(
      onTap: onPress,
      child: Container(
        height: 48,
        alignment: Alignment.center,
        decoration: BoxDecoration(
            color: btnColor, borderRadius: BorderRadius.circular(10)),
        padding: EdgeInsets.symmetric(vertical: 15),
        child: Text(text, style: TextStyle(
          fontSize: 16,
          color: isApprove ? Colors.white : appColors.textColor2,
          fontWeight: FontWeight.w500,
        ),),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Row(
            children: [
              IconButton(
                  onPressed: () => Navigator.pop(context),
                  icon: Icon(Icons.close)),
              Text(
                'Approve Transaction',
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 24, fontWeight: FontWeight.bold, height: 1.166),
              ),
            ],
          ),
        ),
        body: SafeArea(
          child: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      SizedBox(
                        height: 20,
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 24),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            LoadNetWorkImage(
                              url: this.siteInfo.logo.toString(),
                              width: 52,
                              height: 52,
                            ),
                            SizedBox(
                              width: 12,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  siteInfo.name.toString(),
                                  style: TextStyle(
                                      height: 1.25,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500,
                                      color: appColors.textColor1),
                                ),
                                Text(
                                  siteInfo.linkUrl.toString(),
                                  style: TextStyle(
                                      height: 1.28,
                                      fontSize: 14,
                                      color: appColors.textColor3),
                                )
                              ],
                            )
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 18,
                      ),
                      ...transactionInfo,
                      SizedBox(
                        height: 18,
                      )
                    ],
                  ),
                ),
              ),
              Container(
                height: 80,
                padding: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                        child: _buildApproveBtn('Cancel', onPress: () {
                          cancelCallback();
                      Navigator.pop(context);
                    },
                            btnColor: appColors.lightGray)),
                    SizedBox(
                      width: 10,
                    ),
                    Expanded(
                        child: _buildApproveBtn('Approve', onPress: () {
                      approveCallback();
                      Navigator.pop(context);
                    }, isApprove: true, btnColor: appColors.purpleAccent))
                  ],
                ),
              )
            ],
          ),
        ));
  }
}
