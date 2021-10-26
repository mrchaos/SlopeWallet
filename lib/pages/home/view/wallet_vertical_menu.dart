import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:wallet/common/service/wallet_service.dart';
import 'package:wallet/generated/assets.dart';
import 'package:wallet/theme/app_theme.dart';

class WalletVerticalMenu extends StatefulWidget {
  final Function(int) onSelectItem;
  final List<String> svgIcons;
  final List<String> selectedSvgIcons;
  final double width;
  final double iconSize;
  final Size trackSize;
  final double separatedHeight;
  ///Drawer EdgeInsets 20 ,Page EdgeInsets 24
  final isFromDrawer;

  const WalletVerticalMenu(
      {Key? key,
      required this.onSelectItem,
      this.width = 68,
      this.iconSize = 28,
      this.trackSize = const Size(4, 24),
      this.separatedHeight = 16,
      required this.svgIcons,
      required this.selectedSvgIcons,
      this.isFromDrawer = true
      })
      : super(key: key);

  @override
  _WalletVerticalMenuState createState() => _WalletVerticalMenuState();
}

class _WalletVerticalMenuState extends State<WalletVerticalMenu> {
  int _currentIdx = 0;
  double _trackHeight = 0;
  double _topPadding = 0;
  double _compensationPadding = 0;

  @override
  void initState() {
    _trackHeight = widget.trackSize.height;
    if (widget.trackSize.height > widget.iconSize) {
      _trackHeight = widget.iconSize;
    }
    _compensationPadding = (widget.iconSize - _trackHeight) * 0.5;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // service.cache.setString("key", "value");
    _topPadding =
        (_currentIdx.toDouble() * (widget.iconSize + widget.separatedHeight)) +
            _compensationPadding;
    return SizedBox(
      width: widget.width,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AnimatedContainer(
            alignment: Alignment.topCenter,
            duration: Duration(milliseconds: 200),
            padding: EdgeInsets.only(top: _topPadding),
            child: service.svg.asset(                //Manage、Edit、DOnerectangle_svg
              Assets.assets_svg_wallet_rectangle_svg,
              width: widget.trackSize.width,
              height: _trackHeight,
              fit: BoxFit.cover,
              color: AppTheme.of(context).currentColors.textColor1
            ),
          ),
          SizedBox(width: widget.isFromDrawer ? 10 : 20,),
          Expanded(
            child: ListView.separated(
                itemCount: widget.svgIcons.length,
                shrinkWrap: true,
                separatorBuilder: (context, idx) =>
                    SizedBox(height: widget.separatedHeight),
                itemBuilder: (context, idx) {
                  return InkWell(
                    child: service.svg.asset(      //Manage、Edit、Done
                      _currentIdx == idx
                          ? widget.selectedSvgIcons[idx]
                          : widget.svgIcons[idx],
                      width: widget.iconSize,
                      height: widget.iconSize,
                    ),
                    onTap: () {
                      setState(() {
                        _currentIdx = idx;
                      });
                      widget.onSelectItem(idx);
                    },
                  );
                }),
          ),
          SizedBox(width: widget.isFromDrawer ? 10 : 0,),
        ],
      ),
    );
  }
}
