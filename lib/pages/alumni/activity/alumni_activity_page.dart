import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:wallet/common/service/router_service/router_table.dart';
import 'package:wallet/common/service/wallet_service.dart';
import 'package:wallet/data/apis/alumni_activity/ama_list_api.dart';
import 'package:wallet/data/apis/alumni_activity/ido_list_api.dart';
import 'package:wallet/generated/assets.dart';
import 'package:wallet/pages/alumni/activity/model/ama_model.dart';
import 'package:wallet/pages/alumni/activity/model/ido_model.dart';
import 'package:wallet/pages/alumni/activity/view/ido_card.dart';
import 'package:wallet/theme/app_colors.dart';
import 'package:wallet/theme/app_theme.dart';
import 'package:wallet/widgets/load_network_image.dart';
import 'package:wallet/widgets/loading/loading_util.dart';

class AlumniActivityPage extends StatefulWidget {
  const AlumniActivityPage({Key? key}) : super(key: key);

  @override
  _AlumniActivityPageState createState() => _AlumniActivityPageState();
}

class _AlumniActivityPageState extends State<AlumniActivityPage> {
  AppColors get appColors => context.appColors;
  List<Ido>? idoModel = [];
  List<Ama>? amaModel = [];

  final _refreshController = RefreshController(
      initialRefresh: true, initialRefreshStatus: RefreshStatus.refreshing);

  Future<void> _requestIdoData() async {
    final data = await IdoLsitApi().request();
    setState(() {
      idoModel = data.idoList;
    });
  }

  int page = 1;
  String currentPage = "1";
  int lastPage = 1;

  Future<void> _requestAmaData({bool isRefresh = false}) async {
    try {
      final data = await AmaListApi(page: isRefresh ? 1 : ++page).request();
      setState(() {
        if (isRefresh) {
          amaModel = [...data.amaList];
          page = 1;
        } else {
          amaModel!.addAll(data.amaList);
        }
        currentPage = data.currentPage;
        lastPage = data.lastPage;
      });
    } finally {
      _refreshController.refreshCompleted();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SmartRefresher(
          controller: _refreshController,
          enablePullUp: currentPage == lastPage.toString() ? false : true,
          enablePullDown: true,
          onRefresh: () {
            _requestIdoData();
            _requestAmaData(isRefresh: true);
          },
          onLoading: () => _requestAmaData(isRefresh: false),
          child: CustomScrollView(
            slivers: <Widget>[
              _buildIdoHeader(context),
              _buildIdo(context),
              _buildAmaHeader(context),
              _buildAma(context),
            ],
          )),
    );
  }

  _buildIdoHeader(BuildContext context) {
    return SliverToBoxAdapter(
        child: Row(
      children: [
        Container(
          width: 100,
          height: 24,
          margin: EdgeInsets.only(left: 24, bottom: 12),
          decoration: BoxDecoration(
              color: (!_refreshController.isRefresh)
                  ? Colors.transparent
                  : appColors.lightGray,
              borderRadius: BorderRadius.circular(8)),
          child: Text(
            (!_refreshController.isRefresh) ? "IDO" : "",
            style: TextStyle(
                fontSize: 20,
                color: appColors.textColor1,
                fontWeight: FontWeight.w700),
          ),
        )
      ],
    ));
  }

  _jumpIdoDetails(int index) {
    if (idoModel![index].linkUrl == '') {
      showToast('For developing');
      return;
    }
    if (idoModel == null) return;

    service.router.pushNamed(RouteName.idoDetailPage,
        arguments: {'idoItemInfo': idoModel![index]});
  }

