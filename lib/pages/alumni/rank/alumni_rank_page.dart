import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:wallet/common/service/router_service/router_table.dart';
import 'package:wallet/common/service/wallet_service.dart';
import 'package:wallet/common/util/format/num_ext.dart';
import 'package:wallet/data/apis/alumni_api.dart';
import 'package:wallet/theme/app_colors.dart';
import 'package:wallet/theme/app_theme.dart';
import 'package:wallet/widgets/list_placeholder.dart';
import 'package:wallet/widgets/load_network_image.dart';

import 'models/rank_index_chart_model.dart';
import 'models/rank_index_top_model.dart';

class AlumniRankPage extends StatefulWidget {
  const AlumniRankPage({Key? key, required this.setTabViewScrollPhysics}) : super(key: key);

  final void Function(ScrollPhysics) setTabViewScrollPhysics;

  @override
  _AlumniRankPageState createState() => _AlumniRankPageState();
}

extension CommaNumber on String {
  String get number2CommaString {
    final x = num.parse(this);

    if (x <= 999 || this.contains(',')) {
      return this;
    }

    if (this.contains('.')) {
      return this
              .substring(0, this.indexOf('.'))
              .replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]},') +
          this.substring(this.indexOf('.'));
    }

    return this.replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]},');
  }
}

class _AlumniRankPageState extends State<AlumniRankPage> {
  PointerEvent? chartInteractiveType;
  String? showTime;
  double touchTimeOffsetX = 0.0;

  RankChartModel? chartModel;
  RankTopModel? topTenModel;

  final formater = DateFormat('MM-dd');

  final _refreshController = RefreshController(
      initialRefresh: true, initialRefreshStatus: RefreshStatus.refreshing);

  Future<void> _requestChartData() async {
    final data = await RankChart().request();
    setState(() {
      chartModel = data.rankInfo;
    });
  }

  Future<void> _requestTopData() async {
    try {
      final data = await TopTen().request();
      setState(() {
        topTenModel = data.topData;
      });
    } finally {
      _refreshController.refreshCompleted();
    }
  }

  List<SonalaTotalItem> get items => chartModel?.data.list ?? [];

  /// 34
  final int timeToolTipWidth = 34;

  void _touchCallback(LineTouchResponse x, BoxConstraints cons) {
    final int gapsBetweenBodyAndAnotherBody = items.length - 1;

    final index =
        x.lineBarSpots?.first.x ?? (touchTimeOffsetX <= 0 ? 0 : gapsBetweenBodyAndAnotherBody);

    final time = items[index.toInt()].showDate;

    if (showTime != time || chartInteractiveType.runtimeType != x.touchInput.original.runtimeType) {
      setState(() {
        chartInteractiveType = x.touchInput.original;

        final dx = index * (cons.maxWidth / gapsBetweenBodyAndAnotherBody) - timeToolTipWidth / 2;

        if (dx < 0) {
          touchTimeOffsetX = 0;
        } else if (dx > cons.maxWidth - timeToolTipWidth) {
          touchTimeOffsetX = cons.maxWidth - timeToolTipWidth;
        } else {
          touchTimeOffsetX = dx;
        }

        showTime = time;
      });
    }
  }

