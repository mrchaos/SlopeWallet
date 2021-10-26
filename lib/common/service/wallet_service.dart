import 'package:wallet/common/network/base/base_http.dart';
import 'package:wallet/common/service/auth_service/auth_service.dart';
import 'package:wallet/common/service/i_service.dart';
import 'package:wallet/common/service/image_service/image_service.dart';
import 'package:wallet/common/service/router_service/router_table.dart';
import 'package:wallet/common/service/svg_service/svg_service.dart';
import 'package:wd_common_package/wd_common_package.dart';


final WalletService service = WalletService();

class WalletService extends IService {

  factory WalletService() => _getInstance()!;

  static WalletService? get instance => _getInstance();
  static WalletService? _instance;

  WalletService._internal();
  static WalletService? _getInstance() {
    if(null == _instance){
      _instance = WalletService._internal();
    }
    return _instance;
  }
  
  @override
  Future<void> init() async {
    router.routeTable.addAll(RouterTable.table);
    await cache.init();
    await auth.init();
    await image.init();
    await svg.init();
  }

  final router = RouterService();
  final cache = CacheService();
  final auth = AuthService();
  final image = ImageService();
  final svg = SvgService();
}