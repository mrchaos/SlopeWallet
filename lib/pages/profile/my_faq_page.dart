import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:wallet/common/service/wallet_service.dart';
import 'package:wallet/common/service/router_service/router_table.dart';
import 'package:wallet/generated/assets.dart';
import 'package:wallet/theme/app_theme.dart';
import 'package:wallet/widgets/alert_dialog.dart';
import 'package:wallet/widgets/button/app_back_button.dart';

import 'my_faq_list_model.dart';

class MyFaqPage extends StatefulWidget {
  @override
  _MyFaqPageState createState() => _MyFaqPageState();
}

class _MyFaqPageState extends State<MyFaqPage> {
  String _searchKey = '';
  ValueNotifier _searchNotifier = ValueNotifier(false);

  @override
  void initState() {
    super.initState();
    FaqListModel.instance.close();
  }

  // late AppTheme.of(context).currentColors AppTheme.of(context).currentColors;

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: context.read<AppTheme>().lightThemeData,
      child: ChangeNotifierProvider.value(
        value: FaqListModel.instance,
        child: Builder(
          builder: (context) {
            // AppTheme.of(context).currentColors = context.AppTheme.of(context).currentColors;
            return Scaffold(
                appBar: AppBar(
                    leading: AppBackButton(
                      color: Colors.white,
                    ),
                    title: const Text(
                      'FAQ',
                      style: TextStyle(color: Colors.white),
                    ),
                    brightness: Brightness.dark,
                    backgroundColor: (AppTheme.of(context).currentColors.darkMediumGray)),
                body: Column(
                  children: [
                    // UI
                    SearchUI(context),
                    // UI
                    ValueListenableBuilder(
                        valueListenable: _searchNotifier,
                        builder: (c, dynamic value, _) {
                          if (!value) {
                            return ContentListUI(context);
                          }
                          return SearchResultListUI(context);
                        }),
                  ],
                ));
          },
        ),
      ),
    );
  }

  //
  SearchUI(BuildContext context) {
    final prefixIconMargin = const EdgeInsets.only(left: 12, right: 8);
    final prefixIconConstraints = BoxConstraints.tightFor(
        width: 16 + prefixIconMargin.left + prefixIconMargin.right, height: 16);
    return Container(
      height: 116,
      width: MediaQuery.of(context).size.width,
      color: AppTheme.of(context).currentColors.darkMediumGray,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(
                  height: 27,
                ),
                Text(
                  'How can we help you?',
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.normal,
                      color: Colors.white),
                ),
                const SizedBox(
                  height: 15,
                ),
                Container(
                  height: 32,
                  decoration: new BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(4.0)),
                    // border: new Border.all(width: 1, color: Colors.red),
                  ),
                  alignment: Alignment.centerLeft,
                  margin: EdgeInsets.only(left: 16, right: 16),
                  child: TextField(
                    textInputAction: TextInputAction.search,
                    keyboardType: TextInputType.text,
                    textAlignVertical: TextAlignVertical.center,
                    // autofocus: true,
                    onSubmitted: (String value) {
                      _searchKey = value.trim();
                      if (0 != _searchKey.length) {
                        _searchNotifier.value = true;
                        //
                        searchWithKey(_searchKey);
                      } else {
                        _searchNotifier.value = false;
                      }
                    },
                    decoration: InputDecoration(
                      hintText: 'Search your question',
                      hintStyle:
                          TextStyle(fontSize: 14, color: AppTheme.of(context).currentColors.textColor4),
                      contentPadding:
                          kIsWeb ? EdgeInsets.only(top: 8) : EdgeInsets.all(0),
                      border: InputBorder.none,
                      floatingLabelBehavior: FloatingLabelBehavior.never,
                      prefixIconConstraints: prefixIconConstraints,
                      isDense: true,
                      prefixIcon: Container(
                        margin: prefixIconMargin,
                        child: service.svg.asset(
                          Assets.assets_svg_search_faq_svg,
                          width: 24,
                          height: 24,
                        ),
                      ),
                    ),
                  ),
                ),
                Spacer(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  var _showing = false;

  searchWithKey(String key) async {
    if (_showing) {
      await Future<void>.delayed(const Duration(seconds: 1), () async {
        if (_showing) {
          Navigator.pop(context);
        }
        requestWithKey(key);
        return;
      });
    }
    requestWithKey(key);
  }

  requestWithKey(String key) async {
    _showing = true;
    showLoadingDialog(context: context, barrierDismissible: true)
        .whenComplete(() => _showing = false);

    await FaqListModel.instance.getSearchList(key);

    if (_showing) {
      Navigator.pop(context);
    }
  }

  //
  Widget level1Directory(FaqModel model) {
    return Row(
      children: [
        Container(
          width: 4,
          height: 18,
          color: Color(0xff6E66FA),
        ),
        SizedBox(
          width: 12,
        ),

        //
        Text(
          model.sName,
          style: TextStyle(
              fontWeight: FontWeight.w700,
              fontSize: 20,
              color: AppTheme.of(context).currentColors.blackTextInFAQ),
        ),
      ],
    );
  }

  //
  Widget? level2Directory(List<FaqModel> subList) {
    return Container(
      padding: EdgeInsets.only(top: 18, bottom: 14, left: 16, right: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          //
          for (int j = 0; j < subList.length; j++) ...[
            Text(
              subList[j].sName,
              style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 16,
                  color: AppTheme.of(context).currentColors.blackTextInFAQ),
            ),

            //
            if (null != subList[j].articleList &&
                0 != subList[j].articleList.length)
              level3Directory(subList[j], subList[j].articleList),

            if (null != subList[j].articleList &&
                0 != subList[j].articleList.length)
              const SizedBox(
                height: 20,
              ),
          ],
        ],
      ),
    );
  }

  //
  Widget level3Directory(FaqModel model, List<ArticleModel> articleList) {
    int iShowCounts =
        ((articleList.length > 4 && !(model.isOpen)) ? 5 : articleList.length);
    return Container(
      padding: EdgeInsets.only(left: 16, top: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          for (int k = 0; k < iShowCounts; k++) ...[
            createFaqWidget(model, articleList.length > 4,
                k == (iShowCounts - 1), articleList[k]),
          ],
        ],
      ),
    );
  }

  Widget createFaqWidget(FaqModel faqModel, bool isExceedLimit, bool isLastOne,
      ArticleModel artModel) {
    if (isExceedLimit) {
      if (isLastOne) {
        return (faqModel.isOpen)
            ? GestureDetector(
                behavior: HitTestBehavior.opaque,
                onTap: () {
                  refreshData(faqModel);
                },
                child: Padding(
                  padding: EdgeInsets.only(bottom: 8),
                  child: Row(
                    children: [
                      service.image.asset(
                        Assets.assets_image_fold_with_arrow_png,
                      ),
                    ],
                  ),
                ),
              )
            : GestureDetector(
                behavior: HitTestBehavior.opaque,
                onTap: () {
                  refreshData(faqModel);
                },
                child: Padding(
                  padding: EdgeInsets.only(bottom: 8),
                  child: Row(
                    children: [
                      service.image.asset(
                        Assets.assets_image_more_with_arrow_png,
                      ),
                    ],
                  ),
                ),
              );
      }
    }

    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () => service.router
          .pushNamed(RouteName.myFaqDetailPage, arguments: artModel.iId),
      child: Padding(
        padding: EdgeInsets.only(bottom: 8),
        child: Text(
          artModel.sTitle,
          style: TextStyle(
              fontWeight: FontWeight.w400,
              fontSize: 14,
              height: 1.4,
              color: AppTheme.of(context).currentColors.subTextInFAQ),
        ),
      ),
    );
  }

  //
  ContentListUI(BuildContext context) {
    return Selector<FaqListModel, List<FaqModel>>(
      selector: (c, m) => m.list,
      shouldRebuild: (p, n) => true,
      builder: (context, list, _) => Expanded(
        child: ListView(
          children: [
            const SizedBox(
              height: 24,
            ),
            for (var i = 0, size = list.length; i < size; i++) ...[
              Builder(builder: (context) {
                FaqModel model = list[i];
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (1 == model.iLevel) level1Directory(model),
                    if (0 != model.subList.length)
                      level2Directory(model.subList) ?? SizedBox(),
                  ],
                );
              }),
            ],
          ],
        ),
      ),
    );
  }

  Widget NoContentWidget(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      const SizedBox(
        height: 24,
      ),
      Text(
        'Search Result',
        style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w700,
            color: AppTheme.of(context).currentColors.blackTextInFAQ),
      ),
      const SizedBox(
        height: 8,
      ),
      Text(
        '0 results for "$_searchKey"',
        style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w400,
            color: AppTheme.of(context).currentColors.textColor3),
      ),
      const SizedBox(
        height: 24,
      ),
      Expanded(
        child: Container(
          width: MediaQuery.of(context).size.width,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              service.image.asset(
                Assets.assets_image_status_empty_light_png,
                width: 80,
                height: 80,
                fit: BoxFit.scaleDown,
              ),
              const SizedBox(height: 8),
              Text(
                'No content',
                style: TextStyle(
                    color: AppTheme.of(context).currentColors.textColor2, fontSize: 12, height: 18 / 12),
              ),
              const SizedBox(height: 100),
            ],
          ),
        ),
      ),
    ]);
  }

  Widget OneResultRecord(
      ArticleSearchResultModel? model, BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {
        service.router
            .pushNamed(RouteName.myFaqDetailPage, arguments: model?.iId ?? 0);
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            model?.sTitle ?? '',
            style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: AppTheme.of(context).currentColors.blackTextInFAQ),
          ),
          const SizedBox(
            height: 16,
          ),
          Text(
            model?.sDesc ?? '',
            style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w400,
                color: AppTheme.of(context).currentColors.textColor3),
          ),
          const SizedBox(
            height: 8,
          ),
          // service.image.asset(
          //   Assets.assets_image_detail_with_arrow_png,
          //

          Row(
            children: [
              Text(
                'Detail',
                style: TextStyle(
                  color: Color(0xff6e66fa),
                  fontWeight: FontWeight.w500,

                ),
              ),

              service.svg.asset(
                  Assets.assets_svg_ic_menu_trailing_svg,
                  fit: BoxFit.scaleDown,
                width:12,
                height: 12,
                color: Color(0xff6e66fa),
              ),
            ],
          ),


          const SizedBox(
            height: 20,
          ),
        ],
      ),
    );
  }

  Widget SearchList(List<ArticleSearchResultModel> list) {
    return ListView(
      children: [
        const SizedBox(
          height: 24,
        ),
        Text(
          'Search Result',
          style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w700,
              color: AppTheme.of(context).currentColors.blackTextInFAQ),
        ),
        const SizedBox(
          height: 8,
        ),
        Text(
          '${list.length} results for "$_searchKey"',
          style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w400,
              color: AppTheme.of(context).currentColors.blackTextInFAQ),
        ),
        const SizedBox(
          height: 24,
        ),
        for (var i = 0, size = list.length; i < size; i++) ...[
          Builder(builder: (context) {
            ArticleSearchResultModel model = list[i];
            return OneResultRecord(model, context);
          })
        ],
      ],
    );
  }

  //
  SearchResultListUI(BuildContext context) {
    return Selector<FaqListModel, List<ArticleSearchResultModel>>(
      selector: (c, m) => m.resultlist,
      shouldRebuild: (p, n) => true,
      builder: (context, list, _) => Expanded(
        child: Padding(
            padding: EdgeInsets.only(left: 16, right: 16),
            child: (null == list || 0 == list.length)
                ? NoContentWidget(context)
                : SearchList(list)),
      ),
    );
  }

  // Dart，
  void refreshData(FaqModel model) {
    List<FaqModel> list = FaqListModel.instance.list;
    for (int i = 0; i < list.length; i++) {
      FaqModel modelTmp = list[i];
      if (modelTmp.iId == model.iId) {
        modelTmp.isOpen = !modelTmp.isOpen;
        setState(() {});
        return;
      }
      List<FaqModel> subList = modelTmp.subList;
      if (null != subList && 0 != subList.length) {
        for (int j = 0; j < subList.length; j++) {
          FaqModel modelSubTmp = subList[j];
          if (modelSubTmp.iId == model.iId) {
            modelSubTmp.isOpen = !modelSubTmp.isOpen;
            setState(() {});
            return;
          }
        }
      }
    }
  }
}