  Widget get chart => Stack(
        children: [
          LayoutBuilder(
            builder: (_, cons) => LineChart(
              LineChartData(
                minY: 100000000,
                gridData: FlGridData(show: false),
                lineTouchData: LineTouchData(
                    touchCallback: (x) {
                      _touchCallback(x, cons);
                    },
                    handleBuiltInTouches: true,
                    enabled: true,
                    getTouchLineEnd: (data, index) => double.infinity,
                    getTouchedSpotIndicator: (LineChartBarData barData, List<int> spotIndexes) {
                      return [
                        TouchedSpotIndicatorData(
                            FlLine(
                                color: readColor.purpleAccent, strokeWidth: 1, dashArray: [4, 3]),
                            FlDotData(
                                show: true,
                                getDotPainter: (flSpot, double, lineChartBarData, int) {
                                  return FlDotCirclePainter(
                                      color: readColor.backgroundColor,
                                      radius: 1.5,
                                      strokeColor: readColor.purpleAccent,
                                      strokeWidth: 1.5);
                                })),
                      ];
                    },
                    touchTooltipData: LineTouchTooltipData(
                        fitInsideHorizontally: true,
                        fitInsideVertically: false,
                        showOnTopOfTheChartBoxArea: true,
                        tooltipBgColor: context.isLightTheme ? Colors.white : appColors.darkGray,
                        tooltipPadding: EdgeInsets.zero,
                        tooltipMargin: 4,
                        getTooltipItems: (spot) {
                          return [
                            LineTooltipItem(
                                '\$${items[spot.first.x.toInt()].tvl.number2CommaString}',
                                TextStyle(
                                    fontSize: 10,
                                    height: 1.2,
                                    color: context.read<AppTheme>().currentColors.purpleAccent)),
                          ];
                        })),
                titlesData: FlTitlesData(
                  show: true,
                  rightTitles: SideTitles(showTitles: false),
                  topTitles: SideTitles(showTitles: false),
                  leftTitles: SideTitles(showTitles: false),
                  bottomTitles: SideTitles(
                    showTitles: true,
                    reservedSize: 12,
                    getTextStyles: (_, value) => TextStyle(
                        color: context.read<AppTheme>().currentColors.textColor3,
                        fontSize: 10,
                        height: 1.2),
                    getTitles: (value) {
                      final time = DateTime.parse(items[value.toInt()].showDate);

                      return time.weekday == DateTime.now().weekday ? formater.format(time) : '';
                    },
                  ),
                ),
                borderData: FlBorderData(show: false),
                lineBarsData: [
                  LineChartBarData(
                    spots: items
                        .map((e) => FlSpot(items.indexOf(e).toDouble(), double.parse(e.tvl)))
                        .toList(),
                    colors: [appColors.purpleAccent],
                    shadow: BoxShadow(
                        offset: Offset(0, 8),
                        color: appColors.purpleAccent.withOpacity(.06),
                        blurRadius: 4),
                    barWidth: 1.5,
                    dotData: FlDotData(
                      show: false,
                    ),
                    belowBarData: BarAreaData(
                      show: true,
                      gradientFrom: Offset(.5, 1),
                      gradientTo: Offset(.5, 0),
                      colors: [
                        appColors.purpleAccent.withOpacity(0),
                        appColors.purpleAccent.withOpacity(.2),
                      ],
                    ),
                  ),
                ],
              ),

              swapAnimationDuration: Duration(milliseconds: 150),

              // Optional
              swapAnimationCurve: Curves.linear, // Optional
            ),
          ),
          Positioned(
              bottom: 0,
              left: touchTimeOffsetX,
              child: Visibility(
                visible: showTime != null && !(chartInteractiveType is PointerUpEvent),
                child: IgnorePointer(
                  child: Container(
                    width: 34,
                    padding: EdgeInsets.symmetric(horizontal: 4, vertical: 2),
                    decoration: BoxDecoration(
                      color: context.isLightTheme ? Color(0xffF1F0FE) : Color(0xff282737),
                      borderRadius: BorderRadius.circular(3),
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      showTime is String ? formater.format(DateTime.parse(showTime!)) : '',
                      style: TextStyle(fontSize: 10, color: appColors.purpleAccent, height: 1.2),
                    ),
                  ),
                ),
              ))
        ],
      );

