import 'package:flutter/material.dart';
import 'package:wallet/common/service/wallet_service.dart';
import 'package:wallet/pages/alumni/activity/alumni_activity_page.dart';
import 'package:wallet/pages/alumni/news/alumni_news_page.dart';
import 'package:wallet/pages/alumni/rank/alumni_rank_page.dart';
import 'package:wallet/slope_widget/tab_bar.dart';
import 'package:wallet/theme/app_theme.dart';

import '../../main_model.dart';

class AlumniHomePage extends StatefulWidget {
  const AlumniHomePage({Key? key}) : super(key: key);

  @override
  _AlumniHomePageState createState() => _AlumniHomePageState();
}

class _AlumniHomePageState extends State<AlumniHomePage> with TickerProviderStateMixin {
  late TabController _tabController;

  Map<String, Widget> get _tabValues => {
        'Rank': AlumniRankPage(
          setTabViewScrollPhysics: (physics) {
            print(physics);
            setState(() => tabViewPhysics = physics);
          },
        ),
        'News': AlumniNewsPage(),
        'Activity': AlumniActivityPage(),
      };

  @override
  void initState() {
    super.initState();
    bool _isJumpNews = service.cache.getBool('isJumpNews') ?? false;
    _tabController = TabController(
        length: _tabValues.length,
        initialIndex: MainModel.instance.isJumpNews ? 1 : 0,
        vsync: this);
    MainModel.instance.addListener(_isJumpNewsChange);
  }

  _isJumpNewsChange() {
    if (MainModel.instance.isJumpNews) {
      _tabController = TabController(
          length: _tabValues.length,
          initialIndex: MainModel.instance.isJumpNews ? 1 : 0,
          vsync: this);
    }
  }

  ScrollPhysics tabViewPhysics = const ClampingScrollPhysics();

  @override
  Widget build(BuildContext context) {
    // SystemChrome.setEnabledSystemUIOverlays([SystemUiOverlay.top]);
    return Scaffold(
      appBar: _buildAppBar(),
      body: TabBarView(
        physics: tabViewPhysics,
        controller: _tabController,
        children: [..._tabValues.values],
      ),
      // body: [_tabValues.values],
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      toolbarHeight: 56,
      automaticallyImplyLeading: false,
      elevation: 0,
      //Appbar
      centerTitle: false,
      title: SlopeTabBar(
        controller: _tabController,
        height: 56,
        labelStyle: TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.w700,
        ),
        unselectedLabelStyle: TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.w400,
        ),
        labels: _tabValues.keys.toList(growable: false),
      ),
    );
  }
}
