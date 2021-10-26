import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:wallet/common/service/router_service/router_table.dart';
import 'package:wallet/common/service/wallet_service.dart';
import 'package:wallet/common/util/string/string_util.dart';
import 'package:wallet/data/bean/alumni_news/alumni_news_home_banner_bean.dart';
import 'package:wallet/data/bean/alumni_news/alumni_news_home_module_bean.dart';
import 'package:wallet/data/bean/alumni_news/alumni_news_list_bean.dart';
import 'package:wallet/generated/assets.dart';
import 'package:wallet/pages/alumni/news/alumni_news_model.dart';
import 'package:wallet/pages/alumni/news/view/alumni_load_widget.dart';
import 'package:wallet/pages/alumni/news/view/banner_module.dart';
import 'package:wallet/pages/alumni/news/widgets/image_fail_widget.dart';
import 'package:wallet/theme/app_colors.dart';
import 'package:wallet/theme/app_theme.dart';
import 'package:wallet/utils/date_extends.dart';
import 'package:wallet/widgets/placeholder/no_data_place_holder.dart';

class AlumniNewsPage extends StatefulWidget {
  const AlumniNewsPage({Key? key}) : super(key: key);

  @override
  _AlumniNewsPageState createState() => _AlumniNewsPageState();
}

class _AlumniNewsPageState extends State<AlumniNewsPage> {
  late AlumniNewsModel _alumniNewsModel;

  @override
  void initState() {
    _alumniNewsModel = AlumniNewsModel();
    super.initState();

    // _getAlumniNews();
  }

  final ValueNotifier<bool> _isNotLoadFinishNotifiter =
      ValueNotifier<bool>(false);

  // bool _isShow = false;

  _getAlumniNews() async {
    await _alumniNewsModel.getAlumniNewsHome();
  }

  RefreshController _refreshController =
      RefreshController(initialRefresh: true);
  ValueNotifier<bool> _isBannerIsNotDataNotifiter = ValueNotifier<bool>(false);

  void _onRefresh() async {
    try {
      await _getAlumniNews();
      _refreshController.refreshCompleted();
      _isNotLoadFinishNotifiter.value = true;

      if (_alumniNewsModel.alumniNewsBanner.isNotEmpty) {
        _isBannerIsNotDataNotifiter.value = true;
      }
    } catch (e) {
      _refreshController.refreshCompleted();
    }
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (_) => _alumniNewsModel,
        child: Builder(
          builder: (BuildContext context) {
            return SmartRefresher(
                enablePullDown: true,
                enablePullUp: false,
                controller: _refreshController,
                onRefresh: () => _onRefresh(),
                child: ListView(
                  padding: EdgeInsets.zero,
                  children: [
                    ValueListenableBuilder(
                      valueListenable: _isNotLoadFinishNotifiter,
                      builder: (BuildContext context, value, Widget? child) {
                        final _alumniNewsModule = context.select(
                            (AlumniNewsModel vm) => vm.alumniNewsModule);

                        List<AlumniNewsBannerBean> _alumniNewsBanner =
                            context.select((AlumniNewsModel value) =>
                                value.alumniNewsBanner);
                        return _isNotLoadFinishNotifiter.value
                       ? Column(children: [
                          ValueListenableBuilder<bool>(
                              valueListenable:
                              _isBannerIsNotDataNotifiter,
                              builder: (context, value, child) {
                                return _isBannerIsNotDataNotifiter.value
                                    ? _bannerModule(context)
                                    : Container(
                                  height: 188,
                                  color: appColors.loadDataColor,
                                );
                              }),

                          if (_alumniNewsModule.isNotEmpty)
                            ..._alumniNewsModule.map(
                                    (item) => _newsModuleList(context, item)),
                          if (!_alumniNewsModule.isNotEmpty)
                            _notDataWidget(),
                        ]): AlumniLoadWidget();

                      // return NoDataPlaceHolder(
                      //     alignment: Alignment.topCenter,
                      //   );
                      },
                    ),
                    // _isNotLoadFinishNotifiter.value ?
                  ],
                ));
          },
        ));
  }

  Widget _notDataWidget() {
    bool isDark = AppTheme.of(context).themeMode == ThemeMode.dark;
    return Container(
        alignment: Alignment.center,
        child: Column(
          children: [
            isDark
                ? service.image.asset(
                    Assets.assets_image_dark_news_home_not_data_png,
                    width: 223,
                    height: 223,
                    fit: BoxFit.contain)
                : service.image.asset(
                    Assets.assets_image_news_home_not_data_png,
                    width: 223,
                    height: 223,
                    fit: BoxFit.contain,
                  ),
            Align(
                alignment: Alignment.topCenter,
                child: Text(
                  'not data',
                  style: TextStyle(fontSize: 14, height: 18 / 14),
                )),
          ],
        ));
  }

  Widget _bannerModule(BuildContext context) {
    List<AlumniNewsBannerBean> _alumniNewsBanner =
        context.select((AlumniNewsModel value) => value.alumniNewsBanner);
    var imageUrls = _alumniNewsBanner.map((e) => e.banner ?? '').toList();

    return BannerPage.url(
      imageUrls: imageUrls,
      showIndicator: _alumniNewsBanner.length > 1,
      autoPlay: _alumniNewsBanner.length > 1,
      alumniNewsBanner: _alumniNewsBanner,
      onTapBanner: (index) async {
        /// jump_type ：
        /// 1：
        /// 2：
        /// 3：

        final AlumniNewsBannerBean _alumniNewsBannerItem =
            _alumniNewsBanner[index];

        String _url = _alumniNewsBannerItem.jumpUrl ?? '';
        int _jumpType = _alumniNewsBannerItem.jumpType ?? 1;
        if (_jumpType == 1) return;

        if (_alumniNewsBannerItem.jumpType == 2) {
          if (isNetworkUrl(_url)) {
            service.router.pushNamed(RouteName.commonWebViewPage,
                arguments: {'linkUrl': _alumniNewsBannerItem.jumpUrl});
          }
        }
      },
    );
  }

  // imageUrls: [
  //   'https://img.zcool.cn/community/01cfa75cdbaf02a801214168d5a68d.jpg',
  //   'https://pic.macw.com/pic/202002/17163720_e2bb6a15c2.jpeg',
  //   'https://tse4-mm.cn.bing.net/th/id/OIP.Le46HfnZgiYrqAick1T_xwHaD6?pid=Api&rs=1',
  // ],

  AppColors get appColors => context.watch<AppTheme>().currentColors;

  Container _newsModuleList(
      BuildContext context, AlumniNewsModuleBean newsList) {
    return Container(
      alignment: Alignment.topLeft,
      padding: const EdgeInsets.only(top: 39, left: 24, right: 24),
      child: Column(
        // mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        children: [
          GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTap: () {
              service.router
                  .pushNamed(RouteName.alumniNewsListPage, arguments: {
                'type': newsList.id,
                'newsListModule': newsList,
              });
            },
            child: Container(
              alignment: Alignment.topLeft,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    newsList.name,
                    style: TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 20,
                      height: 24 / 20,
                    ),
                  ),
                  Text(
                    'More',
                    style: TextStyle(
                        color: appColors.favorColor,
                        fontSize: 14,
                        fontWeight: FontWeight.w500),
                  )
                ],
              ),
            ),
          ),
          const SizedBox(height: 24),
          ...newsList.childs.map((item) => NewsItemWidget(newsListItem: item))
        ],
      ),
    );
  }
}

