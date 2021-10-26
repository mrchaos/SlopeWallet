import 'dart:async';
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/scheduler.dart';
import 'package:slope_solana_client/slope_solana_client.dart';
import 'package:wallet/common/config/wallet_config.dart';
import 'package:wallet/utils/solana_tokens.dart';
import 'package:wallet/wallet_manager/data/wallet_entity.dart';
import 'package:wd_common_package/wd_common_package.dart';

import 'wallet_main_model.dart';

const _kMETADATA_PROGRAM_ID = 'metaqbxxUerdq28cj1RbAWkYQm3ybzjb6a8bt518x1s';
const _kMETADATA_PREFIX = 'metadata';

/// NFT，NFT。
/// key: owner: value:nft
final sendOutNftStream =
    StreamController<MapEntry<String, MintNftInfo>>.broadcast();
final nftListSizeNotifier = ValueNotifier<int>(0);

class MintNftInfo {
  final String mint;
  final NftInfo nftInfo;

  const MintNftInfo(this.mint, this.nftInfo);
}

class NftListViewModel extends ViewModel {
  //key:wallet address ;  value: User's NFT Map
  final _ntfMap = <String, List<MintNftInfo>?>{};
  late WalletEntity _wallet;
  String _searchText = '';
  StreamSubscription? _nftSendListener;

  NftListViewModel() {
    _wallet = WalletMainModel.instance.currentWallet ?? WalletEntity();
    WalletMainModel.instance.addListener(_onWalletChange);

    _nftSendListener = sendOutNftStream.stream.listen((item) {
      var mintNftList = _ntfMap[item.key];
      if (null != mintNftList && mintNftList.isNotEmpty) {
        mintNftList.removeWhere((e) => e.mint == item.value.mint);
        //new list. update widget
        _ntfMap[item.key] = [...mintNftList];
        notifyListeners();
        refreshNftList();
      }
    });
  }

  @override
  void dispose() {
    _nftSendListener?.cancel();
    _nftSendListener = null;
    WalletMainModel.instance.removeListener(_onWalletChange);
    super.dispose();
  }

  void _onWalletChange() {
    var newWallet = WalletMainModel.instance.currentWallet ?? WalletEntity();
    if (newWallet.address == _wallet.address) return;
    _wallet = newWallet;
    notifyListeners();
    refreshNftList();
  }

  set searchText(String value) {
    _searchText = value;
    notifyListeners();
  }

  List<MintNftInfo> get mintNftList {
    var list = _ntfMap[_wallet.address] ?? [];
    if (_searchText.isNotEmpty) {
      var filters = list.where((e) =>
          e.nftInfo.name.toLowerCase().contains(_searchText.toLowerCase()));
      return filters.toList();
    }

    SchedulerBinding.instance?.addPostFrameCallback((timeStamp) {
      nftListSizeNotifier.value = list.length;
    });
    return list;
  }

  Future<List<MintNftInfo>> _getMintNftList() async {
    //todo . get owner nft List
    return [];
  }

  Future<void> refreshNftList() async {
    final walletAddress = _wallet.address;
    await _getMintNftList().then((list) {
      _ntfMap[walletAddress] = list;
      notifyListeners();
    }).catchError((e) {
      logger.d(e);
    });
  }
}
