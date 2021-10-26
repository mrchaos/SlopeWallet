import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';
import 'package:wallet/theme/app_colors.dart';
import 'package:wallet/theme/app_theme.dart';

class AlumniLoadWidget extends StatefulWidget {
  const AlumniLoadWidget({Key? key}) : super(key: key);

  @override
  _AlumniLoadWidgetState createState() => _AlumniLoadWidgetState();
}




// AppColors get appColors => AppTheme.of(context).currentColors;

class _AlumniLoadWidgetState extends State<AlumniLoadWidget> {
  late AppColors appColors;
  @override
  void initState() {
    super.initState();

  }

  @override
  Widget build(BuildContext context) {
    appColors = AppTheme.of(context).currentColors;
    return Column(
      children: [
        Container(
          height: 188,
            color: appColors.loadDataColor,
        ),

        SizedBox(
          height: 24,
        ),

        Padding(
          padding: EdgeInsets.symmetric(horizontal: 24),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: 100,
                height: 24,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: appColors.loadDataColor,
                ),
              ),

              Container(
                width: 45,
                height: 24,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: appColors.loadDataColor,
                ),
              ),
            ],
          ),
        ),

        SizedBox(height: 28,),

        ...List.generate(4, (index) => LoadNotDataList()),

      ],
    );
  }
}

class LoadNotDataList extends StatelessWidget {
  const LoadNotDataList({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    final AppColors appColors = AppTheme.of(context).currentColors;
    return Padding(
      padding: EdgeInsets.only(left: 24, bottom: 24,right: 24),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        mainAxisSize: MainAxisSize.max,
        children: [
          Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.max,
              children: [
                Container(
                  width:225,
                  height: 18,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(6),
                    color: appColors.loadDataColor,
                  ),

                ),

                SizedBox(height: 3,),

                Container(
                  width:225,
                  height: 18,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(6),
                    color: appColors.loadDataColor,
                  ),
                ),

                SizedBox(height: 3,),
                Container(
                  width:128,
                  height: 18,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(6),
                    color: appColors.loadDataColor,
                  ),
                ),

                SizedBox(height: 3,),

                Container(
                  width:128,
                  height: 18,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(6),
                    color: appColors.loadDataColor,
                  ),
                ),

              ],
            ),
          ),
          Container(
            width: 86,
            height: 86,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: appColors.loadDataColor,
            ),
          )
        ],
      ),
    );
  }
}