  @override
  Widget build(BuildContext context) {
    return SmartRefresher(
      controller: _refreshController,
      enablePullUp: false,
      enablePullDown: true,
      onRefresh: () {
        _requestChartData();
        _requestTopData();
      },
      child: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              AnimatedSwitcher(
                child: _buildTotalValueLocked,
                duration: Duration(milliseconds: 300),
              ),
              //4()+16()+()12
              SizedBox(
                height: 32,
              ),
              if (charDead)
                _noDataContainer(height: 112)
              else
                GestureDetector(
                  onHorizontalDragStart: (_) =>
                      widget.setTabViewScrollPhysics(const NeverScrollableScrollPhysics()),
                  onHorizontalDragEnd: (_) {
                    widget.setTabViewScrollPhysics(const ClampingScrollPhysics());
                  },
                  child: Container(
                    height: 112,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: chart,
                  ),
                ),
              Container(
                height: 16,
              ),
              _buildTopTen
            ],
          ),
        ),
      ),
    );
  }

  AppColors get readColor => context.read<AppTheme>().currentColors;

  AppColors get appColors => context.appColors;

  bool get topTenDead => topTenModel == null;

  bool get charDead => chartModel == null;

  Widget get _buildTopTen => Container(
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                if (topTenModel != null)
                  Text(
                    'Top 10',
                    style: TextStyle(
                        fontSize: 20,
                        height: 1.25,
                        fontWeight: FontWeight.w700,
                        color: appColors.textColor1),
                  )
                else
                  _noDataContainer(width: 100, height: 24),
                if (topTenDead)
                  _noDataContainer(width: 45, height: 24)
                else
                  GestureDetector(
                      onTap: () {
                        service.router.pushNamed(RouteName.rankSeeAll);
                      },
                      child: Text(
                        'See All',
                        style: TextStyle(
                            fontSize: 14,
                            color: appColors.textColor1,
                            fontWeight: FontWeight.w500,
                            height: 1.28),
                      ))
              ],
            ),
            SizedBox(
              height: 8,
            ),
            ListView.builder(
              padding: EdgeInsets.zero,
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemBuilder: (_, int index) {
                if (topTenDead) {
                  return DeadTopItem(
                      context.isLightTheme ? appColors.lightGray : appColors.darkMediumGray);
                }

                final item = topTenModel!.data.list[index];

                return TopItem(
                    img: item.img,
                    name: item.title,
                    index: index,
                    volume: item.tvlShort,
                    tvl: 'TVL',
                    price:
                        '${item.price != '--' ? '\$' : ''}${item.price != '--' ? double.parse(item.price).truncated(4) : item.price}',
                    change:
                        '${item.percentChange.startsWith('-') ? '' : '+'}${item.percentChange}% (24h)',
                    changeColor:
                        item.percentChange.startsWith('-') ? appColors.redAccent : appColors.green,
                    type: item.tags.isEmpty ? '' : item.tags.first);
              },
              itemCount: 10,
            )
          ],
        ),
      );

  Widget _noDataContainer({double? width, double? height, Color? colors}) => getPlaceholder(
        width,
        height,
        8,
        colors ?? (context.isLightTheme ? appColors.lightGray : appColors.darkMediumGray),
      );

  Widget get _noDataValueLock => Container(
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
            color: context.isLightTheme ? appColors.lightGray : appColors.darkMediumGray,
            borderRadius: BorderRadius.circular(16)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _noDataContainer(
                width: 102,
                height: 16,
                colors: context.isLightTheme ? Colors.white : appColors.darkLightGray2),
            SizedBox(
              height: 4,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: _noDataContainer(
                      height: 22,
                      colors: context.isLightTheme ? Colors.white : appColors.darkLightGray2),
                ),
                SizedBox(
                  width: 54,
                ),
                _noDataContainer(
                    height: 24,
                    width: 66,
                    colors: context.isLightTheme ? Colors.white : appColors.darkLightGray2)
              ],
            ),
            SizedBox(
              height: 16,
            ),
            _noDataContainer(
                height: 70, colors: context.isLightTheme ? Colors.white : appColors.darkLightGray2)
          ],
        ),
      );

  bool get isIncreasing => (chartModel?.data.tvlPercentChange ?? 0) > 0;

  Widget get _buildTotalValueLocked => chartModel == null
      ? _noDataValueLock
      : Container(
          padding: EdgeInsets.all(16),
          decoration: BoxDecoration(
              color: appColors.loadDataColor, borderRadius: BorderRadius.circular(16)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                'Total Value Locked',
                style: TextStyle(fontSize: 12, height: 1.333, color: appColors.textColor3),
              ),
              SizedBox(
                height: 4,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Text(
                        '\$ ${(chartModel?.data.totalTVL?.number2CommaString) ?? '...'}',
                        style: TextStyle(
                            fontSize: 20,
                            height: 1.2,
                            color: appColors.textColor1,
                            fontWeight: FontWeight.w700),
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 15),
                    decoration: BoxDecoration(
                      color: (isIncreasing
                          ? appColors.green
                          : appColors.redAccent)
                          .withOpacity(.1),
                        borderRadius: BorderRadius.circular(8)),
                    padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    child: Text(
                      '${isIncreasing ? '+' : ''} ${((chartModel?.data.tvlPercentChange ?? 0) * 100).truncated(2)}% ',
                      style: TextStyle(
                          fontSize: 12,
                          color: isIncreasing ? appColors.green : appColors.redAccent,
                          fontWeight: FontWeight.w500),
                    ),
                  )
                ],
              ),
              SizedBox(
                height: 16,
              ),
              Container(
                height: 72,
                padding: EdgeInsets.all(12),
                decoration: BoxDecoration(
                    color: appColors.dexSliderColor, borderRadius: BorderRadius.circular(10)),
                child: Row(
                  children: [
                    _buildLockedRowItem("Transaction Per \nSecond (TPS)",
                        "${chartModel?.data.tps?.number2CommaString}"),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      child: VerticalDivider(
                        width: 1,
                        color: context.isLightTheme ? Color(0xffF3F3F5) : Color(0xff242628),
                      ),
                    ),
                    _buildLockedRowItem(
                        "Total Txn", "${chartModel?.data.txn?.number2CommaString ?? 0}")
                  ],
                ),
              )
            ],
          ),
        );

  Widget _buildLockedRowItem(String t, String c) => Expanded(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              t,
              style: TextStyle(fontSize: 10, color: appColors.textColor3, height: 1.2),
            ),
            Text(
              c,
              style: TextStyle(
                  fontSize: 14,
                  height: 1.28,
                  color: appColors.textColor1,
                  fontWeight: FontWeight.w500),
            )
          ],
        ),
      );
}