  _buildIdo(BuildContext context) {
    return SliverToBoxAdapter(
      child: Container(
          height: 104,
          child: (_refreshController.isRefresh)
              ? ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: 3,
                  itemBuilder: (BuildContext context, int index) {
                    return Container(
                      width: 270,
                      height: 104,
                      decoration: BoxDecoration(
                          color: context.isLightTheme
                              ? Color(0xFFF7F8FA)
                              : Color(0xFF202021),
                          borderRadius: BorderRadius.circular(16)),
                      margin: EdgeInsets.only(left: 24),
                    );
                  })
              : (idoModel!.isNotEmpty)
                  ? ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: idoModel!.length,
                      itemBuilder: (BuildContext context, int index) {
                        return GestureDetector(
                          child: IdoCard(
                            idoItem: idoModel![index],
                          ),
                          onTap: () => _jumpIdoDetails(index),
                        );
                      })
                  : Column(
                      children: [
                        service.image.asset(
                          context.isLightTheme
                              ? Assets.assets_image_activity_no_record_png
                              : Assets.assets_image_activity_no_record_dark_png,
                          fit: BoxFit.cover,
                          width: 80,
                          height: 80,
                        ),
                        const SizedBox(height: 7),
                        Text(
                          'No record',
                          style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                              color: context.isLightTheme
                                  ? Color(0xFF292C33)
                                  : Color(0xFFE9ECF2)),
                        )
                      ],
                    )),
    );
  }

  _buildAmaHeader(BuildContext context) {
    return SliverToBoxAdapter(
        child: Row(
      children: [
        Container(
          width: 100,
          height: 24,
          margin: EdgeInsets.only(left: 24, top: 24, bottom: 16),
          decoration: BoxDecoration(
              color: (!_refreshController.isRefresh)
                  ? Colors.transparent
                  : appColors.lightGray,
              borderRadius: BorderRadius.circular(8)),
          child: Text(
            (!_refreshController.isRefresh) ? "AMA" : "",
            style: TextStyle(
                fontSize: 20,
                color: appColors.textColor1,
                fontWeight: FontWeight.w700),
          ),
        )
      ],
    ));
  }

  _jumpAmaDetails(int index) {
    if (amaModel![index].linkUrl == '') {
      showToast('For developing');
      return;
    }
    if (amaModel == null) return;

    service.router.pushNamed(RouteName.amaDetailPage,
        arguments: {'amaItemInfo': amaModel![index]});
  }

  _buildAma(BuildContext context) {
    return SliverList(
      delegate: SliverChildBuilderDelegate((content, index) {
        return Container(
            margin: const EdgeInsets.only(left: 24, right: 24),
            height: 82,
            alignment: Alignment.center,
            child: (amaModel!.isNotEmpty)
                ? GestureDetector(
                    child: AmaListView(
                      amaItem: amaModel![index],
                    ),
                    onTap: () => _jumpAmaDetails(index),
                  )
                : _buildNoDataAMa(context));
      }, childCount: (amaModel!.isNotEmpty) ? amaModel!.length : 10),
    );
  }

  _buildNoDataAMa(BuildContext context) {
    return ListView.builder(
      itemCount: 1,
      physics: NeverScrollableScrollPhysics(),
      itemBuilder: (BuildContext context, int index) {
        return Row(
          children: [
            Column(
              children: [
                Container(
                  width: 48,
                  height: 48,
                  margin: EdgeInsets.only(bottom: 16),
                  decoration: BoxDecoration(
                      color: context.isLightTheme
                          ? Color(0xFFF7F8FA)
                          : Color(0xFF202021),
                      borderRadius: BorderRadius.circular(10)),
                ),
              ],
            ),
            SizedBox(
              width: 12,
            ),
            Flexible(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 67,
                    height: 18,
                    decoration: BoxDecoration(
                        color: context.isLightTheme
                            ? Color(0xFFF7F8FA)
                            : Color(0xFF202021),
                        borderRadius: BorderRadius.circular(6)),
                  ),
                  const SizedBox(height: 3),
                  Container(
                    width: 267,
                    height: 18,
                    decoration: BoxDecoration(
                        color: context.isLightTheme
                            ? Color(0xFFF7F8FA)
                            : Color(0xFF202021),
                        borderRadius: BorderRadius.circular(6)),
                  ),
                  const SizedBox(height: 3),
                  Container(
                    width: 267,
                    height: 18,
                    decoration: BoxDecoration(
                        color: context.isLightTheme
                            ? Color(0xFFF7F8FA)
                            : Color(0xFF202021),
                        borderRadius: BorderRadius.circular(6)),
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}

class AmaListView extends StatelessWidget {
  final Ama amaItem;

  AmaListView({required this.amaItem});

  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          LoadNetWorkImage(
            url: amaItem.logo.toString(),
            width: 48,
            height: 48,
          ),
          const SizedBox(width: 12),
          Flexible(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  amaItem.name.toString(),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 16,
                    height: 18 / 16,
                    fontWeight: FontWeight.w500,
                    color: context.appColors.textColor1,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  amaItem.info.toString(),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                      fontSize: 12,
                      height: 16 / 12,
                      fontWeight: FontWeight.w400,
                      color: context.appColors.textColor3),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
