import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:wallet/common/service/wallet_service.dart';
import 'package:wallet/generated/assets.dart';
import 'package:wallet/theme/app_colors.dart';
import 'package:wallet/theme/app_theme.dart';
import 'package:provider/provider.dart';
import 'package:wallet/widgets/menu_tile.dart';

class PathSelectView extends StatefulWidget {
  final String selectedPath;
  final List<String> paths;
  const PathSelectView(
      {Key? key, required this.selectedPath, required this.paths})
      : super(key: key);

  static Future<String?> show(
      BuildContext context, List<String> paths, String selectedPath) async {
    return await showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        builder: (_) =>
            PathSelectView(selectedPath: selectedPath, paths: paths));
  }

  @override
  _PathSelectViewState createState() => _PathSelectViewState();
}

class _PathSelectViewState extends State<PathSelectView> {
  late String _selectedPath;
  AppColors get appColors => context.watch<AppTheme>().currentColors;

  @override
  void initState() {
    _selectedPath = widget.selectedPath;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return _buildSelectPath(context);
  }

  Container _buildSelectPath(BuildContext context) {
    return Container(
      constraints: BoxConstraints(
        maxHeight: 348,
      ),
      padding: EdgeInsets.symmetric(horizontal: 20),
      decoration: BoxDecoration(
        color: appColors.backgroundColor,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Container(
          child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(top: 20, bottom: 16),
            child: Text(
              'Path',
              style: TextStyle(
                  color: appColors.textColor1,
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                  height: 22 / 18),
            ),
          ),
          Card(
            elevation: 0,
            margin: EdgeInsets.symmetric(horizontal: 0),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(16.0)),
              side: BorderSide(
                color: AppTheme.of(context).currentColors.dividerColor,
                width: 1.0,
                style: BorderStyle.solid,
              ),
            ),
            child: _buildPathList(context),
          ),

          SizedBox(
            height: 20,
          ),

          _buildSelectPathCancel(),
        ],
      )),
    );
  }

  Container _buildSelectPathCancel() {
    return Container(
      width: double.infinity,
      height: 48,
      // padding: EdgeInsets.symmetric(vertical: 14),
      child: ElevatedButton(
        child: Text(
          'Cancel',
          style: TextStyle(
              fontSize: 18,
              color: appColors.textColor3,
              fontWeight: FontWeight.w500,
              height: 22 / 18),
        ),
        onPressed: () {
          service.router.pop(_selectedPath);
        },
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(appColors.buyAndSell),
          elevation: MaterialStateProperty.all(0),
          shape: MaterialStateProperty.all(RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16.0))),
        ),
      ),
    );
  }

  Column _buildPathList(BuildContext context) {
    return Column(
      children: [
        for (int i = 0; i < widget.paths.length; i++)
          _buildPathItem(i, context),
        // ...(walletPathMap.map((name) => _buildPathItem(name, context))),
      ],
    );
  }

  Column _buildPathItem(int i, BuildContext context) {
    return Column(
      children: [
        MenuTile(
            height: 56,
            title: Text(
              widget.paths[i],
              style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  height: 20 / 16,
                  color: AppTheme.of(context).currentColors.textColor1),
            ),
            trailing: _selectedPath == widget.paths[i]
                ? service.svg.asset(
                    Assets.assets_svg_path_pitch_svg,
                    color: appColors.textColor3,
                    fit: BoxFit.scaleDown,
                  )
                : const SizedBox(),
            onPressed: () {
              _selectedPath = widget.paths[i];
              service.router.pop(_selectedPath);
            }),
        Visibility(
          visible: widget.paths.length != i + 1,
          child: Divider(
            height: 1,
            thickness: 1,
            indent: 0,
            endIndent: 0,
          ),
        )
      ],
    );
  }
}
