import 'package:wallet/common/config/wallet_config.dart';
import 'package:wallet/common/network/single_protocol.dart';
import 'package:wallet/data/bean/alumni_news/alumni_news_details_bean.dart';
import 'package:wallet/data/bean/alumni_news/alumni_news_home_banner_bean.dart';
import 'package:wallet/data/bean/alumni_news/alumni_news_home_module_bean.dart';
import 'package:wallet/data/bean/alumni_news/alumni_news_list_bean.dart';
import 'package:wd_common_package/wd_common_package.dart';

class AlumniNewsHomeApi extends SingleProtocol<AlumniNewsHomeApi> {
  @override
  String get baseUrl => config.net.phpBaseUrl;

  @override
  String get api => '/api/v1/news/home_list';

  List<AlumniNewsBannerBean> _alumniNewsBanner = [];

  List<AlumniNewsBannerBean> get alumniNewsBanner => _alumniNewsBanner;

  List<AlumniNewsModuleBean> _alumniNewsModule = [];

  List<AlumniNewsModuleBean> get alumniNewsModule => _alumniNewsModule;

  /// 
  WDRequestType get method => WDRequestType.get;

  @override
  Map<String, dynamic>? get arguments => {};

  @override
  void onParse(data) {
    logger.d('newsData:$data');
    logger.d('data[data][list]:${data['data']['list']}');
    if (data['code'] == 200) {
      data['data']['list'].forEach((item) {
        _alumniNewsModule.add(AlumniNewsModuleBean.fromMap(item));
      });

      data['data']['banner'].forEach((item) {
        _alumniNewsBanner.add(AlumniNewsBannerBean.fromMap(item));
      });
    } else {
      _alumniNewsBanner = [];
      _alumniNewsModule = [];
    }
  }
}

class AlumiNewsListApi extends SingleProtocol<AlumiNewsListApi> {
  final int page;
  final int pageSize;
  final int type;
  AlumiNewsListApi({required this.page, this.pageSize = 10,required this.type });

  @override
  String get api => '/api/v1/news/list';

  List<AlumniNewsListBean> _alumniNewsList = [];
  List<AlumniNewsListBean> get alumniNewsList => _alumniNewsList;

  int _total = 0;
  int get total => _total;
  @override
  Map<String, dynamic>? get arguments => {
        "page": page,
        "pageSize": pageSize,
        "item_id": type
      };

  @override
  WDRequestType get method => WDRequestType.get;

  @override
  String get baseUrl => config.net.phpBaseUrl;

  @override
  void onParse(data) {
    if (data['code'] == 200) {
      data['data']['data'].forEach((item) {
        _alumniNewsList.add(AlumniNewsListBean.fromMap(item));
      });
      _total = data['data']['total'];
    } else {
      _alumniNewsList = [];
    }
  }
}

class AlumniNewsDetailsApi extends SingleProtocol<AlumniNewsDetailsApi> {
  late final int id;
  AlumniNewsDetailsApi({ required this.id });
  @override
  String get api => '/api/v1/news/details';

  @override
  String get baseUrl => config.net.phpBaseUrl;

  @override
  WDRequestType get method => WDRequestType.get;

  AlumniNewsDetailsBean? _alumniNewsDetails;
  AlumniNewsDetailsBean? get alumniNewsDetails => _alumniNewsDetails;


  @override
  Map<String, dynamic>? get arguments => {
    "id": id,
  };



  @override
  void onParse(data) {
    if (data['code'] == 200) {
      _alumniNewsDetails = AlumniNewsDetailsBean.fromMap(data['data']);
    } else {
      _alumniNewsDetails = null;
    }
  }

}


