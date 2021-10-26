import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:wallet/data/bean/alumni_news/alumni_news_home_module_bean.dart';
import 'package:wallet/data/bean/alumni_news/alumni_news_list_bean.dart';
import 'package:wallet/pages/alumni/news/alumni_news_model.dart';
import 'package:wallet/pages/alumni/news/alumni_news_page.dart';
import 'package:wallet/widgets/app_bar/wallet_bar.dart';

///News
class AlumniNewsListPage extends StatefulWidget {
  final int type; /// ;
  final AlumniNewsModuleBean alumniNewsListModule;

  const AlumniNewsListPage({Key? key, required this.type, required this.alumniNewsListModule})
      : super(key: key);

  @override
  _AlumniNewsListPageState createState() => _AlumniNewsListPageState();
}

class _AlumniNewsListPageState extends State<AlumniNewsListPage> {
  RefreshController _refreshController =
      RefreshController(initialRefresh: true, initialRefreshStatus: RefreshStatus.refreshing);

  @override
  void initState() {
    super.initState();
  }

  Future<void> _getNewsList(AlumniNewsModel viewModel, int _currentPage) async {
    try {
      await viewModel.getAlumniNewsList(_currentPage, widget.type);
      _refreshController.refreshCompleted();
    } catch (e) {
      _refreshController.refreshCompleted();
    }
  }

  Future<void> _getNewsListPage(AlumniNewsModel viewModel, int _currentPage) async {
    await viewModel.getAlumniNewsListPage(_currentPage,widget.type);
  }

  int _currentPage = 1;

  _onRefresh(AlumniNewsModel viewModel) async {
    setState(() {
      _currentPage = 1;
    });
    await _getNewsList(viewModel, _currentPage);
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => AlumniNewsModel(),
      child: Scaffold(
          appBar: WalletBar(title: Text(widget.alumniNewsListModule.name), showBackButton: true),
          body: Builder(builder: (BuildContext context) {
            List<AlumniNewsListBean> _alumniNewsList =
                context.watch<AlumniNewsModel>().alumniNewsList;
            bool _isUpRefresh = context.select((AlumniNewsModel vm) => vm.isUpRefresh);
            return SafeArea(
              child: SmartRefresher(
                controller: _refreshController,
                enablePullDown: true,
                enablePullUp: _isUpRefresh,
                onRefresh: () => _onRefresh(context.read<AlumniNewsModel>()),
                onLoading: () async {
                  _currentPage++;
                  await _getNewsListPage(context.read<AlumniNewsModel>(), _currentPage);
                  _refreshController.loadComplete();
                },
                child: ListView.separated(
                  padding:const  EdgeInsets.symmetric(horizontal: 24),
                  itemCount: _alumniNewsList.length,
                  itemBuilder: (BuildContext context, int index) {
                    return NewsItemWidget(
                      newsListItem: _alumniNewsList[index],
                    );
                  },
                  separatorBuilder: (BuildContext context, int index) {
                    return SizedBox(
                      height: 32,
                    );
                  },
                ),
              ),
            );
          })),
    );
  }
}
