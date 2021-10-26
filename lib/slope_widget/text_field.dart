import 'package:flutter/material.dart';
import 'package:wallet/common/service/wallet_service.dart';
import 'package:wallet/generated/assets.dart';
import 'package:wallet/theme/app_theme.dart';

///。 [showClearButton] 
class SlopeSearchTextField extends StatelessWidget {
  final TextEditingController _controller;
  final FocusNode? focusNode;
  final ValueChanged<String>? onChanged;
  final double height;
  final EdgeInsetsGeometry? margin;
  final String? hintText;
  final bool showClearButton;
  final bool enable;

  SlopeSearchTextField({
    Key? key,
    TextEditingController? controller,
    this.focusNode,
    this.onChanged,
    this.height = 46.0,
    this.margin,
    this.hintText = 'Search',
    this.showClearButton = true,
    this.enable=true,
  })  : _controller = controller ?? TextEditingController(),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    final appColors = context.appColors;
    return Container(
      height: height,
      margin: margin,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: appColors.dividerColor,
          width: 1,
        ),
      ),
      child: Row(
        children: [
          service.svg.asset(
            Assets.assets_svg_search_svg,
            color: appColors.textColor5,
            width: 16,
          ),
          const SizedBox(width: 8),
          Expanded(
            child: TextField(
              controller: _controller,
              focusNode: focusNode,
              autocorrect: false,
              enableSuggestions: false,
              enabled: enable,
              textInputAction: TextInputAction.search,
              textAlignVertical: TextAlignVertical.top,
              cursorColor: appColors.purpleAccent,
              style: TextStyle(
                color: appColors.textColor1,
                fontSize: 14,
              ),
              decoration: InputDecoration(
                hintText: hintText,
                hintStyle: TextStyle(
                  color: appColors.textColor3,
                ),
                border: InputBorder.none,
                isDense: true,
              ),
              onChanged: (text) {
                onChanged?.call(text);
              },
            ),
          ),
          if (showClearButton)
            ValueListenableBuilder<TextEditingValue>(
              valueListenable: _controller,
              builder: (c, value, child) => Visibility(
                child: child!,
                visible: value.text.isNotEmpty,
              ),
              child: GestureDetector(
                behavior: HitTestBehavior.opaque,
                onTap: () {
                  _controller.clear();
                  onChanged?.call('');
                },
                child: service.svg.asset(
                  Assets.assets_svg_cleantext_nft_svg,
                  color: context.isLightTheme ? appColors.textColor5 : appColors.textColor4,
                  width: 16,
                ),
              ),
            ),
        ],
      ),
    );
  }
}
