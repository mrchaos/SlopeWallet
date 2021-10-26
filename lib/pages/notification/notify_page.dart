import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:wallet/common/service/wallet_service.dart';
import 'package:wallet/generated/assets.dart';
import 'package:wallet/theme/app_colors.dart';
import 'package:wallet/theme/app_theme.dart';
import 'package:wallet/widgets/custom_segmented_control/custom_segmented_control.dart';
import 'package:wallet/widgets/load_network_image.dart';
import 'package:wallet/widgets/loading/loading_util.dart';

class Notify extends StatefulWidget {
  const Notify({Key? key}) : super(key: key);

  @override
  _NotifyState createState() => _NotifyState();
}

class _NotifyState extends State<Notify> with SingleTickerProviderStateMixin {
  AppColors get _appColors => context.read<AppTheme>().currentColors;

  late final TabController tabController;

  int currentTabIndex = 0;

  final DateFormat formatter = DateFormat('MM-dd hh:mm:ss');

  @override
  void initState() {
    tabController = TabController(length: 2, initialIndex: 0, vsync: this);

    tabController.addListener(() {
      setState(() {
        currentTabIndex = tabController.index;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Notifications'),
      ),
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(
              height: 16,
            ),
            _buildSegmentedControl,
            Expanded(
                child: TabBarView(
              controller: tabController,
              children: [
                ListView.builder(
                  padding: EdgeInsets.symmetric(horizontal: 24)
                      .add(EdgeInsets.only(top: 6)),
                  itemBuilder: (_, int index) =>
                      _buildTransactionItem(index, last: index == (20 - 1)),
                  itemCount: 20,
                ),
                ListView.builder(
                  padding: EdgeInsets.symmetric(horizontal: 24)
                      .add(EdgeInsets.only(top: 8)),
                  itemBuilder: (_, int index) => _buildMessage(index),
                  itemCount: 20,
                )
              ],
            ))
          ],
        ),
      ),
    );
  }

  Widget _buildMessage(int index) {
    return Container(
      decoration: BoxDecoration(
          border: Border(
              bottom: BorderSide(
                  width: 1,
                  color: context.isLightTheme
                      ? Color(0xfff0f1f2)
                      : Color(0xff242628)))),
      padding: EdgeInsets.symmetric(vertical: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Put a Straw Under Baby'),
              Row(
                children: [
                  Text(formatter.format(DateTime.now())),
                  if (index % 2 == 0)
                    Container(
                      margin: EdgeInsets.only(left: 4),
                      decoration: BoxDecoration(
                          color: _appColors.redAccent, shape: BoxShape.circle),
                      width: 6,
                      height: 6,
                    )
                ],
              )
            ],
          ),
          SizedBox(
            height: 8,
          ),
          Text(
            '''Put a straw under baby Your good deed for the day Put a straw under baby Keep the splinters away Let the corridors echo As the dark places grow Hear Superior's footsteps On the landing below''',
            maxLines: 2,
            style: TextStyle(
              fontSize: 14,
              height: 18 / 14,
              color: _appColors.textColor3,
            ),
            overflow: TextOverflow.ellipsis,
          )
        ],
      ),
    );
  }

  Widget _buildTransactionItem(int index, {bool last = false}) {
    return Container(
      child: Row(
        children: [
          LoadNetWorkImage(
            radius: 60,
            width: 32,
            height: 32,
            url:
                'https://img2.baidu.com/it/u=1331054119,3366246286&fm=26&fmt=auto',
            fit: BoxFit.fitHeight,
          ),
          SizedBox(
            width: 8,
          ),
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                  border: Border(
                      bottom: BorderSide(
                          color: context.isLightTheme
                              ? Color(0xfff0f1f2)
                              : Color(0xff242628),
                          width: last ? 0 : 1))),
              padding: EdgeInsets.symmetric(vertical: 17),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'SOL-Send',
                        style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            height: 18 / 14,
                            color: _appColors.textColor1),
                      ),
                      Text(
                        '-12.87938',
                        style: TextStyle(
                            fontSize: 16,
                            color: index % 2 == 0
                                ? _appColors.greenAccent
                                : _appColors.textColor1,
                            fontWeight: FontWeight.w500,
                            height: 20 / 16),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 4,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '04-13 17:35:00',
                        style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                            height: 16 / 12,
                            color: _appColors.textColor3),
                      ),
                      SizedBox(
                        width: 52,
                      ),
                      Expanded(
                        child: Row(
                          children: [
                            Expanded(
                              child: Row(
                                children: [
                                  Text(
                                    'TXID: ',
                                    style: TextStyle(
                                        fontSize: 12,
                                        color: _appColors.textColor3,
                                        fontWeight: FontWeight.w400,
                                        height: 16 / 12),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  Expanded(
                                    child: Text(
                                      'eBgimcSknSh7b6QePEZbjzkkj7sXaokGzNRa5um6N3QjfQhHovrCokSM5wDRppn53rTe73XRbDMWNKH1XaRm8xU',
                                      style: TextStyle(
                                          fontSize: 12,
                                          color: _appColors.textColor3,
                                          fontWeight: FontWeight.w400,
                                          height: 16 / 12),
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  )
                                ],
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                Clipboard.setData(ClipboardData(text: 'cunt'));
                                showToast("Copy success!");
                              },
                              behavior: HitTestBehavior.opaque,
                              child: Container(
                                child: service.svg.asset(
                                  Assets.assets_svg_copy_txid_svg,
                                  width: 16,
                                  height: 16,
                                ),
                              ),
                            )
                          ],
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget get _buildSegmentedControl => Padding(
        padding: EdgeInsets.symmetric(horizontal: 24),
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 4, vertical: 3),
          height: 46,
          width: double.infinity,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                color: _appColors.dividerColor,
              )),
          child: CustomSegmentedControl(
            padding: EdgeInsets.zero,
            groupValue: currentTabIndex,
            children: {
              0: Container(
                height: 38,
                alignment: Alignment.center,
                child: Text(
                  'Transaction',
                  style: TextStyle(
                      color: currentTabIndex == 0
                          ? _appColors.textColor1
                          : _appColors.textColor3,
                      fontWeight: FontWeight.w500,
                      fontSize: 14),
                ),
              ),
              1: Container(
                height: 38,
                alignment: Alignment.center,
                child: Text(
                  'Messages',
                  style: TextStyle(
                      color: currentTabIndex == 1
                          ? _appColors.textColor1
                          : _appColors.textColor3,
                      fontWeight: FontWeight.w500,
                      fontSize: 14),
                ),
              ),
            },
            thumbColor: _appColors.lightGray,
            backgroundColor: _appColors.backgroundColor,
            onValueChanged: (int? val) {
              FocusScopeNode currentFocus = FocusScope.of(context);
              if (!currentFocus.hasPrimaryFocus &&
                  currentFocus.focusedChild != null) {
                FocusManager.instance.primaryFocus!.unfocus();
              }
              if (null != val && val != currentTabIndex) {
                setState(() {
                  currentTabIndex = val;
                  tabController.animateTo(val);
                });
              }
            },
          ),
        ),
      );
}