class NewsItemWidget extends StatelessWidget {
  final AlumniNewsListBean newsListItem;

  const NewsItemWidget({
    Key? key,
    required this.newsListItem,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AppColors appColor = context.watch<AppTheme>().currentColors;
    bool _isNotImage = true;
    if (newsListItem.logo != null) {
      _isNotImage = newsListItem.logo!.contains('http') ||
          newsListItem.logo!.contains('https');
    }
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {
        service.router.pushNamed(RouteName.newsDetailsPage,
            arguments: {'newsId': newsListItem.id});
      },
      child: Container(
        padding: const EdgeInsets.only(bottom: 24),
        child: Row(children: [
          Expanded(
              child:  Container(
                height: 86,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Container(
                      alignment: Alignment.topLeft,
                      child: Text(
                        newsListItem.title ?? '',
                        overflow: TextOverflow.ellipsis,
                        maxLines: 3,
                        textAlign: TextAlign.start,
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: appColor.favorColor,
                            height: 22 / 16),
                      ),
                    ),

                    SizedBox(height: 4),

                    Row(
                      children: [
                        Flexible(
                          child: SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Text(
                              newsListItem.author!.isNotEmpty
                                  ? newsListItem.author ?? '--'
                                  : '--',
                              style: TextStyle(color: appColor.textColor3),
                            ),
                          ),
                        ),
                        const SizedBox(width: 8),
                        Text(
                          newsListItem.releaseStime != null
                              ? DateExtends.format(
                              newsListItem.releaseStime ?? 0 * 1000)
                              : '',
                          style: TextStyle(color: appColor.textColor3),
                        ),
                      ],
                    )
                  ],
                ),
              )),
          Visibility(
            visible: newsListItem.logo != null,
            child: SizedBox(
              width: 16,
            ),
          ),
          if (newsListItem.logo != null && _isNotImage)
            Visibility(
                visible: newsListItem.logo != '',
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: ImageFailWidget(
                    width: 86,
                    height: 86,
                    radius: 12,
                    url: newsListItem.logo ?? '',
                  ),
                ))
        ]),
      ),
    );
  }
}
