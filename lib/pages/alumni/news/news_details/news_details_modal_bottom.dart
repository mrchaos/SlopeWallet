import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:wallet/common/service/wallet_service.dart';
import 'package:wallet/theme/app_colors.dart';
import 'package:wallet/theme/app_theme.dart';

class SharePageModel {
  static showShareView({
    required BuildContext context,
    Widget? showWidget,
    required List<ShareItem> shareMenus,
    List<ShareItem> actions = const [],
  }) {
    showModalBottomSheet(
        context: context,
        backgroundColor: Colors.transparent,
        elevation: 0,
        isScrollControlled: true,
        builder: (BuildContext context) {
          return SharePage(
            context: context,
            showWidget: showWidget,
            shareMenus: shareMenus,
            actions: actions,
          );
        });
  }
}

class SharePage extends StatefulWidget {
  const SharePage({
    Key? key,
    this.showWidget,
    required this.context,
    required this.shareMenus,
    this.actions,
  }) : super(key: key);

  ///，
  final Widget? showWidget;
  final BuildContext context;
  final List<ShareItem> shareMenus;
  final List<ShareItem>? actions;

  @override
  _SharePageState createState() => _SharePageState();
}

class _SharePageState extends State<SharePage> {
  AppColors get appColors => context.appColors;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () => Navigator.pop(context),
      child: Column(
        // mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Expanded(
            child: Center(
              child: GestureDetector(
                onTap: null != widget.showWidget ? () {} : null,
                child: widget.showWidget,
              ),
            ),
          ),
          GestureDetector(child: _buildModalBottom(context)),
        ],
      ),
    );
  }

  Widget _buildModalBottom(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
        color: appColors.backgroundColor,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            margin: const EdgeInsets.only(bottom: 16),
            alignment: Alignment.topLeft,
            child: const Text(
              'Share To',
              style: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 18,
                height: 22 / 18,
              ),
            ),
          ),
          _buildShareMenu(widget.shareMenus),
          const SizedBox(height: 24),
          _buildShareMenu(widget.actions??[]),
          Container(
              width: double.infinity,
              height: 48,
              margin: const EdgeInsets.symmetric(vertical: 20),
              child: TextButton(
                onPressed: () => service.router.pop(),
                child: const Text(
                  'Cancel',
                  style: TextStyle(color: Color(0xff919499)),
                ),
                style: TextButton.styleFrom(
                  backgroundColor: appColors.lightGray,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16.0)),
                ),
              )),
        ],
      ),
    );
  }

  ///APP
  Widget _buildShareMenu(List<ShareItem> shareMenus) {
    return Container(
      height: 64,
      child: ListView.separated(
        scrollDirection:  Axis.horizontal,
          itemBuilder: (BuildContext context, int index) {
            ShareItem e = shareMenus[index];
            return NewsSharedItemWidget(item: e);
          },
          separatorBuilder: (BuildContext context, int index) {
            return SizedBox(
              width: 16,
            );
          },
          itemCount: shareMenus.length),
    );
    // return Container(
    //   width: double.infinity,
    //   child: Column(
    //     mainAxisSize: MainAxisSize.min,
    //     crossAxisAlignment: CrossAxisAlignment.start,
    //     children: [
    //       Wrap(
    //         spacing: 16,
    //         runSpacing: 24,
    //         children: [
    //           ...widget.shareMenus.map((e) => NewsSharedItemWidget(item: e)),
    //         ],
    //       ),
    //       const SizedBox(height: 24),
    //       Wrap(
    //         spacing: 16,
    //         runSpacing: 24,
    //         children: [
    //           ...?widget.actions?.map((e) => NewsSharedItemWidget(item: e)),
    //         ],
    //       ),
    //     ],
    //   ),
    // );
  }
}

class ShareItem {
  final String name;
  final String icon;
  final VoidCallback? onPressed;

  ShareItem({required this.name, required this.icon, this.onPressed});
}

class NewsSharedItemWidget extends StatelessWidget {
  final ShareItem item;

  const NewsSharedItemWidget({
    required this.item,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var appColors = AppTheme.of(context).currentColors;
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: item.onPressed,
      child: Container(
        height: 64,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              width: 40,
              height: 40,
              child: item.icon.isEmpty
                  ? null
                  : service.image.asset(
                      item.icon,
                      fit: BoxFit.contain,
                    ),
            ),
            const SizedBox(height: 8),
            SizedBox(
              height: 16,
              child: Text(
                item.name,
                style: TextStyle(
                  fontSize: 12,
                  color: appColors.textColor6,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
