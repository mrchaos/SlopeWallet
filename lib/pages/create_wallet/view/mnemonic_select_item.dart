import 'package:flutter/material.dart';
import 'package:wallet/theme/app_theme.dart';

class MnemonicSelectItem extends StatelessWidget {
  final String word;
  final bool isSelected;
  final VoidCallback onTap;
  const MnemonicSelectItem(
      {Key? key,
      required this.word,
      this.isSelected = false,
      required this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    Color color = isSelected
        ? AppTheme.of(context).currentColors.textColor1.withOpacity(0.5)
        : AppTheme.of(context).currentColors.textColor1;
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        decoration: BoxDecoration(
          color: AppTheme.of(context).themeMode == ThemeMode.light
              ? AppTheme.of(context).currentColors.lightGray
              : AppTheme.of(context).currentColors.dividerColor,
          borderRadius: BorderRadius.circular(10),
        ),
        alignment: Alignment.center,
        child: Text(
          word,
          style: TextStyle(
            color: color,
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
          softWrap: true,
        ),
      ),
    );
  }
}
