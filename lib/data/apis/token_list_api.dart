import 'package:wallet/common/network/single_protocol.dart';
import 'package:wallet/common/util/ai_json/ai_json.dart';
import 'package:wallet/wallet_manager/data/wallet_entity.dart';
import 'package:wd_common_package/wd_common_package.dart';

class TokenListApi extends SingleProtocol<TokenListApi> {
  final page;
  final size;
  TokenListApi({this.page = 1, this.size = 1000});

  List<CoinEntity>? _tokenList;

  @override
  String get api => '/slope-dex-api/slope/market/symbolList';

  List<CoinEntity> get tokenList => _tokenList ?? [];
  @override
  Map<String, dynamic>? get arguments => {
        "pageReq": {
          "page": page,
          "size": size,
        }
      };

  // CoinEntity(
  // coin: 'AKRO',
  // icon: Assets.assets_image_contract_address_akro_png,
  // contractAddress: '6WNVCuxCGJzNjmMZoKyhZJwvJ5tYpsLyAtagzYASqBoF',
  // decimals: 6,
  // isSelected: false),
  @override
  void onParse(data) {
    AiJson aiJson = AiJson(data);
    final list = aiJson.getArray('data.list');
    _tokenList = (list.map((e) {
      Map<String, dynamic> newMap = {};
      newMap['coin'] = e['baseCurrency'];
      newMap['icon'] = e['iconUrl'];
      newMap['contractAddress'] = e['baseMintAddress'];
      newMap['decimals'] = e['decimals'];
      newMap['isSelected'] = false;
      return CoinEntity.fromJson(newMap);
    })).toList();
  }

  // List<TradeHistoryBean> get tradeHistory => _tradeHistory ?? [];

  // @override
  // void onParse(data) {
  //   AiJson aiJson = AiJson(data);
  //   final list = aiJson.getArray('data.list');
  //   _tradeHistory = list.map((e) => TradeHistoryBean.fromJson(e)).toList();
  // }
}