class TopItem extends StatelessWidget {
  final String img;
  final String name;
  final int index;
  final String volume;
  final String tvl;
  final String price;
  final String change;
  final Color changeColor;
  final String? type;

  TopItem(
      {required this.img,
      required this.name,
      required this.index,
      required this.volume,
      required this.tvl,
      required this.price,
      required this.change,
      required this.changeColor,
      required this.type});

  Color get c => const Color(0xffF7F8FA);

  Widget get deadAvatar => Container(
        decoration: BoxDecoration(color: c, shape: BoxShape.circle),
        width: 28,
        height: 28,
      );

  @override
  Widget build(BuildContext context) {
    AppColors appColors = context.appColors;

    return Container(
      padding: const EdgeInsets.symmetric(
        vertical: 16,
      ),
      child: Row(
        children: [
          Expanded(
            flex: 80,
            child: Row(
              children: [
                LoadNetWorkImage(
                  radius: 60,
                  width: 28,
                  height: 28,
                  url: img,
                ),
                SizedBox(
                  width: 8,
                ),
                Flexible(
                  child: Container(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          name,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                              fontSize: 14,
                              height: 1.28,
                              fontWeight: FontWeight.w500,
                              color: appColors.textColor1),
                        ),
                        SizedBox(
                          height: 4,
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              padding: EdgeInsets.symmetric(horizontal: 6, vertical: 1),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(4),
                                  color: index <= 2
                                      ? appColors.purpleAccent.withOpacity(.1)
                                      : appColors.lightGray),
                              child: Text(
                                '${index + 1}',
                                style: TextStyle(
                                    color:
                                        index <= 2 ? appColors.purpleAccent : appColors.textColor3,
                                    fontSize: 10,
                                    height: 1.2,
                                    fontWeight: FontWeight.w500),
                              ),
                            ),
                            SizedBox(
                              width: 4,
                            ),
                            Expanded(
                              child: Text(
                                type ?? '',
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  fontSize: 12,
                                  color: appColors.textColor3,
                                ),
                              ),
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(
            width: 8,
          ),
          Expanded(
            flex: 56,
            child: Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(volume,
                      textAlign: TextAlign.end,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                          fontSize: 14,
                          height: 1.28,
                          color: appColors.textColor1,
                          fontWeight: FontWeight.w500)),
                  SizedBox(height: 4),
                  Text(
                    tvl,
                    textAlign: TextAlign.end,
                    style: TextStyle(fontSize: 12, color: appColors.textColor3, height: 1.333),
                  )
                ],
              ),
            ),
          ),
          const SizedBox(
            width: 8,
          ),
          Expanded(
            flex: 80,
            child: Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(price,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                          fontSize: 14,
                          height: 1.28,
                          color: appColors.textColor1,
                          fontWeight: FontWeight.w500)),
                  SizedBox(
                    height: 4,
                  ),
                  Text(
                    change,
                    style: TextStyle(
                        fontSize: 12,
                        color: changeColor,
                        fontWeight: FontWeight.w500,
                        height: 1.333),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}

class DeadTopItem extends StatelessWidget {
  final Color c;

  DeadTopItem(this.c);

  Widget get deadAvatar => Container(
        decoration: BoxDecoration(color: c, shape: BoxShape.circle),
        width: 28,
        height: 28,
      );

  Container _noDataContainer({double? width, double? height, Color? colors}) => Container(
        decoration: BoxDecoration(color: c, borderRadius: BorderRadius.circular(8)),
        width: width,
        height: height,
      );

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        vertical: 16,
      ),
      child: Row(
        children: [
          deadAvatar,
          SizedBox(
            width: 8,
          ),
          SizedBox(
            width: 95,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _noDataContainer(width: 64, height: 18),
                SizedBox(
                  height: 4,
                ),
                _noDataContainer(width: 36, height: 18)
              ],
            ),
          ),
          Expanded(child: SizedBox()),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              _noDataContainer(width: 48, height: 18),
              SizedBox(height: 4),
              _noDataContainer(width: 48, height: 18)
            ],
          ),
          Expanded(child: SizedBox()),
          SizedBox(
            width: 120,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                _noDataContainer(width: 76, height: 18),
                SizedBox(
                  height: 4,
                ),
                _noDataContainer(width: 76, height: 18)
              ],
            ),
          )
        ],
      ),
    );
  }
}
