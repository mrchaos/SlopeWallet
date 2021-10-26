
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:wallet/data/apis/faq_list_api.dart';
import 'package:wallet/data/apis/faq_search_api.dart';
import 'package:wd_common_package/wd_common_package.dart';

class ArticleModel {
  late int iId = 0;
  late String sTitle = '';

  ArticleModel({this.iId =0, this.sTitle = ''});

  ArticleModel.fromJson(dynamic json) {
    iId = int.parse(json["id"].toString());
    sTitle = json["title"];
  }
}

class ArticleSearchResultModel {
  late int iId = 0;
  late String sTitle = '';
  late String sDesc = '';

  ArticleSearchResultModel.fromJson(dynamic json) {
    iId = int.parse(json["id"].toString());
    sTitle = json["title"];
    sDesc = json["description"];
  }
}

class FaqModel {
  int iId = 0;
  int iPid = 0;
  String sName = '';
  int iSort = 0;
  int iLevel = 0;
  List<FaqModel> subList = [];
  List subListTmp = [];
  List<ArticleModel> articleList = [];
  List articleListTmp = [];

  //
  bool isOpen = false;

  FaqModel.fromJson(dynamic json) {
    iId = int.parse(json["id"].toString());
    iPid = int.parse(json["pid"].toString());
    sName = json["name"] ?? '';
    iSort = int.parse(json["sort"].toString());
    iLevel = int.parse(json["leave"].toString());
    subListTmp = json["children"] ?? [];
    articleListTmp = json["article_list"] ?? [];
    isOpen = false;
  }
}

class FaqListModel extends ViewModel {
  static FaqListModel of(BuildContext context) =>
      Provider.of(context, listen: false);

  static FaqListModel? _instance;

  FaqListModel._();

  static FaqListModel get instance {
    _instance ??= FaqListModel._()..getFaqList();
    return _instance!;
  }


  //
  List<FaqModel>? _list;

  List<FaqModel> get list => _list ?? [];

  set list(List<FaqModel> list) {
    _list = list;
    notifyListeners();
  }

  //
  List<ArticleModel> dealArticleList(List list) {
    if (null == list || 0 == list.length) return [];
    List<ArticleModel> artList = [];
    for (int i = 0; i < list.length; i++) {
      var Tmp = list[i];
      ArticleModel model = ArticleModel.fromJson(Tmp);
      artList.add(model);
    }

    // article4，()
    if (4 < list.length) artList.add(ArticleModel());

    return artList;
  }

  // close
  close () {
    dealClose(this.list);
  }

  dealClose (List? list) {
    if (null == list || 0 == list.length) return;
    for (int i = 0; i < list.length; i++) {
      FaqModel? model = list[i];
      if (null != model) model.isOpen = false;
      if (null != model && null != model.subList) dealClose(model.subList);
    }
  }


  //
  List<FaqModel> dealFaqList(List? list) {
    if (null == list || 0 == list.length) return [];
    List<FaqModel> totalList = [];
    for (int i = 0; i < list.length; i++) {
      var Tmp = list[i];
      print('FaqListModel.dealFaqList $Tmp');
      FaqModel? model = FaqModel.fromJson(Tmp);
      if ((null != model.subListTmp) &&
          (model.subListTmp is List) &&
          (0 != model.subListTmp.length)) {
        model.subList = dealFaqList(model.subListTmp);
      }
      if ((null != model.articleListTmp) &&
          (model.articleListTmp is List) &&
          (0 != model.articleListTmp.length)) {
        model.articleList = dealArticleList(model.articleListTmp);
      }
      totalList.add(model);
    }
    return totalList;
  }

  //
  Future<bool> getFaqList() async {

    var result = await FaqListApi().request();
    if (null == _list) _list = [];
    _list!.clear();
    if (result.isSuccess) {
      final json = result.data['data'];
      List list = json['list'];
      this.list = dealFaqList(list);
    }
    return result.isSuccess;

  }

  ////////////////////////////////////////
  //
  List<ArticleSearchResultModel>? _resultlist;

  ////////////////////////////////////////
  List<ArticleSearchResultModel> get resultlist => _resultlist ?? [];

  ////////////////////////////////////////
  set resultlist(List<ArticleSearchResultModel>? resultlist) {
    _resultlist = resultlist;
    notifyListeners();
  }

  //
  Future<bool> getSearchList(String key) async {

  var result =  await FaqSearchApi(keyword: key).request();

  // ，，
  if (null == _resultlist) _resultlist = [];
  _resultlist!.clear();
  if (result.isSuccess) {
    final json = result.data['data'];
    List list = json['list'];
    List<ArticleSearchResultModel> tempList = [];
    for (int i = 0; i < list.length; i++) {
      dynamic json = list[i];
      ArticleSearchResultModel model =
      ArticleSearchResultModel.fromJson(json);
      tempList.add(model);
    }
    this.resultlist = [...tempList];
  }
  return result.isSuccess;

  }
}
