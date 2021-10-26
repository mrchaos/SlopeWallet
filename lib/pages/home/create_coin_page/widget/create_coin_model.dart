import 'package:wallet/common/service/wallet_service.dart';
import 'package:wallet/utils/solana_tokens.dart';
import 'package:wallet/wallet_manager/data/wallet_entity.dart';
import 'package:wd_common_package/wd_common_package.dart';

const _CACHE_CUSTOM_COIN_KEY = 'CACHE_CUSTOM_COIN_KEY';

class CreateCoinModel extends ViewModel {
  List<CoinEntity> _solanaTokenList = [];

  /// ;
  Future<List<CoinEntity>> getSolanaToken() async {
    if (_solanaTokenList.isNotEmpty) return _solanaTokenList;
    SolanaTokenAllApi solanaTokenApi = SolanaTokenAllApi();
    var result = await solanaTokenApi.request();
    _solanaTokenList = result.solanaTokenList;
    return _solanaTokenList;
  }

  /// ;
  List<CoinEntity> findContractList = [];

  String _searchContractText = '';



  String get searchContractText => _searchContractText;

  set setFindContractText(String value) {
    _searchContractText = value;
    notifyListeners();
  }

  /// Contract
  bool get searchContractTextIsNotEmpty => _searchContractText.isNotEmpty;

  List<CoinEntity> getFindList(text) {
    findContractList =
        _solanaTokenList.where((element) => element.contractAddress == text).toList();
    return findContractList;
  }

  List<CoinEntity> get getSymoblFindList {
    if (_searchSymbolText.isNotEmpty) {
      findContractList =
          _solanaTokenList.where((element) => element.coin == _searchSymbolText).toList();
    } else {
      findContractList = [];
    }
    return findContractList;
  }

  List<CoinEntity> get getFindContractList => getFindList(_searchContractText);

  /// ;

  /// Symbol
  String _searchSymbolText = '';

  set setFindSymbolText(String value) {
    _searchSymbolText = value;
    notifyListeners();
  }


  String get searchSymbolText => _searchSymbolText;

  /// ;
  /// walletAddress: ;
  ///
  /// data: ;
  void setCacheCustomCoin({required String walletAddress, required CoinEntity data}) {
    // Map<String, dynamic>? _customCoin =
    //     service.cache.getMap(_CACHE_CUSTOM_COIN_KEY)?.isNotEmpty ?? false
    //         ? service.cache.getMap(_CACHE_CUSTOM_COIN_KEY)
    //         : {};
    // List<dynamic> _currentWalletCustomCoin = _customCoin![walletAddress] ?? [];
    /// ;
    List<dynamic> _customCoin = service.cache.getMapList(_CACHE_CUSTOM_COIN_KEY)??[];
    _customCoin.add(data.toJson());
    service.cache.setMapList(_CACHE_CUSTOM_COIN_KEY, _customCoin);

    // _currentWalletCustomCoin.add(data.toJson());
    // _customCoin[walletAddress] = _currentWalletCustomCoin;
    // // service.cache.setMap(_CACHE_CUSTOM_COIN_KEY, _customCoin);
    // service.cache.setMapList(_CACHE_CUSTOM_COIN_KEY, _customCoin);
  }

  /// ;
  List<CoinEntity> getCacheCustomCoin({required String walletAddress}) {
    List<dynamic>? _customCoinList = service.cache.getMapList(_CACHE_CUSTOM_COIN_KEY);
    List<dynamic> _currentWalletCustomCoinMap = _customCoinList ?? [];
    List<CoinEntity> _currentWalletCustomCoin =
        _currentWalletCustomCoinMap.map((e) => CoinEntity.fromJson(e)).toList();
    return _currentWalletCustomCoin;
  }

  /// ;
  ///
  void clearCacheCustomCoin() {
    service.cache.removeValue(_CACHE_CUSTOM_COIN_KEY);
  }

  // /// ;
  // void clearAppointWalletCustomCoin({required String walletAddress}) {
  //   Map<String, dynamic> _customCoinMap = service.cache.getMap(_CACHE_CUSTOM_COIN_KEY)!;
  //   if (_customCoinMap[walletAddress] == null) return;
  //   _customCoinMap.remove(walletAddress);
  //   service.cache.setMap(_CACHE_CUSTOM_COIN_KEY, _customCoinMap);
  // }
}
//
// class ContractVerify {
//   final String program;
//   final bool isInitialized;
//   final String type;
//   ContractVerify(this.program, this.isInitialized, this.type);
// }
