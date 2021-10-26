import 'package:flutter/material.dart';
import 'package:wallet/common/service/wallet_service.dart';
import 'package:wallet/generated/assets.dart';
import 'package:wallet/slope_widget/button.dart';
import 'package:wallet/slope_widget/dialog.dart';
import 'package:wallet/theme/app_theme.dart';

enum RecordType {
  All,
  Receive,
  Send,
}

extension RecordTypeExt on RecordType {
  String get text {
    var _text = '';
    switch (this) {
      case RecordType.All:
        _text = 'All';
        break;
      case RecordType.Receive:
        _text = 'Receive';
        break;
      case RecordType.Send:
        _text = 'Send';
        break;
    }
    return _text;
  }
}

Future<RecordType?> showRecordTypePicker(BuildContext context) {
  return showModalBottomSheet<RecordType>(context: context, builder: (c) => _RecordTypePicker());
}

class _RecordTypePicker extends StatelessWidget {
  const _RecordTypePicker({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        margin: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              children: [
                Text(
                  'Record Type',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(width: 4),
                GestureDetector(
                  onTap: () {
                    showSlopeConfirmDialog(
                      barrierColor: Colors.transparent,
                      context: context,
                      title: 'Record Type',
                      content: 'We only display Tokens transactions, except NFT and Swap token.',
                      confirmLabel: 'Done',
                    );
                  },
                  child: service.svg.asset(
                    Assets.assets_svg_ic_record_type_help_svg,
                    color: context.appColors.textColor4,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                for (var i = 0; i < RecordType.values.length; i++) ...[
                  if (i != 0) const SizedBox(width: 16),
                  Expanded(
                    child: TextButton(
                      onPressed: () {
                        Navigator.pop(context, RecordType.values[i]);
                      },
                      child: Text(RecordType.values[i].text),
                      style: TextButton.styleFrom(
                          primary: context.appColors.textColor1,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                            side: BorderSide(
                              color: context.appColors.dividerColor,
                            ),
                          ),
                          fixedSize: Size.fromHeight(50),
                          textStyle: TextStyle(
                            fontWeight: FontWeight.w400,
                          )),
                    ),
                  ),
                ],
              ],
            ),
            SlopeCancelButton(
              margin: const EdgeInsets.only(top: 20),
              onPressed: () => Navigator.pop(context),
            ),
          ],
        ),
      ),
    );
  }
}
