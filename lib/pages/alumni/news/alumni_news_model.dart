import 'package:wallet/data/apis/alumni_news/alumni_news_api.dart';
import 'package:wallet/data/apis/file_api.dart';
import 'package:wallet/data/bean/alumni_news/alumni_news_details_bean.dart';
import 'package:wallet/data/bean/alumni_news/alumni_news_home_banner_bean.dart';
import 'package:wallet/data/bean/alumni_news/alumni_news_home_module_bean.dart';
import 'package:wallet/data/bean/alumni_news/alumni_news_list_bean.dart';
import 'package:wd_common_package/wd_common_package.dart';

class AlumniNewsModel extends ViewModel {
  List<AlumniNewsBannerBean> _alumniNewsBanner = [];
  List<AlumniNewsModuleBean> _alumniNewsModule = [];
  List<AlumniNewsListBean> _alumniNewList = [];
  AlumniNewsDetailsBean? _alumniNewsDetails;

  bool _isUpRefresh = false;

  /// alumni news home ;
  Future<void> getAlumniNewsHome() async {
    AlumniNewsHomeApi result = await AlumniNewsHomeApi().request();
    this._alumniNewsBanner = result.alumniNewsBanner;
    this._alumniNewsModule = result.alumniNewsModule;
    notifyListeners();
  }

  List<AlumniNewsBannerBean> get alumniNewsBanner {
    return _alumniNewsBanner;
  }

  List<AlumniNewsModuleBean> get alumniNewsModule {
    return _alumniNewsModule;
  }

  List<AlumniNewsListBean> get alumniNewsList {
    return _alumniNewList;
  }

  bool get isUpRefresh {
    return _isUpRefresh;
  }

  /// alumni;
  Future<void> getAlumniNewsList(int page,int type) async {
    AlumiNewsListApi result = await AlumiNewsListApi(page: page, type:type).request();
    _alumniNewList = result.alumniNewsList;
    if (_alumniNewList.length >= result.total) {
      _isUpRefresh = false;
    } else {
      _isUpRefresh = true;
    }
    notifyListeners();
  }

  /// alumni;
  Future<void> getAlumniNewsListPage(int page, int type) async {
    AlumiNewsListApi result = await AlumiNewsListApi(page: page, type: type).request();
    _alumniNewList.addAll(result.alumniNewsList);
    if (_alumniNewList.length >= result.total) {
      _isUpRefresh = false;
    } else {
      _isUpRefresh = true;
    }
    notifyListeners();
  }

  /// 
  Future<void> getAlumniNewsDetails(int id) async {
    AlumniNewsDetailsApi result = await AlumniNewsDetailsApi(id: id).request();
    _alumniNewsDetails = result.alumniNewsDetails;
    notifyListeners();
  }

  /// 
  AlumniNewsDetailsBean? get alumniNewsDetails => _alumniNewsDetails;

  ///
  Future<String> uploadImage({
    required String filePath,
    String? account,
  }) async {
    //Token
    var result = await GetTokenApi(account: account ?? 'Slope Wallet').request();
    String fileName = filePath.substring(filePath.lastIndexOf("/") + 1, filePath.length);

    //
    final paramsResult = await GetUploadParamsApi(
      token: result.token,
      fileName: fileName,
    ).request();

    //
    final uploadResult = await UploadFileApi(
      token: result.token,
      uploadParams: paramsResult.uploadParams,
      filePath: filePath,
    ).request();

    String fileUrl = '';
    if (uploadResult.isSuccess) {
      fileUrl = paramsResult.uploadParams['remote_request_url'];
    }

    //
    return fileUrl;
  }
}
