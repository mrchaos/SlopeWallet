import 'package:wallet/data/apis/version_control_api.dart';
import 'package:wallet/data/apis/version_info_api.dart';
import 'package:wallet/data/bean/version_control.dart';
import 'package:wd_common_package/wd_common_package.dart';

class NavigationModel extends ViewModel {
  List<VersionControlBean> _versionControlData = [];

  Future<List<VersionControlBean>> getSystemConfig() async {
    VersionControlApi result = await VersionControlApi().request();
    _versionControlData = result.versionControlData;
    return _versionControlData;
  }

  Future<VersionInfoBean?> getVersionInfo() async {
    VersionInfoApi result = await VersionInfoApi().request();
    VersionInfoBean? data = result.model;
    return data;
  }
}
