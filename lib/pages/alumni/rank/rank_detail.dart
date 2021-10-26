import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:wallet/common/service/wallet_service.dart';
import 'package:wallet/common/util/format/num_ext.dart';
import 'package:wallet/data/apis/alumni_api.dart';
import 'package:wallet/generated/assets.dart';
import 'package:wallet/theme/app_colors.dart';
import 'package:wallet/theme/app_theme.dart';

import 'alumni_rank_page.dart';
import 'models/rank_index_top_model.dart';

class RankDetail extends StatefulWidget {
  const RankDetail({Key? key}) : super(key: key);

  @override
  _RankDetailState createState() => _RankDetailState();
}

class _RankDetailState extends State<RankDetail> {
  int total = -1;

  int page = 1;

  String tvlOrder = 'DESC';
  String changeOrder = "DESC";

  String get _getCurrentOrder => sort == 'tvl' ? tvlOrder : changeOrder;

  String sort = 'tvl';

  String tagFilter = 'All';

  RankTopModel? topTenModel;

  List<X>? showList;

  final _refreshController = RefreshController(
      initialRefresh: true, initialRefreshStatus: RefreshStatus.refreshing);

  Future<void> _requestTopData({bool isRefresh = false}) async {
    if (!isRefresh && topTenModel!.data.list.length >= total) {
      return;
    }

    try {
      final data = await TopTen(
              page: isRefresh ? 1 : ++page, sort: sort, order: _getCurrentOrder)
          .request();
      setState(() {
        var temp = data.topData.data.list.where((element) =>
            tagFilter == 'All' ? true : element.tags.contains(tagFilter));

        if (isRefresh) {
          topTenModel = data.topData;
          showList = [...temp];
          page = 1;
        } else {
          topTenModel!.data.list.addAll(data.topData.data.list);
          showList!.addAll(temp);
        }
        total = int.parse(data.topData.data.total!);
      });
    } finally {
      _refreshController.refreshCompleted();
      if (!isRefresh) {
        _refreshController.loadComplete();
      }
    }
  }

