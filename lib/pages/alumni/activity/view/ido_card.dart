import 'package:decimal/decimal.dart';
import 'package:flutter/material.dart';
import 'package:wallet/pages/alumni/activity/model/ido_model.dart';
import 'package:wallet/theme/app_theme.dart';
import 'package:wallet/widgets/load_network_image.dart';

class IdoCard extends StatelessWidget {
  final Ido idoItem;

  IdoCard({required this.idoItem});

  //tokenNums
/*  String get tokenNumsUnit {
    var tokenNums = double.parse(idoItem.tokenNums.toString());

    if (tokenNums >= 1000000000) {
      var numberB1 = (tokenNums % 1000000000);
      var numberB2 = (numberB1 / 100000000);
      var numberB3 = numberB2.round().toString();
      return "${tokenNums ~/ 1000000000}" + "." + numberB3 + "B";
    } else if (tokenNums >= 1000000) {
      var numberM1 = (tokenNums % 1000000);
      var numberM2 = (numberM1 / 100000);
      var numberM3 = numberM2.round().toString();
      return "${tokenNums ~/ 1000000}" + "." + numberM3 + "M";
    }
    return "${tokenNums.toInt()}";
  }*/

  //tokenNums(1.4444M1.5M)
  String get tokenNumsUnit {
    var tokenNums =
        double.parse(idoItem.tokenNums!.replaceAll(',', '').toString());

    if (tokenNums >= 1000000000) {
      var numberB1 = (tokenNums % 1000000000);
      var numberB2 = (numberB1 ~/ 100000000);
      var numberB3 = ((tokenNums % 100000000) == 0
          ? (numberB2 == 0 ? "" : '.' + numberB2.toString())
          : '.' + (numberB2 + 1).toString());
      return "${tokenNums ~/ 1000000000}" + numberB3.toString() + "B";
    } else if (tokenNums >= 1000000) {
      var numberM1 = (tokenNums % 1000000);
      var numberM2 = (numberM1 ~/ 100000);
      var numberM3 = ((tokenNums % 100000) == 0
          ? (numberM2 == 0 ? "" : '.' + numberM2.toString())
          : '.' + (numberM2 + 1).toString());
      return "${tokenNums ~/ 1000000}" + numberM3.toString() + "M";
    }
    return "${tokenNums.toInt()}";
  }

  Widget build(BuildContext context) {
    return Container(
      width: 270,
      height: 104,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      decoration: BoxDecoration(
          color: context.isLightTheme
              ? const Color(0xFFF7F8FA)
              : const Color(0xFF202021),
          borderRadius: BorderRadius.circular(16)),
      margin: const EdgeInsets.only(left: 24),
      child: Row(
        children: [
          LoadNetWorkImage(url: idoItem.logo.toString(), width: 72, height: 72),
          const SizedBox(width: 12),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 66,
                child: Text(
                  idoItem.name.toString(),
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: context.appColors.textColor1,
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Text(
                "Token Price",
                style: TextStyle(
                    color: context.appColors.textColor3,
                    fontSize: 12,
                    fontWeight: FontWeight.w400),
              ),
              const SizedBox(height: 4),
              Text(
                "Pool Size",
                style: TextStyle(
                    color: context.appColors.textColor3,
                    fontSize: 12,
                    fontWeight: FontWeight.w400),
              ),
            ],
          ),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Container(
                    height: 20,
                    alignment: Alignment.center,
                    padding:
                        const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                    decoration: BoxDecoration(
                      color: const Color(0xFF6E66FA).withOpacity(0.1),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Text(
                      idoItem.timeTip?.toString() ?? '',
                      maxLines: 1,
                      style: TextStyle(
                        color: context.appColors.purpleAccent,
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  // idoItem.airdropNums!.toStringAsFixed(4),
                  Decimal.parse(idoItem.airdropNums!.toStringAsFixed(6)).toString(),
                  style: TextStyle(
                    color: context.appColors.textColor1,
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                const SizedBox(height: 4),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Text(
                    // "${idoItem.tokenNums.toString()}",
                    tokenNumsUnit,
                    style: TextStyle(
                      color: context.appColors.textColor1,
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
