  // import 'package:slope/common/apis/apis.dart';
// import 'package:slope/common/base/base_view_model.dart';

import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:wallet/data/apis/faq_detail_api.dart';
import 'package:wd_common_package/wd_common_package.dart';

class FaqDetailModel {
  int? iId = 0;
  String? sTitle = '';
  String? sDesc = '';
  String? sContent = '';

  FaqDetailModel({this.iId, this.sTitle, this.sDesc, this.sContent});

  FaqDetailModel.fromJson(Map<String, dynamic> json) {
    iId = int.parse(json["id"].toString());
    sTitle = json["title"] ?? '';
    sDesc = json["description"] ?? '';
    sContent = json["content"] ?? '';
  }
}

class FaqDetailViewModel extends ViewModel {
  // static FaqDetailViewModel of(BuildContext context) =>
  //     Provider.of(context, listen: false);

  // 
  // FaqDetailViewModel();

  FaqDetailModel? _detail;
  FaqDetailModel? get detail => _detail;
  set detail(FaqDetailModel? newValue) {
    _detail = newValue;
    notifyListeners();
  }

  ///
  bool loadFinished = false;

  Future<bool> getDetail(String id) async {
    var result = await FaqDetailApi(id: id).request();
    loadFinished = false;
    if (result.isSuccess) {
      detail = FaqDetailModel.fromJson(result.data['data']);
      loadFinished = true;
      // notifyListeners();
      return true;
    }
    loadFinished = true;
    return false;
    //
    // return slopeApi.instance.getFaqDetail(id).then((result) {
    //   loadFinished = false;
    //   if (result.isValue) {
    //     detail = FaqDetailModel.fromJson(result.asValue!.value);
    //     loadFinished = true;
    //     notifyListeners();
    //     return true;
    //   }
    //   loadFinished = true;
    //   return false;
    // });
  }
}