  Future<String?> get _showSelectTag => showModalBottomSheet<String?>(
      isScrollControlled: true,
      context: context,
      builder: (context) {
        return SafeArea(
          child: Padding(
            padding:const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Select Tags',
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                      color: appColors.textColor1,
                      height: 1.2222),
                ),
                SizedBox(
                  height: 16,
                ),
                GridView(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    padding: EdgeInsets.zero,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      crossAxisSpacing: 12,
                      mainAxisSpacing: 12,
                      childAspectRatio: 103 / 50,
                    ),
                    children: [
                      _buildTag('All'),
                      _buildTag(
                        'DEX',
                      ),
                      _buildTag('Application'),
                      _buildTag('AMM'),
                    ]),
                SizedBox(
                  height: 20,
                ),
                _buildSelectTagBtn(
                  context,
                )
              ],
            ),
          ),
        );
      });

  Widget _buildTag(String t) {
    final bool isSelected = tagFilter == t;
    return GestureDetector(
      onTap: () {
        Navigator.pop(context, t);
      },
      behavior: HitTestBehavior.opaque,
      child: Container(
        decoration: BoxDecoration(
            border: Border.all(
                color: isSelected
                    ? appColors.purpleAccent
                    : context.isLightTheme
                        ? Color(0xffF3F3F5)
                        : Color(0xff242628)),
            color: isSelected ? appColors.purpleAccent.withOpacity(.1) : null,
            borderRadius: BorderRadius.circular(8)),
        alignment: Alignment.center,
        child: Text(
          t,
          style: TextStyle(
              fontSize: 14,
              height: 18 / 14,
              color:
                  isSelected ? appColors.purpleAccent : appColors.textColor1),
        ),
      ),
    );
  }

  Widget _buildSelectTagBtn(BuildContext context,
          {String? t = 'Cancel', GestureTapCallback? onTap}) =>
      GestureDetector(
        onTap: () => t == 'Cancel' ? Navigator.pop(context) : onTap!(),
        behavior: HitTestBehavior.opaque,
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 14),
          alignment: Alignment.center,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: t == 'Cancel' ? appColors.lightGray : appColors.purpleAccent,
          ),
          child: Text(
            t!,
            style: TextStyle(
                fontSize: 16,
                height: 1.25,
                fontWeight: FontWeight.w500,
                color: t == 'Cancel' ? appColors.textColor3 : appColors.white),
          ),
        ),
      );

  AppColors get appColors => context.read<AppTheme>().currentColors;

  void _sort(String sorting) {
    setState(() {
      _refreshController.requestRefresh();
      if (sort == sorting) {
        if (sorting == 'tvl') {
          tvlOrder = _getCurrentOrder == 'DESC' ? 'ASC' : 'DESC';
        } else {
          changeOrder = _getCurrentOrder == 'DESC' ? 'ASC' : 'DESC';
        }
      }
      sort = sorting;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Rank'),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Container(
              alignment: Alignment.center,
              height: 50,
              padding: EdgeInsets.symmetric(horizontal: 24),
              child: Row(
                children: [
                  Expanded(
                    flex: 80,
                    child: _buildFilter(
                        '${tagFilter == 'All' ? 'All Tags' : 'Tag'}',
                        service.svg.asset(Assets.assets_svg_rank_tags_svg,
                            color: tagFilter != 'All'
                                ? appColors.purpleAccent
                                : appColors.textColor1), onTap: () async {
                      final tag = await _showSelectTag;

                      if (tag is String) {
                        setState(() {
                          tagFilter = tag;

                          showList = topTenModel!.data.list
                              .where((element) => tag == 'All'
                                  ? true
                                  : element.tags.contains(tagFilter))
                              .toList();
                        });
                      }
                    }, isTags: true),
                  ),
                  Expanded(
                    flex: 136,
                    child: Row(
                      children: [
                        Expanded(
                          flex: 56,
                          child: _buildFilter(
                              'TVL',
                              RotatedBox(
                                quarterTurns:
                                    sort == 'tvl' && tvlOrder == 'ASC' ? 6 : 0,
                                child: service.svg.asset(
                                    Assets.assets_svg_rank_sort_svg,
                                    color: appColors.textColor1),
                              ),
                              onTap: () => _sort('tvl')),
                        ),
                        Expanded(
                          flex: 80,
                          child: _buildFilter(
                              'Change%',
                              RotatedBox(
                                quarterTurns:
                                    sort == 'price' && changeOrder == 'ASC'
                                        ? 6
                                        : 0,
                                child: service.svg.asset(
                                    Assets.assets_svg_rank_sort_svg,
                                    color: appColors.textColor1),
                              ),
                              onTap: () => _sort('price')),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
            Expanded(
              child: SmartRefresher(
                  controller: _refreshController,
                  enablePullUp: topTenModel == null
                      ? true
                      : topTenModel!.data.list.length < total,
                  enablePullDown: true,
                  onRefresh: () => _requestTopData(isRefresh: true),
                  onLoading: () => _requestTopData(isRefresh: false),
                  child: ListView.builder(
                    padding: EdgeInsets.symmetric(horizontal: 24),
                    itemBuilder: (_, int i) {
                      final item = showList![i];

                      return TopItem(
                          img: item.img,
                          name: item.title,
                          index: topTenModel!.data.list.indexOf(item),
                          volume: item.tvlShort == '0' ? '--' : item.tvlShort,
                          tvl: 'TVL',
                          price:
                              '${item.price != '--' ? '\$' : ''}${item.price != '--' ? double.parse(item.price).truncated(4, true) : item.price}',
                          change:
                              '${item.percentChange.startsWith('-') ? '' : '+'}${item.percentChange}% (24h)',
                          changeColor: item.percentChange.startsWith('-')
                              ? appColors.redAccent
                              : appColors.green,
                          type: item.tags.isEmpty ? '' : item.tags.join(' '));
                    },
                    itemCount: showList?.length ?? 0,
                  )
                  ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFilter(String t, Widget icon,
      {required GestureTapCallback onTap, bool isTags = false}) {
    return GestureDetector(
      onTap: () {
        if (topTenModel != null) {
          onTap();
        }
      },
      onLongPress: () {
        ///
        if (topTenModel != null) {
          setState(() {
            tagFilter = 'All';
            showList = [...topTenModel!.data.list];
            sort = 'tvl';
            tvlOrder = 'DESC';
            changeOrder = 'DESC';
          });
        }
      },
      child: Align(
        alignment: isTags ? Alignment.centerLeft : Alignment.centerRight,
        child: Container(
          decoration: BoxDecoration(
            color: appColors.lightGray,
            borderRadius: BorderRadius.circular(34),
          ),
          padding: EdgeInsets.only(left: 14, top: 6, bottom: 6, right: 8),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                t,
                style: TextStyle(
                    fontSize: 14,
                    color: t == 'Tag' && tagFilter != 'All'
                        ? appColors.purpleAccent
                        : appColors.textColor1,
                    height: 1.28,
                    fontWeight: FontWeight.w500),
              ),
              icon
            ],
          ),
        ),
      ),
    );
  }
}
