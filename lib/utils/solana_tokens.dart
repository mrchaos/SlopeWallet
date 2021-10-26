import 'package:wallet/common/network/cache_protocol.dart';
import 'package:wallet/common/network/single_protocol.dart';
import 'package:wallet/data/bean/solana_token_entity.dart';
import 'package:wallet/generated/json/base/json_convert_content.dart';
import 'package:wallet/wallet_manager/data/wallet_entity.dart';

///SolanaToken。
class SolanaTokenApi extends CacheProtocol<SolanaTokenApi> {
  @override
  String get api => '/gh/solana-labs/token-list@main/src/tokens/solana.tokenlist.json';

  @override
  String get baseUrl => 'https://cdn.jsdelivr.net';

  // List<CoinEntity> _solanaTokenList = [];
  //
  // List<CoinEntity> get solanaTokenList => _solanaTokenList;

  ///
  @override
  WDRequestType get method => WDRequestType.get;

  @override
  void onParse(respData) {
    SolanaTokenEntity solanaToken = JsonConvert.fromJsonAsT<SolanaTokenEntity>(respData);
    if (solanaToken.tokens.isNotEmpty) {
      SOLANA_TOKENS = solanaToken.tokens.map((e) {
        return e.toJson();
      }).toList();
    }
  }
}
class SolanaTokenAllApi extends SingleProtocol<SolanaTokenAllApi> {
  @override
  String get api => '/gh/solana-labs/token-list@main/src/tokens/solana.tokenlist.json';

  @override
  String get baseUrl => 'https://cdn.jsdelivr.net';

  ///
  @override
  WDRequestType get method => WDRequestType.get;

  List<CoinEntity> _solanaTokenList = [];

  List<CoinEntity> get solanaTokenList => _solanaTokenList;

  @override
  void onParse(respData) {
    List<Map<String, dynamic>> _solanaTokensAll = [];

    /// 103
    ///
    /// 101
    /// ;
    SOLANA_TOKENS.removeWhere((element) => element['chainId'] == 103);
    if (respData != null) {
      _solanaTokensAll = SOLANA_TOKENS;
    } else {
      _solanaTokensAll = SOLANA_TOKENS;
    }
    _solanaTokenList = (_solanaTokensAll.map((e) {
      Map<String, dynamic> newMap = {};
      newMap['coin'] = e['symbol'];
      newMap['icon'] = e['logoURI'];
      newMap['contractAddress'] = e['address'];
      newMap['decimals'] = e['decimals'];
      newMap['isSelected'] = false;
      return CoinEntity.fromJson(newMap);
    })).toList();
  }
}

List<Map<String, dynamic>> SOLANA_TOKENS = [
  {
    "chainId": 101,
    "address": "2uRFEWRBQLEKpLmF8mohFZGDcFQmrkQEEZmHQvMUBvY7",
    "symbol": "SLB",
    "name": "Solberg",
    "decimals": 2,
    "logoURI":
        "https://raw.githubusercontent.com/solana-labs/token-list/main/assets/mainnet/2uRFEWRBQLEKpLmF8mohFZGDcFQmrkQEEZmHQvMUBvY7/logo.svg",
    "tags": [],
    "extensions": {
      "website": "https://www.solbergtoken.com/",
      "telegram": "https://t.me/solbergofficial",
      "twitter": "https://twitter.com/SolbergToken",
      "discord": "https://discord.gg/2w7J25Xgce",
      "instagram": "https://www.instagram.com/solbergtoken/"
    }
  },
  {
    "chainId": 101,
    "address": "HDLRMKW1FDz2q5Zg778CZx26UgrtnqpUDkNNJHhmVUFr",
    "symbol": "MILLI",
    "name": "MILLIONSY",
    "decimals": 9,
    "logoURI":
        "https://raw.githubusercontent.com/millionsy/token-list/main/assets/mainnet/HDLRMKW1FDz2q5Zg778CZx26UgrtnqpUDkNNJHhmVUFr/logo.png",
    "tags": [],
    "extensions": {
      "website": "https://www.millionsy.io/",
      "telegram": "https://t.me/MILLIONSYofficialchat",
      "twitter": "https://twitter.com/MILLIONSYio"
    }
  },
  {
    "chainId": 101,
    "address": "7ic3cSqD6iiwsqxDyBbcs2qYfMcKY2HndLDrjhMKZ4cQ",
    "symbol": "\$SOLY",
    "name": "Solana Yield",
    "decimals": 8,
    "logoURI":
        "https://github.com/saimaliabrish/Solana-yield-logo/blob/main/IMG_20210923_195019_436.png",
    "tags": [],
    "extensions": {"twitter": "https://twitter.com/AbrishSaim"}
  },
  {
    "chainId": 101,
    "address": "99pifp4v4qQNk3irTHpmAEEzgKfs3ahLE7iFKEqfyxPj",
    "symbol": "ZI",
    "name": "ZI (The Z Institute Token)",
    "decimals": 6,
    "logoURI":
        "https://raw.githubusercontent.com/solana-labs/token-list/main/assets/mainnet/99pifp4v4qQNk3irTHpmAEEzgKfs3ahLE7iFKEqfyxPj/logo.png",
    "tags": ["utility-token"],
    "extensions": {
      "website": "https://zinstitute.net/",
      "twitter": "https://twitter.com/the_z_institute"
    }
  },
  {
    "chainId": 101,
    "address": "FYfQ9uaRaYvRiaEGUmct45F9WKam3BYXArTrotnTNFXF",
    "symbol": "SOLA",
    "name": "Sola Token",
    "decimals": 9,
    "logoURI":
        "https://raw.githubusercontent.com/solana-labs/token-list/main/assets/mainnet/FYfQ9uaRaYvRiaEGUmct45F9WKam3BYXArTrotnTNFXF/logo.png",
    "tags": ["Solana tokenized", "Solana Community token"],
    "extensions": {
      "website": "https://solatoken.net/",
      "telegram": "https://t.me/solatokennet",
      "twitter": "https://twitter.com/EcoSolana",
      "serumV3Usdc": "4RZ27tjRnSwrtRqsJxDEgsERnDKFs7yx6Ra3HsJvkboy",
      "coingeckoId": "sola-token"
    }
  },
  {
    "chainId": 101,
    "address": "So11111111111111111111111111111111111111112",
    "symbol": "SOL",
    "name": "Wrapped SOL",
    "decimals": 9,
    "logoURI":
        "https://raw.githubusercontent.com/solana-labs/token-list/main/assets/mainnet/So11111111111111111111111111111111111111112/logo.png",
    "tags": [],
    "extensions": {
      "website": "https://solana.com/",
      "serumV3Usdc": "9wFFyRfZBsuAha4YcuxcXLKwMxJR43S7fPfQLusDBzvT",
      "serumV3Usdt": "HWHvQhFmJB3NUcu1aihKmrKegfVxBEHzwVX6yZCKEsi1",
      "coingeckoId": "solana"
    }
  },
  {
    "chainId": 101,
    "address": "EPjFWdd5AufqSSqeM2qN1xzybapC8G4wEGGkZwyTDt1v",
    "symbol": "USDC",
    "name": "USD Coin",
    "decimals": 6,
    "logoURI":
        "https://raw.githubusercontent.com/solana-labs/token-list/main/assets/mainnet/EPjFWdd5AufqSSqeM2qN1xzybapC8G4wEGGkZwyTDt1v/logo.png",
    "tags": ["stablecoin"],
    "extensions": {
      "website": "https://www.centre.io/",
      "coingeckoId": "usd-coin",
      "serumV3Usdt": "77quYg4MGneUdjgXCunt9GgM1usmrxKY31twEy3WHwcS"
    }
  },
  {
    "chainId": 101,
    "address": "2inRoG4DuMRRzZxAt913CCdNZCu2eGsDD9kZTrsj2DAZ",
    "symbol": "TSLA",
    "name": "Tesla Inc.",
    "decimals": 8,
    "logoURI":
        "https://raw.githubusercontent.com/solana-labs/token-list/main/assets/mainnet/2inRoG4DuMRRzZxAt913CCdNZCu2eGsDD9kZTrsj2DAZ/logo.svg",
    "tags": ["tokenized-stock"],
    "extensions": {"website": "https://www.digitalassets.ag/UnderlyingDetails?TSLA"}
  },
  {
    "chainId": 101,
    "address": "8bpRdBGPt354VfABL5xugP3pmYZ2tQjzRcqjg2kmwfbF",
    "symbol": "AAPL",
    "name": "Apple Inc.",
    "decimals": 8,
    "logoURI":
        "https://raw.githubusercontent.com/solana-labs/token-list/main/assets/mainnet/8bpRdBGPt354VfABL5xugP3pmYZ2tQjzRcqjg2kmwfbF/logo.svg",
    "tags": ["tokenized-stock"],
    "extensions": {"website": "https://www.digitalassets.ag/UnderlyingDetails?AAPL"}
  },
  {
    "chainId": 101,
    "address": "3vhcrQfEn8ashuBfE82F3MtEDFcBCEFfFw1ZgM3xj1s8",
    "symbol": "MSFT",
    "name": "Microsoft Corporation",
    "decimals": 8,
    "logoURI":
        "https://raw.githubusercontent.com/solana-labs/token-list/main/assets/mainnet/3vhcrQfEn8ashuBfE82F3MtEDFcBCEFfFw1ZgM3xj1s8/logo.svg",
    "tags": ["tokenized-stock"],
    "extensions": {"website": "https://www.digitalassets.ag/UnderlyingDetails?MSFT"}
  },
  {
    "chainId": 101,
    "address": "HNXTQPd5FkGX7USMufrxkvUQkTGmNFxVYCnAhuR941mm",
    "symbol": "DOWIT",
    "name": "DOWIT",
    "decimals": 8,
    "logoURI":
        "https://raw.githubusercontent.com/solana-labs/token-list/main/assets/mainnet/HNXTQPd5FkGX7USMufrxkvUQkTGmNFxVYCnAhuR941mm/logo.png",
    "tags": [],
    "extensions": {"website": "https://dowit-coin.com"}
  },
  {
    "chainId": 101,
    "address": "4R8DBzZEzjBQzPJe4qqaxXM97am7unGM1ZYfviS6oSFe",
    "symbol": "ANU",
    "name": "ANUBEAST",
    "decimals": 8,
    "logoURI": "https://raw.githubusercontent.com/ANUBEAST/ANUBEAST/master/assets/logo.png",
    "tags": ["stake"],
    "extensions": {"website": "https://github.com/ANUBEAST"}
  },
  {
    "chainId": 101,
    "address": "ASwYCbLedk85mRdPnkzrUXbbYbwe26m71af9rzrhC2Qz",
    "symbol": "MSTR",
    "name": "MicroStrategy Incorporated.",
    "decimals": 8,
    "logoURI":
        "https://raw.githubusercontent.com/solana-labs/token-list/main/assets/mainnet/ASwYCbLedk85mRdPnkzrUXbbYbwe26m71af9rzrhC2Qz/logo.svg",
    "tags": ["tokenized-stock"],
    "extensions": {"website": "https://www.digitalassets.ag/UnderlyingDetails?MSTR"}
  },
  {
    "chainId": 101,
    "address": "J25jdsEgTnAwB4nVq3dEQhwekbXCnVTGzFpVMPScXRgK",
    "symbol": "COIN",
    "name": "Coinbase Global Inc.",
    "decimals": 8,
    "logoURI":
        "https://raw.githubusercontent.com/solana-labs/token-list/main/assets/mainnet/J25jdsEgTnAwB4nVq3dEQhwekbXCnVTGzFpVMPScXRgK/logo.svg",
    "tags": ["tokenized-stock"],
    "extensions": {"website": "https://www.digitalassets.ag/UnderlyingDetails?COIN"}
  },
  {
    "chainId": 101,
    "address": "G2Cg4XoXdEJT5sfrSy9N6YCC3uuVV3AoTQSvMeSqT8ZV",
    "symbol": "ABC",
    "name": "AmerisourceBergen Corp",
    "decimals": 8,
    "logoURI":
        "https://raw.githubusercontent.com/solana-labs/token-list/main/assets/mainnet/G2Cg4XoXdEJT5sfrSy9N6YCC3uuVV3AoTQSvMeSqT8ZV/logo.svg",
    "tags": ["tokenized-stock"],
    "extensions": {"website": "https://www.digitalassets.ag/UnderlyingDetails?ABC"}
  },
  {
    "chainId": 101,
    "address": "FqqVanFZosh4M4zqxzWUmEnky6nVANjghiSLaGqUAYGi",
    "symbol": "ABNB",
    "name": "Airbnb",
    "decimals": 8,
    "logoURI":
        "https://raw.githubusercontent.com/solana-labs/token-list/main/assets/mainnet/FqqVanFZosh4M4zqxzWUmEnky6nVANjghiSLaGqUAYGi/logo.svg",
    "tags": ["tokenized-stock"],
    "extensions": {"website": "https://www.digitalassets.ag/UnderlyingDetails?ABNB"}
  },
  {
    "chainId": 101,
    "address": "FgcUo7Ymua8r5xxsn9puizkLGN5w4i3nnBmasXvkcWfJ",
    "symbol": "ACB",
    "name": "Aurora Cannabis Inc",
    "decimals": 8,
    "logoURI":
        "https://raw.githubusercontent.com/solana-labs/token-list/main/assets/mainnet/FgcUo7Ymua8r5xxsn9puizkLGN5w4i3nnBmasXvkcWfJ/logo.svg",
    "tags": ["tokenized-stock"],
    "extensions": {"website": "https://www.digitalassets.ag/UnderlyingDetails?ACB"}
  },
  {
    "chainId": 101,
    "address": "FenmUGWjsW5AohtHRbgLoPUZyWSK36Cd5a31XJWjnRur",
    "symbol": "AMC",
    "name": "AMC Entertainment Holdings",
    "decimals": 8,
    "logoURI":
        "https://raw.githubusercontent.com/solana-labs/token-list/main/assets/mainnet/FenmUGWjsW5AohtHRbgLoPUZyWSK36Cd5a31XJWjnRur/logo.svg",
    "tags": ["tokenized-stock"],
    "extensions": {"website": "https://www.digitalassets.ag/UnderlyingDetails?AMC"}
  },
  {
    "chainId": 101,
    "address": "7grgNP3tAJh7DRELmotHzC5Efth4e4SoBvgmFYTX9jPB",
    "symbol": "AMD",
    "name": "Advanced Micro Devices",
    "decimals": 8,
    "logoURI":
        "https://raw.githubusercontent.com/solana-labs/token-list/main/assets/mainnet/7grgNP3tAJh7DRELmotHzC5Efth4e4SoBvgmFYTX9jPB/logo.svg",
    "tags": ["tokenized-stock"],
    "extensions": {"website": "https://www.digitalassets.ag/UnderlyingDetails?AMD"}
  },
  {
    "chainId": 101,
    "address": "3bjpzTTK49eP8m1bYxw6HYAFGtzyWjvEyGYcFS4gbRAx",
    "symbol": "AMZN",
    "name": "Amazon",
    "decimals": 8,
    "logoURI":
        "https://raw.githubusercontent.com/solana-labs/token-list/main/assets/mainnet/3bjpzTTK49eP8m1bYxw6HYAFGtzyWjvEyGYcFS4gbRAx/logo.svg",
    "tags": ["tokenized-stock"],
    "extensions": {"website": "https://www.digitalassets.ag/UnderlyingDetails?AMZN"}
  },
  {
    "chainId": 101,
    "address": "4cr7NH1BD2PMV38JQp58UaHUxzqhxeSiF7b6q1GCS7Ae",
    "symbol": "APHA",
    "name": "Aphria Inc",
    "decimals": 8,
    "logoURI":
        "https://raw.githubusercontent.com/solana-labs/token-list/main/assets/mainnet/4cr7NH1BD2PMV38JQp58UaHUxzqhxeSiF7b6q1GCS7Ae/logo.svg",
    "tags": ["tokenized-stock"],
    "extensions": {"website": "https://www.digitalassets.ag/UnderlyingDetails?APHA"}
  },
  {
    "chainId": 101,
    "address": "GPoBx2hycDs3t4Q8DeBme9RHb9nQpzH3a36iUoojHe16",
    "symbol": "ARKK",
    "name": "ARK Innovation ETF",
    "decimals": 8,
    "logoURI":
        "https://raw.githubusercontent.com/solana-labs/token-list/main/assets/mainnet/GPoBx2hycDs3t4Q8DeBme9RHb9nQpzH3a36iUoojHe16/logo.png",
    "tags": ["tokenized-stock"],
    "extensions": {"website": "https://www.digitalassets.ag/UnderlyingDetails?ARKK"}
  },
  {
    "chainId": 101,
    "address": "GgDDCnzZGQRUDy8jWqSqDDcPwAVg2YsKZfLPaTYBWdWt",
    "symbol": "BABA",
    "name": "Alibaba",
    "decimals": 8,
    "logoURI":
        "https://raw.githubusercontent.com/solana-labs/token-list/main/assets/mainnet/GgDDCnzZGQRUDy8jWqSqDDcPwAVg2YsKZfLPaTYBWdWt/logo.svg",
    "tags": ["tokenized-stock"],
    "extensions": {"website": "https://www.digitalassets.ag/UnderlyingDetails?BABA"}
  },
  {
    "chainId": 101,
    "address": "6jSgnmu8yg7kaZRWp5MtQqNrWTUDk7KWXhZhJPmsQ65y",
    "symbol": "BB",
    "name": "BlackBerry",
    "decimals": 8,
    "logoURI":
        "https://raw.githubusercontent.com/solana-labs/token-list/main/assets/mainnet/6jSgnmu8yg7kaZRWp5MtQqNrWTUDk7KWXhZhJPmsQ65y/logo.svg",
    "tags": ["tokenized-stock"],
    "extensions": {"website": "https://www.digitalassets.ag/UnderlyingDetails?BB"}
  },
  {
    "chainId": 101,
    "address": "9Vovr1bqDbMQ8DyaizdC7n1YVvSia8r3PQ1RcPFqpQAs",
    "symbol": "BILI",
    "name": "Bilibili Inc",
    "decimals": 8,
    "logoURI":
        "https://raw.githubusercontent.com/solana-labs/token-list/main/assets/mainnet/9Vovr1bqDbMQ8DyaizdC7n1YVvSia8r3PQ1RcPFqpQAs/logo.svg",
    "tags": ["tokenized-stock"],
    "extensions": {"website": "https://www.digitalassets.ag/UnderlyingDetails?BILI"}
  },
  {
    "chainId": 101,
    "address": "j35qY1SbQ3k7b2WAR5cNETDKzDESxGnYbArsLNRUzg2",
    "symbol": "BITW",
    "name": "Bitwise 10 Crypto Index Fund",
    "decimals": 8,
    "logoURI":
        "https://raw.githubusercontent.com/solana-labs/token-list/main/assets/mainnet/j35qY1SbQ3k7b2WAR5cNETDKzDESxGnYbArsLNRUzg2/logo.png",
    "tags": ["tokenized-stock"],
    "extensions": {"website": "https://www.digitalassets.ag/UnderlyingDetails?BITW"}
  },
  {
    "chainId": 101,
    "address": "AykRYHVEERRoKGzfg2AMTqEFGmCGk9LNnGv2k5FgjKVB",
    "symbol": "BNTX",
    "name": "BioNTech",
    "decimals": 8,
    "logoURI":
        "https://raw.githubusercontent.com/solana-labs/token-list/main/assets/mainnet/AykRYHVEERRoKGzfg2AMTqEFGmCGk9LNnGv2k5FgjKVB/logo.png",
    "tags": ["tokenized-stock"],
    "extensions": {"website": "https://www.digitalassets.ag/UnderlyingDetails?BNTX"}
  },
  {
    "chainId": 101,
    "address": "Dj76V3vdFGGE8444NWFACR5qmtJrrSop5RCBAGbC88nr",
    "symbol": "BRKA",
    "name": "Berkshire Hathaway Inc",
    "decimals": 8,
    "logoURI":
        "https://raw.githubusercontent.com/solana-labs/token-list/main/assets/mainnet/Dj76V3vdFGGE8444NWFACR5qmtJrrSop5RCBAGbC88nr/logo.png",
    "tags": ["tokenized-stock"],
    "extensions": {"website": "https://www.digitalassets.ag/UnderlyingDetails?BRKA"}
  },
  {
    "chainId": 101,
    "address": "8TUg3Kpa4pNfaMvgyFdvwyiPBSnyTx7kK5EDfb42N6VK",
    "symbol": "BYND",
    "name": "Beyond Meat Inc",
    "decimals": 8,
    "logoURI":
        "https://raw.githubusercontent.com/solana-labs/token-list/main/assets/mainnet/8TUg3Kpa4pNfaMvgyFdvwyiPBSnyTx7kK5EDfb42N6VK/logo.svg",
    "tags": ["tokenized-stock"],
    "extensions": {"website": "https://www.digitalassets.ag/UnderlyingDetails?BYND"}
  },
  {
    "chainId": 101,
    "address": "8FyEsMuDWAMMusMqVEstt2sDkMvcUKsTy1gF6oMfWZcG",
    "symbol": "CGC",
    "name": "Canopy Growth Corp",
    "decimals": 8,
    "logoURI":
        "https://raw.githubusercontent.com/solana-labs/token-list/main/assets/mainnet/8FyEsMuDWAMMusMqVEstt2sDkMvcUKsTy1gF6oMfWZcG/logo.svg",
    "tags": ["tokenized-stock"],
    "extensions": {"website": "https://www.digitalassets.ag/UnderlyingDetails?CGC"}
  },
  {
    "chainId": 101,
    "address": "DUFVbhWf7FsUo3ouMnFbDjv4YYaRE1Sz9jvAmDsNTt1m",
    "symbol": "CRON",
    "name": "Chronos Group Inc",
    "decimals": 8,
    "logoURI":
        "https://raw.githubusercontent.com/solana-labs/token-list/main/assets/mainnet/DUFVbhWf7FsUo3ouMnFbDjv4YYaRE1Sz9jvAmDsNTt1m/logo.svg",
    "tags": ["tokenized-stock"],
    "extensions": {"website": "https://www.digitalassets.ag/UnderlyingDetails?CRON"}
  },
  {
    "chainId": 101,
    "address": "J9GVpBChXZ8EK7JuPsLSDV17BF9KLJweBQet3L6ZWvTC",
    "symbol": "EEM",
    "name": "iShares MSCI Emerging Markets ETF",
    "decimals": 8,
    "logoURI":
        "https://raw.githubusercontent.com/solana-labs/token-list/main/assets/mainnet/J9GVpBChXZ8EK7JuPsLSDV17BF9KLJweBQet3L6ZWvTC/logo.svg",
    "tags": ["tokenized-stock"],
    "extensions": {"website": "https://www.digitalassets.ag/UnderlyingDetails?EEM"}
  },
  {
    "chainId": 101,
    "address": "6Xj2NzAW437UUomaxFiVyJQPGvvup6YLeXFQpp4kqNaD",
    "symbol": "EFA",
    "name": "iShares MSCI EAFE ETF",
    "decimals": 8,
    "logoURI":
        "https://raw.githubusercontent.com/solana-labs/token-list/main/assets/mainnet/6Xj2NzAW437UUomaxFiVyJQPGvvup6YLeXFQpp4kqNaD/logo.svg",
    "tags": ["tokenized-stock"],
    "extensions": {"website": "https://www.digitalassets.ag/UnderlyingDetails?EFA"}
  },
  {
    "chainId": 101,
    "address": "5YMFoVuoQzdivpm6W97UGKkHxq6aEhipuNkA8imPDoa1",
    "symbol": "ETHE",
    "name": "Grayscale Ethereum Trust",
    "decimals": 8,
    "logoURI":
        "https://raw.githubusercontent.com/solana-labs/token-list/main/assets/mainnet/5YMFoVuoQzdivpm6W97UGKkHxq6aEhipuNkA8imPDoa1/logo.png",
    "tags": ["tokenized-stock"],
    "extensions": {"website": "https://www.digitalassets.ag/UnderlyingDetails?ETHE"}
  },
  {
    "chainId": 101,
    "address": "C9vMZBz1UCmYSCmMcZFw6N9AsYhXDAWnuhxd8ygCA1Ah",
    "symbol": "EWA",
    "name": "iShares MSCI Australia ETF",
    "decimals": 8,
    "logoURI":
        "https://raw.githubusercontent.com/solana-labs/token-list/main/assets/mainnet/C9vMZBz1UCmYSCmMcZFw6N9AsYhXDAWnuhxd8ygCA1Ah/logo.svg",
    "tags": ["tokenized-stock"],
    "extensions": {"website": "https://www.digitalassets.ag/UnderlyingDetails?EWA"}
  },
  {
    "chainId": 101,
    "address": "AcXn3WXPARC7r5JwrkPHSUmBGWyWx1vRydNHXXvgc8V6",
    "symbol": "EWJ",
    "name": "iShares MSCI Japan ETF",
    "decimals": 8,
    "logoURI":
        "https://raw.githubusercontent.com/solana-labs/token-list/main/assets/mainnet/AcXn3WXPARC7r5JwrkPHSUmBGWyWx1vRydNHXXvgc8V6/logo.svg",
    "tags": ["tokenized-stock"],
    "extensions": {"website": "https://www.digitalassets.ag/UnderlyingDetails?EWJ"}
  },
  {
    "chainId": 101,
    "address": "8ihxfcxBZ7dZyfnpXJiGrgEZfrKWbZUk6LjfosLrQfR",
    "symbol": "EWY",
    "name": "iShares MSCI South Korea ETF",
    "decimals": 8,
    "logoURI":
        "https://raw.githubusercontent.com/solana-labs/token-list/main/assets/mainnet/8ihxfcxBZ7dZyfnpXJiGrgEZfrKWbZUk6LjfosLrQfR/logo.svg",
    "tags": ["tokenized-stock"],
    "extensions": {"website": "https://www.digitalassets.ag/UnderlyingDetails?EWY"}
  },
  {
    "chainId": 101,
    "address": "N5ykto2MU7CNcLX7sgWFe3M2Vpy7wq8gDt2sVNDe6aH",
    "symbol": "EWZ",
    "name": "iShares MSCI Brazil ETF",
    "decimals": 8,
    "logoURI":
        "https://raw.githubusercontent.com/solana-labs/token-list/main/assets/mainnet/N5ykto2MU7CNcLX7sgWFe3M2Vpy7wq8gDt2sVNDe6aH/logo.svg",
    "tags": ["tokenized-stock"],
    "extensions": {"website": "https://www.digitalassets.ag/UnderlyingDetails?EWZ"}
  },
  {
    "chainId": 101,
    "address": "3K9pfJzKiAm9upcyDWk5NBVdjxVtqXN8sVfQ4aR6qwb2",
    "symbol": "FB",
    "name": "Facebook",
    "decimals": 8,
    "logoURI":
        "https://raw.githubusercontent.com/solana-labs/token-list/main/assets/mainnet/3K9pfJzKiAm9upcyDWk5NBVdjxVtqXN8sVfQ4aR6qwb2/logo.svg",
    "tags": ["tokenized-stock"],
    "extensions": {"website": "https://www.digitalassets.ag/UnderlyingDetails?FB"}
  },
  {
    "chainId": 101,
    "address": "Ege7FzfrrBSusVQrRUuTiFVCSc8u2R9fRWh4qLjdNYfz",
    "symbol": "FXI",
    "name": "iShares China Large-Cap ETF",
    "decimals": 8,
    "logoURI":
        "https://raw.githubusercontent.com/solana-labs/token-list/main/assets/mainnet/Ege7FzfrrBSusVQrRUuTiFVCSc8u2R9fRWh4qLjdNYfz/logo.svg",
    "tags": ["tokenized-stock"],
    "extensions": {"website": "https://www.digitalassets.ag/UnderlyingDetails?FXI"}
  },
  {
    "chainId": 101,
    "address": "FiV4TtDtnjaf8m8vw2a7uc9hRoFvvu9Ft7GzxiMujn3t",
    "symbol": "GBTC",
    "name": "Grayscale Bitcoin Trust",
    "decimals": 8,
    "logoURI":
        "https://raw.githubusercontent.com/solana-labs/token-list/main/assets/mainnet/FiV4TtDtnjaf8m8vw2a7uc9hRoFvvu9Ft7GzxiMujn3t/logo.png",
    "tags": ["tokenized-stock"],
    "extensions": {"website": "https://www.digitalassets.ag/UnderlyingDetails?GBTC"}
  },
  {
    "chainId": 101,
    "address": "7FYk6a91TiFWigBvCf8KbuEMyyfpqET5QHFkRtiD2XxF",
    "symbol": "GDX",
    "name": "VanEck Vectors Gold Miners Etf",
    "decimals": 8,
    "logoURI":
        "https://raw.githubusercontent.com/solana-labs/token-list/main/assets/mainnet/7FYk6a91TiFWigBvCf8KbuEMyyfpqET5QHFkRtiD2XxF/logo.svg",
    "tags": ["tokenized-stock"],
    "extensions": {"website": "https://www.digitalassets.ag/UnderlyingDetails?GDX"}
  },
  {
    "chainId": 101,
    "address": "EGhhk4sHgY1SBYsgkfgyGNhAKBXqn6QyKNx7W13evx9D",
    "symbol": "GDXJ",
    "name": "VanEck Vectors Junior Gold Miners Etf",
    "decimals": 8,
    "logoURI":
        "https://raw.githubusercontent.com/solana-labs/token-list/main/assets/mainnet/EGhhk4sHgY1SBYsgkfgyGNhAKBXqn6QyKNx7W13evx9D/logo.svg",
    "tags": ["tokenized-stock"],
    "extensions": {"website": "https://www.digitalassets.ag/UnderlyingDetails?GDXJ"}
  },
  {
    "chainId": 101,
    "address": "9HyU5EEyPvkxeuekNUwsHzmMCJoiw8FZBGWaNih2oux1",
    "symbol": "GLD",
    "name": "SPDR Gold Shares",
    "decimals": 8,
    "logoURI":
        "https://raw.githubusercontent.com/solana-labs/token-list/main/assets/mainnet/9HyU5EEyPvkxeuekNUwsHzmMCJoiw8FZBGWaNih2oux1/logo.png",
    "tags": ["tokenized-stock"],
    "extensions": {"website": "https://www.digitalassets.ag/UnderlyingDetails?GLD"}
  },
  {
    "chainId": 101,
    "address": "EYLa7susWhzqDNKYe7qLhFHb3Y9kdNwThc6QSnc4TLWN",
    "symbol": "GLXY",
    "name": "Galaxy Digital Holdings",
    "decimals": 8,
    "logoURI":
        "https://raw.githubusercontent.com/solana-labs/token-list/main/assets/mainnet/EYLa7susWhzqDNKYe7qLhFHb3Y9kdNwThc6QSnc4TLWN/logo.png",
    "tags": ["tokenized-stock"],
    "extensions": {"website": "https://www.digitalassets.ag/UnderlyingDetails?GLXY"}
  },
  {
    "chainId": 101,
    "address": "Ac2wmyujRxiGtb5msS7fKzGycaCF7K8NbVs5ortE6MFo",
    "symbol": "GME",
    "name": "GameStop",
    "decimals": 8,
    "logoURI":
        "https://raw.githubusercontent.com/solana-labs/token-list/main/assets/mainnet/Ac2wmyujRxiGtb5msS7fKzGycaCF7K8NbVs5ortE6MFo/logo.svg",
    "tags": ["tokenized-stock"],
    "extensions": {"website": "https://www.digitalassets.ag/UnderlyingDetails?GME"}
  },
  {
    "chainId": 101,
    "address": "7uzWUPC6XsWkgFAuDjpZgPVH9p3WqeKTvTJqLM1RXX6w",
    "symbol": "GOOGL",
    "name": "Google",
    "decimals": 8,
    "logoURI":
        "https://raw.githubusercontent.com/solana-labs/token-list/main/assets/mainnet/7uzWUPC6XsWkgFAuDjpZgPVH9p3WqeKTvTJqLM1RXX6w/logo.svg",
    "tags": ["tokenized-stock"],
    "extensions": {"website": "https://www.digitalassets.ag/UnderlyingDetails?GOOGL"}
  },
  {
    "chainId": 101,
    "address": "XJUMvw7KRLoLCYVD727jV9fjNUSDVcZaQUK6XpY6kGm",
    "symbol": "IF",
    "name": "Impossible Finance",
    "decimals": 9,
    "logoURI":
        "https://gateway.pinata.cloud/ipfs/QmcfMbNuvDV6ho3fueNPFTtgSruaUBmSdqP5D5ZduipN6S/logo.png",
    "tags": ["ethereum"],
    "extensions": {"website": "https://impossible.finance", "coingeckoId": "impossible-finance"}
  },
  {
    "chainId": 101,
    "address": "CnLLrX9A8RhKpq8Z3CKko7sQMqN2AXj8AfFyxxoBBEFf",
    "symbol": "CH",
    "name": "COIN HUNTER",
    "decimals": 8,
    "logoURI":
        "https://raw.githubusercontent.com/solana-labs/token-list/main/assets/mainnet/CnLLrX9A8RhKpq8Z3CKko7sQMqN2AXj8AfFyxxoBBEFf/logo.png",
    "tags": [],
    "extensions": {"website": "https://bit.ly/Coin-Hunter"}
  },
  {
    "chainId": 101,
    "address": "CB3obConLVWpo8RtTANzBSURmJnAVgy5xznvQfWXDfpR",
    "symbol": "PURITY",
    "name": "PURITY",
    "decimals": 9,
    "logoURI":
        "https://raw.githubusercontent.com/solana-labs/token-list/main/assets/mainnet/CB3obConLVWpo8RtTANzBSURmJnAVgy5xznvQfWXDfpR/logo.png",
    "tags": [],
    "extensions": {"website": "https://github.com/teampurity"}
  },
  {
    "chainId": 101,
    "address": "GkDg1ZfoFkroLAwLqtJNXhxCDg8gmKxHAGxSUZagYFfE",
    "symbol": "SOL100",
    "name": "SOL100",
    "decimals": 9,
    "logoURI":
        "https://raw.githubusercontent.com/solana-labs/token-list/main/assets/mainnet/GkDg1ZfoFkroLAwLqtJNXhxCDg8gmKxHAGxSUZagYFfE/logo.png",
    "tags": [],
    "extensions": {"website": "https://github.com/teampurity"}
  },
  {
    "chainId": 101,
    "address": "5E2742iZRZgZF94bfz39NgV9wjppe24YrQJVu6niLPMA",
    "symbol": "GPA",
    "name": "GALAXY PANDA",
    "decimals": 8,
    "logoURI":
        "https://raw.githubusercontent.com/solana-labs/token-list/main/assets/mainnet/5E2742iZRZgZF94bfz39NgV9wjppe24YrQJVu6niLPMA/logo.png",
    "tags": [],
    "extensions": {"website": "http://galaxypanda.space"}
  },
  {
    "chainId": 101,
    "address": "4oyFkXQhvvDFa8cvShR4zwhYJ1RfhRzQjVAx1wemmjs6",
    "symbol": "GRU",
    "name": "GURU",
    "decimals": 9,
    "logoURI":
        "https://raw.githubusercontent.com/solana-labs/token-list/main/assets/mainnet/4oyFkXQhvvDFa8cvShR4zwhYJ1RfhRzQjVAx1wemmjs6/logo.png",
    "tags": [],
    "extensions": {"website": "https://solanaguru.web.app"}
  },
  {
    "chainId": 101,
    "address": "4796pBun8ihiecy4unZuLWoSVRmK8sf7yQMbwkkvZDH3",
    "symbol": "BLOK",
    "name": "BLOCITIES",
    "decimals": 9,
    "logoURI":
        "https://raw.githubusercontent.com/solana-labs/token-list/main/assets/mainnet/4796pBun8ihiecy4unZuLWoSVRmK8sf7yQMbwkkvZDH3/logo.png",
    "tags": [],
    "extensions": {"website": "https://blocities.finance"}
  },
  {
    "chainId": 101,
    "address": "C4kmKzQ8o6NAP8pToERJF6C7V4PjCVE3o2oSrp24f5GP",
    "symbol": "CERCr",
    "name": "Elemento6",
    "decimals": 9,
    "logoURI":
        "https://raw.githubusercontent.com/solana-labs/token-list/main/assets/mainnet/C4kmKzQ8o6NAP8pToERJF6C7V4PjCVE3o2oSrp24f5GP/logo.png",
    "tags": ["Elemento6", "Carbon Emission Reduction Credit", "Respectful Development Foundation"],
    "extensions": {"website": "https://respectfuldevelopmentpanama.com"}
  },
  {
    "chainId": 101,
    "address": "6CuCUCYovcLxwaKuxWm8uTquVKGWaAydcFEU3NrtvxGZ",
    "symbol": "INTC",
    "name": "Intel Corp",
    "decimals": 8,
    "logoURI":
        "https://raw.githubusercontent.com/solana-labs/token-list/main/assets/mainnet/6CuCUCYovcLxwaKuxWm8uTquVKGWaAydcFEU3NrtvxGZ/logo.svg",
    "tags": ["tokenized-stock"],
    "extensions": {"website": "https://www.digitalassets.ag/UnderlyingDetails?INTC"}
  },
  {
    "chainId": 101,
    "address": "iVNcrNE9BRZBC9Aqf753iZiZfbszeAVUoikgT9yvr2a",
    "symbol": "IVN",
    "name": "Investin Protocol",
    "decimals": 6,
    "logoURI":
        "https://raw.githubusercontent.com/solana-labs/token-list/main/assets/mainnet/iVNcrNE9BRZBC9Aqf753iZiZfbszeAVUoikgT9yvr2a/logo.png",
    "tags": ["DeFi", "Fund Management"],
    "extensions": {
      "website": "https://www.investin.pro/",
      "serumV3Usdc": "AdmfUBJ64BTsjaZdtu1iQHAtxJ4Ge7Zw5bNMsrLGdZu7",
      "coingeckoId": "investin",
      "medium": "https://medium.com/investin-pro",
      "twitter": "https://twitter.com/Investin_pro",
      "discord": "https://discord.com/invite/Yf54h9B",
      "telegram": "https://t.me/Investin_pro1"
    }
  },
  {
    "chainId": 101,
    "address": "6H26K637YNAjZycRosvBR3ENKFGMsbr4xmoV7ca83GWf",
    "symbol": "JUST",
    "name": "Just Group PLC",
    "decimals": 8,
    "logoURI":
        "https://raw.githubusercontent.com/solana-labs/token-list/main/assets/mainnet/6H26K637YNAjZycRosvBR3ENKFGMsbr4xmoV7ca83GWf/logo.png",
    "tags": ["tokenized-stock"],
    "extensions": {"website": "https://www.digitalassets.ag/UnderlyingDetails?JUST"}
  },
  {
    "chainId": 101,
    "address": "FFRtWiE8FT7HMf673r9cmpabHVQfa2QEf4rSRwNo4JM3",
    "symbol": "MRNA",
    "name": "Moderna",
    "decimals": 8,
    "logoURI":
        "https://raw.githubusercontent.com/solana-labs/token-list/main/assets/mainnet/FFRtWiE8FT7HMf673r9cmpabHVQfa2QEf4rSRwNo4JM3/logo.svg",
    "tags": ["tokenized-stock"],
    "extensions": {"website": "https://www.digitalassets.ag/UnderlyingDetails?MRNA"}
  },
  {
    "chainId": 101,
    "address": "Hfbh3GU8AdYCw4stirFy2RPGtwQbbzToG2DgFozAymUb",
    "symbol": "NFLX",
    "name": "Netflix",
    "decimals": 8,
    "logoURI":
        "https://raw.githubusercontent.com/solana-labs/token-list/main/assets/mainnet/Hfbh3GU8AdYCw4stirFy2RPGtwQbbzToG2DgFozAymUb/logo.svg",
    "tags": ["tokenized-stock"],
    "extensions": {"website": "https://www.digitalassets.ag/UnderlyingDetails?NFLX"}
  },
  {
    "chainId": 101,
    "address": "56Zwe8Crm4pXvmByCxmGDjYrLPxkenTrckdRM7WG3zQv",
    "symbol": "NIO",
    "name": "Nio",
    "decimals": 8,
    "logoURI":
        "https://raw.githubusercontent.com/solana-labs/token-list/main/assets/mainnet/56Zwe8Crm4pXvmByCxmGDjYrLPxkenTrckdRM7WG3zQv/logo.svg",
    "tags": ["tokenized-stock"],
    "extensions": {"website": "https://www.digitalassets.ag/UnderlyingDetails?NIO"}
  },
  {
    "chainId": 101,
    "address": "HP9WMRDV3KdUfJ7CNn5Wf8JzLczwxdnQYTHDAa9yCSnq",
    "symbol": "NOK",
    "name": "Nokia",
    "decimals": 8,
    "logoURI":
        "https://raw.githubusercontent.com/solana-labs/token-list/main/assets/mainnet/HP9WMRDV3KdUfJ7CNn5Wf8JzLczwxdnQYTHDAa9yCSnq/logo.svg",
    "tags": ["tokenized-stock"],
    "extensions": {"website": "https://www.digitalassets.ag/UnderlyingDetails?NOK"}
  },
  {
    "chainId": 101,
    "address": "GpM58T33eTrGEdHmeFnSVksJjJT6JVdTvim59ipTgTNh",
    "symbol": "NVDA",
    "name": "NVIDIA",
    "decimals": 8,
    "logoURI":
        "https://raw.githubusercontent.com/solana-labs/token-list/main/assets/mainnet/GpM58T33eTrGEdHmeFnSVksJjJT6JVdTvim59ipTgTNh/logo.svg",
    "tags": ["tokenized-stock"],
    "extensions": {"website": "https://www.digitalassets.ag/UnderlyingDetails?NVDA"}
  },
  {
    "chainId": 101,
    "address": "CRCop5kHBDLTYJyG7z3u6yiVQi4FQHbyHdtb18Qh2Ta9",
    "symbol": "PENN",
    "name": "Penn National Gaming",
    "decimals": 8,
    "logoURI":
        "https://raw.githubusercontent.com/solana-labs/token-list/main/assets/mainnet/CRCop5kHBDLTYJyG7z3u6yiVQi4FQHbyHdtb18Qh2Ta9/logo.svg",
    "tags": ["tokenized-stock"],
    "extensions": {"website": "https://www.digitalassets.ag/UnderlyingDetails?PENN"}
  },
  {
    "chainId": 101,
    "address": "97v2oXMQ2MMAkgUnoQk3rNhrZCRThorYhvz1poAe9stk",
    "symbol": "PFE",
    "name": "Pfizer",
    "decimals": 8,
    "logoURI":
        "https://raw.githubusercontent.com/solana-labs/token-list/main/assets/mainnet/97v2oXMQ2MMAkgUnoQk3rNhrZCRThorYhvz1poAe9stk/logo.svg",
    "tags": ["tokenized-stock"],
    "extensions": {"website": "https://www.digitalassets.ag/UnderlyingDetails?PFE"}
  },
  {
    "chainId": 101,
    "address": "AwutBmwmhehaMh18CxqFPPN311uCB1M2awp68A2bG41v",
    "symbol": "PYPL",
    "name": "PayPal",
    "decimals": 8,
    "logoURI":
        "https://raw.githubusercontent.com/solana-labs/token-list/main/assets/mainnet/AwutBmwmhehaMh18CxqFPPN311uCB1M2awp68A2bG41v/logo.svg",
    "tags": ["tokenized-stock"],
    "extensions": {"website": "https://www.digitalassets.ag/UnderlyingDetails?PYPL"}
  },
  {
    "chainId": 101,
    "address": "8Sa7BjogSJnkHyhtRTKNDDTDtASnWMcAsD4ySVNSFu27",
    "symbol": "SLV",
    "name": "iShares Silver Trust",
    "decimals": 8,
    "logoURI":
        "https://raw.githubusercontent.com/solana-labs/token-list/main/assets/mainnet/8Sa7BjogSJnkHyhtRTKNDDTDtASnWMcAsD4ySVNSFu27/logo.svg",
    "tags": ["tokenized-stock"],
    "extensions": {"website": "https://www.digitalassets.ag/UnderlyingDetails?SLV"}
  },
  {
    "chainId": 101,
    "address": "CS4tNS523VCLiTsGnYEAd6GqfrZNLtA14C98DC6gE47g",
    "symbol": "SPY",
    "name": "SPDR S&P 500 ETF",
    "decimals": 8,
    "logoURI":
        "https://raw.githubusercontent.com/solana-labs/token-list/main/assets/mainnet/CS4tNS523VCLiTsGnYEAd6GqfrZNLtA14C98DC6gE47g/logo.svg",
    "tags": ["tokenized-stock"],
    "extensions": {"website": "https://www.digitalassets.ag/UnderlyingDetails?SPY"}
  },
  {
    "chainId": 101,
    "address": "BLyrWJuDyYnDaUMxqBMqkDYAeajnyode1ARh7TxtakEh",
    "symbol": "SQ",
    "name": "Square",
    "decimals": 8,
    "logoURI":
        "https://raw.githubusercontent.com/solana-labs/token-list/main/assets/mainnet/BLyrWJuDyYnDaUMxqBMqkDYAeajnyode1ARh7TxtakEh/logo.svg",
    "tags": ["tokenized-stock"],
    "extensions": {"website": "https://www.digitalassets.ag/UnderlyingDetails?SQ"}
  },
  {
    "chainId": 101,
    "address": "HSDepE3xvbyRDx4M11LX7Hf9qgHSopfTXxAoeatCcwWF",
    "symbol": "SUN",
    "name": "Sunoco LP",
    "decimals": 8,
    "logoURI":
        "https://raw.githubusercontent.com/solana-labs/token-list/main/assets/mainnet/HSDepE3xvbyRDx4M11LX7Hf9qgHSopfTXxAoeatCcwWF/logo.svg",
    "tags": ["tokenized-stock"],
    "extensions": {"website": "https://www.digitalassets.ag/UnderlyingDetails?SUN"}
  },
  {
    "chainId": 101,
    "address": "LZufgu7ekMcWBUypPMBYia2ipnFzpxpZgRBFLhYswgR",
    "symbol": "TLRY",
    "name": "Tilray Inc",
    "decimals": 8,
    "logoURI":
        "https://raw.githubusercontent.com/solana-labs/token-list/main/assets/mainnet/LZufgu7ekMcWBUypPMBYia2ipnFzpxpZgRBFLhYswgR/logo.svg",
    "tags": ["tokenized-stock"],
    "extensions": {"website": "https://www.digitalassets.ag/UnderlyingDetails?TLRY"}
  },
  {
    "chainId": 101,
    "address": "2iCUKaCQpGvnaBimLprKWT8bNGF92e6LxWq4gjsteWfx",
    "symbol": "TSM",
    "name": "Taiwan Semiconductor Mfg",
    "decimals": 8,
    "logoURI":
        "https://raw.githubusercontent.com/solana-labs/token-list/main/assets/mainnet/2iCUKaCQpGvnaBimLprKWT8bNGF92e6LxWq4gjsteWfx/logo.svg",
    "tags": ["tokenized-stock"],
    "extensions": {"website": "https://www.digitalassets.ag/UnderlyingDetails?TSM"}
  },
  {
    "chainId": 101,
    "address": "BZMg4HyyHVUJkwh2yuv6duu4iQUaXRxT6sK1dT7FcaZf",
    "symbol": "TUR",
    "name": "iShares MSCI Turkey ETF",
    "decimals": 8,
    "logoURI":
        "https://raw.githubusercontent.com/solana-labs/token-list/main/assets/mainnet/BZMg4HyyHVUJkwh2yuv6duu4iQUaXRxT6sK1dT7FcaZf/logo.svg",
    "tags": ["tokenized-stock"],
    "extensions": {"website": "https://www.digitalassets.ag/UnderlyingDetails?TUR"}
  },
  {
    "chainId": 101,
    "address": "C2tNm8bMU5tz6KdXjHY5zewsN1Wv1TEbxK9XGTCgUZMJ",
    "symbol": "TWTR",
    "name": "Twitter",
    "decimals": 8,
    "logoURI":
        "https://raw.githubusercontent.com/solana-labs/token-list/main/assets/mainnet/C2tNm8bMU5tz6KdXjHY5zewsN1Wv1TEbxK9XGTCgUZMJ/logo.svg",
    "tags": ["tokenized-stock"],
    "extensions": {"website": "https://www.digitalassets.ag/UnderlyingDetails?TWTR"}
  },
  {
    "chainId": 101,
    "address": "4kmVbBDCzYam3S4e9XqKQkLCEz16gu3dTTo65KbhShuv",
    "symbol": "UBER",
    "name": "Uber",
    "decimals": 8,
    "logoURI":
        "https://raw.githubusercontent.com/solana-labs/token-list/main/assets/mainnet/4kmVbBDCzYam3S4e9XqKQkLCEz16gu3dTTo65KbhShuv/logo.svg",
    "tags": ["tokenized-stock"],
    "extensions": {"website": "https://www.digitalassets.ag/UnderlyingDetails?UBER"}
  },
  {
    "chainId": 101,
    "address": "J645gMdx9zSMM2VySLBrtv6Zv1HyEjPqQXVGRAPYqzvK",
    "symbol": "USO",
    "name": "United States Oil Fund",
    "decimals": 8,
    "logoURI":
        "https://raw.githubusercontent.com/solana-labs/token-list/main/assets/mainnet/J645gMdx9zSMM2VySLBrtv6Zv1HyEjPqQXVGRAPYqzvK/logo.svg",
    "tags": ["tokenized-stock"],
    "extensions": {"website": "https://www.digitalassets.ag/UnderlyingDetails?USO"}
  },
  {
    "chainId": 101,
    "address": "3LjkoC9FYEqRKNpy7xz3nxfnGVAt1SNS98rYwF2adQWB",
    "symbol": "VXX",
    "name": "iPath B S&P 500 VIX S/T Futs ETN",
    "decimals": 8,
    "logoURI":
        "https://raw.githubusercontent.com/solana-labs/token-list/main/assets/mainnet/3LjkoC9FYEqRKNpy7xz3nxfnGVAt1SNS98rYwF2adQWB/logo.png",
    "tags": ["tokenized-stock"],
    "extensions": {"website": "https://www.digitalassets.ag/UnderlyingDetails?VXX"}
  },
  {
    "chainId": 101,
    "address": "BcALTCjD4HJJxBDUXi3nHUgqsJmXAQdBbQrcmtLtqZaf",
    "symbol": "ZM",
    "name": "Zoom",
    "decimals": 8,
    "logoURI":
        "https://raw.githubusercontent.com/solana-labs/token-list/main/assets/mainnet/BcALTCjD4HJJxBDUXi3nHUgqsJmXAQdBbQrcmtLtqZaf/logo.svg",
    "tags": ["tokenized-stock"],
    "extensions": {"website": "https://www.digitalassets.ag/UnderlyingDetails?ZM"}
  },
  {
    "chainId": 101,
    "address": "9n4nbM75f5Ui33ZbPYXn59EwSgE8CGsHtAeTH5YFeJ9E",
    "symbol": "BTC",
    "name": "Wrapped Bitcoin (Sollet)",
    "decimals": 6,
    "logoURI":
        "https://raw.githubusercontent.com/solana-labs/token-list/main/assets/mainnet/9n4nbM75f5Ui33ZbPYXn59EwSgE8CGsHtAeTH5YFeJ9E/logo.png",
    "tags": ["wrapped-sollet", "ethereum"],
    "extensions": {
      "bridgeContract": "https://etherscan.io/address/0xeae57ce9cc1984f202e15e038b964bb8bdf7229a",
      "serumV3Usdc": "A8YFbxQYFVqKZaoYJLLUVcQiWP7G2MeEgW5wsAQgMvFw",
      "serumV3Usdt": "C1EuT9VokAKLiW7i2ASnZUvxDoKuKkCpDDeNxAptuNe4",
      "coingeckoId": "bitcoin"
    }
  },
  {
    "chainId": 101,
    "address": "2FPyTwcZLUg1MDrwsyoP4D6s1tM7hAkHYRjkNb5w6Pxk",
    "symbol": "ETH",
    "name": "Wrapped Ethereum (Sollet)",
    "decimals": 6,
    "logoURI":
        "https://raw.githubusercontent.com/solana-labs/token-list/main/assets/mainnet/2FPyTwcZLUg1MDrwsyoP4D6s1tM7hAkHYRjkNb5w6Pxk/logo.png",
    "tags": ["wrapped-sollet", "ethereum"],
    "extensions": {
      "bridgeContract": "https://etherscan.io/address/0xeae57ce9cc1984f202e15e038b964bb8bdf7229a",
      "serumV3Usdc": "4tSvZvnbyzHXLMTiFonMyxZoHmFqau1XArcRCVHLZ5gX",
      "serumV3Usdt": "7dLVkUfBVfCGkFhSXDCq1ukM9usathSgS716t643iFGF",
      "coingeckoId": "ethereum"
    }
  },
  {
    "chainId": 101,
    "address": "3JSf5tPeuscJGtaCp5giEiDhv51gQ4v3zWg8DGgyLfAB",
    "symbol": "YFI",
    "name": "Wrapped YFI (Sollet)",
    "decimals": 6,
    "logoURI":
        "https://raw.githubusercontent.com/solana-labs/token-list/main/assets/mainnet/3JSf5tPeuscJGtaCp5giEiDhv51gQ4v3zWg8DGgyLfAB/logo.png",
    "tags": ["wrapped-sollet", "ethereum"],
    "extensions": {
      "bridgeContract": "https://etherscan.io/address/0xeae57ce9cc1984f202e15e038b964bb8bdf7229a",
      "serumV3Usdc": "7qcCo8jqepnjjvB5swP4Afsr3keVBs6gNpBTNubd1Kr2",
      "serumV3Usdt": "3Xg9Q4VtZhD4bVYJbTfgGWFV5zjE3U7ztSHa938zizte",
      "coingeckoId": "yearn-finance"
    }
  },
  {
    "chainId": 101,
    "address": "CWE8jPTUYhdCTZYWPTe1o5DFqfdjzWKc9WKz6rSjQUdG",
    "symbol": "LINK",
    "name": "Wrapped Chainlink (Sollet)",
    "decimals": 6,
    "logoURI":
        "https://raw.githubusercontent.com/solana-labs/token-list/main/assets/mainnet/CWE8jPTUYhdCTZYWPTe1o5DFqfdjzWKc9WKz6rSjQUdG/logo.png",
    "tags": ["wrapped-sollet", "ethereum"],
    "extensions": {
      "bridgeContract": "https://etherscan.io/address/0xeae57ce9cc1984f202e15e038b964bb8bdf7229a",
      "serumV3Usdc": "3hwH1txjJVS8qv588tWrjHfRxdqNjBykM1kMcit484up",
      "serumV3Usdt": "3yEZ9ZpXSQapmKjLAGKZEzUNA1rcupJtsDp5mPBWmGZR",
      "coingeckoId": "chainlink"
    }
  },
  {
    "chainId": 101,
    "address": "Ga2AXHpfAF6mv2ekZwcsJFqu7wB4NV331qNH7fW9Nst8",
    "symbol": "XRP",
    "name": "Wrapped XRP (Sollet)",
    "decimals": 6,
    "logoURI":
        "https://raw.githubusercontent.com/solana-labs/token-list/main/assets/mainnet/Ga2AXHpfAF6mv2ekZwcsJFqu7wB4NV331qNH7fW9Nst8/logo.png",
    "tags": ["wrapped-sollet", "ethereum"],
    "extensions": {
      "bridgeContract": "https://etherscan.io/address/0xeae57ce9cc1984f202e15e038b964bb8bdf7229a",
      "coingeckoId": "ripple"
    }
  },
  {
    "chainId": 101,
    "address": "BQcdHdAQW1hczDbBi9hiegXAR7A98Q9jx3X3iBBBDiq4",
    "symbol": "wUSDT",
    "name": "Wrapped USDT (Sollet)",
    "decimals": 6,
    "logoURI":
        "https://raw.githubusercontent.com/solana-labs/token-list/main/assets/mainnet/BQcdHdAQW1hczDbBi9hiegXAR7A98Q9jx3X3iBBBDiq4/logo.png",
    "tags": ["stablecoin", "wrapped-sollet", "ethereum"],
    "extensions": {
      "bridgeContract": "https://etherscan.io/address/0xeae57ce9cc1984f202e15e038b964bb8bdf7229a",
      "coingeckoId": "tether"
    }
  },
  {
    "chainId": 101,
    "address": "AR1Mtgh7zAtxuxGd2XPovXPVjcSdY3i4rQYisNadjfKy",
    "symbol": "SUSHI",
    "name": "Wrapped SUSHI (Sollet)",
    "decimals": 6,
    "logoURI":
        "https://raw.githubusercontent.com/solana-labs/token-list/main/assets/mainnet/AR1Mtgh7zAtxuxGd2XPovXPVjcSdY3i4rQYisNadjfKy/logo.png",
    "tags": ["wrapped-sollet", "ethereum"],
    "extensions": {
      "website": "https://www.sushi.com",
      "bridgeContract": "https://etherscan.io/address/0xeae57ce9cc1984f202e15e038b964bb8bdf7229a",
      "serumV3Usdc": "A1Q9iJDVVS8Wsswr9ajeZugmj64bQVCYLZQLra2TMBMo",
      "serumV3Usdt": "6DgQRTpJTnAYBSShngAVZZDq7j9ogRN1GfSQ3cq9tubW",
      "coingeckoId": "sushi",
      "waterfallbot": "https://bit.ly/SUSHIwaterfall"
    }
  },
  {
    "chainId": 101,
    "address": "CsZ5LZkDS7h9TDKjrbL7VAwQZ9nsRu8vJLhRYfmGaN8K",
    "symbol": "ALEPH",
    "name": "Wrapped ALEPH (Sollet)",
    "decimals": 6,
    "logoURI":
        "https://raw.githubusercontent.com/solana-labs/token-list/main/assets/mainnet/CsZ5LZkDS7h9TDKjrbL7VAwQZ9nsRu8vJLhRYfmGaN8K/logo.png",
    "tags": ["wrapped-sollet", "ethereum"],
    "extensions": {
      "bridgeContract": "https://etherscan.io/address/0xeae57ce9cc1984f202e15e038b964bb8bdf7229a",
      "serumV3Usdc": "GcoKtAmTy5QyuijXSmJKBtFdt99e6Buza18Js7j9AJ6e",
      "serumV3Usdt": "Gyp1UGRgbrb6z8t7fpssxEKQgEmcJ4pVnWW3ds2p6ZPY",
      "coingeckoId": "aleph"
    }
  },
  {
    "chainId": 101,
    "address": "SF3oTvfWzEP3DTwGSvUXRrGTvr75pdZNnBLAH9bzMuX",
    "symbol": "SXP",
    "name": "Wrapped SXP (Sollet)",
    "decimals": 6,
    "logoURI":
        "https://raw.githubusercontent.com/solana-labs/token-list/main/assets/mainnet/SF3oTvfWzEP3DTwGSvUXRrGTvr75pdZNnBLAH9bzMuX/logo.png",
    "tags": ["wrapped-sollet", "ethereum"],
    "extensions": {
      "bridgeContract": "https://etherscan.io/address/0xeae57ce9cc1984f202e15e038b964bb8bdf7229a",
      "serumV3Usdc": "4LUro5jaPaTurXK737QAxgJywdhABnFAMQkXX4ZyqqaZ",
      "serumV3Usdt": "8afKwzHR3wJE7W7Y5hvQkngXh6iTepSZuutRMMy96MjR",
      "coingeckoId": "swipe"
    }
  },
  {
    "chainId": 101,
    "address": "BtZQfWqDGbk9Wf2rXEiWyQBdBY1etnUUn6zEphvVS7yN",
    "symbol": "HGET",
    "name": "Wrapped Hedget (Sollet)",
    "decimals": 6,
    "logoURI":
        "https://raw.githubusercontent.com/solana-labs/token-list/main/assets/mainnet/BtZQfWqDGbk9Wf2rXEiWyQBdBY1etnUUn6zEphvVS7yN/logo.svg",
    "tags": ["wrapped-sollet", "ethereum"],
    "extensions": {
      "website": "https://www.hedget.com/",
      "bridgeContract": "https://etherscan.io/address/0xeae57ce9cc1984f202e15e038b964bb8bdf7229a",
      "serumV3Usdc": "88vztw7RTN6yJQchVvxrs6oXUDryvpv9iJaFa1EEmg87",
      "serumV3Usdt": "ErQXxiNfJgd4fqQ58PuEw5xY35TZG84tHT6FXf5s4UxY",
      "coingeckoId": "hedget"
    }
  },
  {
    "chainId": 101,
    "address": "5Fu5UUgbjpUvdBveb3a1JTNirL8rXtiYeSMWvKjtUNQv",
    "symbol": "CREAM",
    "name": "Wrapped Cream Finance (Sollet)",
    "decimals": 6,
    "logoURI":
        "https://raw.githubusercontent.com/solana-labs/token-list/main/assets/mainnet/5Fu5UUgbjpUvdBveb3a1JTNirL8rXtiYeSMWvKjtUNQv/logo.png",
    "tags": ["wrapped-sollet", "ethereum"],
    "extensions": {
      "bridgeContract": "https://etherscan.io/address/0xeae57ce9cc1984f202e15e038b964bb8bdf7229a",
      "serumV3Usdc": "7nZP6feE94eAz9jmfakNJWPwEKaeezuKKC5D1vrnqyo2",
      "serumV3Usdt": "4ztJEvQyryoYagj2uieep3dyPwG2pyEwb2dKXTwmXe82",
      "coingeckoId": "cream-2"
    }
  },
  {
    "chainId": 101,
    "address": "873KLxCbz7s9Kc4ZzgYRtNmhfkQrhfyWGZJBmyCbC3ei",
    "symbol": "UBXT",
    "name": "Wrapped Upbots (Sollet)",
    "decimals": 6,
    "logoURI":
        "https://raw.githubusercontent.com/solana-labs/token-list/main/assets/mainnet/873KLxCbz7s9Kc4ZzgYRtNmhfkQrhfyWGZJBmyCbC3ei/logo.png",
    "tags": ["wrapped-sollet", "ethereum"],
    "extensions": {
      "website": "https://upbots.com/",
      "explorer": "https://etherscan.io/address/0xeae57ce9cc1984f202e15e038b964bb8bdf7229a",
      "serumV3Usdc": "2wr3Ab29KNwGhtzr5HaPCyfU1qGJzTUAN4amCLZWaD1H",
      "serumV3Usdt": "F1T7b6pnR8Pge3qmfNUfW6ZipRDiGpMww6TKTrRU4NiL",
      "coingeckoId": "upbots"
    }
  },
  {
    "chainId": 101,
    "address": "HqB7uswoVg4suaQiDP3wjxob1G5WdZ144zhdStwMCq7e",
    "symbol": "HNT",
    "name": "Wrapped Helium (Sollet)",
    "decimals": 6,
    "logoURI":
        "https://raw.githubusercontent.com/solana-labs/token-list/main/assets/mainnet/HqB7uswoVg4suaQiDP3wjxob1G5WdZ144zhdStwMCq7e/logo.png",
    "tags": ["wrapped-sollet", "ethereum"],
    "extensions": {
      "bridgeContract": "https://etherscan.io/address/0xeae57ce9cc1984f202e15e038b964bb8bdf7229a",
      "serumV3Usdc": "CnUV42ZykoKUnMDdyefv5kP6nDSJf7jFd7WXAecC6LYr",
      "serumV3Usdt": "8FpuMGLtMZ7Wt9ZvyTGuTVwTwwzLYfS5NZWcHxbP1Wuh",
      "coingeckoId": "helium"
    }
  },
  {
    "chainId": 101,
    "address": "9S4t2NEAiJVMvPdRYKVrfJpBafPBLtvbvyS3DecojQHw",
    "symbol": "FRONT",
    "name": "Wrapped FRONT (Sollet)",
    "decimals": 6,
    "logoURI":
        "https://raw.githubusercontent.com/solana-labs/token-list/main/assets/mainnet/9S4t2NEAiJVMvPdRYKVrfJpBafPBLtvbvyS3DecojQHw/logo.png",
    "tags": ["wrapped-sollet", "ethereum"],
    "extensions": {
      "bridgeContract": "https://etherscan.io/address/0xeae57ce9cc1984f202e15e038b964bb8bdf7229a",
      "serumV3Usdc": "9Zx1CvxSVdroKMMWf2z8RwrnrLiQZ9VkQ7Ex3syQqdSH",
      "serumV3Usdt": "CGC4UgWwqA9PET6Tfx6o6dLv94EK2coVkPtxgNHuBtxj",
      "coingeckoId": "frontier-token"
    }
  },
  {
    "chainId": 101,
    "address": "6WNVCuxCGJzNjmMZoKyhZJwvJ5tYpsLyAtagzYASqBoF",
    "symbol": "AKRO",
    "name": "Wrapped AKRO (Sollet)",
    "decimals": 6,
    "logoURI":
        "https://raw.githubusercontent.com/solana-labs/token-list/main/assets/mainnet/6WNVCuxCGJzNjmMZoKyhZJwvJ5tYpsLyAtagzYASqBoF/logo.png",
    "tags": ["wrapped-sollet", "ethereum"],
    "extensions": {
      "bridgeContract": "https://etherscan.io/address/0xeae57ce9cc1984f202e15e038b964bb8bdf7229a",
      "serumV3Usdc": "5CZXTTgVZKSzgSA3AFMN5a2f3hmwmmJ6hU8BHTEJ3PX8",
      "serumV3Usdt": "HLvRdctRB48F9yLnu9E24LUTRt89D48Z35yi1HcxayDf",
      "coingeckoId": "akropolis"
    }
  },
  {
    "chainId": 101,
    "address": "DJafV9qemGp7mLMEn5wrfqaFwxsbLgUsGVS16zKRk9kc",
    "symbol": "HXRO",
    "name": "Wrapped HXRO (Sollet)",
    "decimals": 6,
    "logoURI":
        "https://raw.githubusercontent.com/solana-labs/token-list/main/assets/mainnet/DJafV9qemGp7mLMEn5wrfqaFwxsbLgUsGVS16zKRk9kc/logo.png",
    "tags": ["wrapped-sollet", "ethereum"],
    "extensions": {
      "bridgeContract": "https://etherscan.io/address/0xeae57ce9cc1984f202e15e038b964bb8bdf7229a",
      "serumV3Usdc": "6Pn1cSiRos3qhBf54uBP9ZQg8x3JTardm1dL3n4p29tA",
      "serumV3Usdt": "4absuMsgemvdjfkgdLQq1zKEjw3dHBoCWkzKoctndyqd",
      "coingeckoId": "hxro"
    }
  },
  {
    "chainId": 101,
    "address": "DEhAasscXF4kEGxFgJ3bq4PpVGp5wyUxMRvn6TzGVHaw",
    "symbol": "UNI",
    "name": "Wrapped UNI (Sollet)",
    "decimals": 6,
    "logoURI":
        "https://raw.githubusercontent.com/solana-labs/token-list/main/assets/mainnet/DEhAasscXF4kEGxFgJ3bq4PpVGp5wyUxMRvn6TzGVHaw/logo.png",
    "tags": ["wrapped-sollet", "ethereum"],
    "extensions": {
      "bridgeContract": "https://etherscan.io/address/0xeae57ce9cc1984f202e15e038b964bb8bdf7229a",
      "serumV3Usdc": "6JYHjaQBx6AtKSSsizDMwozAEDEZ5KBsSUzH7kRjGJon",
      "serumV3Usdt": "2SSnWNrc83otLpfRo792P6P3PESZpdr8cu2r8zCE6bMD",
      "coingeckoId": "uniswap"
    }
  },
  {
    "chainId": 101,
    "address": "SRMuApVNdxXokk5GT7XD5cUUgXMBCoAz2LHeuAoKWRt",
    "symbol": "SRM",
    "name": "Serum",
    "decimals": 6,
    "logoURI":
        "https://raw.githubusercontent.com/solana-labs/token-list/main/assets/mainnet/SRMuApVNdxXokk5GT7XD5cUUgXMBCoAz2LHeuAoKWRt/logo.png",
    "tags": [],
    "extensions": {
      "website": "https://projectserum.com/",
      "serumV3Usdc": "ByRys5tuUWDgL73G8JBAEfkdFf8JWBzPBDHsBVQ5vbQA",
      "serumV3Usdt": "AtNnsY1AyRERWJ8xCskfz38YdvruWVJQUVXgScC1iPb",
      "coingeckoId": "serum",
      "waterfallbot": "https://bit.ly/SRMwaterfall"
    }
  },
  {
    "chainId": 101,
    "address": "AGFEad2et2ZJif9jaGpdMixQqvW5i81aBdvKe7PHNfz3",
    "symbol": "FTT",
    "name": "Wrapped FTT (Sollet)",
    "decimals": 6,
    "logoURI":
        "https://raw.githubusercontent.com/solana-labs/token-list/main/assets/mainnet/AGFEad2et2ZJif9jaGpdMixQqvW5i81aBdvKe7PHNfz3/logo.png",
    "tags": ["wrapped-sollet", "ethereum"],
    "extensions": {
      "bridgeContract": "https://etherscan.io/address/0xeae57ce9cc1984f202e15e038b964bb8bdf7229a",
      "assetContract": "https://etherscan.io/address/0x50d1c9771902476076ecfc8b2a83ad6b9355a4c9",
      "serumV3Usdc": "2Pbh1CvRVku1TgewMfycemghf6sU9EyuFDcNXqvRmSxc",
      "serumV3Usdt": "Hr3wzG8mZXNHV7TuL6YqtgfVUesCqMxGYCEyP3otywZE",
      "coingeckoId": "ftx-token",
      "waterfallbot": "https://bit.ly/FTTwaterfall"
    }
  },
  {
    "chainId": 101,
    "address": "MSRMcoVyrFxnSgo5uXwone5SKcGhT1KEJMFEkMEWf9L",
    "symbol": "MSRM",
    "name": "MegaSerum",
    "decimals": 0,
    "logoURI":
        "https://raw.githubusercontent.com/solana-labs/token-list/main/assets/mainnet/MSRMcoVyrFxnSgo5uXwone5SKcGhT1KEJMFEkMEWf9L/logo.png",
    "tags": [],
    "extensions": {
      "website": "https://projectserum.com/",
      "serumV3Usdc": "4VKLSYdvrQ5ngQrt1d2VS8o4ewvb2MMUZLiejbnGPV33",
      "serumV3Usdt": "5nLJ22h1DUfeCfwbFxPYK8zbfbri7nA9bXoDcR8AcJjs",
      "coingeckoId": "megaserum"
    }
  },
  {
    "chainId": 101,
    "address": "BXXkv6z8ykpG1yuvUDPgh732wzVHB69RnB9YgSYh3itW",
    "symbol": "WUSDC",
    "name": "Wrapped USDC (Sollet)",
    "decimals": 6,
    "logoURI":
        "https://raw.githubusercontent.com/solana-labs/token-list/main/assets/mainnet/BXXkv6z8ykpG1yuvUDPgh732wzVHB69RnB9YgSYh3itW/logo.png",
    "tags": ["stablecoin", "wrapped-sollet", "ethereum"],
    "extensions": {"coingeckoId": "usd-coin"}
  },
  {
    "chainId": 101,
    "address": "GXMvfY2jpQctDqZ9RoU3oWPhufKiCcFEfchvYumtX7jd",
    "symbol": "TOMO",
    "name": "Wrapped TOMO (Sollet)",
    "decimals": 6,
    "logoURI":
        "https://raw.githubusercontent.com/solana-labs/token-list/main/assets/mainnet/GXMvfY2jpQctDqZ9RoU3oWPhufKiCcFEfchvYumtX7jd/logo.png",
    "tags": ["wrapped-sollet", "ethereum"],
    "extensions": {
      "bridgeContract": "https://etherscan.io/address/0xeae57ce9cc1984f202e15e038b964bb8bdf7229a",
      "serumV3Usdc": "8BdpjpSD5n3nk8DQLqPUyTZvVqFu6kcff5bzUX5dqDpy",
      "serumV3Usdt": "GnKPri4thaGipzTbp8hhSGSrHgG4F8MFiZVrbRn16iG2",
      "coingeckoId": "tomochain",
      "waterfallbot": "https://t.me/TOMOwaterfall"
    }
  },
  {
    "chainId": 101,
    "address": "EcqExpGNFBve2i1cMJUTR4bPXj4ZoqmDD2rTkeCcaTFX",
    "symbol": "KARMA",
    "name": "Wrapped KARMA (Sollet)",
    "decimals": 4,
    "logoURI":
        "https://raw.githubusercontent.com/solana-labs/token-list/main/assets/mainnet/EcqExpGNFBve2i1cMJUTR4bPXj4ZoqmDD2rTkeCcaTFX/logo.png",
    "tags": ["wrapped-sollet", "ethereum"],
    "extensions": {
      "bridgeContract": "https://etherscan.io/address/0xeae57ce9cc1984f202e15e038b964bb8bdf7229a",
      "coingeckoId": "karma-dao"
    }
  },
  {
    "chainId": 101,
    "address": "EqWCKXfs3x47uVosDpTRgFniThL9Y8iCztJaapxbEaVX",
    "symbol": "LUA",
    "name": "Wrapped LUA (Sollet)",
    "decimals": 6,
    "logoURI":
        "https://raw.githubusercontent.com/solana-labs/token-list/main/assets/mainnet/EqWCKXfs3x47uVosDpTRgFniThL9Y8iCztJaapxbEaVX/logo.png",
    "tags": ["wrapped-sollet", "ethereum"],
    "extensions": {
      "bridgeContract": "https://etherscan.io/address/0xeae57ce9cc1984f202e15e038b964bb8bdf7229a",
      "serumV3Usdc": "4xyWjQ74Eifq17vbue5Ut9xfFNfuVB116tZLEpiZuAn8",
      "serumV3Usdt": "35tV8UsHH8FnSAi3YFRrgCu4K9tb883wKnAXpnihot5r",
      "coingeckoId": "lua-token",
      "waterfallbot": "https://t.me/LUAwaterfall"
    }
  },
  {
    "chainId": 101,
    "address": "GeDS162t9yGJuLEHPWXXGrb1zwkzinCgRwnT8vHYjKza",
    "symbol": "MATH",
    "name": "Wrapped MATH (Sollet)",
    "decimals": 6,
    "logoURI":
        "https://raw.githubusercontent.com/solana-labs/token-list/main/assets/mainnet/GeDS162t9yGJuLEHPWXXGrb1zwkzinCgRwnT8vHYjKza/logo.png",
    "tags": ["wrapped-sollet", "ethereum"],
    "extensions": {
      "bridgeContract": "https://etherscan.io/address/0xeae57ce9cc1984f202e15e038b964bb8bdf7229a",
      "serumV3Usdc": "J7cPYBrXVy8Qeki2crZkZavcojf2sMRyQU7nx438Mf8t",
      "serumV3Usdt": "2WghiBkDL2yRhHdvm8CpprrkmfguuQGJTCDfPSudKBAZ",
      "coingeckoId": "math"
    }
  },
  {
    "chainId": 101,
    "address": "GUohe4DJUA5FKPWo3joiPgsB7yzer7LpDmt1Vhzy3Zht",
    "symbol": "KEEP",
    "name": "Wrapped KEEP (Sollet)",
    "decimals": 6,
    "logoURI":
        "https://raw.githubusercontent.com/solana-labs/token-list/main/assets/mainnet/GUohe4DJUA5FKPWo3joiPgsB7yzer7LpDmt1Vhzy3Zht/logo.png",
    "tags": ["wrapped-sollet", "ethereum"],
    "extensions": {
      "bridgeContract": "https://etherscan.io/address/0xeae57ce9cc1984f202e15e038b964bb8bdf7229a",
      "serumV3Usdc": "3rgacody9SvM88QR83GHaNdEEx4Fe2V2ed5GJp2oeKDr",
      "serumV3Usdt": "HEGnaVL5i48ubPBqWAhodnZo8VsSLzEM3Gfc451DnFj9",
      "coingeckoId": "keep-network"
    }
  },
  {
    "chainId": 101,
    "address": "9F9fNTT6qwjsu4X4yWYKZpsbw5qT7o6yR2i57JF2jagy",
    "symbol": "SWAG",
    "name": "Wrapped SWAG (Sollet)",
    "decimals": 6,
    "logoURI":
        "https://raw.githubusercontent.com/solana-labs/token-list/main/assets/mainnet/9F9fNTT6qwjsu4X4yWYKZpsbw5qT7o6yR2i57JF2jagy/logo.png",
    "tags": ["wrapped-sollet", "ethereum"],
    "extensions": {
      "bridgeContract": "https://etherscan.io/address/0xeae57ce9cc1984f202e15e038b964bb8bdf7229a",
      "serumV3Usdt": "J2XSt77XWim5HwtUM8RUwQvmRXNZsbMKpp5GTKpHafvf",
      "coingeckoId": "swag-finance"
    }
  },
  {
    "chainId": 101,
    "address": "DgHK9mfhMtUwwv54GChRrU54T2Em5cuszq2uMuen1ZVE",
    "symbol": "CEL",
    "name": "Wrapped Celsius (Sollet)",
    "decimals": 4,
    "logoURI":
        "https://raw.githubusercontent.com/solana-labs/token-list/main/assets/mainnet/DgHK9mfhMtUwwv54GChRrU54T2Em5cuszq2uMuen1ZVE/logo.png",
    "tags": ["wrapped-sollet", "ethereum"],
    "extensions": {
      "bridgeContract": "https://etherscan.io/address/0xeae57ce9cc1984f202e15e038b964bb8bdf7229a",
      "serumV3Usdt": "cgani53cMZgYfRMgSrNekJTMaLmccRfspsfTbXWRg7u",
      "coingeckoId": "celsius-degree-token"
    }
  },
  {
    "chainId": 101,
    "address": "7ncCLJpP3MNww17LW8bRvx8odQQnubNtfNZBL5BgAEHW",
    "symbol": "RSR",
    "name": "Wrapped Reserve Rights (Sollet)",
    "decimals": 6,
    "logoURI":
        "https://raw.githubusercontent.com/solana-labs/token-list/main/assets/mainnet/7ncCLJpP3MNww17LW8bRvx8odQQnubNtfNZBL5BgAEHW/logo.png",
    "tags": ["wrapped-sollet", "ethereum"],
    "extensions": {
      "bridgeContract": "https://etherscan.io/address/0xeae57ce9cc1984f202e15e038b964bb8bdf7229a",
      "serumV3Usdt": "FcPet5fz9NLdbXwVM6kw2WTHzRAD7mT78UjwTpawd7hJ",
      "coingeckoId": "reserve-rights-token"
    }
  },
  {
    "chainId": 101,
    "address": "5wihEYGca7X4gSe97C5mVcqNsfxBzhdTwpv72HKs25US",
    "symbol": "1INCH",
    "name": "Wrapped 1INCH (Sollet)",
    "decimals": 6,
    "logoURI":
        "https://raw.githubusercontent.com/solana-labs/token-list/main/assets/mainnet/5wihEYGca7X4gSe97C5mVcqNsfxBzhdTwpv72HKs25US/logo.png",
    "tags": ["wrapped-sollet", "ethereum"],
    "extensions": {
      "bridgeContract": "https://etherscan.io/address/0xeae57ce9cc1984f202e15e038b964bb8bdf7229a",
      "coingeckoId": "1inch"
    }
  },
  {
    "chainId": 101,
    "address": "38i2NQxjp5rt5B3KogqrxmBxgrAwaB3W1f1GmiKqh9MS",
    "symbol": "GRT",
    "name": "Wrapped GRT  (Sollet)",
    "decimals": 6,
    "logoURI":
        "https://raw.githubusercontent.com/solana-labs/token-list/main/assets/mainnet/38i2NQxjp5rt5B3KogqrxmBxgrAwaB3W1f1GmiKqh9MS/logo.png",
    "tags": ["wrapped-sollet", "ethereum"],
    "extensions": {
      "bridgeContract": "https://etherscan.io/address/0xeae57ce9cc1984f202e15e038b964bb8bdf7229a",
      "coingeckoId": "the-graph"
    }
  },
  {
    "chainId": 101,
    "address": "Avz2fmevhhu87WYtWQCFj9UjKRjF9Z9QWwN2ih9yF95G",
    "symbol": "COMP",
    "name": "Wrapped Compound (Sollet)",
    "decimals": 6,
    "logoURI":
        "https://raw.githubusercontent.com/solana-labs/token-list/main/assets/mainnet/Avz2fmevhhu87WYtWQCFj9UjKRjF9Z9QWwN2ih9yF95G/logo.png",
    "tags": ["wrapped-sollet", "ethereum"],
    "extensions": {
      "bridgeContract": "https://etherscan.io/address/0xeae57ce9cc1984f202e15e038b964bb8bdf7229a",
      "coingeckoId": "compound-coin"
    }
  },
  {
    "chainId": 101,
    "address": "9wRD14AhdZ3qV8et3eBQVsrb3UoBZDUbJGyFckpTg8sj",
    "symbol": "PAXG",
    "name": "Wrapped Paxos Gold (Sollet)",
    "decimals": 6,
    "logoURI":
        "https://raw.githubusercontent.com/solana-labs/token-list/main/assets/mainnet/9wRD14AhdZ3qV8et3eBQVsrb3UoBZDUbJGyFckpTg8sj/logo.png",
    "tags": ["wrapped-sollet", "ethereum"],
    "extensions": {
      "bridgeContract": "https://etherscan.io/address/0xeae57ce9cc1984f202e15e038b964bb8bdf7229a",
      "coingeckoId": "pax-gold"
    }
  },
  {
    "chainId": 101,
    "address": "AByXcTZwJHMtrKrvVsh9eFNB1pJaLDjCUR2ayvxBAAM2",
    "symbol": "STRONG",
    "name": "Wrapped Strong (Sollet)",
    "decimals": 6,
    "logoURI":
        "https://raw.githubusercontent.com/solana-labs/token-list/main/assets/mainnet/AByXcTZwJHMtrKrvVsh9eFNB1pJaLDjCUR2ayvxBAAM2/logo.png",
    "tags": ["wrapped-sollet", "ethereum"],
    "extensions": {
      "bridgeContract": "https://etherscan.io/address/0xeae57ce9cc1984f202e15e038b964bb8bdf7229a",
      "coingeckoId": "strong"
    }
  },
  {
    "chainId": 101,
    "address": "EchesyfXePKdLtoiZSL8pBe8Myagyy8ZRqsACNCFGnvp",
    "symbol": "FIDA",
    "name": "Bonfida",
    "decimals": 6,
    "logoURI":
        "https://raw.githubusercontent.com/solana-labs/token-list/main/assets/mainnet/EchesyfXePKdLtoiZSL8pBe8Myagyy8ZRqsACNCFGnvp/logo.svg",
    "tags": [],
    "extensions": {
      "website": "https://bonfida.com/",
      "serumV3Usdc": "E14BKBhDWD4EuTkWj1ooZezesGxMW8LPCps4W5PuzZJo",
      "serumV3Usdt": "EbV7pPpEvheLizuYX3gUCvWM8iySbSRAhu2mQ5Vz2Mxf",
      "coingeckoId": "bonfida",
      "waterfallbot": "https://bit.ly/FIDAwaterfall"
    }
  },
  {
    "chainId": 101,
    "address": "kinXdEcpDQeHPEuQnqmUgtYykqKGVFq6CeVX5iAHJq6",
    "symbol": "KIN",
    "name": "KIN",
    "decimals": 5,
    "logoURI":
        "https://raw.githubusercontent.com/solana-labs/token-list/main/assets/mainnet/kinXdEcpDQeHPEuQnqmUgtYykqKGVFq6CeVX5iAHJq6/logo.png",
    "tags": [],
    "extensions": {
      "serumV3Usdc": "Bn6NPyr6UzrFAwC4WmvPvDr2Vm8XSUnFykM2aQroedgn",
      "serumV3Usdt": "4nCFQr8sahhhL4XJ7kngGFBmpkmyf3xLzemuMhn6mWTm",
      "coingeckoId": "kin",
      "waterfallbot": "https://bit.ly/KINwaterfall"
    }
  },
  {
    "chainId": 101,
    "address": "MAPS41MDahZ9QdKXhVa4dWB9RuyfV4XqhyAZ8XcYepb",
    "symbol": "MAPS",
    "name": "MAPS",
    "decimals": 6,
    "logoURI":
        "https://raw.githubusercontent.com/solana-labs/token-list/main/assets/mainnet/MAPS41MDahZ9QdKXhVa4dWB9RuyfV4XqhyAZ8XcYepb/logo.svg",
    "tags": [],
    "extensions": {
      "website": "https://maps.me/",
      "serumV3Usdc": "3A8XQRWXC7BjLpgLDDBhQJLT5yPCzS16cGYRKHkKxvYo",
      "serumV3Usdt": "7cknqHAuGpfVXPtFoJpFvUjJ8wkmyEfbFusmwMfNy3FE",
      "coingeckoId": "maps"
    }
  },
  {
    "chainId": 101,
    "address": "z3dn17yLaGMKffVogeFHQ9zWVcXgqgf3PQnDsNs2g6M",
    "symbol": "OXY",
    "name": "Oxygen Protocol",
    "decimals": 6,
    "logoURI":
        "https://raw.githubusercontent.com/solana-labs/token-list/main/assets/mainnet/z3dn17yLaGMKffVogeFHQ9zWVcXgqgf3PQnDsNs2g6M/logo.svg",
    "tags": [],
    "extensions": {
      "website": "https://www.oxygen.org/",
      "serumV3Usdt": "GKLev6UHeX1KSDCyo2bzyG6wqhByEzDBkmYTxEdmYJgB",
      "serumV3Usdc": "GZ3WBFsqntmERPwumFEYgrX2B7J7G11MzNZAy7Hje27X",
      "coingeckoId": "oxygen",
      "waterfallbot": "https://bit.ly/OXYwaterfall"
    }
  },
  {
    "chainId": 101,
    "address": "FtgGSFADXBtroxq8VCausXRr2of47QBf5AS1NtZCu4GD",
    "symbol": "BRZ",
    "name": "BRZ",
    "decimals": 4,
    "logoURI":
        "https://raw.githubusercontent.com/solana-labs/token-list/main/assets/mainnet/FtgGSFADXBtroxq8VCausXRr2of47QBf5AS1NtZCu4GD/logo.png",
    "tags": [],
    "extensions": {"website": "https://brztoken.io/", "coingeckoId": "brz"}
  },
  {
    "chainId": 101,
    "address": "Es9vMFrzaCERmJfrF4H2FYD4KCoNkY11McCe8BenwNYB",
    "symbol": "USDT",
    "name": "USDT",
    "decimals": 6,
    "logoURI":
        "https://raw.githubusercontent.com/solana-labs/token-list/main/assets/mainnet/Es9vMFrzaCERmJfrF4H2FYD4KCoNkY11McCe8BenwNYB/logo.svg",
    "tags": ["stablecoin"],
    "extensions": {
      "website": "https://tether.to/",
      "coingeckoId": "tether",
      "serumV3Usdc": "77quYg4MGneUdjgXCunt9GgM1usmrxKY31twEy3WHwcS"
    }
  },
  {
    "chainId": 101,
    "address": "2oDxYGgTBmST4rc3yn1YtcSEck7ReDZ8wHWLqZAuNWXH",
    "symbol": "xMARK",
    "name": "Standard",
    "decimals": 9,
    "logoURI":
        "https://raw.githubusercontent.com/solana-labs/token-list/main/assets/mainnet/2oDxYGgTBmST4rc3yn1YtcSEck7ReDZ8wHWLqZAuNWXH/logo.png",
    "tags": ["wrapped", "wormhole"],
    "extensions": {
      "website": "https://benchmarkprotocol.finance/",
      "address": "0x36b679bd64ed73dbfd88909cdcb892cb66bd4cbb",
      "bridgeContract": "https://etherscan.io/address/0xf92cD566Ea4864356C5491c177A430C222d7e678",
      "assetContract": "https://etherscan.io/address/0x36b679bd64ed73dbfd88909cdcb892cb66bd4cbb",
      "coingeckoId": "xmark"
    }
  },
  {
    "chainId": 101,
    "address": "4k3Dyjzvzp8eMZWUXbBCjEvwSkkk59S5iCNLY3QrkX6R",
    "symbol": "RAY",
    "name": "Raydium",
    "decimals": 6,
    "logoURI":
        "https://raw.githubusercontent.com/solana-labs/token-list/main/assets/mainnet/4k3Dyjzvzp8eMZWUXbBCjEvwSkkk59S5iCNLY3QrkX6R/logo.png",
    "tags": [],
    "extensions": {
      "website": "https://raydium.io/",
      "serumV3Usdt": "teE55QrL4a4QSfydR9dnHF97jgCfptpuigbb53Lo95g",
      "serumV3Usdc": "2xiv8A5xrJ7RnGdxXB42uFEkYHJjszEhaJyKKt4WaLep",
      "coingeckoId": "raydium",
      "waterfallbot": "https://bit.ly/RAYwaterfall"
    }
  },
  {
    "chainId": 101,
    "address": "CzPDyvotTcxNqtPne32yUiEVQ6jk42HZi1Y3hUu7qf7f",
    "symbol": "RAY-WUSDT",
    "name": "Raydium Legacy LP Token V2 (RAY-WUSDT)",
    "decimals": 6,
    "logoURI":
        "https://raw.githubusercontent.com/solana-labs/token-list/main/assets/mainnet/CzPDyvotTcxNqtPne32yUiEVQ6jk42HZi1Y3hUu7qf7f/logo.png",
    "tags": ["lp-token"],
    "extensions": {"website": "https://raydium.io/"}
  },
  {
    "chainId": 101,
    "address": "134Cct3CSdRCbYgq5SkwmHgfwjJ7EM5cG9PzqffWqECx",
    "symbol": "RAY-SOL",
    "name": "Raydium Legacy LP Token V2 (RAY-SOL)",
    "decimals": 6,
    "logoURI":
        "https://raw.githubusercontent.com/solana-labs/token-list/main/assets/mainnet/134Cct3CSdRCbYgq5SkwmHgfwjJ7EM5cG9PzqffWqECx/logo.png",
    "tags": ["lp-token"],
    "extensions": {"website": "https://raydium.io/"}
  },
  {
    "chainId": 101,
    "address": "EVDmwajM5U73PD34bYPugwiA4Eqqbrej4mLXXv15Z5qR",
    "symbol": "LINK-WUSDT",
    "name": "Raydium Legacy LP Token V2 (LINK-WUSDT)",
    "decimals": 6,
    "logoURI":
        "https://raw.githubusercontent.com/solana-labs/token-list/main/assets/mainnet/EVDmwajM5U73PD34bYPugwiA4Eqqbrej4mLXXv15Z5qR/logo.png",
    "tags": ["lp-token"],
    "extensions": {"website": "https://raydium.io/"}
  },
  {
    "chainId": 101,
    "address": "KY4XvwHy7JPzbWYAbk23jQvEb4qWJ8aCqYWREmk1Q7K",
    "symbol": "ETH-WUSDT",
    "name": "Raydium Legacy LP Token V2 (ETH-WUSDT)",
    "decimals": 6,
    "logoURI":
        "https://raw.githubusercontent.com/solana-labs/token-list/main/assets/mainnet/KY4XvwHy7JPzbWYAbk23jQvEb4qWJ8aCqYWREmk1Q7K/logo.png",
    "tags": ["lp-token"],
    "extensions": {"website": "https://raydium.io/"}
  },
  {
    "chainId": 101,
    "address": "FgmBnsF5Qrnv8X9bomQfEtQTQjNNiBCWRKGpzPnE5BDg",
    "symbol": "RAY-USDC",
    "name": "Raydium Legacy LP Token V2 (RAY-USDC)",
    "decimals": 6,
    "logoURI":
        "https://raw.githubusercontent.com/solana-labs/token-list/main/assets/mainnet/FgmBnsF5Qrnv8X9bomQfEtQTQjNNiBCWRKGpzPnE5BDg/logo.png",
    "tags": ["lp-token"],
    "extensions": {"website": "https://raydium.io/"}
  },
  {
    "chainId": 101,
    "address": "5QXBMXuCL7zfAk39jEVVEvcrz1AvBGgT9wAhLLHLyyUJ",
    "symbol": "RAY-SRM",
    "name": "Raydium Legacy LP Token V2 (RAY-SRM)",
    "decimals": 6,
    "logoURI":
        "https://raw.githubusercontent.com/solana-labs/token-list/main/assets/mainnet/5QXBMXuCL7zfAk39jEVVEvcrz1AvBGgT9wAhLLHLyyUJ/logo.png",
    "tags": ["lp-token"],
    "extensions": {"website": "https://raydium.io/"}
  },
  {
    "chainId": 101,
    "address": "FdhKXYjCou2jQfgKWcNY7jb8F2DPLU1teTTTRfLBD2v1",
    "symbol": "RAY-WUSDT",
    "name": "Raydium Legacy LP Token V3 (RAY-WUSDT)",
    "decimals": 6,
    "logoURI":
        "https://raw.githubusercontent.com/solana-labs/token-list/main/assets/mainnet/FdhKXYjCou2jQfgKWcNY7jb8F2DPLU1teTTTRfLBD2v1/logo.png",
    "tags": ["lp-token"],
    "extensions": {"website": "https://raydium.io/"}
  },
  {
    "chainId": 101,
    "address": "BZFGfXMrjG2sS7QT2eiCDEevPFnkYYF7kzJpWfYxPbcx",
    "symbol": "RAY-USDC",
    "name": "Raydium Legacy LP Token V3 (RAY-USDC)",
    "decimals": 6,
    "logoURI":
        "https://raw.githubusercontent.com/solana-labs/token-list/main/assets/mainnet/BZFGfXMrjG2sS7QT2eiCDEevPFnkYYF7kzJpWfYxPbcx/logo.png",
    "tags": ["lp-token"],
    "extensions": {"website": "https://raydium.io/"}
  },
  {
    "chainId": 101,
    "address": "DSX5E21RE9FB9hM8Nh8xcXQfPK6SzRaJiywemHBSsfup",
    "symbol": "RAY-SRM",
    "name": "Raydium Legacy LP Token V3 (RAY-SRM)",
    "decimals": 6,
    "logoURI":
        "https://raw.githubusercontent.com/solana-labs/token-list/main/assets/mainnet/DSX5E21RE9FB9hM8Nh8xcXQfPK6SzRaJiywemHBSsfup/logo.png",
    "tags": ["lp-token"],
    "extensions": {"website": "https://raydium.io/"}
  },
  {
    "chainId": 101,
    "address": "F5PPQHGcznZ2FxD9JaxJMXaf7XkaFFJ6zzTBcW8osQjw",
    "symbol": "RAY-SOL",
    "name": "Raydium Legacy LP Token V3 (RAY-SOL)",
    "decimals": 6,
    "logoURI":
        "https://raw.githubusercontent.com/solana-labs/token-list/main/assets/mainnet/F5PPQHGcznZ2FxD9JaxJMXaf7XkaFFJ6zzTBcW8osQjw/logo.png",
    "tags": ["lp-token"],
    "extensions": {"website": "https://raydium.io/"}
  },
  {
    "chainId": 101,
    "address": "8Q6MKy5Yxb9vG1mWzppMtMb2nrhNuCRNUkJTeiE3fuwD",
    "symbol": "RAY-ETH",
    "name": "Raydium Legacy LP Token V3 (RAY-ETH)",
    "decimals": 6,
    "logoURI":
        "https://raw.githubusercontent.com/solana-labs/token-list/main/assets/mainnet/8Q6MKy5Yxb9vG1mWzppMtMb2nrhNuCRNUkJTeiE3fuwD/logo.png",
    "tags": ["lp-token"],
    "extensions": {"website": "https://raydium.io/"}
  },
  {
    "chainId": 101,
    "address": "DsBuznXRTmzvEdb36Dx3aVLVo1XmH7r1PRZUFugLPTFv",
    "symbol": "FIDA-RAY",
    "name": "Raydium LP Token V4 (FIDA-RAY)",
    "decimals": 6,
    "logoURI":
        "https://raw.githubusercontent.com/solana-labs/token-list/main/assets/mainnet/DsBuznXRTmzvEdb36Dx3aVLVo1XmH7r1PRZUFugLPTFv/logo.png",
    "tags": ["lp-token"],
    "extensions": {"website": "https://raydium.io/"}
  },
  {
    "chainId": 101,
    "address": "FwaX9W7iThTZH5MFeasxdLpxTVxRcM7ZHieTCnYog8Yb",
    "symbol": "OXY-RAY",
    "name": "Raydium LP Token V4 (OXY-RAY)",
    "decimals": 6,
    "logoURI":
        "https://raw.githubusercontent.com/solana-labs/token-list/main/assets/mainnet/FwaX9W7iThTZH5MFeasxdLpxTVxRcM7ZHieTCnYog8Yb/logo.png",
    "tags": ["lp-token"],
    "extensions": {"website": "https://raydium.io/"}
  },
  {
    "chainId": 101,
    "address": "CcKK8srfVdTSsFGV3VLBb2YDbzF4T4NM2C3UEjC39RLP",
    "symbol": "MAPS-RAY",
    "name": "Raydium LP Token V4 (MAPS-RAY)",
    "decimals": 6,
    "logoURI":
        "https://raw.githubusercontent.com/solana-labs/token-list/main/assets/mainnet/CcKK8srfVdTSsFGV3VLBb2YDbzF4T4NM2C3UEjC39RLP/logo.png",
    "tags": ["lp-token"],
    "extensions": {"website": "https://raydium.io/"}
  },
  {
    "chainId": 101,
    "address": "CHT8sft3h3gpLYbCcZ9o27mT5s3Z6VifBVbUiDvprHPW",
    "symbol": "KIN-RAY",
    "name": "Raydium LP Token V4 (KIN-RAY)",
    "decimals": 6,
    "logoURI":
        "https://raw.githubusercontent.com/solana-labs/token-list/main/assets/mainnet/CHT8sft3h3gpLYbCcZ9o27mT5s3Z6VifBVbUiDvprHPW/logo.png",
    "tags": ["lp-token"],
    "extensions": {"website": "https://raydium.io/"}
  },
  {
    "chainId": 101,
    "address": "C3sT1R3nsw4AVdepvLTLKr5Gvszr7jufyBWUCvy4TUvT",
    "symbol": "RAY-USDT",
    "name": "Raydium LP Token V4 (RAY-USDT)",
    "decimals": 6,
    "logoURI":
        "https://raw.githubusercontent.com/solana-labs/token-list/main/assets/mainnet/C3sT1R3nsw4AVdepvLTLKr5Gvszr7jufyBWUCvy4TUvT/logo.png",
    "tags": ["lp-token"],
    "extensions": {"website": "https://raydium.io/"}
  },
  {
    "chainId": 101,
    "address": "8HoQnePLqPj4M7PUDzfw8e3Ymdwgc7NLGnaTUapubyvu",
    "symbol": "SOL-USDC",
    "name": "Raydium LP Token V4 (SOL-USDC)",
    "decimals": 9,
    "logoURI":
        "https://raw.githubusercontent.com/solana-labs/token-list/main/assets/mainnet/8HoQnePLqPj4M7PUDzfw8e3Ymdwgc7NLGnaTUapubyvu/logo.png",
    "tags": ["lp-token"],
    "extensions": {"website": "https://raydium.io/"}
  },
  {
    "chainId": 101,
    "address": "865j7iMmRRycSYUXzJ33ZcvLiX9JHvaLidasCyUyKaRE",
    "symbol": "YFI-USDC",
    "name": "Raydium LP Token V4 (YFI-USDC)",
    "decimals": 6,
    "logoURI":
        "https://raw.githubusercontent.com/solana-labs/token-list/main/assets/mainnet/865j7iMmRRycSYUXzJ33ZcvLiX9JHvaLidasCyUyKaRE/logo.png",
    "tags": ["lp-token"],
    "extensions": {"website": "https://raydium.io/"}
  },
  {
    "chainId": 101,
    "address": "9XnZd82j34KxNLgQfz29jGbYdxsYznTWRpvZE3SRE7JG",
    "symbol": "SRM-USDC",
    "name": "Raydium LP Token V4 (SRM-USDC)",
    "decimals": 6,
    "logoURI":
        "https://raw.githubusercontent.com/solana-labs/token-list/main/assets/mainnet/9XnZd82j34KxNLgQfz29jGbYdxsYznTWRpvZE3SRE7JG/logo.png",
    "tags": ["lp-token"],
    "extensions": {"website": "https://raydium.io/"}
  },
  {
    "chainId": 101,
    "address": "75dCoKfUHLUuZ4qEh46ovsxfgWhB4icc3SintzWRedT9",
    "symbol": "FTT-USDC",
    "name": "Raydium LP Token V4 (FTT-USDC)",
    "decimals": 6,
    "logoURI":
        "https://raw.githubusercontent.com/solana-labs/token-list/main/assets/mainnet/75dCoKfUHLUuZ4qEh46ovsxfgWhB4icc3SintzWRedT9/logo.png",
    "tags": ["lp-token"],
    "extensions": {"website": "https://raydium.io/"}
  },
  {
    "chainId": 101,
    "address": "2hMdRdVWZqetQsaHG8kQjdZinEMBz75vsoWTCob1ijXu",
    "symbol": "BTC-USDC",
    "name": "Raydium LP Token V4 (BTC-USDC)",
    "decimals": 6,
    "logoURI":
        "https://raw.githubusercontent.com/solana-labs/token-list/main/assets/mainnet/2hMdRdVWZqetQsaHG8kQjdZinEMBz75vsoWTCob1ijXu/logo.png",
    "tags": ["lp-token"],
    "extensions": {"website": "https://raydium.io/"}
  },
  {
    "chainId": 101,
    "address": "2QVjeR9d2PbSf8em8NE8zWd8RYHjFtucDUdDgdbDD2h2",
    "symbol": "SUSHI-USDC",
    "name": "Raydium LP Token V4 (SUSHI-USDC)",
    "decimals": 6,
    "logoURI":
        "https://raw.githubusercontent.com/solana-labs/token-list/main/assets/mainnet/2QVjeR9d2PbSf8em8NE8zWd8RYHjFtucDUdDgdbDD2h2/logo.png",
    "tags": ["lp-token"],
    "extensions": {"website": "https://raydium.io/"}
  },
  {
    "chainId": 101,
    "address": "CHyUpQFeW456zcr5XEh4RZiibH8Dzocs6Wbgz9aWpXnQ",
    "symbol": "TOMO-USDC",
    "name": "Raydium LP Token V4 (TOMO-USDC)",
    "decimals": 6,
    "logoURI":
        "https://raw.githubusercontent.com/solana-labs/token-list/main/assets/mainnet/CHyUpQFeW456zcr5XEh4RZiibH8Dzocs6Wbgz9aWpXnQ/logo.png",
    "tags": ["lp-token"],
    "extensions": {"website": "https://raydium.io/"}
  },
  {
    "chainId": 101,
    "address": "BqjoYjqKrXtfBKXeaWeAT5sYCy7wsAYf3XjgDWsHSBRs",
    "symbol": "LINK-USDC",
    "name": "Raydium LP Token V4 (LINK-USDC)",
    "decimals": 6,
    "logoURI":
        "https://raw.githubusercontent.com/solana-labs/token-list/main/assets/mainnet/BqjoYjqKrXtfBKXeaWeAT5sYCy7wsAYf3XjgDWsHSBRs/logo.png",
    "tags": ["lp-token"],
    "extensions": {"website": "https://raydium.io/"}
  },
  {
    "chainId": 101,
    "address": "13PoKid6cZop4sj2GfoBeujnGfthUbTERdE5tpLCDLEY",
    "symbol": "ETH-USDC",
    "name": "Raydium LP Token V4 (ETH-USDC)",
    "decimals": 6,
    "logoURI":
        "https://raw.githubusercontent.com/solana-labs/token-list/main/assets/mainnet/13PoKid6cZop4sj2GfoBeujnGfthUbTERdE5tpLCDLEY/logo.png",
    "tags": ["lp-token"],
    "extensions": {"website": "https://raydium.io/"}
  },
  {
    "chainId": 101,
    "address": "2Vyyeuyd15Gp8aH6uKE72c4hxc8TVSLibxDP9vzspQWG",
    "symbol": "COPE-USDC",
    "name": "Raydium LP Token V4 (COPE-USDC)",
    "decimals": 0,
    "logoURI":
        "https://raw.githubusercontent.com/solana-labs/token-list/main/assets/mainnet/2Vyyeuyd15Gp8aH6uKE72c4hxc8TVSLibxDP9vzspQWG/logo.png",
    "tags": ["lp-token"],
    "extensions": {"website": "https://raydium.io/"}
  },
  {
    "chainId": 101,
    "address": "Epm4KfTj4DMrvqn6Bwg2Tr2N8vhQuNbuK8bESFp4k33K",
    "symbol": "SOL-USDT",
    "name": "Raydium LP Token V4 (SOL-USDT)",
    "decimals": 9,
    "logoURI":
        "https://raw.githubusercontent.com/solana-labs/token-list/main/assets/mainnet/Epm4KfTj4DMrvqn6Bwg2Tr2N8vhQuNbuK8bESFp4k33K/logo.png",
    "tags": ["lp-token"],
    "extensions": {"website": "https://raydium.io/"}
  },
  {
    "chainId": 101,
    "address": "FA1i7fej1pAbQbnY8NbyYUsTrWcasTyipKreDgy1Mgku",
    "symbol": "YFI-USDT",
    "name": "Raydium LP Token V4 (YFI-USDT)",
    "decimals": 6,
    "logoURI":
        "https://raw.githubusercontent.com/solana-labs/token-list/main/assets/mainnet/FA1i7fej1pAbQbnY8NbyYUsTrWcasTyipKreDgy1Mgku/logo.png",
    "tags": ["lp-token"],
    "extensions": {"website": "https://raydium.io/"}
  },
  {
    "chainId": 101,
    "address": "HYSAu42BFejBS77jZAZdNAWa3iVcbSRJSzp3wtqCbWwv",
    "symbol": "SRM-USDT",
    "name": "Raydium LP Token V4 (SRM-USDT)",
    "decimals": 6,
    "logoURI":
        "https://raw.githubusercontent.com/solana-labs/token-list/main/assets/mainnet/HYSAu42BFejBS77jZAZdNAWa3iVcbSRJSzp3wtqCbWwv/logo.png",
    "tags": ["lp-token"],
    "extensions": {"website": "https://raydium.io/"}
  },
  {
    "chainId": 101,
    "address": "2cTCiUnect5Lap2sk19xLby7aajNDYseFhC9Pigou11z",
    "symbol": "FTT-USDT",
    "name": "Raydium LP Token V4 (FTT-USDT)",
    "decimals": 6,
    "logoURI":
        "https://raw.githubusercontent.com/solana-labs/token-list/main/assets/mainnet/2cTCiUnect5Lap2sk19xLby7aajNDYseFhC9Pigou11z/logo.png",
    "tags": ["lp-token"],
    "extensions": {"website": "https://raydium.io/"}
  },
  {
    "chainId": 101,
    "address": "DgGuvR9GSHimopo3Gc7gfkbKamLKrdyzWkq5yqA6LqYS",
    "symbol": "BTC-USDT",
    "name": "Raydium LP Token V4 (BTC-USDT)",
    "decimals": 6,
    "logoURI":
        "https://raw.githubusercontent.com/solana-labs/token-list/main/assets/mainnet/DgGuvR9GSHimopo3Gc7gfkbKamLKrdyzWkq5yqA6LqYS/logo.png",
    "tags": ["lp-token"],
    "extensions": {"website": "https://raydium.io/"}
  },
  {
    "chainId": 101,
    "address": "Ba26poEYDy6P2o95AJUsewXgZ8DM9BCsmnU9hmC9i4Ki",
    "symbol": "SUSHI-USDT",
    "name": "Raydium LP Token V4 (SUSHI-USDT)",
    "decimals": 6,
    "logoURI":
        "https://raw.githubusercontent.com/solana-labs/token-list/main/assets/mainnet/Ba26poEYDy6P2o95AJUsewXgZ8DM9BCsmnU9hmC9i4Ki/logo.png",
    "tags": ["lp-token"],
    "extensions": {"website": "https://raydium.io/"}
  },
  {
    "chainId": 101,
    "address": "D3iGro1vn6PWJXo9QAPj3dfta6dKkHHnmiiym2EfsAmi",
    "symbol": "TOMO-USDT",
    "name": "Raydium LP Token V4 (TOMO-USDT)",
    "decimals": 6,
    "logoURI":
        "https://raw.githubusercontent.com/solana-labs/token-list/main/assets/mainnet/D3iGro1vn6PWJXo9QAPj3dfta6dKkHHnmiiym2EfsAmi/logo.png",
    "tags": ["lp-token"],
    "extensions": {"website": "https://raydium.io/"}
  },
  {
    "chainId": 101,
    "address": "Dr12Sgt9gkY8WU5tRkgZf1TkVWJbvjYuPAhR3aDCwiiX",
    "symbol": "LINK-USDT",
    "name": "Raydium LP Token V4 (LINK-USDT)",
    "decimals": 6,
    "logoURI":
        "https://raw.githubusercontent.com/solana-labs/token-list/main/assets/mainnet/Dr12Sgt9gkY8WU5tRkgZf1TkVWJbvjYuPAhR3aDCwiiX/logo.png",
    "tags": ["lp-token"],
    "extensions": {"website": "https://raydium.io/"}
  },
  {
    "chainId": 101,
    "address": "nPrB78ETY8661fUgohpuVusNCZnedYCgghzRJzxWnVb",
    "symbol": "ETH-USDT",
    "name": "Raydium LP Token V4 (ETH-USDT)",
    "decimals": 6,
    "logoURI":
        "https://raw.githubusercontent.com/solana-labs/token-list/main/assets/mainnet/nPrB78ETY8661fUgohpuVusNCZnedYCgghzRJzxWnVb/logo.png",
    "tags": ["lp-token"],
    "extensions": {"website": "https://raydium.io/"}
  },
  {
    "chainId": 101,
    "address": "EGJht91R7dKpCj8wzALkjmNdUUUcQgodqWCYweyKcRcV",
    "symbol": "YFI-SRM",
    "name": "Raydium LP Token V4 (YFI-SRM)",
    "decimals": 6,
    "logoURI":
        "https://raw.githubusercontent.com/solana-labs/token-list/main/assets/mainnet/EGJht91R7dKpCj8wzALkjmNdUUUcQgodqWCYweyKcRcV/logo.png",
    "tags": ["lp-token"],
    "extensions": {"website": "https://raydium.io/"}
  },
  {
    "chainId": 101,
    "address": "AsDuPg9MgPtt3jfoyctUCUgsvwqAN6RZPftqoeiPDefM",
    "symbol": "FTT-SRM",
    "name": "Raydium LP Token V4 (FTT-SRM)",
    "decimals": 6,
    "logoURI":
        "https://raw.githubusercontent.com/solana-labs/token-list/main/assets/mainnet/AsDuPg9MgPtt3jfoyctUCUgsvwqAN6RZPftqoeiPDefM/logo.png",
    "tags": ["lp-token"],
    "extensions": {"website": "https://raydium.io/"}
  },
  {
    "chainId": 101,
    "address": "AGHQxXb3GSzeiLTcLtXMS2D5GGDZxsB2fZYZxSB5weqB",
    "symbol": "BTC-SRM",
    "name": "Raydium LP Token V4 (BTC-SRM)",
    "decimals": 6,
    "logoURI":
        "https://raw.githubusercontent.com/solana-labs/token-list/main/assets/mainnet/AGHQxXb3GSzeiLTcLtXMS2D5GGDZxsB2fZYZxSB5weqB/logo.png",
    "tags": ["lp-token"],
    "extensions": {"website": "https://raydium.io/"}
  },
  {
    "chainId": 101,
    "address": "3HYhUnUdV67j1vn8fu7ExuVGy5dJozHEyWvqEstDbWwE",
    "symbol": "SUSHI-SRM",
    "name": "Raydium LP Token V4 (SUSHI-SRM)",
    "decimals": 6,
    "logoURI":
        "https://raw.githubusercontent.com/solana-labs/token-list/main/assets/mainnet/3HYhUnUdV67j1vn8fu7ExuVGy5dJozHEyWvqEstDbWwE/logo.png",
    "tags": ["lp-token"],
    "extensions": {"website": "https://raydium.io/"}
  },
  {
    "chainId": 101,
    "address": "GgH9RnKrQpaMQeqmdbMvs5oo1A24hERQ9wuY2pSkeG7x",
    "symbol": "TOMO-SRM",
    "name": "Raydium LP Token V4 (TOMO-SRM)",
    "decimals": 6,
    "logoURI":
        "https://raw.githubusercontent.com/solana-labs/token-list/main/assets/mainnet/GgH9RnKrQpaMQeqmdbMvs5oo1A24hERQ9wuY2pSkeG7x/logo.png",
    "tags": ["lp-token"],
    "extensions": {"website": "https://raydium.io/"}
  },
  {
    "chainId": 101,
    "address": "GXN6yJv12o18skTmJXaeFXZVY1iqR18CHsmCT8VVCmDD",
    "symbol": "LINK-SRM",
    "name": "Raydium LP Token V4 (LINK-SRM)",
    "decimals": 6,
    "logoURI":
        "https://raw.githubusercontent.com/solana-labs/token-list/main/assets/mainnet/GXN6yJv12o18skTmJXaeFXZVY1iqR18CHsmCT8VVCmDD/logo.png",
    "tags": ["lp-token"],
    "extensions": {"website": "https://raydium.io/"}
  },
  {
    "chainId": 101,
    "address": "9VoY3VERETuc2FoadMSYYizF26mJinY514ZpEzkHMtwG",
    "symbol": "ETH-SRM",
    "name": "Raydium LP Token V4 (ETH-SRM)",
    "decimals": 6,
    "logoURI":
        "https://raw.githubusercontent.com/solana-labs/token-list/main/assets/mainnet/9VoY3VERETuc2FoadMSYYizF26mJinY514ZpEzkHMtwG/logo.png",
    "tags": ["lp-token"],
    "extensions": {"website": "https://raydium.io/"}
  },
  {
    "chainId": 101,
    "address": "AKJHspCwDhABucCxNLXUSfEzb7Ny62RqFtC9uNjJi4fq",
    "symbol": "SRM-SOL",
    "name": "Raydium LP Token V4 (SRM-SOL)",
    "decimals": 6,
    "logoURI":
        "https://raw.githubusercontent.com/solana-labs/token-list/main/assets/mainnet/AKJHspCwDhABucCxNLXUSfEzb7Ny62RqFtC9uNjJi4fq/logo.png",
    "tags": ["lp-token"],
    "extensions": {"website": "https://raydium.io/"}
  },
  {
    "chainId": 101,
    "address": "2doeZGLJyACtaG9DCUyqMLtswesfje1hjNA11hMdj6YU",
    "symbol": "TULIP-USDC",
    "name": "Raydium LP Token V4 (TULIP-USDC)",
    "decimals": 6,
    "logoURI":
        "https://raw.githubusercontent.com/solana-labs/token-list/main/assets/mainnet/2doeZGLJyACtaG9DCUyqMLtswesfje1hjNA11hMdj6YU/logo.svg",
    "tags": ["lp-token"],
    "extensions": {"website": "https://raydium.io/"}
  },
  {
    "chainId": 101,
    "address": "AcstFzGGawvvdVhYV9bftr7fmBHbePUjhv53YK1W3dZo",
    "symbol": "LSD",
    "name": "LSD",
    "decimals": 9,
    "logoURI":
        "https://raw.githubusercontent.com/solana-labs/token-list/main/assets/mainnet/AcstFzGGawvvdVhYV9bftr7fmBHbePUjhv53YK1W3dZo/logo.svg",
    "tags": ["nft"],
    "extensions": {"website": "https://solible.com/"}
  },
  {
    "chainId": 101,
    "address": "91fSFQsPzMLat9DHwLdQacW3i3EGnWds5tA5mt7yLiT9",
    "symbol": "Unlimited Energy",
    "name": "Unlimited Energy",
    "decimals": 9,
    "tags": ["nft"],
    "extensions": {"website": "https://solible.com/"}
  },
  {
    "chainId": 101,
    "address": "29PEpZeuqWf9tS2gwCjpeXNdXLkaZSMR2s1ibkvGsfnP",
    "symbol": "Need for Speed",
    "name": "Need for Speed",
    "decimals": 9,
    "tags": ["nft"],
    "extensions": {"website": "https://solible.com/"}
  },
  {
    "chainId": 101,
    "address": "HsY8PNar8VExU335ZRYzg89fX7qa4upYu6vPMPFyCDdK",
    "symbol": "ADOR OPENS",
    "name": "ADOR OPENS",
    "decimals": 0,
    "tags": ["nft"],
    "extensions": {"website": "https://solible.com/"}
  },
  {
    "chainId": 101,
    "address": "EDP8TpLJ77M3KiDgFkZW4v4mhmKJHZi9gehYXenfFZuL",
    "symbol": "CMS - Rare",
    "name": "CMS - Rare",
    "decimals": 0,
    "tags": ["nft"],
    "extensions": {"website": "https://solible.com/"}
  },
  {
    "chainId": 101,
    "address": "BrUKFwAABkExb1xzYU4NkRWzjBihVQdZ3PBz4m5S8if3",
    "symbol": "Tesla",
    "name": "Tesla",
    "decimals": 0,
    "tags": ["nft"],
    "extensions": {"website": "https://solible.com/"}
  },
  {
    "chainId": 101,
    "address": "9CmQwpvVXRyixjiE3LrbSyyopPZohNDN1RZiTk8rnXsQ",
    "symbol": "DeceFi",
    "name": "DeceFi",
    "decimals": 0,
    "tags": ["nft"],
    "extensions": {"website": "https://solible.com/"}
  },
  {
    "chainId": 101,
    "address": "F6ST1wWkx2PeH45sKmRxo1boyuzzWCfpnvyKL4BGeLxF",
    "symbol": "Power User",
    "name": "Power User",
    "decimals": 0,
    "tags": ["nft"],
    "extensions": {"website": "https://solible.com/"}
  },
  {
    "chainId": 101,
    "address": "dZytJ7iPDcCu9mKe3srL7bpUeaR3zzkcVqbtqsmxtXZ",
    "symbol": "VIP Member",
    "name": "VIP Member",
    "decimals": 0,
    "tags": ["nft"],
    "extensions": {"website": "https://solible.com/"}
  },
  {
    "chainId": 101,
    "address": "8T4vXgwZUWwsbCDiptHFHjdfexvLG9UP8oy1psJWEQdS",
    "symbol": "Uni Christmas",
    "name": "Uni Christmas",
    "decimals": 0,
    "tags": ["nft"],
    "extensions": {"website": "https://solible.com/"}
  },
  {
    "chainId": 101,
    "address": "EjFGGJSyp9UDS8aqafET5LX49nsG326MeNezYzpiwgpQ",
    "symbol": "BNB",
    "name": "BNB",
    "decimals": 0,
    "tags": ["nft"],
    "extensions": {"website": "https://solible.com/"}
  },
  {
    "chainId": 101,
    "address": "FkmkTr4en8CXkfo9jAwEMov6PVNLpYMzWr3Udqf9so8Z",
    "symbol": "Seldom",
    "name": "Seldom",
    "decimals": 9,
    "tags": ["nft"],
    "extensions": {"website": "https://solible.com/"}
  },
  {
    "chainId": 101,
    "address": "2gn1PJdMAU92SU5inLSp4Xp16ZC5iLF6ScEi7UBvp8ZD",
    "symbol": "Satoshi Closeup",
    "name": "Satoshi Closeup",
    "decimals": 9,
    "tags": ["nft"],
    "extensions": {"website": "https://solible.com/"}
  },
  {
    "chainId": 101,
    "address": "7mhZHtPL4GFkquQR4Y6h34Q8hNkQvGc1FaNtyE43NvUR",
    "symbol": "Satoshi GB",
    "name": "Satoshi GB",
    "decimals": 9,
    "tags": ["nft"],
    "extensions": {"website": "https://solible.com/"}
  },
  {
    "chainId": 101,
    "address": "8RoKfLx5RCscbtVh8kYb81TF7ngFJ38RPomXtUREKsT2",
    "symbol": "Satoshi OG",
    "name": "Satoshi OG",
    "decimals": 9,
    "tags": ["nft"],
    "extensions": {"website": "https://solible.com/"}
  },
  {
    "chainId": 101,
    "address": "9rw5hyDngBQ3yDsCRHqgzGHERpU2zaLh1BXBUjree48J",
    "symbol": "Satoshi BTC",
    "name": "Satoshi BTC",
    "decimals": 9,
    "tags": ["nft"],
    "extensions": {"website": "https://solible.com/"}
  },
  {
    "chainId": 101,
    "address": "AiD7J6D5Hny5DJB1MrYBc2ePQqy2Yh4NoxWwYfR7PzxH",
    "symbol": "Satoshi GB",
    "name": "Satoshi GB",
    "decimals": 9,
    "tags": ["nft"],
    "extensions": {"website": "https://solible.com/"}
  },
  {
    "chainId": 101,
    "address": "4qzEcYvT6TuJME2EMZ5vjaLvQja6R4hKjarA73WQUwt6",
    "name": "APESZN_HOODIE",
    "symbol": "APESZN_HOODIE",
    "decimals": 0,
    "tags": ["nft"],
    "extensions": {"website": "https://solible.com/"}
  },
  {
    "chainId": 101,
    "address": "APhyVWtzjdTVYhyta9ngSiCDk2pLi8eEZKsHGSbsmwv6",
    "name": "APESZN_TEE_SHIRT",
    "symbol": "APESZN_TEE_SHIRT",
    "decimals": 0,
    "tags": ["nft"],
    "extensions": {"website": "https://solible.com/"}
  },
  {
    "chainId": 101,
    "address": "bxiA13fpU1utDmYuUvxvyMT8odew5FEm96MRv7ij3eb",
    "symbol": "Satoshi",
    "name": "Satoshi",
    "decimals": 9,
    "tags": ["nft"],
    "extensions": {"website": "https://solible.com/"}
  },
  {
    "chainId": 101,
    "address": "GoC24kpj6TkvjzspXrjSJC2CVb5zMWhLyRcHJh9yKjRF",
    "symbol": "Satoshi Closeup",
    "name": "Satoshi Closeup",
    "decimals": 9,
    "tags": ["nft"],
    "extensions": {"website": "https://solible.com/"}
  },
  {
    "chainId": 101,
    "address": "oCUduD44ETuZ65bpWdPzPDSnAdreg1sJrugfwyFZVHV",
    "symbol": "Satoshi BTC",
    "name": "Satoshi BTC",
    "decimals": 9,
    "tags": ["nft"],
    "extensions": {"website": "https://solible.com/"}
  },
  {
    "chainId": 101,
    "address": "9Vvre2DxBB9onibwYDHeMsY1cj6BDKtEDccBPWRN215E",
    "symbol": "Satoshi Nakamoto",
    "name": "Satoshi Nakamoto",
    "decimals": 9,
    "tags": ["nft"],
    "extensions": {"website": "https://solible.com/"}
  },
  {
    "chainId": 101,
    "address": "7RpFk44cMTAUt9CcjEMWnZMypE9bYQsjBiSNLn5qBvhP",
    "symbol": "Charles Hoskinson",
    "name": "Charles Hoskinson",
    "decimals": 9,
    "tags": ["nft"],
    "extensions": {"website": "https://solible.com/"}
  },
  {
    "chainId": 101,
    "address": "GyRkPAxpd9XrMHcBF6fYHVRSZQvQBwAGKAGQeBPSKzMq",
    "symbol": "SBF",
    "name": "SBF",
    "decimals": 0,
    "tags": ["nft"],
    "extensions": {"website": "https://solible.com/"}
  },
  {
    "chainId": 101,
    "address": "AgdBQN2Sy2abiZ2KToWeUsQ9PHdCv95wt6kVWRf5zDkx",
    "symbol": "Bitcoin Tram",
    "name": "Bitcoin Tram",
    "decimals": 0,
    "tags": ["nft"],
    "extensions": {"website": "https://solible.com/"}
  },
  {
    "chainId": 101,
    "address": "7TRzvCqXN8KSXggbSyeEG2Z9YBBhEFmbtmv6FLbd4mmd",
    "symbol": "SRM tee-shirt",
    "name": "SRM tee-shirt",
    "decimals": 0,
    "tags": ["nft"],
    "extensions": {"website": "https://solible.com/"}
  },
  {
    "chainId": 101,
    "address": "gksYzxitEf2HyE7Bb81vvHXNH5f3wa43jvXf4TcUZwb",
    "symbol": "PERK",
    "name": "PERK",
    "decimals": 6,
    "logoURI":
        "https://raw.githubusercontent.com/solana-labs/token-list/main/assets/mainnet/gksYzxitEf2HyE7Bb81vvHXNH5f3wa43jvXf4TcUZwb/logo.png",
    "tags": [],
    "extensions": {"website": "https://perk.exchange/"}
  },
  {
    "chainId": 101,
    "address": "BDxWSxkMLW1nJ3VggamUKkEKrtCaVqzFxoDApM8HdBks",
    "symbol": "BTSG",
    "name": "BitSong",
    "decimals": 6,
    "logoURI":
        "https://raw.githubusercontent.com/solana-labs/token-list/main/assets/mainnet/BDxWSxkMLW1nJ3VggamUKkEKrtCaVqzFxoDApM8HdBks/logo.png",
    "tags": [],
    "extensions": {"website": "https://bitsong.io/", "coingeckoId": "bitsong"}
  },
  {
    "chainId": 101,
    "address": "5ddiFxh3J2tcZHfn8uhGRYqu16P3FUvBfh8WoZPUHKW5",
    "name": "EOSBEAR",
    "symbol": "EOSBEAR",
    "decimals": 6,
    "logoURI": "",
    "tags": ["leveraged", "bear"],
    "extensions": {
      "coingeckoId": "3x-short-eos-token",
      "serumV3Usdc": "2BQrJP599QVKRyHhyJ6oRrTPNUmPBgXxiBo2duvYdacy"
    }
  },
  {
    "chainId": 101,
    "address": "qxxF6S62hmZF5bo46mS7C2qbBa87qRossAM78VzsDqi",
    "name": "EOSBULL",
    "symbol": "EOSBULL",
    "decimals": 6,
    "logoURI": "",
    "tags": ["leveraged", "bull"],
    "extensions": {"coingeckoId": "3x-long-eos-token"}
  },
  {
    "chainId": 101,
    "address": "2CDLbxeuqkLTLY3em6FFQgfBQV5LRnEsJJgcFCvWKNcS",
    "name": "BNBBEAR",
    "symbol": "BNBBEAR",
    "decimals": 6,
    "logoURI": "",
    "tags": ["leveraged", "bear"],
    "extensions": {"coingeckoId": "3x-short-bnb-token"}
  },
  {
    "chainId": 101,
    "address": "AfjHjdLibuXyvmz7PyTSc5KEcGBh43Kcu8Sr2tyDaJyt",
    "name": "BNBBULL",
    "symbol": "BNBBULL",
    "decimals": 6,
    "logoURI": "",
    "tags": ["leveraged", "bull"],
    "extensions": {"coingeckoId": "3x-long-bnb-token"}
  },
  {
    "chainId": 101,
    "address": "8kA1WJKoLTxtACNPkvW6UNufsrpxUY57tXZ9KmG9123t",
    "name": "BSVBULL",
    "symbol": "BSVBULL",
    "decimals": 6,
    "logoURI": "",
    "tags": ["leveraged", "bull"],
    "extensions": {"coingeckoId": "3x-long-bitcoin-sv-token"}
  },
  {
    "chainId": 101,
    "address": "2FGW8BVMu1EHsz2ZS9rZummDaq6o2DVrZZPw4KaAvDWh",
    "name": "BSVBEAR",
    "symbol": "BSVBEAR",
    "decimals": 6,
    "logoURI": "",
    "tags": ["leveraged", "bear"],
    "extensions": {"coingeckoId": "3x-short-bitcoin-sv-token"}
  },
  {
    "chainId": 101,
    "address": "8L9XGTMzcqS9p61zsR35t7qipwAXMYkD6disWoDFZiFT",
    "name": "LTCBEAR",
    "symbol": "LTCBEAR",
    "decimals": 6,
    "logoURI": "",
    "tags": ["leveraged", "bear"],
    "extensions": {"coingeckoId": "3x-short-litecoin-token"}
  },
  {
    "chainId": 101,
    "address": "863ZRjf1J8AaVuCqypAdm5ktVyGYDiBTvD1MNHKrwyjp",
    "name": "LTCBULL",
    "symbol": "LTCBULL",
    "decimals": 6,
    "logoURI": "",
    "tags": ["leveraged", "bull"],
    "extensions": {"coingeckoId": "3x-long-litecoin-token"}
  },
  {
    "chainId": 101,
    "address": "GkSPaHdY2raetuYzsJYacHtrAtQUfWt64bpd1VzxJgSD",
    "name": "BULL",
    "symbol": "BULL",
    "decimals": 6,
    "logoURI": "",
    "tags": ["leveraged", "bull"],
    "extensions": {"coingeckoId": "3x-long-bitcoin-token"}
  },
  {
    "chainId": 101,
    "address": "45vwTZSDFBiqCMRdtK4xiLCHEov8LJRW8GwnofG8HYyH",
    "name": "BEAR",
    "symbol": "BEAR",
    "decimals": 6,
    "logoURI": "",
    "tags": ["leveraged", "bear"],
    "extensions": {"coingeckoId": "3x-short-bitcoin-token"}
  },
  {
    "chainId": 101,
    "address": "2VTAVf1YCwamD3ALMdYHRMV5vPUCXdnatJH5f1khbmx6",
    "name": "BCHBEAR",
    "symbol": "BCHBEAR",
    "decimals": 6,
    "logoURI": "",
    "tags": ["leveraged", "bear"],
    "extensions": {"coingeckoId": "3x-short-bitcoin-cash-token"}
  },
  {
    "chainId": 101,
    "address": "22xoSp66BDt4x4Q5xqxjaSnirdEyharoBziSFChkLFLy",
    "name": "BCHBULL",
    "symbol": "BCHBULL",
    "decimals": 6,
    "logoURI": "",
    "tags": ["leveraged", "bull"],
    "extensions": {"coingeckoId": "3x-long-bitcoin-cash-token"}
  },
  {
    "chainId": 101,
    "address": "CwChm6p9Q3yFrjzVeiLTTbsoJkooscof5SJYZc2CrNqG",
    "name": "ETHBULL",
    "symbol": "ETHBULL",
    "decimals": 6,
    "logoURI": "",
    "tags": ["leveraged", "bull"],
    "extensions": {
      "coingeckoId": "3x-long-ethereum-token",
      "serumV3Usdt": "FuhKVt5YYCv7vXnADXtb7vqzYn82PJoap86q5wm8LX8Q"
    }
  },
  {
    "chainId": 101,
    "address": "Bvv9xLodFrvDFSno9Ud8SEh5zVtBDQQjnBty2SgMcJ2s",
    "name": "ETHBEAR",
    "symbol": "ETHBEAR",
    "decimals": 6,
    "logoURI": "",
    "tags": ["leveraged", "bear"],
    "extensions": {"coingeckoId": "3x-short-ethereum-token"}
  },
  {
    "chainId": 101,
    "address": "HRhaNssoyv5tKFRcbPg69ULEbcD8DPv99GdXLcdkgc1A",
    "name": "ALTBULL",
    "symbol": "ALTBULL",
    "decimals": 6,
    "logoURI": "",
    "tags": ["leveraged", "bull"],
    "extensions": {"coingeckoId": "3x-long-altcoin-index-token"}
  },
  {
    "chainId": 101,
    "address": "9Mu1KmjBKTUWgpDoeTJ5oD7XFQmEiZxzspEd3TZGkavx",
    "name": "ALTBEAR",
    "symbol": "ALTBEAR",
    "decimals": 6,
    "logoURI": "",
    "tags": ["leveraged", "bear"],
    "extensions": {"coingeckoId": "3x-short-altcoin-index-token"}
  },
  {
    "chainId": 101,
    "address": "AYL1adismZ1U9pTuN33ahG4aYc5XTZQL4vKFx9ofsGWD",
    "name": "BULLSHIT",
    "symbol": "BULLSHIT",
    "decimals": 6,
    "logoURI": "",
    "tags": ["leveraged", "bull"],
    "extensions": {"coingeckoId": "3x-long-shitcoin-index-token"}
  },
  {
    "chainId": 101,
    "address": "5jqymuoXXVcUuJKrf1MWiHSqHyg2osMaJGVy69NsJWyP",
    "name": "BEARSHIT",
    "symbol": "BEARSHIT",
    "decimals": 6,
    "logoURI": "",
    "tags": ["leveraged", "bear"],
    "extensions": {"coingeckoId": "3x-short-shitcoin-index-token"}
  },
  {
    "chainId": 101,
    "address": "EL1aDTnLKjf4SaGpqtxJPyK94imSBr8fWDbcXjXQrsmj",
    "name": "MIDBULL",
    "symbol": "MIDBULL",
    "decimals": 6,
    "logoURI": "",
    "tags": ["leveraged", "bull"],
    "extensions": {
      "coingeckoId": "3x-long-midcap-index-token",
      "serumV3Usdc": "8BBtLkoaEyavREriwGUudzAcihTH9SJLAPBbgb7QZe9y"
    }
  },
  {
    "chainId": 101,
    "address": "2EPvVjHusU3ozoucmdhhnqv3HQtBsQmjTnSa87K91HkC",
    "name": "MIDBEAR",
    "symbol": "MIDBEAR",
    "decimals": 6,
    "logoURI": "",
    "tags": ["leveraged", "bear"],
    "extensions": {"coingeckoId": "3x-short-midcap-index-token"}
  },
  {
    "chainId": 101,
    "address": "8TCfJTyeqNBZqyDMY4VwDY7kdCCY7pcbJJ58CnKHkMu2",
    "name": "LINKBEAR",
    "symbol": "LINKBEAR",
    "decimals": 6,
    "logoURI": "",
    "tags": ["leveraged", "bear"],
    "extensions": {"coingeckoId": "3x-short-chainlink-token"}
  },
  {
    "chainId": 101,
    "address": "EsUoZMbACNMppdqdmuLCFLet8VXxt2h47N9jHCKwyaPz",
    "name": "LINKBULL",
    "symbol": "LINKBULL",
    "decimals": 6,
    "logoURI": "",
    "tags": ["leveraged", "bull"],
    "extensions": {"coingeckoId": "3x-long-chainlink-token"}
  },
  {
    "chainId": 101,
    "address": "262cQHT3soHwzuo2oVSy5kAfHcFZ1Jjn8C1GRLcQNKA3",
    "name": "XRPBULL",
    "symbol": "XRPBULL",
    "decimals": 6,
    "logoURI": "",
    "tags": ["leveraged", "bull"],
    "extensions": {"coingeckoId": "3x-long-xrp-token"}
  },
  {
    "chainId": 101,
    "address": "5AX3ZyDN1rpamEzHpLfsJ5t6TyNECKSwPRfnzVHVuRFj",
    "symbol": "YUMZ",
    "name": "Food tasting Social Token",
    "decimals": 8,
    "logoURI": "https://cdn.jsdelivr.net/gh/yu-ming-chen/yumzToken/logo.JPG",
    "tags": ["social-token", "yumz"]
  },
  {
    "chainId": 101,
    "address": "8sxtSswmQ7Lcd2GjK6am37Z61wJZjA2SzE7Luf7yaKBB",
    "name": "XRPBEAR",
    "symbol": "XRPBEAR",
    "decimals": 6,
    "logoURI": "",
    "tags": ["leveraged", "bear"],
    "extensions": {"coingeckoId": "3x-short-xrp-token"}
  },
  {
    "chainId": 101,
    "address": "91z91RukFM16hyEUCXuwMQwp2BW3vanNG5Jh5yj6auiJ",
    "name": "BVOL",
    "symbol": "BVOL",
    "decimals": 6,
    "logoURI": "",
    "tags": [],
    "extensions": {"coingeckoId": "1x-long-btc-implied-volatility-token"}
  },
  {
    "chainId": 101,
    "address": "5TY71D29Cyuk9UrsSxLXw2quJBpS7xDDFuFu2K9W7Wf9",
    "name": "IBlive",
    "symbol": "IBVOL",
    "decimals": 6,
    "logoURI": "",
    "tags": [],
    "extensions": {"coingeckoId": "1x-short-btc-implied-volatility"}
  },
  {
    "chainId": 101,
    "address": "dK83wTVypEpa1pqiBbHY3MNuUnT3ADUZM4wk9VZXZEc",
    "name": "Wrapped Aave",
    "symbol": "AAVE",
    "decimals": 6,
    "logoURI":
        "https://raw.githubusercontent.com/solana-labs/token-list/main/assets/mainnet/dK83wTVypEpa1pqiBbHY3MNuUnT3ADUZM4wk9VZXZEc/logo.png",
    "tags": [],
    "extensions": {
      "serumV3Usdt": "6bxuB5N3bt3qW8UnPNLgMMzDq5sEH8pFmYJYGgzvE11V",
      "coingeckoId": "aave"
    }
  },
  {
    "chainId": 101,
    "address": "A6aY2ceogBz1VaXBxm1j2eJuNZMRqrWUAnKecrMH85zj",
    "name": "LQID",
    "symbol": "LQID",
    "decimals": 6,
    "logoURI":
        "https://raw.githubusercontent.com/solana-labs/token-list/main/assets/mainnet/A6aY2ceogBz1VaXBxm1j2eJuNZMRqrWUAnKecrMH85zj/logo.svg",
    "tags": []
  },
  {
    "chainId": 101,
    "address": "7CnFGR9mZWyAtWxPcVuTewpyC3A3MDW4nLsu5NY6PDbd",
    "name": "SECO",
    "symbol": "SECO",
    "decimals": 6,
    "logoURI": "",
    "tags": [],
    "extensions": {"coingeckoId": "serum-ecosystem-token"}
  },
  {
    "chainId": 101,
    "address": "3GECTP7H4Tww3w8jEPJCJtXUtXxiZty31S9szs84CcwQ",
    "name": "HOLY",
    "symbol": "HOLY",
    "decimals": 6,
    "logoURI": "",
    "tags": [],
    "extensions": {"coingeckoId": "holy-trinity"}
  },
  {
    "chainId": 101,
    "address": "6ry4WBDvAwAnrYJVv6MCog4J8zx6S3cPgSqnTsDZ73AR",
    "name": "TRYB",
    "symbol": "TRYB",
    "decimals": 6,
    "logoURI": "",
    "tags": [],
    "extensions": {
      "serumV3Usdt": "AADohBGxvf7bvixs2HKC3dG2RuU3xpZDwaTzYFJThM8U",
      "coingeckoId": "bilira"
    }
  },
  {
    "chainId": 101,
    "address": "ASboaJPFtJeCS5eG4gL3Lg95xrTz2UZSLE9sdJtY93kE",
    "name": "DOGEBULL",
    "symbol": "DOGEBULL",
    "decimals": 6,
    "logoURI": "",
    "tags": ["leveraged", "bull"],
    "extensions": {"coingeckoId": "3x-long-dogecoin-token"}
  },
  {
    "chainId": 101,
    "address": "Gnhy3boBT4MA8TTjGip5ND2uNsceh1Wgeaw1rYJo51ZY",
    "symbol": "MAPSPOOL",
    "name": "Bonfida Maps Pool",
    "decimals": 6,
    "logoURI":
        "https://raw.githubusercontent.com/solana-labs/token-list/main/assets/mainnet/Gnhy3boBT4MA8TTjGip5ND2uNsceh1Wgeaw1rYJo51ZY/logo.svg",
    "tags": [],
    "extensions": {"website": "https://bonfida.com/"}
  },
  {
    "chainId": 101,
    "address": "9iDWyYZ5VHBCxxmWZogoY3Z6FSbKsX4WFe37c728krdT",
    "symbol": "OXYPOOL",
    "name": "Bonfida Oxy Pool",
    "decimals": 6,
    "logoURI":
        "https://raw.githubusercontent.com/solana-labs/token-list/main/assets/mainnet/9iDWyYZ5VHBCxxmWZogoY3Z6FSbKsX4WFe37c728krdT/logo.svg",
    "tags": [],
    "extensions": {"website": "https://bonfida.com/"}
  },
  {
    "chainId": 101,
    "address": "D68NB5JkzvyNCZAvi6EGtEcGvSoRNPanU9heYTAUFFRa",
    "name": "PERP",
    "symbol": "PERP",
    "decimals": 6,
    "logoURI":
        "https://raw.githubusercontent.com/solana-labs/token-list/main/assets/mainnet/D68NB5JkzvyNCZAvi6EGtEcGvSoRNPanU9heYTAUFFRa/logo.png",
    "tags": [],
    "extensions": {"coingeckoId": "perpetual-protocol"}
  },
  {
    "chainId": 101,
    "address": "93a1L7xaEV7vZGzNXCcb9ztZedbpKgUiTHYxmFKJwKvc",
    "symbol": "RAYPOOL",
    "name": "Bonfida Ray Pool",
    "decimals": 6,
    "logoURI":
        "https://raw.githubusercontent.com/solana-labs/token-list/main/assets/mainnet/93a1L7xaEV7vZGzNXCcb9ztZedbpKgUiTHYxmFKJwKvc/logo.png",
    "tags": [],
    "extensions": {"website": "https://bonfida.com/"}
  },
  {
    "chainId": 101,
    "address": "FeGn77dhg1KXRRFeSwwMiykZnZPw5JXW6naf2aQgZDQf",
    "symbol": "wWETH",
    "name": "Wrapped Ether (Wormhole)",
    "decimals": 9,
    "logoURI":
        "https://raw.githubusercontent.com/solana-labs/token-list/main/assets/mainnet/FeGn77dhg1KXRRFeSwwMiykZnZPw5JXW6naf2aQgZDQf/logo.png",
    "tags": ["wrapped", "wormhole"],
    "extensions": {
      "address": "0xC02aaA39b223FE8D0A0e5C4F27eAD9083C756Cc2",
      "bridgeContract": "https://etherscan.io/address/0xf92cD566Ea4864356C5491c177A430C222d7e678",
      "assetContract": "https://etherscan.io/address/0xC02aaA39b223FE8D0A0e5C4F27eAD9083C756Cc2",
      "coingeckoId": "weth"
    }
  },
  {
    "chainId": 101,
    "address": "GbBWwtYTMPis4VHb8MrBbdibPhn28TSrLB53KvUmb7Gi",
    "symbol": "wFTT",
    "name": "Wrapped FTT (Wormhole)",
    "decimals": 9,
    "logoURI":
        "https://raw.githubusercontent.com/solana-labs/token-list/main/assets/mainnet/GbBWwtYTMPis4VHb8MrBbdibPhn28TSrLB53KvUmb7Gi/logo.png",
    "tags": ["wrapped", "wormhole"],
    "extensions": {
      "address": "0x50d1c9771902476076ecfc8b2a83ad6b9355a4c9",
      "bridgeContract": "https://etherscan.io/address/0xf92cD566Ea4864356C5491c177A430C222d7e678",
      "assetContract": "https://etherscan.io/address/0x50d1c9771902476076ecfc8b2a83ad6b9355a4c9",
      "coingeckoId": "ftx-token"
    }
  },
  {
    "chainId": 101,
    "address": "AbLwQCyU9S8ycJgu8wn6woRCHSYJmjMpJFcAHQ6vjq2P",
    "symbol": "wTUSD",
    "name": "TrueUSD (Wormhole)",
    "decimals": 9,
    "logoURI":
        "https://raw.githubusercontent.com/solana-labs/token-list/main/assets/mainnet/AbLwQCyU9S8ycJgu8wn6woRCHSYJmjMpJFcAHQ6vjq2P/logo.png",
    "tags": ["wrapped", "wormhole"],
    "extensions": {
      "address": "0x0000000000085d4780B73119b644AE5ecd22b376",
      "bridgeContract": "https://etherscan.io/address/0xf92cD566Ea4864356C5491c177A430C222d7e678",
      "assetContract": "https://etherscan.io/address/0x0000000000085d4780B73119b644AE5ecd22b376",
      "coingeckoId": "true-usd"
    }
  },
  {
    "chainId": 101,
    "address": "3JfuyCg5891hCX1ZTbvt3pkiaww3XwgyqQH6E9eHtqKD",
    "symbol": "wLON",
    "name": "Tokenlon (Wormhole)",
    "decimals": 9,
    "logoURI":
        "https://raw.githubusercontent.com/solana-labs/token-list/main/assets/mainnet/3JfuyCg5891hCX1ZTbvt3pkiaww3XwgyqQH6E9eHtqKD/logo.png",
    "tags": ["wrapped", "wormhole"],
    "extensions": {
      "address": "0x0000000000095413afC295d19EDeb1Ad7B71c952",
      "bridgeContract": "https://etherscan.io/address/0xf92cD566Ea4864356C5491c177A430C222d7e678",
      "assetContract": "https://etherscan.io/address/0x0000000000095413afC295d19EDeb1Ad7B71c952",
      "coingeckoId": "tokenlon"
    }
  },
  {
    "chainId": 101,
    "address": "6k7mrqiAqEWnABVN8FhfuNUrmrnaMh44nNWydNXctbpV",
    "symbol": "wALBT",
    "name": "AllianceBlock Token (Wormhole)",
    "decimals": 9,
    "logoURI":
        "https://raw.githubusercontent.com/solana-labs/token-list/main/assets/mainnet/6k7mrqiAqEWnABVN8FhfuNUrmrnaMh44nNWydNXctbpV/logo.png",
    "tags": ["wrapped", "wormhole"],
    "extensions": {
      "address": "0x00a8b738E453fFd858a7edf03bcCfe20412f0Eb0",
      "bridgeContract": "https://etherscan.io/address/0xf92cD566Ea4864356C5491c177A430C222d7e678",
      "assetContract": "https://etherscan.io/address/0x00a8b738E453fFd858a7edf03bcCfe20412f0Eb0",
      "coingeckoId": "allianceblock"
    }
  },
  {
    "chainId": 101,
    "address": "4b166BQEQunjg8oNTDcLeWU3nidQnVTL1Vni8ANU7Mvt",
    "symbol": "wSKL",
    "name": "SKALE (Wormhole)",
    "decimals": 9,
    "logoURI":
        "https://raw.githubusercontent.com/solana-labs/token-list/main/assets/mainnet/4b166BQEQunjg8oNTDcLeWU3nidQnVTL1Vni8ANU7Mvt/logo.png",
    "tags": ["wrapped", "wormhole"],
    "extensions": {
      "address": "0x00c83aeCC790e8a4453e5dD3B0B4b3680501a7A7",
      "bridgeContract": "https://etherscan.io/address/0xf92cD566Ea4864356C5491c177A430C222d7e678",
      "assetContract": "https://etherscan.io/address/0x00c83aeCC790e8a4453e5dD3B0B4b3680501a7A7",
      "coingeckoId": "skale"
    }
  },
  {
    "chainId": 101,
    "address": "CcHhpEx9VcWx7UBJC8DJaR5h3wNdexsQtB1nEfekjSHn",
    "symbol": "wUFT",
    "name": "UniLend Finance Token (Wormhole)",
    "decimals": 9,
    "logoURI":
        "https://raw.githubusercontent.com/solana-labs/token-list/main/assets/mainnet/CcHhpEx9VcWx7UBJC8DJaR5h3wNdexsQtB1nEfekjSHn/logo.png",
    "tags": ["wrapped", "wormhole"],
    "extensions": {
      "address": "0x0202Be363B8a4820f3F4DE7FaF5224fF05943AB1",
      "bridgeContract": "https://etherscan.io/address/0xf92cD566Ea4864356C5491c177A430C222d7e678",
      "assetContract": "https://etherscan.io/address/0x0202Be363B8a4820f3F4DE7FaF5224fF05943AB1",
      "coingeckoId": "unlend-finance"
    }
  },
  {
    "chainId": 101,
    "address": "VPjCJkR1uZGT9k9q7PsLArS5sEQtWgij8eZC8tysCy7",
    "symbol": "wORN",
    "name": "Orion Protocol (Wormhole)",
    "decimals": 8,
    "logoURI":
        "https://raw.githubusercontent.com/solana-labs/token-list/main/assets/mainnet/VPjCJkR1uZGT9k9q7PsLArS5sEQtWgij8eZC8tysCy7/logo.png",
    "tags": ["wrapped", "wormhole"],
    "extensions": {
      "address": "0x0258F474786DdFd37ABCE6df6BBb1Dd5dfC4434a",
      "bridgeContract": "https://etherscan.io/address/0xf92cD566Ea4864356C5491c177A430C222d7e678",
      "assetContract": "https://etherscan.io/address/0x0258F474786DdFd37ABCE6df6BBb1Dd5dfC4434a",
      "coingeckoId": "orion-protocol"
    }
  },
  {
    "chainId": 101,
    "address": "CxzHZtzrm6bAz6iFCAGgCYCd3iQb5guUD7oQXKxdgk5c",
    "symbol": "wSRK",
    "name": "SparkPoint (Wormhole)",
    "decimals": 9,
    "logoURI":
        "https://raw.githubusercontent.com/solana-labs/token-list/main/assets/mainnet/CxzHZtzrm6bAz6iFCAGgCYCd3iQb5guUD7oQXKxdgk5c/logo.png",
    "tags": ["wrapped", "wormhole"],
    "extensions": {
      "address": "0x0488401c3F535193Fa8Df029d9fFe615A06E74E6",
      "bridgeContract": "https://etherscan.io/address/0xf92cD566Ea4864356C5491c177A430C222d7e678",
      "assetContract": "https://etherscan.io/address/0x0488401c3F535193Fa8Df029d9fFe615A06E74E6",
      "coingeckoId": "sparkpoint"
    }
  },
  {
    "chainId": 101,
    "address": "FqMZWvmii4NNzhLBKGzkvGj3e3XTxNVDNSKDJnt9fVQV",
    "symbol": "wUMA",
    "name": "UMA Voting Token v1 (Wormhole)",
    "decimals": 9,
    "logoURI":
        "https://raw.githubusercontent.com/solana-labs/token-list/main/assets/mainnet/FqMZWvmii4NNzhLBKGzkvGj3e3XTxNVDNSKDJnt9fVQV/logo.png",
    "tags": ["wrapped", "wormhole"],
    "extensions": {
      "address": "0x04Fa0d235C4abf4BcF4787aF4CF447DE572eF828",
      "bridgeContract": "https://etherscan.io/address/0xf92cD566Ea4864356C5491c177A430C222d7e678",
      "assetContract": "https://etherscan.io/address/0x04Fa0d235C4abf4BcF4787aF4CF447DE572eF828",
      "coingeckoId": "uma"
    }
  },
  {
    "chainId": 101,
    "address": "6GGNzF99kCG1ozQbP7M7EYW9zPbQGPMwTCCi2Dqx3qhU",
    "symbol": "wSkey",
    "name": "SmartKey (Wormhole)",
    "decimals": 8,
    "logoURI":
        "https://raw.githubusercontent.com/solana-labs/token-list/main/assets/mainnet/6GGNzF99kCG1ozQbP7M7EYW9zPbQGPMwTCCi2Dqx3qhU/logo.png",
    "tags": ["wrapped", "wormhole"],
    "extensions": {
      "address": "0x06A01a4d579479Dd5D884EBf61A31727A3d8D442",
      "bridgeContract": "https://etherscan.io/address/0xf92cD566Ea4864356C5491c177A430C222d7e678",
      "assetContract": "https://etherscan.io/address/0x06A01a4d579479Dd5D884EBf61A31727A3d8D442",
      "coingeckoId": "smartkey"
    }
  },
  {
    "chainId": 101,
    "address": "Gc9rR2dUHfuYCJ8rU1Ye9fr8JoZZt9ZrfmXitQRLsxRW",
    "symbol": "wMIR",
    "name": "Wrapped MIR Token (Wormhole)",
    "decimals": 9,
    "logoURI":
        "https://raw.githubusercontent.com/solana-labs/token-list/main/assets/mainnet/Gc9rR2dUHfuYCJ8rU1Ye9fr8JoZZt9ZrfmXitQRLsxRW/logo.png",
    "tags": ["wrapped", "wormhole"],
    "extensions": {
      "address": "0x09a3EcAFa817268f77BE1283176B946C4ff2E608",
      "bridgeContract": "https://etherscan.io/address/0xf92cD566Ea4864356C5491c177A430C222d7e678",
      "assetContract": "https://etherscan.io/address/0x09a3EcAFa817268f77BE1283176B946C4ff2E608",
      "coingeckoId": "mirror-protocol"
    }
  },
  {
    "chainId": 101,
    "address": "B8xDqdrHpYLNHQKQ4ARDKurxhkhn2gfZa8WRosCEzXnF",
    "symbol": "wGRO",
    "name": "Growth (Wormhole)",
    "decimals": 9,
    "logoURI":
        "https://raw.githubusercontent.com/solana-labs/token-list/main/assets/mainnet/B8xDqdrHpYLNHQKQ4ARDKurxhkhn2gfZa8WRosCEzXnF/logo.png",
    "tags": ["wrapped", "wormhole"],
    "extensions": {
      "address": "0x09e64c2B61a5f1690Ee6fbeD9baf5D6990F8dFd0",
      "bridgeContract": "https://etherscan.io/address/0xf92cD566Ea4864356C5491c177A430C222d7e678",
      "assetContract": "https://etherscan.io/address/0x09e64c2B61a5f1690Ee6fbeD9baf5D6990F8dFd0",
      "coingeckoId": "growth-defi"
    }
  },
  {
    "chainId": 101,
    "address": "GE1X8ef7fcsJ93THx4CvV7BQsdEyEAyk61s2L5YfSXiL",
    "symbol": "wSTAKE",
    "name": "xDai (Wormhole)",
    "decimals": 9,
    "logoURI":
        "https://raw.githubusercontent.com/solana-labs/token-list/main/assets/mainnet/GE1X8ef7fcsJ93THx4CvV7BQsdEyEAyk61s2L5YfSXiL/logo.png",
    "tags": ["wrapped", "wormhole"],
    "extensions": {
      "address": "0x0Ae055097C6d159879521C384F1D2123D1f195e6",
      "bridgeContract": "https://etherscan.io/address/0xf92cD566Ea4864356C5491c177A430C222d7e678",
      "assetContract": "https://etherscan.io/address/0x0Ae055097C6d159879521C384F1D2123D1f195e6",
      "coingeckoId": "xdai-stake"
    }
  },
  {
    "chainId": 101,
    "address": "7TK6QeyTsnTT6KsnK2tHHfh62mbjNuFWoyUc8vo3CmmU",
    "symbol": "wYFI",
    "name": "yearn.finance (Wormhole)",
    "decimals": 9,
    "logoURI":
        "https://raw.githubusercontent.com/solana-labs/token-list/main/assets/mainnet/7TK6QeyTsnTT6KsnK2tHHfh62mbjNuFWoyUc8vo3CmmU/logo.png",
    "tags": ["wrapped", "wormhole"],
    "extensions": {
      "address": "0x0bc529c00C6401aEF6D220BE8C6Ea1667F6Ad93e",
      "bridgeContract": "https://etherscan.io/address/0xf92cD566Ea4864356C5491c177A430C222d7e678",
      "assetContract": "https://etherscan.io/address/0x0bc529c00C6401aEF6D220BE8C6Ea1667F6Ad93e",
      "coingeckoId": "yearn-finance"
    }
  },
  {
    "chainId": 101,
    "address": "CTtKth9uW7froBA6xCd2MP7BXjGFESdT1SyxUmbHovSw",
    "symbol": "wBAT",
    "name": "Basic Attention Token (Wormhole)",
    "decimals": 9,
    "logoURI":
        "https://raw.githubusercontent.com/solana-labs/token-list/main/assets/mainnet/CTtKth9uW7froBA6xCd2MP7BXjGFESdT1SyxUmbHovSw/logo.png",
    "tags": ["wrapped", "wormhole"],
    "extensions": {
      "address": "0x0D8775F648430679A709E98d2b0Cb6250d2887EF",
      "bridgeContract": "https://etherscan.io/address/0xf92cD566Ea4864356C5491c177A430C222d7e678",
      "assetContract": "https://etherscan.io/address/0x0D8775F648430679A709E98d2b0Cb6250d2887EF",
      "coingeckoId": "basic-attention-token"
    }
  },
  {
    "chainId": 101,
    "address": "DrL2D4qCRCeNkQz3AJikLjBc3cS6fqqcQ3W7T9vbshCu",
    "symbol": "wMANA",
    "name": "Decentraland MANA (Wormhole)",
    "decimals": 9,
    "logoURI":
        "https://raw.githubusercontent.com/solana-labs/token-list/main/assets/mainnet/DrL2D4qCRCeNkQz3AJikLjBc3cS6fqqcQ3W7T9vbshCu/logo.png",
    "tags": ["wrapped", "wormhole"],
    "extensions": {
      "address": "0x0F5D2fB29fb7d3CFeE444a200298f468908cC942",
      "bridgeContract": "https://etherscan.io/address/0xf92cD566Ea4864356C5491c177A430C222d7e678",
      "assetContract": "https://etherscan.io/address/0x0F5D2fB29fb7d3CFeE444a200298f468908cC942",
      "coingeckoId": "decentraland"
    }
  },
  {
    "chainId": 101,
    "address": "3cJKTW69FQDDCud7AhKHXZg126b3t73a2qVcVBS1BWjL",
    "symbol": "wXIO",
    "name": "XIO Network (Wormhole)",
    "decimals": 9,
    "logoURI":
        "https://raw.githubusercontent.com/solana-labs/token-list/main/assets/mainnet/3cJKTW69FQDDCud7AhKHXZg126b3t73a2qVcVBS1BWjL/logo.png",
    "tags": ["wrapped", "wormhole"],
    "extensions": {
      "address": "0x0f7F961648aE6Db43C75663aC7E5414Eb79b5704",
      "bridgeContract": "https://etherscan.io/address/0xf92cD566Ea4864356C5491c177A430C222d7e678",
      "assetContract": "https://etherscan.io/address/0x0f7F961648aE6Db43C75663aC7E5414Eb79b5704",
      "coingeckoId": "xio"
    }
  },
  {
    "chainId": 101,
    "address": "CQivbzuRQLvZbqefKc5gLzhSzZzAaySAdMmTG7pFn41w",
    "symbol": "wLAYER",
    "name": "Unilayer (Wormhole)",
    "decimals": 9,
    "logoURI":
        "https://raw.githubusercontent.com/solana-labs/token-list/main/assets/mainnet/CQivbzuRQLvZbqefKc5gLzhSzZzAaySAdMmTG7pFn41w/logo.png",
    "tags": ["wrapped", "wormhole"],
    "extensions": {
      "address": "0x0fF6ffcFDa92c53F615a4A75D982f399C989366b",
      "bridgeContract": "https://etherscan.io/address/0xf92cD566Ea4864356C5491c177A430C222d7e678",
      "assetContract": "https://etherscan.io/address/0x0fF6ffcFDa92c53F615a4A75D982f399C989366b",
      "coingeckoId": "unilayer"
    }
  },
  {
    "chainId": 101,
    "address": "C1LpKYrkVvWF5imsQ7JqJSZHj9NXNmJ5tEHkGTtLVH2L",
    "symbol": "wUMX",
    "name": "https://unimex.network/ (Wormhole)",
    "decimals": 9,
    "logoURI":
        "https://raw.githubusercontent.com/solana-labs/token-list/main/assets/mainnet/C1LpKYrkVvWF5imsQ7JqJSZHj9NXNmJ5tEHkGTtLVH2L/logo.png",
    "tags": ["wrapped", "wormhole"],
    "extensions": {
      "address": "0x10Be9a8dAe441d276a5027936c3aADEd2d82bC15",
      "bridgeContract": "https://etherscan.io/address/0xf92cD566Ea4864356C5491c177A430C222d7e678",
      "assetContract": "https://etherscan.io/address/0x10Be9a8dAe441d276a5027936c3aADEd2d82bC15",
      "coingeckoId": "unimex-network"
    }
  },
  {
    "chainId": 101,
    "address": "8F3kZd9XEpFgNZ4fZnEAC5CJZLewnkNE8QCjdvorGWuW",
    "symbol": "w1INCH",
    "name": "1INCH Token (Wormhole)",
    "decimals": 9,
    "logoURI":
        "https://raw.githubusercontent.com/solana-labs/token-list/main/assets/mainnet/8F3kZd9XEpFgNZ4fZnEAC5CJZLewnkNE8QCjdvorGWuW/logo.png",
    "tags": ["wrapped", "wormhole"],
    "extensions": {
      "address": "0x111111111117dC0aa78b770fA6A738034120C302",
      "bridgeContract": "https://etherscan.io/address/0xf92cD566Ea4864356C5491c177A430C222d7e678",
      "assetContract": "https://etherscan.io/address/0x111111111117dC0aa78b770fA6A738034120C302",
      "coingeckoId": "1inch"
    }
  },
  {
    "chainId": 101,
    "address": "H3UMboX4tnjba1Xw1a2VhUtkdgnrbmPvmDm6jaouQDN9",
    "symbol": "wARMOR",
    "name": "Armor (Wormhole)",
    "decimals": 9,
    "logoURI":
        "https://raw.githubusercontent.com/solana-labs/token-list/main/assets/mainnet/H3UMboX4tnjba1Xw1a2VhUtkdgnrbmPvmDm6jaouQDN9/logo.png",
    "tags": ["wrapped", "wormhole"],
    "extensions": {
      "address": "0x1337DEF16F9B486fAEd0293eb623Dc8395dFE46a",
      "bridgeContract": "https://etherscan.io/address/0xf92cD566Ea4864356C5491c177A430C222d7e678",
      "assetContract": "https://etherscan.io/address/0x1337DEF16F9B486fAEd0293eb623Dc8395dFE46a",
      "coingeckoId": "armor"
    }
  },
  {
    "chainId": 101,
    "address": "Cw26Yz3rAN42mM5WpKriuGvbXnvRYmFA9sbBWH49KyqL",
    "symbol": "warNXM",
    "name": "Armor NXM (Wormhole)",
    "decimals": 9,
    "logoURI":
        "https://raw.githubusercontent.com/solana-labs/token-list/main/assets/mainnet/Cw26Yz3rAN42mM5WpKriuGvbXnvRYmFA9sbBWH49KyqL/logo.png",
    "tags": ["wrapped", "wormhole"],
    "extensions": {
      "address": "0x1337DEF18C680aF1f9f45cBcab6309562975b1dD",
      "bridgeContract": "https://etherscan.io/address/0xf92cD566Ea4864356C5491c177A430C222d7e678",
      "assetContract": "https://etherscan.io/address/0x1337DEF18C680aF1f9f45cBcab6309562975b1dD",
      "coingeckoId": "armor-nxm"
    }
  },
  {
    "chainId": 101,
    "address": "3GVAecXsFP8xLFuAMMpg5NU4g5JK6h2NZWsQJ45wiw6b",
    "symbol": "wDPI",
    "name": "DefiPulse Index (Wormhole)",
    "decimals": 9,
    "logoURI":
        "https://raw.githubusercontent.com/solana-labs/token-list/main/assets/mainnet/3GVAecXsFP8xLFuAMMpg5NU4g5JK6h2NZWsQJ45wiw6b/logo.png",
    "tags": ["wrapped", "wormhole"],
    "extensions": {
      "address": "0x1494CA1F11D487c2bBe4543E90080AeBa4BA3C2b",
      "bridgeContract": "https://etherscan.io/address/0xf92cD566Ea4864356C5491c177A430C222d7e678",
      "assetContract": "https://etherscan.io/address/0x1494CA1F11D487c2bBe4543E90080AeBa4BA3C2b",
      "coingeckoId": "defipulse-index"
    }
  },
  {
    "chainId": 101,
    "address": "AC4BK5yoEKn5hw6WpH3iWu56pEwigQdR48CiiqJ3R1pd",
    "symbol": "wDHC",
    "name": "DeltaHub Community (Wormhole)",
    "decimals": 9,
    "logoURI":
        "https://raw.githubusercontent.com/solana-labs/token-list/main/assets/mainnet/AC4BK5yoEKn5hw6WpH3iWu56pEwigQdR48CiiqJ3R1pd/logo.png",
    "tags": ["wrapped", "wormhole"],
    "extensions": {
      "address": "0x152687Bc4A7FCC89049cF119F9ac3e5aCF2eE7ef",
      "bridgeContract": "https://etherscan.io/address/0xf92cD566Ea4864356C5491c177A430C222d7e678",
      "assetContract": "https://etherscan.io/address/0x152687Bc4A7FCC89049cF119F9ac3e5aCF2eE7ef",
      "coingeckoId": "deltahub-community"
    }
  },
  {
    "chainId": 101,
    "address": "7bXgNP7SEwrqbnfLBPgKDRKSGjVe7cjbuioRP23upF5H",
    "symbol": "wKEX",
    "name": "KIRA Network (Wormhole)",
    "decimals": 6,
    "logoURI":
        "https://raw.githubusercontent.com/solana-labs/token-list/main/assets/mainnet/7bXgNP7SEwrqbnfLBPgKDRKSGjVe7cjbuioRP23upF5H/logo.png",
    "tags": ["wrapped", "wormhole"],
    "extensions": {
      "address": "0x16980b3B4a3f9D89E33311B5aa8f80303E5ca4F8",
      "bridgeContract": "https://etherscan.io/address/0xf92cD566Ea4864356C5491c177A430C222d7e678",
      "assetContract": "https://etherscan.io/address/0x16980b3B4a3f9D89E33311B5aa8f80303E5ca4F8",
      "coingeckoId": "kira-network"
    }
  },
  {
    "chainId": 101,
    "address": "5uC8Gj96sK6UG44AYLpbX3DUjKtBUxBrhHcM8JDtyYum",
    "symbol": "wEWTB",
    "name": "Energy Web Token Bridged (Wormhole)",
    "decimals": 9,
    "logoURI":
        "https://raw.githubusercontent.com/solana-labs/token-list/main/assets/mainnet/5uC8Gj96sK6UG44AYLpbX3DUjKtBUxBrhHcM8JDtyYum/logo.png",
    "tags": ["wrapped", "wormhole"],
    "extensions": {
      "address": "0x178c820f862B14f316509ec36b13123DA19A6054",
      "bridgeContract": "https://etherscan.io/address/0xf92cD566Ea4864356C5491c177A430C222d7e678",
      "assetContract": "https://etherscan.io/address/0x178c820f862B14f316509ec36b13123DA19A6054",
      "coingeckoId": "energy-web-token"
    }
  },
  {
    "chainId": 101,
    "address": "EzeRaHuh1Xu1nDUypv1VWXcGsNJ71ncCJ8HeWuyg8atJ",
    "symbol": "wCC10",
    "name": "Cryptocurrency Top 10 Tokens Index (Wormhole)",
    "decimals": 9,
    "logoURI":
        "https://raw.githubusercontent.com/solana-labs/token-list/main/assets/mainnet/EzeRaHuh1Xu1nDUypv1VWXcGsNJ71ncCJ8HeWuyg8atJ/logo.png",
    "tags": ["wrapped", "wormhole"],
    "extensions": {
      "address": "0x17aC188e09A7890a1844E5E65471fE8b0CcFadF3",
      "bridgeContract": "https://etherscan.io/address/0xf92cD566Ea4864356C5491c177A430C222d7e678",
      "assetContract": "https://etherscan.io/address/0x17aC188e09A7890a1844E5E65471fE8b0CcFadF3",
      "coingeckoId": "cryptocurrency-top-10-tokens-index"
    }
  },
  {
    "chainId": 101,
    "address": "CYzPVv1zB9RH6hRWRKprFoepdD8Y7Q5HefCqrybvetja",
    "symbol": "wAUDIO",
    "name": "Audius (Wormhole)",
    "decimals": 9,
    "logoURI":
        "https://raw.githubusercontent.com/solana-labs/token-list/main/assets/mainnet/CYzPVv1zB9RH6hRWRKprFoepdD8Y7Q5HefCqrybvetja/logo.png",
    "tags": ["wrapped", "wormhole"],
    "extensions": {
      "address": "0x18aAA7115705e8be94bfFEBDE57Af9BFc265B998",
      "bridgeContract": "https://etherscan.io/address/0xf92cD566Ea4864356C5491c177A430C222d7e678",
      "assetContract": "https://etherscan.io/address/0x18aAA7115705e8be94bfFEBDE57Af9BFc265B998",
      "coingeckoId": "audius"
    }
  },
  {
    "chainId": 101,
    "address": "9yPmJNUp1qFV6LafdYdegZ8sCgC4oy6Rgt9WsDJqv3EX",
    "symbol": "wREP",
    "name": "Reputation (Wormhole)",
    "decimals": 9,
    "logoURI":
        "https://raw.githubusercontent.com/solana-labs/token-list/main/assets/mainnet/9yPmJNUp1qFV6LafdYdegZ8sCgC4oy6Rgt9WsDJqv3EX/logo.png",
    "tags": ["wrapped", "wormhole"],
    "extensions": {
      "address": "0x1985365e9f78359a9B6AD760e32412f4a445E862",
      "bridgeContract": "https://etherscan.io/address/0xf92cD566Ea4864356C5491c177A430C222d7e678",
      "assetContract": "https://etherscan.io/address/0x1985365e9f78359a9B6AD760e32412f4a445E862"
    }
  },
  {
    "chainId": 101,
    "address": "CZxP1KtsfvMXZTGKR1fNwNChv8hGAfQrgVoENabN8zKU",
    "symbol": "wVSP",
    "name": "VesperToken (Wormhole)",
    "decimals": 9,
    "logoURI":
        "https://raw.githubusercontent.com/solana-labs/token-list/main/assets/mainnet/CZxP1KtsfvMXZTGKR1fNwNChv8hGAfQrgVoENabN8zKU/logo.png",
    "tags": ["wrapped", "wormhole"],
    "extensions": {
      "address": "0x1b40183EFB4Dd766f11bDa7A7c3AD8982e998421",
      "bridgeContract": "https://etherscan.io/address/0xf92cD566Ea4864356C5491c177A430C222d7e678",
      "assetContract": "https://etherscan.io/address/0x1b40183EFB4Dd766f11bDa7A7c3AD8982e998421",
      "coingeckoId": "vesper-finance"
    }
  },
  {
    "chainId": 101,
    "address": "8cGPyDGT1mgG1iWzNjPmCDKSK9veJhoBAguq7rp7CjTe",
    "symbol": "wKP3R",
    "name": "Keep3rV1 (Wormhole)",
    "decimals": 9,
    "logoURI":
        "https://raw.githubusercontent.com/solana-labs/token-list/main/assets/mainnet/8cGPyDGT1mgG1iWzNjPmCDKSK9veJhoBAguq7rp7CjTe/logo.png",
    "tags": ["wrapped", "wormhole"],
    "extensions": {
      "address": "0x1cEB5cB57C4D4E2b2433641b95Dd330A33185A44",
      "bridgeContract": "https://etherscan.io/address/0xf92cD566Ea4864356C5491c177A430C222d7e678",
      "assetContract": "https://etherscan.io/address/0x1cEB5cB57C4D4E2b2433641b95Dd330A33185A44",
      "coingeckoId": "keep3rv1"
    }
  },
  {
    "chainId": 101,
    "address": "DGghbWvncPL41U8TmUtXcGMgLeQqkaA2yM7UfcabftR8",
    "symbol": "wLEAD",
    "name": "Lead Token (Wormhole)",
    "decimals": 9,
    "logoURI":
        "https://raw.githubusercontent.com/solana-labs/token-list/main/assets/mainnet/DGghbWvncPL41U8TmUtXcGMgLeQqkaA2yM7UfcabftR8/logo.png",
    "tags": ["wrapped", "wormhole"],
    "extensions": {
      "address": "0x1dD80016e3d4ae146Ee2EBB484e8edD92dacC4ce",
      "bridgeContract": "https://etherscan.io/address/0xf92cD566Ea4864356C5491c177A430C222d7e678",
      "assetContract": "https://etherscan.io/address/0x1dD80016e3d4ae146Ee2EBB484e8edD92dacC4ce",
      "coingeckoId": "lead-token"
    }
  },
  {
    "chainId": 101,
    "address": "3MVa4e32PaKmPxYUQ6n8vFkWtCma68Ld7e7fTktWDueQ",
    "symbol": "wUNI",
    "name": "Uniswap (Wormhole)",
    "decimals": 9,
    "logoURI":
        "https://raw.githubusercontent.com/solana-labs/token-list/main/assets/mainnet/3MVa4e32PaKmPxYUQ6n8vFkWtCma68Ld7e7fTktWDueQ/logo.png",
    "tags": ["wrapped", "wormhole"],
    "extensions": {
      "address": "0x1f9840a85d5aF5bf1D1762F925BDADdC4201F984",
      "bridgeContract": "https://etherscan.io/address/0xf92cD566Ea4864356C5491c177A430C222d7e678",
      "assetContract": "https://etherscan.io/address/0x1f9840a85d5aF5bf1D1762F925BDADdC4201F984",
      "coingeckoId": "uniswap"
    }
  },
  {
    "chainId": 101,
    "address": "qfnqNqs3nCAHjnyCgLRDbBtq4p2MtHZxw8YjSyYhPoL",
    "symbol": "wWBTC",
    "name": "Wrapped BTC (Wormhole)",
    "decimals": 8,
    "logoURI":
        "https://raw.githubusercontent.com/solana-labs/token-list/main/assets/mainnet/qfnqNqs3nCAHjnyCgLRDbBtq4p2MtHZxw8YjSyYhPoL/logo.png",
    "tags": ["wrapped", "wormhole"],
    "extensions": {
      "address": "0x2260FAC5E5542a773Aa44fBCfeDf7C193bc2C599",
      "bridgeContract": "https://etherscan.io/address/0xf92cD566Ea4864356C5491c177A430C222d7e678",
      "assetContract": "https://etherscan.io/address/0x2260FAC5E5542a773Aa44fBCfeDf7C193bc2C599",
      "coingeckoId": "wrapped-bitcoin"
    }
  },
  {
    "chainId": 101,
    "address": "8My83RG8Xa1EhXdDKHWq8BWZN1zF3XUrWL3TXCLjVPFh",
    "symbol": "wUNN",
    "name": "UNION Protocol Governance Token (Wormhole)",
    "decimals": 9,
    "logoURI":
        "https://raw.githubusercontent.com/solana-labs/token-list/main/assets/mainnet/8My83RG8Xa1EhXdDKHWq8BWZN1zF3XUrWL3TXCLjVPFh/logo.png",
    "tags": ["wrapped", "wormhole"],
    "extensions": {
      "address": "0x226f7b842E0F0120b7E194D05432b3fd14773a9D",
      "bridgeContract": "https://etherscan.io/address/0xf92cD566Ea4864356C5491c177A430C222d7e678",
      "assetContract": "https://etherscan.io/address/0x226f7b842E0F0120b7E194D05432b3fd14773a9D",
      "coingeckoId": "union-protocol-governance-token"
    }
  },
  {
    "chainId": 101,
    "address": "6jVuhLJ2mzyZ8DyUcrDj8Qr6Q9bqbJnq4fAnMeEduDM9",
    "symbol": "wSOCKS",
    "name": "Unisocks Edition 0 (Wormhole)",
    "decimals": 9,
    "logoURI":
        "https://raw.githubusercontent.com/solana-labs/token-list/main/assets/mainnet/6jVuhLJ2mzyZ8DyUcrDj8Qr6Q9bqbJnq4fAnMeEduDM9/logo.png",
    "tags": ["wrapped", "wormhole"],
    "extensions": {
      "address": "0x23B608675a2B2fB1890d3ABBd85c5775c51691d5",
      "bridgeContract": "https://etherscan.io/address/0xf92cD566Ea4864356C5491c177A430C222d7e678",
      "assetContract": "https://etherscan.io/address/0x23B608675a2B2fB1890d3ABBd85c5775c51691d5",
      "coingeckoId": "unisocks"
    }
  },
  {
    "chainId": 101,
    "address": "Az8PAQ7s6s5ZFgBiKKEizHt3SzDxXKZayDCtRZoC3452",
    "symbol": "wDEXT",
    "name": "DEXTools (Wormhole)",
    "decimals": 9,
    "logoURI":
        "https://raw.githubusercontent.com/solana-labs/token-list/main/assets/mainnet/Az8PAQ7s6s5ZFgBiKKEizHt3SzDxXKZayDCtRZoC3452/logo.png",
    "tags": ["wrapped", "wormhole"],
    "extensions": {
      "address": "0x26CE25148832C04f3d7F26F32478a9fe55197166",
      "bridgeContract": "https://etherscan.io/address/0xf92cD566Ea4864356C5491c177A430C222d7e678",
      "assetContract": "https://etherscan.io/address/0x26CE25148832C04f3d7F26F32478a9fe55197166",
      "coingeckoId": "idextools"
    }
  },
  {
    "chainId": 101,
    "address": "ELSnGFd5XnSdYFFSgYQp7n89FEbDqxN4npuRLW4PPPLv",
    "symbol": "wHEX",
    "name": "HEX (Wormhole)",
    "decimals": 8,
    "logoURI":
        "https://raw.githubusercontent.com/solana-labs/token-list/main/assets/mainnet/ELSnGFd5XnSdYFFSgYQp7n89FEbDqxN4npuRLW4PPPLv/logo.png",
    "tags": ["wrapped", "wormhole"],
    "extensions": {
      "address": "0x2b591e99afE9f32eAA6214f7B7629768c40Eeb39",
      "bridgeContract": "https://etherscan.io/address/0xf92cD566Ea4864356C5491c177A430C222d7e678",
      "assetContract": "https://etherscan.io/address/0x2b591e99afE9f32eAA6214f7B7629768c40Eeb39",
      "coingeckoId": "hex"
    }
  },
  {
    "chainId": 101,
    "address": "9iwfHhE7BJKNo4Eb1wX3p4uyJjEN9RoGLt4BvMdzZoiN",
    "symbol": "wCREAM",
    "name": "Cream (Wormhole)",
    "decimals": 9,
    "logoURI":
        "https://raw.githubusercontent.com/solana-labs/token-list/main/assets/mainnet/9iwfHhE7BJKNo4Eb1wX3p4uyJjEN9RoGLt4BvMdzZoiN/logo.png",
    "tags": ["wrapped", "wormhole"],
    "extensions": {
      "address": "0x2ba592F78dB6436527729929AAf6c908497cB200",
      "bridgeContract": "https://etherscan.io/address/0xf92cD566Ea4864356C5491c177A430C222d7e678",
      "assetContract": "https://etherscan.io/address/0x2ba592F78dB6436527729929AAf6c908497cB200",
      "coingeckoId": "cream-2"
    }
  },
  {
    "chainId": 101,
    "address": "DdiXkfDGhLiKyw889QC4nmcxSwMqarLBtrDofPJyx7bt",
    "symbol": "wYFIM",
    "name": "yfi.mobi (Wormhole)",
    "decimals": 9,
    "logoURI":
        "https://raw.githubusercontent.com/solana-labs/token-list/main/assets/mainnet/DdiXkfDGhLiKyw889QC4nmcxSwMqarLBtrDofPJyx7bt/logo.png",
    "tags": ["wrapped", "wormhole"],
    "extensions": {
      "address": "0x2e2f3246b6c65CCc4239c9Ee556EC143a7E5DE2c",
      "bridgeContract": "https://etherscan.io/address/0xf92cD566Ea4864356C5491c177A430C222d7e678",
      "assetContract": "https://etherscan.io/address/0x2e2f3246b6c65CCc4239c9Ee556EC143a7E5DE2c",
      "coingeckoId": "yfimobi"
    }
  },
  {
    "chainId": 101,
    "address": "6wdcYNvUyHCerSiGbChkvGBF6Qzju1YP5qpXRQ4tqdZ3",
    "symbol": "wZEE",
    "name": "ZeroSwapToken (Wormhole)",
    "decimals": 9,
    "logoURI":
        "https://raw.githubusercontent.com/solana-labs/token-list/main/assets/mainnet/6wdcYNvUyHCerSiGbChkvGBF6Qzju1YP5qpXRQ4tqdZ3/logo.png",
    "tags": ["wrapped", "wormhole"],
    "extensions": {
      "address": "0x2eDf094dB69d6Dcd487f1B3dB9febE2eeC0dd4c5",
      "bridgeContract": "https://etherscan.io/address/0xf92cD566Ea4864356C5491c177A430C222d7e678",
      "assetContract": "https://etherscan.io/address/0x2eDf094dB69d6Dcd487f1B3dB9febE2eeC0dd4c5",
      "coingeckoId": "zeroswap"
    }
  },
  {
    "chainId": 101,
    "address": "4xh8iC54UgaNpY4h34rxfZBSc9L2fBB8gWcYtDGHjxhN",
    "symbol": "wwANATHA",
    "name": "Wrapped ANATHA (Wormhole)",
    "decimals": 9,
    "logoURI":
        "https://raw.githubusercontent.com/solana-labs/token-list/main/assets/mainnet/4xh8iC54UgaNpY4h34rxfZBSc9L2fBB8gWcYtDGHjxhN/logo.png",
    "tags": ["wrapped", "wormhole"],
    "extensions": {
      "address": "0x3383c5a8969Dc413bfdDc9656Eb80A1408E4bA20",
      "bridgeContract": "https://etherscan.io/address/0xf92cD566Ea4864356C5491c177A430C222d7e678",
      "assetContract": "https://etherscan.io/address/0x3383c5a8969Dc413bfdDc9656Eb80A1408E4bA20",
      "coingeckoId": "wrapped-anatha"
    }
  },
  {
    "chainId": 101,
    "address": "5Jq6S9HYqfG6TUMjjsKpnfis7utUAB69JiEGkkypdmgP",
    "symbol": "wRAMP",
    "name": "RAMP DEFI (Wormhole)",
    "decimals": 9,
    "logoURI":
        "https://raw.githubusercontent.com/solana-labs/token-list/main/assets/mainnet/5Jq6S9HYqfG6TUMjjsKpnfis7utUAB69JiEGkkypdmgP/logo.png",
    "tags": ["wrapped", "wormhole"],
    "extensions": {
      "address": "0x33D0568941C0C64ff7e0FB4fbA0B11BD37deEd9f",
      "bridgeContract": "https://etherscan.io/address/0xf92cD566Ea4864356C5491c177A430C222d7e678",
      "assetContract": "https://etherscan.io/address/0x33D0568941C0C64ff7e0FB4fbA0B11BD37deEd9f",
      "coingeckoId": "ramp"
    }
  },
  {
    "chainId": 101,
    "address": "6uMUH5ztnj6AKYvL71EZgcyyRxjyBC5LVkscA5LrBc3c",
    "symbol": "wPRQ",
    "name": "Parsiq Token (Wormhole)",
    "decimals": 9,
    "logoURI":
        "https://raw.githubusercontent.com/solana-labs/token-list/main/assets/mainnet/6uMUH5ztnj6AKYvL71EZgcyyRxjyBC5LVkscA5LrBc3c/logo.png",
    "tags": ["wrapped", "wormhole"],
    "extensions": {
      "address": "0x362bc847A3a9637d3af6624EeC853618a43ed7D2",
      "bridgeContract": "https://etherscan.io/address/0xf92cD566Ea4864356C5491c177A430C222d7e678",
      "assetContract": "https://etherscan.io/address/0x362bc847A3a9637d3af6624EeC853618a43ed7D2",
      "coingeckoId": "parsiq"
    }
  },
  {
    "chainId": 101,
    "address": "42gecM46tdSiYZN2CK1ek5raCxnzQf1xfhoKAf3F7Y5k",
    "symbol": "wSLP",
    "name": "Small Love Potion (Wormhole)",
    "decimals": 0,
    "logoURI":
        "https://raw.githubusercontent.com/solana-labs/token-list/main/assets/mainnet/42gecM46tdSiYZN2CK1ek5raCxnzQf1xfhoKAf3F7Y5k/logo.png",
    "tags": ["wrapped", "wormhole"],
    "extensions": {
      "address": "0x37236CD05b34Cc79d3715AF2383E96dd7443dCF1",
      "bridgeContract": "https://etherscan.io/address/0xf92cD566Ea4864356C5491c177A430C222d7e678",
      "assetContract": "https://etherscan.io/address/0x37236CD05b34Cc79d3715AF2383E96dd7443dCF1",
      "coingeckoId": "smooth-love-potion"
    }
  },
  {
    "chainId": 101,
    "address": "F6M9DW1cWw7EtFK9m2ukvT9WEvtEbdZfTzZTtDeBcnAf",
    "symbol": "wSAND",
    "name": "SAND (Wormhole)",
    "decimals": 9,
    "logoURI":
        "https://raw.githubusercontent.com/solana-labs/token-list/main/assets/mainnet/F6M9DW1cWw7EtFK9m2ukvT9WEvtEbdZfTzZTtDeBcnAf/logo.png",
    "tags": ["wrapped", "wormhole"],
    "extensions": {
      "address": "0x3845badAde8e6dFF049820680d1F14bD3903a5d0",
      "bridgeContract": "https://etherscan.io/address/0xf92cD566Ea4864356C5491c177A430C222d7e678",
      "assetContract": "https://etherscan.io/address/0x3845badAde8e6dFF049820680d1F14bD3903a5d0",
      "coingeckoId": "the-sandbox"
    }
  },
  {
    "chainId": 101,
    "address": "G27M8w6G4hwatMNFi46DPAUR1YkxSmRNFKus7SgYLoDy",
    "symbol": "wCVP",
    "name": "Concentrated Voting Power (Wormhole)",
    "decimals": 9,
    "logoURI":
        "https://raw.githubusercontent.com/solana-labs/token-list/main/assets/mainnet/G27M8w6G4hwatMNFi46DPAUR1YkxSmRNFKus7SgYLoDy/logo.png",
    "tags": ["wrapped", "wormhole"],
    "extensions": {
      "address": "0x38e4adB44ef08F22F5B5b76A8f0c2d0dCbE7DcA1",
      "bridgeContract": "https://etherscan.io/address/0xf92cD566Ea4864356C5491c177A430C222d7e678",
      "assetContract": "https://etherscan.io/address/0x38e4adB44ef08F22F5B5b76A8f0c2d0dCbE7DcA1",
      "coingeckoId": "concentrated-voting-power"
    }
  },
  {
    "chainId": 101,
    "address": "FjucGZpcdVXaWJH21pbrGQaKNszsGsJqbAXu4sJywKJa",
    "symbol": "wREN",
    "name": "Republic Token (Wormhole)",
    "decimals": 9,
    "logoURI":
        "https://raw.githubusercontent.com/solana-labs/token-list/main/assets/mainnet/FjucGZpcdVXaWJH21pbrGQaKNszsGsJqbAXu4sJywKJa/logo.png",
    "tags": ["wrapped", "wormhole"],
    "extensions": {
      "address": "0x408e41876cCCDC0F92210600ef50372656052a38",
      "bridgeContract": "https://etherscan.io/address/0xf92cD566Ea4864356C5491c177A430C222d7e678",
      "assetContract": "https://etherscan.io/address/0x408e41876cCCDC0F92210600ef50372656052a38",
      "coingeckoId": "republic-protocol"
    }
  },
  {
    "chainId": 101,
    "address": "5kvugu18snfGRu1PykMfRzYfUxJYs3smk1PWQcGo6Z8a",
    "symbol": "wXOR",
    "name": "Sora (Wormhole)",
    "decimals": 9,
    "logoURI":
        "https://raw.githubusercontent.com/solana-labs/token-list/main/assets/mainnet/5kvugu18snfGRu1PykMfRzYfUxJYs3smk1PWQcGo6Z8a/logo.png",
    "tags": ["wrapped", "wormhole"],
    "extensions": {
      "address": "0x40FD72257597aA14C7231A7B1aaa29Fce868F677",
      "bridgeContract": "https://etherscan.io/address/0xf92cD566Ea4864356C5491c177A430C222d7e678",
      "assetContract": "https://etherscan.io/address/0x40FD72257597aA14C7231A7B1aaa29Fce868F677",
      "coingeckoId": "sora"
    }
  },
  {
    "chainId": 101,
    "address": "3EKQDmiXj8yLBFpZca4coxBpP8XJCzmjVgUdVydSmaaT",
    "symbol": "wFUN",
    "name": "FunFair (Wormhole)",
    "decimals": 8,
    "logoURI":
        "https://raw.githubusercontent.com/solana-labs/token-list/main/assets/mainnet/3EKQDmiXj8yLBFpZca4coxBpP8XJCzmjVgUdVydSmaaT/logo.png",
    "tags": ["wrapped", "wormhole"],
    "extensions": {
      "address": "0x419D0d8BdD9aF5e606Ae2232ed285Aff190E711b",
      "bridgeContract": "https://etherscan.io/address/0xf92cD566Ea4864356C5491c177A430C222d7e678",
      "assetContract": "https://etherscan.io/address/0x419D0d8BdD9aF5e606Ae2232ed285Aff190E711b",
      "coingeckoId": "funfair"
    }
  },
  {
    "chainId": 101,
    "address": "6J9soByB65WUamsEG8KSPdphBV1oCoGvr5QpaUaY3r19",
    "symbol": "wPICKLE",
    "name": "PickleToken (Wormhole)",
    "decimals": 9,
    "logoURI":
        "https://raw.githubusercontent.com/solana-labs/token-list/main/assets/mainnet/6J9soByB65WUamsEG8KSPdphBV1oCoGvr5QpaUaY3r19/logo.png",
    "tags": ["wrapped", "wormhole"],
    "extensions": {
      "address": "0x429881672B9AE42b8EbA0E26cD9C73711b891Ca5",
      "bridgeContract": "https://etherscan.io/address/0xf92cD566Ea4864356C5491c177A430C222d7e678",
      "assetContract": "https://etherscan.io/address/0x429881672B9AE42b8EbA0E26cD9C73711b891Ca5",
      "coingeckoId": "pickle-finance"
    }
  },
  {
    "chainId": 101,
    "address": "HEsqFznmAERPUmMWHtDWYAZRoFbNHZpuNuFrPio68Zp1",
    "symbol": "wPAXG",
    "name": "Paxos Gold (Wormhole)",
    "decimals": 9,
    "logoURI":
        "https://raw.githubusercontent.com/solana-labs/token-list/main/assets/mainnet/HEsqFznmAERPUmMWHtDWYAZRoFbNHZpuNuFrPio68Zp1/logo.png",
    "tags": ["wrapped", "wormhole"],
    "extensions": {
      "address": "0x45804880De22913dAFE09f4980848ECE6EcbAf78",
      "bridgeContract": "https://etherscan.io/address/0xf92cD566Ea4864356C5491c177A430C222d7e678",
      "assetContract": "https://etherscan.io/address/0x45804880De22913dAFE09f4980848ECE6EcbAf78",
      "coingeckoId": "pax-gold"
    }
  },
  {
    "chainId": 101,
    "address": "BrtLvpVCwVDH5Jpqjtiuhh8wKYA5b3NZCnsSftr61viv",
    "symbol": "wQNT",
    "name": "Quant (Wormhole)",
    "decimals": 9,
    "logoURI":
        "https://raw.githubusercontent.com/solana-labs/token-list/main/assets/mainnet/BrtLvpVCwVDH5Jpqjtiuhh8wKYA5b3NZCnsSftr61viv/logo.png",
    "tags": ["wrapped", "wormhole"],
    "extensions": {
      "address": "0x4a220E6096B25EADb88358cb44068A3248254675",
      "bridgeContract": "https://etherscan.io/address/0xf92cD566Ea4864356C5491c177A430C222d7e678",
      "assetContract": "https://etherscan.io/address/0x4a220E6096B25EADb88358cb44068A3248254675",
      "coingeckoId": "quant-network"
    }
  },
  {
    "chainId": 101,
    "address": "8DRgurhcQPJeCqQEpbeYGUmwAz2tETbyWUYLUU4Q7goM",
    "symbol": "wORAI",
    "name": "Oraichain Token (Wormhole)",
    "decimals": 9,
    "logoURI":
        "https://raw.githubusercontent.com/solana-labs/token-list/main/assets/mainnet/8DRgurhcQPJeCqQEpbeYGUmwAz2tETbyWUYLUU4Q7goM/logo.png",
    "tags": ["wrapped", "wormhole"],
    "extensions": {
      "address": "0x4c11249814f11b9346808179Cf06e71ac328c1b5",
      "bridgeContract": "https://etherscan.io/address/0xf92cD566Ea4864356C5491c177A430C222d7e678",
      "assetContract": "https://etherscan.io/address/0x4c11249814f11b9346808179Cf06e71ac328c1b5",
      "coingeckoId": "oraichain-token"
    }
  },
  {
    "chainId": 101,
    "address": "4e5cqAsZ7wQqwLi7AApS9CgN8Yaho5TvkhvcLaGyiuzL",
    "symbol": "wTRU",
    "name": "TrustToken (Wormhole)",
    "decimals": 8,
    "logoURI":
        "https://raw.githubusercontent.com/solana-labs/token-list/main/assets/mainnet/4e5cqAsZ7wQqwLi7AApS9CgN8Yaho5TvkhvcLaGyiuzL/logo.png",
    "tags": ["wrapped", "wormhole"],
    "extensions": {
      "address": "0x4C19596f5aAfF459fA38B0f7eD92F11AE6543784",
      "bridgeContract": "https://etherscan.io/address/0xf92cD566Ea4864356C5491c177A430C222d7e678",
      "assetContract": "https://etherscan.io/address/0x4C19596f5aAfF459fA38B0f7eD92F11AE6543784",
      "coingeckoId": "truefi"
    }
  },
  {
    "chainId": 101,
    "address": "HkhBUKSct2V93Z35apDmXthkRvH4yvMovLyv8s8idDgP",
    "symbol": "wMCB",
    "name": "MCDEX Token (Wormhole)",
    "decimals": 9,
    "logoURI":
        "https://raw.githubusercontent.com/solana-labs/token-list/main/assets/mainnet/HkhBUKSct2V93Z35apDmXthkRvH4yvMovLyv8s8idDgP/logo.png",
    "tags": ["wrapped", "wormhole"],
    "extensions": {
      "address": "0x4e352cF164E64ADCBad318C3a1e222E9EBa4Ce42",
      "bridgeContract": "https://etherscan.io/address/0xf92cD566Ea4864356C5491c177A430C222d7e678",
      "assetContract": "https://etherscan.io/address/0x4e352cF164E64ADCBad318C3a1e222E9EBa4Ce42",
      "coingeckoId": "mcdex"
    }
  },
  {
    "chainId": 101,
    "address": "Eof7wbYsHZKaoyUGwM7Nfkoo6zQW4U7uWXqz2hoQzSkK",
    "symbol": "wNU",
    "name": "NuCypher (Wormhole)",
    "decimals": 9,
    "logoURI":
        "https://raw.githubusercontent.com/solana-labs/token-list/main/assets/mainnet/Eof7wbYsHZKaoyUGwM7Nfkoo6zQW4U7uWXqz2hoQzSkK/logo.png",
    "tags": ["wrapped", "wormhole"],
    "extensions": {
      "address": "0x4fE83213D56308330EC302a8BD641f1d0113A4Cc",
      "bridgeContract": "https://etherscan.io/address/0xf92cD566Ea4864356C5491c177A430C222d7e678",
      "assetContract": "https://etherscan.io/address/0x4fE83213D56308330EC302a8BD641f1d0113A4Cc",
      "coingeckoId": "nucypher"
    }
  },
  {
    "chainId": 101,
    "address": "5CmA1HTVZt5NRtwiUrqWrcnT5JRW5zHe6uQXfP7SDUNz",
    "symbol": "wRAZOR",
    "name": "RAZOR (Wormhole)",
    "decimals": 9,
    "logoURI":
        "https://raw.githubusercontent.com/solana-labs/token-list/main/assets/mainnet/5CmA1HTVZt5NRtwiUrqWrcnT5JRW5zHe6uQXfP7SDUNz/logo.png",
    "tags": ["wrapped", "wormhole"],
    "extensions": {
      "address": "0x50DE6856358Cc35f3A9a57eAAA34BD4cB707d2cd",
      "bridgeContract": "https://etherscan.io/address/0xf92cD566Ea4864356C5491c177A430C222d7e678",
      "assetContract": "https://etherscan.io/address/0x50DE6856358Cc35f3A9a57eAAA34BD4cB707d2cd",
      "coingeckoId": "razor-network"
    }
  },
  {
    "chainId": 101,
    "address": "6msNYXzSVtjinqapq2xcvBb5NRq4YTPAi7wc5Jx8M8TS",
    "symbol": "wLINK",
    "name": "ChainLink Token (Wormhole)",
    "decimals": 9,
    "logoURI":
        "https://raw.githubusercontent.com/solana-labs/token-list/main/assets/mainnet/6msNYXzSVtjinqapq2xcvBb5NRq4YTPAi7wc5Jx8M8TS/logo.png",
    "tags": ["wrapped", "wormhole"],
    "extensions": {
      "address": "0x514910771AF9Ca656af840dff83E8264EcF986CA",
      "bridgeContract": "https://etherscan.io/address/0xf92cD566Ea4864356C5491c177A430C222d7e678",
      "assetContract": "https://etherscan.io/address/0x514910771AF9Ca656af840dff83E8264EcF986CA",
      "coingeckoId": "chainlink"
    }
  },
  {
    "chainId": 101,
    "address": "BX2gcRRS12iqFzKCpvTt4krBBYNymR9JBDZBxzfFLnbF",
    "symbol": "weRSDL",
    "name": "UnFederalReserveToken (Wormhole)",
    "decimals": 9,
    "logoURI":
        "https://raw.githubusercontent.com/solana-labs/token-list/main/assets/mainnet/BX2gcRRS12iqFzKCpvTt4krBBYNymR9JBDZBxzfFLnbF/logo.png",
    "tags": ["wrapped", "wormhole"],
    "extensions": {
      "address": "0x5218E472cFCFE0b64A064F055B43b4cdC9EfD3A6",
      "bridgeContract": "https://etherscan.io/address/0xf92cD566Ea4864356C5491c177A430C222d7e678",
      "assetContract": "https://etherscan.io/address/0x5218E472cFCFE0b64A064F055B43b4cdC9EfD3A6",
      "coingeckoId": "unfederalreserve"
    }
  },
  {
    "chainId": 101,
    "address": "CCGLdsokcybeF8NrCcu1RSQK8isNBjBA58kVEMTHTKjx",
    "symbol": "wsUSD",
    "name": "Synth sUSD (Wormhole)",
    "decimals": 9,
    "logoURI":
        "https://raw.githubusercontent.com/solana-labs/token-list/main/assets/mainnet/CCGLdsokcybeF8NrCcu1RSQK8isNBjBA58kVEMTHTKjx/logo.png",
    "tags": ["wrapped", "wormhole"],
    "extensions": {
      "address": "0x57Ab1ec28D129707052df4dF418D58a2D46d5f51",
      "bridgeContract": "https://etherscan.io/address/0xf92cD566Ea4864356C5491c177A430C222d7e678",
      "assetContract": "https://etherscan.io/address/0x57Ab1ec28D129707052df4dF418D58a2D46d5f51",
      "coingeckoId": "nusd"
    }
  },
  {
    "chainId": 101,
    "address": "FP9ogG7hTdfcTJwn4prF9AVEcfcjLq1GtkqYM4oRn7eY",
    "symbol": "wHEGIC",
    "name": "Hegic (Wormhole)",
    "decimals": 9,
    "logoURI":
        "https://raw.githubusercontent.com/solana-labs/token-list/main/assets/mainnet/FP9ogG7hTdfcTJwn4prF9AVEcfcjLq1GtkqYM4oRn7eY/logo.png",
    "tags": ["wrapped", "wormhole"],
    "extensions": {
      "address": "0x584bC13c7D411c00c01A62e8019472dE68768430",
      "bridgeContract": "https://etherscan.io/address/0xf92cD566Ea4864356C5491c177A430C222d7e678",
      "assetContract": "https://etherscan.io/address/0x584bC13c7D411c00c01A62e8019472dE68768430",
      "coingeckoId": "hegic"
    }
  },
  {
    "chainId": 101,
    "address": "DboP5vvYUVjmKSHKJ1YFHwmv41KtUscnYgzjmPgHwQVn",
    "symbol": "wXFI",
    "name": "Xfinance (Wormhole)",
    "decimals": 9,
    "logoURI":
        "https://raw.githubusercontent.com/solana-labs/token-list/main/assets/mainnet/DboP5vvYUVjmKSHKJ1YFHwmv41KtUscnYgzjmPgHwQVn/logo.png",
    "tags": ["wrapped", "wormhole"],
    "extensions": {
      "address": "0x5BEfBB272290dD5b8521D4a938f6c4757742c430",
      "bridgeContract": "https://etherscan.io/address/0xf92cD566Ea4864356C5491c177A430C222d7e678",
      "assetContract": "https://etherscan.io/address/0x5BEfBB272290dD5b8521D4a938f6c4757742c430",
      "coingeckoId": "xfinance"
    }
  },
  {
    "chainId": 101,
    "address": "6c4U9yxGzVjejSJJXrdX8wtt532Et6MrBUZc2oK5j6w5",
    "symbol": "wDEXTF",
    "name": "DEXTF Token (Wormhole)",
    "decimals": 9,
    "logoURI":
        "https://raw.githubusercontent.com/solana-labs/token-list/main/assets/mainnet/6c4U9yxGzVjejSJJXrdX8wtt532Et6MrBUZc2oK5j6w5/logo.png",
    "tags": ["wrapped", "wormhole"],
    "extensions": {
      "address": "0x5F64Ab1544D28732F0A24F4713c2C8ec0dA089f0",
      "bridgeContract": "https://etherscan.io/address/0xf92cD566Ea4864356C5491c177A430C222d7e678",
      "assetContract": "https://etherscan.io/address/0x5F64Ab1544D28732F0A24F4713c2C8ec0dA089f0",
      "coingeckoId": "dextf"
    }
  },
  {
    "chainId": 101,
    "address": "JuXkRYNw54rujC7SPWcAM4ArLgA5x8nDQbS8xHAr6MA",
    "symbol": "wRLC",
    "name": "iExec RLC (Wormhole)",
    "decimals": 9,
    "logoURI":
        "https://raw.githubusercontent.com/solana-labs/token-list/main/assets/mainnet/JuXkRYNw54rujC7SPWcAM4ArLgA5x8nDQbS8xHAr6MA/logo.png",
    "tags": ["wrapped", "wormhole"],
    "extensions": {
      "address": "0x607F4C5BB672230e8672085532f7e901544a7375",
      "bridgeContract": "https://etherscan.io/address/0xf92cD566Ea4864356C5491c177A430C222d7e678",
      "assetContract": "https://etherscan.io/address/0x607F4C5BB672230e8672085532f7e901544a7375",
      "coingeckoId": "iexec-rlc"
    }
  },
  {
    "chainId": 101,
    "address": "7NfgSkv6kZ6ZWP6SJPtMuaUYGVEngVK8UFnaFTPk3QsM",
    "symbol": "wCORE",
    "name": "cVault.finance (Wormhole)",
    "decimals": 9,
    "logoURI":
        "https://raw.githubusercontent.com/solana-labs/token-list/main/assets/mainnet/7NfgSkv6kZ6ZWP6SJPtMuaUYGVEngVK8UFnaFTPk3QsM/logo.png",
    "tags": ["wrapped", "wormhole"],
    "extensions": {
      "address": "0x62359Ed7505Efc61FF1D56fEF82158CcaffA23D7",
      "bridgeContract": "https://etherscan.io/address/0xf92cD566Ea4864356C5491c177A430C222d7e678",
      "assetContract": "https://etherscan.io/address/0x62359Ed7505Efc61FF1D56fEF82158CcaffA23D7",
      "coingeckoId": "cvault-finance"
    }
  },
  {
    "chainId": 101,
    "address": "AqLKDJiGL4wXKPAfzNom3xEdQwgj2LTCE4k34gzvZsE6",
    "symbol": "wCFi",
    "name": "CyberFi Token (Wormhole)",
    "decimals": 9,
    "logoURI":
        "https://raw.githubusercontent.com/solana-labs/token-list/main/assets/mainnet/AqLKDJiGL4wXKPAfzNom3xEdQwgj2LTCE4k34gzvZsE6/logo.png",
    "tags": ["wrapped", "wormhole"],
    "extensions": {
      "address": "0x63b4f3e3fa4e438698CE330e365E831F7cCD1eF4",
      "bridgeContract": "https://etherscan.io/address/0xf92cD566Ea4864356C5491c177A430C222d7e678",
      "assetContract": "https://etherscan.io/address/0x63b4f3e3fa4e438698CE330e365E831F7cCD1eF4",
      "coingeckoId": "cyberfi"
    }
  },
  {
    "chainId": 101,
    "address": "FLrjpCRrd4GffHu8MVYGvuLxYLuBGVaXsnCecw3Effci",
    "symbol": "wWISE",
    "name": "Wise Token (Wormhole)",
    "decimals": 9,
    "logoURI":
        "https://raw.githubusercontent.com/solana-labs/token-list/main/assets/mainnet/FLrjpCRrd4GffHu8MVYGvuLxYLuBGVaXsnCecw3Effci/logo.png",
    "tags": ["wrapped", "wormhole"],
    "extensions": {
      "address": "0x66a0f676479Cee1d7373f3DC2e2952778BfF5bd6",
      "bridgeContract": "https://etherscan.io/address/0xf92cD566Ea4864356C5491c177A430C222d7e678",
      "assetContract": "https://etherscan.io/address/0x66a0f676479Cee1d7373f3DC2e2952778BfF5bd6",
      "coingeckoId": "wise-token11"
    }
  },
  {
    "chainId": 101,
    "address": "GaMPhVyp1xd9xJuPskDEzQzp8mKfEjAmhny8NX7y7YKc",
    "symbol": "wGNO",
    "name": "Gnosis Token (Wormhole)",
    "decimals": 9,
    "logoURI":
        "https://raw.githubusercontent.com/solana-labs/token-list/main/assets/mainnet/GaMPhVyp1xd9xJuPskDEzQzp8mKfEjAmhny8NX7y7YKc/logo.png",
    "tags": ["wrapped", "wormhole"],
    "extensions": {
      "address": "0x6810e776880C02933D47DB1b9fc05908e5386b96",
      "bridgeContract": "https://etherscan.io/address/0xf92cD566Ea4864356C5491c177A430C222d7e678",
      "assetContract": "https://etherscan.io/address/0x6810e776880C02933D47DB1b9fc05908e5386b96",
      "coingeckoId": "gnosis"
    }
  },
  {
    "chainId": 101,
    "address": "CCAQZHBVWKDukT68PZ3LenDs7apibeSYeJ3jHE8NzBC5",
    "symbol": "wPOOLZ",
    "name": "\$Poolz Finance (Wormhole)",
    "decimals": 9,
    "logoURI":
        "https://raw.githubusercontent.com/solana-labs/token-list/main/assets/mainnet/CCAQZHBVWKDukT68PZ3LenDs7apibeSYeJ3jHE8NzBC5/logo.png",
    "tags": ["wrapped", "wormhole"],
    "extensions": {
      "address": "0x69A95185ee2a045CDC4bCd1b1Df10710395e4e23",
      "bridgeContract": "https://etherscan.io/address/0xf92cD566Ea4864356C5491c177A430C222d7e678",
      "assetContract": "https://etherscan.io/address/0x69A95185ee2a045CDC4bCd1b1Df10710395e4e23",
      "coingeckoId": "poolz-finance"
    }
  },
  {
    "chainId": 101,
    "address": "FYpdBuyAHSbdaAyD1sKkxyLWbAP8uUW9h6uvdhK74ij1",
    "symbol": "wDAI",
    "name": "Dai Stablecoin (Wormhole)",
    "decimals": 9,
    "logoURI":
        "https://raw.githubusercontent.com/solana-labs/token-list/main/assets/mainnet/FYpdBuyAHSbdaAyD1sKkxyLWbAP8uUW9h6uvdhK74ij1/logo.png",
    "tags": ["wrapped", "wormhole"],
    "extensions": {
      "address": "0x6B175474E89094C44Da98b954EedeAC495271d0F",
      "bridgeContract": "https://etherscan.io/address/0xf92cD566Ea4864356C5491c177A430C222d7e678",
      "assetContract": "https://etherscan.io/address/0x6B175474E89094C44Da98b954EedeAC495271d0F",
      "coingeckoId": "dai"
    }
  },
  {
    "chainId": 101,
    "address": "HbMGwfGjGPchtaPwyrtJFy8APZN5w1hi63xnzmj1f23v",
    "symbol": "wSUSHI",
    "name": "SushiSwap (Wormhole)",
    "decimals": 9,
    "logoURI":
        "https://raw.githubusercontent.com/solana-labs/token-list/main/assets/mainnet/HbMGwfGjGPchtaPwyrtJFy8APZN5w1hi63xnzmj1f23v/logo.png",
    "tags": ["wrapped", "wormhole"],
    "extensions": {
      "address": "0x6B3595068778DD592e39A122f4f5a5cF09C90fE2",
      "bridgeContract": "https://etherscan.io/address/0xf92cD566Ea4864356C5491c177A430C222d7e678",
      "assetContract": "https://etherscan.io/address/0x6B3595068778DD592e39A122f4f5a5cF09C90fE2",
      "coingeckoId": "sushi"
    }
  },
  {
    "chainId": 101,
    "address": "6Tmi8TZasqdxWB59uE5Zw9VLKecuCbsLSsPEqoMpmozA",
    "symbol": "wFYZ",
    "name": "Fyooz (Wormhole)",
    "decimals": 9,
    "logoURI":
        "https://raw.githubusercontent.com/solana-labs/token-list/main/assets/mainnet/6Tmi8TZasqdxWB59uE5Zw9VLKecuCbsLSsPEqoMpmozA/logo.png",
    "tags": ["wrapped", "wormhole"],
    "extensions": {
      "address": "0x6BFf2fE249601ed0Db3a87424a2E923118BB0312",
      "bridgeContract": "https://etherscan.io/address/0xf92cD566Ea4864356C5491c177A430C222d7e678",
      "assetContract": "https://etherscan.io/address/0x6BFf2fE249601ed0Db3a87424a2E923118BB0312",
      "coingeckoId": "fyooz"
    }
  },
  {
    "chainId": 101,
    "address": "3sHinPxEPqhEGip2Wy45TFmgAA1Atg2mctMjY5RKJUjk",
    "symbol": "wQRX",
    "name": "QuiverX (Wormhole)",
    "decimals": 9,
    "logoURI":
        "https://raw.githubusercontent.com/solana-labs/token-list/main/assets/mainnet/3sHinPxEPqhEGip2Wy45TFmgAA1Atg2mctMjY5RKJUjk/logo.png",
    "tags": ["wrapped", "wormhole"],
    "extensions": {
      "address": "0x6e0daDE58D2d89eBBe7aFc384e3E4f15b70b14D8",
      "bridgeContract": "https://etherscan.io/address/0xf92cD566Ea4864356C5491c177A430C222d7e678",
      "assetContract": "https://etherscan.io/address/0x6e0daDE58D2d89eBBe7aFc384e3E4f15b70b14D8",
      "coingeckoId": "quiverx"
    }
  },
  {
    "chainId": 101,
    "address": "4ighgEijHcCoLu9AsvwVz2TnGFqAgzQtQMr6ch88Jrfe",
    "symbol": "wTRADE",
    "name": "UniTrade (Wormhole)",
    "decimals": 9,
    "logoURI":
        "https://raw.githubusercontent.com/solana-labs/token-list/main/assets/mainnet/4ighgEijHcCoLu9AsvwVz2TnGFqAgzQtQMr6ch88Jrfe/logo.png",
    "tags": ["wrapped", "wormhole"],
    "extensions": {
      "address": "0x6F87D756DAf0503d08Eb8993686c7Fc01Dc44fB1",
      "bridgeContract": "https://etherscan.io/address/0xf92cD566Ea4864356C5491c177A430C222d7e678",
      "assetContract": "https://etherscan.io/address/0x6F87D756DAf0503d08Eb8993686c7Fc01Dc44fB1",
      "coingeckoId": "unitrade"
    }
  },
  {
    "chainId": 101,
    "address": "FTPnEQ3NfRRZ9tvmpDW6JFrvweBE5sanxnXSpJL1dvbB",
    "symbol": "wBIRD",
    "name": "Bird.Money (Wormhole)",
    "decimals": 9,
    "logoURI":
        "https://raw.githubusercontent.com/solana-labs/token-list/main/assets/mainnet/FTPnEQ3NfRRZ9tvmpDW6JFrvweBE5sanxnXSpJL1dvbB/logo.png",
    "tags": ["wrapped", "wormhole"],
    "extensions": {
      "address": "0x70401dFD142A16dC7031c56E862Fc88Cb9537Ce0",
      "bridgeContract": "https://etherscan.io/address/0xf92cD566Ea4864356C5491c177A430C222d7e678",
      "assetContract": "https://etherscan.io/address/0x70401dFD142A16dC7031c56E862Fc88Cb9537Ce0",
      "coingeckoId": "bird-money"
    }
  },
  {
    "chainId": 101,
    "address": "QVDE6rhcGPSB3ex5T7vWBzvoSRUXULjuSGpVuKwu5XH",
    "symbol": "wAXN",
    "name": "Axion (Wormhole)",
    "decimals": 9,
    "logoURI":
        "https://raw.githubusercontent.com/solana-labs/token-list/main/assets/mainnet/QVDE6rhcGPSB3ex5T7vWBzvoSRUXULjuSGpVuKwu5XH/logo.png",
    "tags": ["wrapped", "wormhole"],
    "extensions": {
      "address": "0x71F85B2E46976bD21302B64329868fd15eb0D127",
      "bridgeContract": "https://etherscan.io/address/0xf92cD566Ea4864356C5491c177A430C222d7e678",
      "assetContract": "https://etherscan.io/address/0x71F85B2E46976bD21302B64329868fd15eb0D127",
      "coingeckoId": "axion"
    }
  },
  {
    "chainId": 101,
    "address": "J6AbGG62yo9UJ2T9r9GM7pnoRNui5DsZDnPbiNAPqbVd",
    "symbol": "wBMI",
    "name": "Bridge Mutual (Wormhole)",
    "decimals": 9,
    "logoURI":
        "https://raw.githubusercontent.com/solana-labs/token-list/main/assets/mainnet/J6AbGG62yo9UJ2T9r9GM7pnoRNui5DsZDnPbiNAPqbVd/logo.png",
    "tags": ["wrapped", "wormhole"],
    "extensions": {
      "address": "0x725C263e32c72dDC3A19bEa12C5a0479a81eE688",
      "bridgeContract": "https://etherscan.io/address/0xf92cD566Ea4864356C5491c177A430C222d7e678",
      "assetContract": "https://etherscan.io/address/0x725C263e32c72dDC3A19bEa12C5a0479a81eE688",
      "coingeckoId": "bridge-mutual"
    }
  },
  {
    "chainId": 101,
    "address": "4wvHoaxxZxFeNrMTP8bLVRh1ziSBV7crN665WX4rRMqe",
    "symbol": "wDYT",
    "name": "DoYourTip (Wormhole)",
    "decimals": 9,
    "logoURI":
        "https://raw.githubusercontent.com/solana-labs/token-list/main/assets/mainnet/4wvHoaxxZxFeNrMTP8bLVRh1ziSBV7crN665WX4rRMqe/logo.png",
    "tags": ["wrapped", "wormhole"],
    "extensions": {
      "address": "0x740623d2c797b7D8D1EcB98e9b4Afcf99Ec31E14",
      "bridgeContract": "https://etherscan.io/address/0xf92cD566Ea4864356C5491c177A430C222d7e678",
      "assetContract": "https://etherscan.io/address/0x740623d2c797b7D8D1EcB98e9b4Afcf99Ec31E14",
      "coingeckoId": "dynamite"
    }
  },
  {
    "chainId": 101,
    "address": "Fe5fWjCLDMJoi4sTmfR2VW4BT1LwsbR1n6QAjzJQvhhf",
    "symbol": "wBBR",
    "name": "BitberryToken (Wormhole)",
    "decimals": 9,
    "logoURI":
        "https://raw.githubusercontent.com/solana-labs/token-list/main/assets/mainnet/Fe5fWjCLDMJoi4sTmfR2VW4BT1LwsbR1n6QAjzJQvhhf/logo.png",
    "tags": ["wrapped", "wormhole"],
    "extensions": {
      "address": "0x7671904eed7f10808B664fc30BB8693FD7237abF",
      "bridgeContract": "https://etherscan.io/address/0xf92cD566Ea4864356C5491c177A430C222d7e678",
      "assetContract": "https://etherscan.io/address/0x7671904eed7f10808B664fc30BB8693FD7237abF",
      "coingeckoId": "bitberry-token"
    }
  },
  {
    "chainId": 101,
    "address": "5J9yhFRnQZx3RiqHzfQpAffX5UQz3k8vQCZH2g9Z9sDg",
    "symbol": "wWAXE",
    "name": "WAX Economic Token (Wormhole)",
    "decimals": 8,
    "logoURI":
        "https://raw.githubusercontent.com/solana-labs/token-list/main/assets/mainnet/5J9yhFRnQZx3RiqHzfQpAffX5UQz3k8vQCZH2g9Z9sDg/logo.png",
    "tags": ["wrapped", "wormhole"],
    "extensions": {
      "address": "0x7a2Bc711E19ba6aff6cE8246C546E8c4B4944DFD",
      "bridgeContract": "https://etherscan.io/address/0xf92cD566Ea4864356C5491c177A430C222d7e678",
      "assetContract": "https://etherscan.io/address/0x7a2Bc711E19ba6aff6cE8246C546E8c4B4944DFD",
      "coingeckoId": "waxe"
    }
  },
  {
    "chainId": 101,
    "address": "4DHywS5EjUTF5AYisPZiJbWcCV4gfpH98oKxpgyKRnnQ",
    "symbol": "wMATIC",
    "name": "Matic Token (Wormhole)",
    "decimals": 9,
    "logoURI":
        "https://raw.githubusercontent.com/solana-labs/token-list/main/assets/mainnet/4DHywS5EjUTF5AYisPZiJbWcCV4gfpH98oKxpgyKRnnQ/logo.png",
    "tags": ["wrapped", "wormhole"],
    "extensions": {
      "address": "0x7D1AfA7B718fb893dB30A3aBc0Cfc608AaCfeBB0",
      "bridgeContract": "https://etherscan.io/address/0xf92cD566Ea4864356C5491c177A430C222d7e678",
      "assetContract": "https://etherscan.io/address/0x7D1AfA7B718fb893dB30A3aBc0Cfc608AaCfeBB0",
      "coingeckoId": "matic-network"
    }
  },
  {
    "chainId": 101,
    "address": "Au9E8ygQdTJQZXmNKPdtLEP8rGjC4qsGRhkJgjFNPAr8",
    "symbol": "wXRT",
    "name": "Robonomics (Wormhole)",
    "decimals": 9,
    "logoURI":
        "https://raw.githubusercontent.com/solana-labs/token-list/main/assets/mainnet/Au9E8ygQdTJQZXmNKPdtLEP8rGjC4qsGRhkJgjFNPAr8/logo.png",
    "tags": ["wrapped", "wormhole"],
    "extensions": {
      "address": "0x7dE91B204C1C737bcEe6F000AAA6569Cf7061cb7",
      "bridgeContract": "https://etherscan.io/address/0xf92cD566Ea4864356C5491c177A430C222d7e678",
      "assetContract": "https://etherscan.io/address/0x7dE91B204C1C737bcEe6F000AAA6569Cf7061cb7",
      "coingeckoId": "robonomics-network"
    }
  },
  {
    "chainId": 101,
    "address": "5DQZ14hLDxveMH7NyGmTmUTRGgVAVXADp3cP2UHeH6hM",
    "symbol": "wAAVE",
    "name": "Aave Token (Wormhole)",
    "decimals": 9,
    "logoURI":
        "https://raw.githubusercontent.com/solana-labs/token-list/main/assets/mainnet/5DQZ14hLDxveMH7NyGmTmUTRGgVAVXADp3cP2UHeH6hM/logo.png",
    "tags": ["wrapped", "wormhole"],
    "extensions": {
      "address": "0x7Fc66500c84A76Ad7e9c93437bFc5Ac33E2DDaE9",
      "bridgeContract": "https://etherscan.io/address/0xf92cD566Ea4864356C5491c177A430C222d7e678",
      "assetContract": "https://etherscan.io/address/0x7Fc66500c84A76Ad7e9c93437bFc5Ac33E2DDaE9",
      "coingeckoId": "aave"
    }
  },
  {
    "chainId": 101,
    "address": "Arc2ZVKNCdDU4vB8Ubud5QayDtjo2oJF9xVrUPQ6TWxF",
    "symbol": "wLEND",
    "name": "Lend (Wormhole)",
    "decimals": 9,
    "logoURI":
        "https://raw.githubusercontent.com/solana-labs/token-list/main/assets/mainnet/Arc2ZVKNCdDU4vB8Ubud5QayDtjo2oJF9xVrUPQ6TWxF/logo.png",
    "tags": ["wrapped", "wormhole"],
    "extensions": {
      "address": "0x80fB784B7eD66730e8b1DBd9820aFD29931aab03",
      "bridgeContract": "https://etherscan.io/address/0xf92cD566Ea4864356C5491c177A430C222d7e678",
      "assetContract": "https://etherscan.io/address/0x80fB784B7eD66730e8b1DBd9820aFD29931aab03",
      "coingeckoId": "ethlend"
    }
  },
  {
    "chainId": 101,
    "address": "2ctKUDkGBnVykt31AhMPhHvAQWJvoNGbLh7aRidjtAqv",
    "symbol": "wPOLS",
    "name": "PolkastarterToken (Wormhole)",
    "decimals": 9,
    "logoURI":
        "https://raw.githubusercontent.com/solana-labs/token-list/main/assets/mainnet/2ctKUDkGBnVykt31AhMPhHvAQWJvoNGbLh7aRidjtAqv/logo.png",
    "tags": ["wrapped", "wormhole"],
    "extensions": {
      "address": "0x83e6f1E41cdd28eAcEB20Cb649155049Fac3D5Aa",
      "bridgeContract": "https://etherscan.io/address/0xf92cD566Ea4864356C5491c177A430C222d7e678",
      "assetContract": "https://etherscan.io/address/0x83e6f1E41cdd28eAcEB20Cb649155049Fac3D5Aa",
      "coingeckoId": "polkastarter"
    }
  },
  {
    "chainId": 101,
    "address": "8FnkznYpHvKiaBkgatVoCrNiS5y5KW62JqgjnxVhDejC",
    "symbol": "wUBT",
    "name": "Unibright (Wormhole)",
    "decimals": 8,
    "logoURI":
        "https://raw.githubusercontent.com/solana-labs/token-list/main/assets/mainnet/8FnkznYpHvKiaBkgatVoCrNiS5y5KW62JqgjnxVhDejC/logo.png",
    "tags": ["wrapped", "wormhole"],
    "extensions": {
      "address": "0x8400D94A5cb0fa0D041a3788e395285d61c9ee5e",
      "bridgeContract": "https://etherscan.io/address/0xf92cD566Ea4864356C5491c177A430C222d7e678",
      "assetContract": "https://etherscan.io/address/0x8400D94A5cb0fa0D041a3788e395285d61c9ee5e",
      "coingeckoId": "unibright"
    }
  },
  {
    "chainId": 101,
    "address": "4LLAYXVmT3U8Sew6k3tk66zk3btT91QRzQzxcNX8XhzV",
    "symbol": "wDIA",
    "name": "DIA (Wormhole)",
    "decimals": 9,
    "logoURI":
        "https://raw.githubusercontent.com/solana-labs/token-list/main/assets/mainnet/4LLAYXVmT3U8Sew6k3tk66zk3btT91QRzQzxcNX8XhzV/logo.png",
    "tags": ["wrapped", "wormhole"],
    "extensions": {
      "address": "0x84cA8bc7997272c7CfB4D0Cd3D55cd942B3c9419",
      "bridgeContract": "https://etherscan.io/address/0xf92cD566Ea4864356C5491c177A430C222d7e678",
      "assetContract": "https://etherscan.io/address/0x84cA8bc7997272c7CfB4D0Cd3D55cd942B3c9419",
      "coingeckoId": "dia-data"
    }
  },
  {
    "chainId": 101,
    "address": "8L8pDf3jutdpdr4m3np68CL9ZroLActrqwxi6s9Ah5xU",
    "symbol": "wFRAX",
    "name": "Frax (Wormhole)",
    "decimals": 9,
    "logoURI":
        "https://raw.githubusercontent.com/solana-labs/token-list/main/assets/mainnet/8L8pDf3jutdpdr4m3np68CL9ZroLActrqwxi6s9Ah5xU/logo.png",
    "tags": ["wrapped", "wormhole"],
    "extensions": {
      "address": "0x853d955aCEf822Db058eb8505911ED77F175b99e",
      "bridgeContract": "https://etherscan.io/address/0xf92cD566Ea4864356C5491c177A430C222d7e678",
      "assetContract": "https://etherscan.io/address/0x853d955aCEf822Db058eb8505911ED77F175b99e",
      "coingeckoId": "frax"
    }
  },
  {
    "chainId": 101,
    "address": "H3oVL2zJpHJaDoRfQmSrftv3fkGzvsiQgugCZmcRBykG",
    "symbol": "wKEEP",
    "name": "KEEP Token (Wormhole)",
    "decimals": 9,
    "logoURI":
        "https://raw.githubusercontent.com/solana-labs/token-list/main/assets/mainnet/H3oVL2zJpHJaDoRfQmSrftv3fkGzvsiQgugCZmcRBykG/logo.png",
    "tags": ["wrapped", "wormhole"],
    "extensions": {
      "address": "0x85Eee30c52B0b379b046Fb0F85F4f3Dc3009aFEC",
      "bridgeContract": "https://etherscan.io/address/0xf92cD566Ea4864356C5491c177A430C222d7e678",
      "assetContract": "https://etherscan.io/address/0x85Eee30c52B0b379b046Fb0F85F4f3Dc3009aFEC",
      "coingeckoId": "keep-network"
    }
  },
  {
    "chainId": 101,
    "address": "64oqP1dFqqD8NEL4RPCpMyrHmpo31rj3nYxULVXvayfW",
    "symbol": "wRSR",
    "name": "Reserve Rights (Wormhole)",
    "decimals": 9,
    "logoURI":
        "https://raw.githubusercontent.com/solana-labs/token-list/main/assets/mainnet/64oqP1dFqqD8NEL4RPCpMyrHmpo31rj3nYxULVXvayfW/logo.png",
    "tags": ["wrapped", "wormhole"],
    "extensions": {
      "address": "0x8762db106B2c2A0bccB3A80d1Ed41273552616E8",
      "bridgeContract": "https://etherscan.io/address/0xf92cD566Ea4864356C5491c177A430C222d7e678",
      "assetContract": "https://etherscan.io/address/0x8762db106B2c2A0bccB3A80d1Ed41273552616E8",
      "coingeckoId": "reserve-rights-token"
    }
  },
  {
    "chainId": 101,
    "address": "5SU7veiCRA16ZxnS24kCC1dwQYVwi3whvTdM48iNE1Rm",
    "symbol": "wMPH",
    "name": "88mph.app (Wormhole)",
    "decimals": 9,
    "logoURI":
        "https://raw.githubusercontent.com/solana-labs/token-list/main/assets/mainnet/5SU7veiCRA16ZxnS24kCC1dwQYVwi3whvTdM48iNE1Rm/logo.png",
    "tags": ["wrapped", "wormhole"],
    "extensions": {
      "address": "0x8888801aF4d980682e47f1A9036e589479e835C5",
      "bridgeContract": "https://etherscan.io/address/0xf92cD566Ea4864356C5491c177A430C222d7e678",
      "assetContract": "https://etherscan.io/address/0x8888801aF4d980682e47f1A9036e589479e835C5",
      "coingeckoId": "88mph"
    }
  },
  {
    "chainId": 101,
    "address": "5fv26ojhPHWNaikXcMf2TBu4JENjLQ2PWgWYeitttVwv",
    "symbol": "wPAID",
    "name": "PAID Network (Wormhole)",
    "decimals": 9,
    "logoURI":
        "https://raw.githubusercontent.com/solana-labs/token-list/main/assets/mainnet/5fv26ojhPHWNaikXcMf2TBu4JENjLQ2PWgWYeitttVwv/logo.png",
    "tags": ["wrapped", "wormhole"],
    "extensions": {
      "address": "0x8c8687fC965593DFb2F0b4EAeFD55E9D8df348df",
      "bridgeContract": "https://etherscan.io/address/0xf92cD566Ea4864356C5491c177A430C222d7e678",
      "assetContract": "https://etherscan.io/address/0x8c8687fC965593DFb2F0b4EAeFD55E9D8df348df",
      "coingeckoId": "paid-network"
    }
  },
  {
    "chainId": 101,
    "address": "ACr98v3kv9qaGnR3p2BfsoSK9Q2ZmP6zUkm3qxv5ZJDd",
    "symbol": "wSXP",
    "name": "Swipe (Wormhole)",
    "decimals": 9,
    "logoURI":
        "https://raw.githubusercontent.com/solana-labs/token-list/main/assets/mainnet/ACr98v3kv9qaGnR3p2BfsoSK9Q2ZmP6zUkm3qxv5ZJDd/logo.png",
    "tags": ["wrapped", "wormhole"],
    "extensions": {
      "address": "0x8CE9137d39326AD0cD6491fb5CC0CbA0e089b6A9",
      "bridgeContract": "https://etherscan.io/address/0xf92cD566Ea4864356C5491c177A430C222d7e678",
      "assetContract": "https://etherscan.io/address/0x8CE9137d39326AD0cD6491fb5CC0CbA0e089b6A9",
      "coingeckoId": "swipe"
    }
  },
  {
    "chainId": 101,
    "address": "7gBuzBcJ7V48m8TiKJ1XWNDUerK2XfAbjxuRiKMb6S8Z",
    "symbol": "wREQ",
    "name": "Request Token (Wormhole)",
    "decimals": 9,
    "logoURI":
        "https://raw.githubusercontent.com/solana-labs/token-list/main/assets/mainnet/7gBuzBcJ7V48m8TiKJ1XWNDUerK2XfAbjxuRiKMb6S8Z/logo.png",
    "tags": ["wrapped", "wormhole"],
    "extensions": {
      "address": "0x8f8221aFbB33998d8584A2B05749bA73c37a938a",
      "bridgeContract": "https://etherscan.io/address/0xf92cD566Ea4864356C5491c177A430C222d7e678",
      "assetContract": "https://etherscan.io/address/0x8f8221aFbB33998d8584A2B05749bA73c37a938a",
      "coingeckoId": "request-network"
    }
  },
  {
    "chainId": 101,
    "address": "CtDjsryLtwZCLj8TeniV7tWHbkaREfjKDWpvyQvsTyek",
    "symbol": "wWHALE",
    "name": "WHALE (Wormhole)",
    "decimals": 4,
    "logoURI":
        "https://raw.githubusercontent.com/solana-labs/token-list/main/assets/mainnet/CtDjsryLtwZCLj8TeniV7tWHbkaREfjKDWpvyQvsTyek/logo.png",
    "tags": ["wrapped", "wormhole"],
    "extensions": {
      "address": "0x9355372396e3F6daF13359B7b607a3374cc638e0",
      "bridgeContract": "https://etherscan.io/address/0xf92cD566Ea4864356C5491c177A430C222d7e678",
      "assetContract": "https://etherscan.io/address/0x9355372396e3F6daF13359B7b607a3374cc638e0",
      "coingeckoId": "whale"
    }
  },
  {
    "chainId": 101,
    "address": "JDUgn6JUSwufqqthRdnZZKWv2vEdYvHxigF5Hk79yxRm",
    "symbol": "wPNK",
    "name": "Pinakion (Wormhole)",
    "decimals": 9,
    "logoURI":
        "https://raw.githubusercontent.com/solana-labs/token-list/main/assets/mainnet/JDUgn6JUSwufqqthRdnZZKWv2vEdYvHxigF5Hk79yxRm/logo.png",
    "tags": ["wrapped", "wormhole"],
    "extensions": {
      "address": "0x93ED3FBe21207Ec2E8f2d3c3de6e058Cb73Bc04d",
      "bridgeContract": "https://etherscan.io/address/0xf92cD566Ea4864356C5491c177A430C222d7e678",
      "assetContract": "https://etherscan.io/address/0x93ED3FBe21207Ec2E8f2d3c3de6e058Cb73Bc04d",
      "coingeckoId": "kleros"
    }
  },
  {
    "chainId": 101,
    "address": "Gw7M5dqZJ6B6a8dYkDry6z9t9FuUA2xPUokjV2cortoq",
    "symbol": "KRW",
    "name": "Krown",
    "decimals": 18,
    "logoURI":
        "https://raw.githubusercontent.com/solana-labs/token-list/main/assets/mainnet/Gw7M5dqZJ6B6a8dYkDry6z9t9FuUA2xPUokjV2cortoq/logo.png",
    "tags": ["wrapped"],
    "extensions": {
      "address": "0x1446f3cedf4d86a9399e49f7937766e6de2a3aab",
      "bridgeContract": "https://bscscan.com/address/0x0ac4a2f14927c7e038a3962b647dc7527d8a7229",
      "assetContract": "https://www.bscscan.com/address/0x1446f3cedf4d86a9399e49f7937766e6de2a3aab",
      "coingeckoId": "krown",
      "website": "https://kingdefi.io",
      "twitter": "https://twitter.com/kingdefi2"
    }
  },
  {
    "chainId": 101,
    "address": "EJKqF4p7xVhXkcDNCrVQJE4osow76226bc6u3AtsGXaG",
    "symbol": "wAPY",
    "name": "APY Governance Token (Wormhole)",
    "decimals": 9,
    "logoURI":
        "https://raw.githubusercontent.com/solana-labs/token-list/main/assets/mainnet/EJKqF4p7xVhXkcDNCrVQJE4osow76226bc6u3AtsGXaG/logo.png",
    "tags": ["wrapped", "wormhole"],
    "extensions": {
      "address": "0x95a4492F028aa1fd432Ea71146b433E7B4446611",
      "bridgeContract": "https://etherscan.io/address/0xf92cD566Ea4864356C5491c177A430C222d7e678",
      "assetContract": "https://etherscan.io/address/0x95a4492F028aa1fd432Ea71146b433E7B4446611",
      "coingeckoId": "apy-finance"
    }
  },
  {
    "chainId": 101,
    "address": "AF7Dv5Vzi1dT2fLnz4ysiRQ6FxGN1M6mrmHwgNpx7FVH",
    "symbol": "wOCEAN",
    "name": "Ocean Protocol (Wormhole)",
    "decimals": 9,
    "logoURI":
        "https://raw.githubusercontent.com/solana-labs/token-list/main/assets/mainnet/AF7Dv5Vzi1dT2fLnz4ysiRQ6FxGN1M6mrmHwgNpx7FVH/logo.png",
    "tags": ["wrapped", "wormhole"],
    "extensions": {
      "address": "0x967da4048cD07aB37855c090aAF366e4ce1b9F48",
      "bridgeContract": "https://etherscan.io/address/0xf92cD566Ea4864356C5491c177A430C222d7e678",
      "assetContract": "https://etherscan.io/address/0x967da4048cD07aB37855c090aAF366e4ce1b9F48",
      "coingeckoId": "ocean-protocol"
    }
  },
  {
    "chainId": 101,
    "address": "AyNULvvLGW11fThvhncqNRjEgmDbMEHdDL4HqXD6SM8V",
    "symbol": "wSPI",
    "name": "Shopping.io (Wormhole)",
    "decimals": 9,
    "logoURI":
        "https://raw.githubusercontent.com/solana-labs/token-list/main/assets/mainnet/AyNULvvLGW11fThvhncqNRjEgmDbMEHdDL4HqXD6SM8V/logo.png",
    "tags": ["wrapped", "wormhole"],
    "extensions": {
      "address": "0x9B02dD390a603Add5c07f9fd9175b7DABE8D63B7",
      "bridgeContract": "https://etherscan.io/address/0xf92cD566Ea4864356C5491c177A430C222d7e678",
      "assetContract": "https://etherscan.io/address/0x9B02dD390a603Add5c07f9fd9175b7DABE8D63B7",
      "coingeckoId": "shopping-io"
    }
  },
  {
    "chainId": 101,
    "address": "3UeKTABxz9XexDtyKq646rSQvx8GVpKNwfMoKKfxsTsF",
    "symbol": "wBBTC",
    "name": "Binance Wrapped BTC (Wormhole)",
    "decimals": 8,
    "logoURI":
        "https://raw.githubusercontent.com/solana-labs/token-list/main/assets/mainnet/3UeKTABxz9XexDtyKq646rSQvx8GVpKNwfMoKKfxsTsF/logo.png",
    "tags": ["wrapped", "wormhole"],
    "extensions": {
      "address": "0x9BE89D2a4cd102D8Fecc6BF9dA793be995C22541",
      "bridgeContract": "https://etherscan.io/address/0xf92cD566Ea4864356C5491c177A430C222d7e678",
      "assetContract": "https://etherscan.io/address/0x9BE89D2a4cd102D8Fecc6BF9dA793be995C22541",
      "coingeckoId": "binance-wrapped-btc"
    }
  },
  {
    "chainId": 101,
    "address": "DsGbyCHbG4vSWBqAprR2eWuUAg8fXAgYkWL9psgvYZn5",
    "symbol": "wUNISTAKE",
    "name": "Unistake (Wormhole)",
    "decimals": 9,
    "logoURI":
        "https://raw.githubusercontent.com/solana-labs/token-list/main/assets/mainnet/DsGbyCHbG4vSWBqAprR2eWuUAg8fXAgYkWL9psgvYZn5/logo.png",
    "tags": ["wrapped", "wormhole"],
    "extensions": {
      "address": "0x9Ed8e7C9604790F7Ec589F99b94361d8AAB64E5E",
      "bridgeContract": "https://etherscan.io/address/0xf92cD566Ea4864356C5491c177A430C222d7e678",
      "assetContract": "https://etherscan.io/address/0x9Ed8e7C9604790F7Ec589F99b94361d8AAB64E5E",
      "coingeckoId": "unistake"
    }
  },
  {
    "chainId": 101,
    "address": "GBvv3jn9u6pZqPd2GVnQ7BKJzLwQnEWe4ci9k359PN9Z",
    "symbol": "wMKR",
    "name": "MakerDAO (Wormhole)",
    "decimals": 9,
    "logoURI":
        "https://raw.githubusercontent.com/solana-labs/token-list/main/assets/mainnet/GBvv3jn9u6pZqPd2GVnQ7BKJzLwQnEWe4ci9k359PN9Z/logo.png",
    "tags": ["wrapped", "wormhole"],
    "extensions": {
      "address": "0x9f8F72aA9304c8B593d555F12eF6589cC3A579A2",
      "bridgeContract": "https://etherscan.io/address/0xf92cD566Ea4864356C5491c177A430C222d7e678",
      "assetContract": "https://etherscan.io/address/0x9f8F72aA9304c8B593d555F12eF6589cC3A579A2",
      "coingeckoId": "maker"
    }
  },
  {
    "chainId": 101,
    "address": "53ETjuzUNHG8c7rZ2hxQLQfN5R6tEYtdYwNQsa68xFUk",
    "symbol": "wFARM",
    "name": "FARM Reward Token (Wormhole)",
    "decimals": 9,
    "logoURI":
        "https://raw.githubusercontent.com/solana-labs/token-list/main/assets/mainnet/53ETjuzUNHG8c7rZ2hxQLQfN5R6tEYtdYwNQsa68xFUk/logo.png",
    "tags": ["wrapped", "wormhole"],
    "extensions": {
      "address": "0xa0246c9032bC3A600820415aE600c6388619A14D",
      "bridgeContract": "https://etherscan.io/address/0xf92cD566Ea4864356C5491c177A430C222d7e678",
      "assetContract": "https://etherscan.io/address/0xa0246c9032bC3A600820415aE600c6388619A14D",
      "coingeckoId": "harvest-finance"
    }
  },
  {
    "chainId": 101,
    "address": "FVsXUnbhifqJ4LiXQEbpUtXVdB8T5ADLKqSs5t1oc54F",
    "symbol": "wUSDC",
    "name": "USD Coin (Wormhole)",
    "decimals": 6,
    "logoURI":
        "https://raw.githubusercontent.com/solana-labs/token-list/main/assets/mainnet/FVsXUnbhifqJ4LiXQEbpUtXVdB8T5ADLKqSs5t1oc54F/logo.png",
    "tags": ["wrapped", "wormhole"],
    "extensions": {
      "address": "0xA0b86991c6218b36c1d19D4a2e9Eb0cE3606eB48",
      "bridgeContract": "https://etherscan.io/address/0xf92cD566Ea4864356C5491c177A430C222d7e678",
      "assetContract": "https://etherscan.io/address/0xA0b86991c6218b36c1d19D4a2e9Eb0cE3606eB48",
      "coingeckoId": "usd-coin"
    }
  },
  {
    "chainId": 101,
    "address": "EjBpnWzWZeW1PKzfCszLdHgENZLZDoTNaEmz8BddpWJx",
    "symbol": "wANT",
    "name": "Aragon Network Token (Wormhole)",
    "decimals": 9,
    "logoURI":
        "https://raw.githubusercontent.com/solana-labs/token-list/main/assets/mainnet/EjBpnWzWZeW1PKzfCszLdHgENZLZDoTNaEmz8BddpWJx/logo.png",
    "tags": ["wrapped", "wormhole"],
    "extensions": {
      "address": "0xa117000000f279D81A1D3cc75430fAA017FA5A2e",
      "bridgeContract": "https://etherscan.io/address/0xf92cD566Ea4864356C5491c177A430C222d7e678",
      "assetContract": "https://etherscan.io/address/0xa117000000f279D81A1D3cc75430fAA017FA5A2e",
      "coingeckoId": "aragon"
    }
  },
  {
    "chainId": 101,
    "address": "Rs4LHZ4WogZCAkCzfsKJib5LLnYL6xcVAfTcLQiSjg2",
    "symbol": "wNPXS",
    "name": "Pundi X Token (Wormhole)",
    "decimals": 9,
    "logoURI":
        "https://raw.githubusercontent.com/solana-labs/token-list/main/assets/mainnet/Rs4LHZ4WogZCAkCzfsKJib5LLnYL6xcVAfTcLQiSjg2/logo.png",
    "tags": ["wrapped", "wormhole"],
    "extensions": {
      "address": "0xA15C7Ebe1f07CaF6bFF097D8a589fb8AC49Ae5B3",
      "bridgeContract": "https://etherscan.io/address/0xf92cD566Ea4864356C5491c177A430C222d7e678",
      "assetContract": "https://etherscan.io/address/0xA15C7Ebe1f07CaF6bFF097D8a589fb8AC49Ae5B3",
      "coingeckoId": "pundi-x"
    }
  },
  {
    "chainId": 101,
    "address": "65ribugkb42AANKYrEeuruhhfXffyE4jY22FUxFbpW7C",
    "symbol": "wRFOX",
    "name": "RFOX (Wormhole)",
    "decimals": 9,
    "logoURI":
        "https://raw.githubusercontent.com/solana-labs/token-list/main/assets/mainnet/65ribugkb42AANKYrEeuruhhfXffyE4jY22FUxFbpW7C/logo.png",
    "tags": ["wrapped", "wormhole"],
    "extensions": {
      "address": "0xa1d6Df714F91DeBF4e0802A542E13067f31b8262",
      "bridgeContract": "https://etherscan.io/address/0xf92cD566Ea4864356C5491c177A430C222d7e678",
      "assetContract": "https://etherscan.io/address/0xa1d6Df714F91DeBF4e0802A542E13067f31b8262",
      "coingeckoId": "redfox-labs-2"
    }
  },
  {
    "chainId": 101,
    "address": "T2mo6dnFiutu26KMuCMSjCLBB4ofWvQ3qBJGEMc3JSe",
    "symbol": "wMTA",
    "name": "Meta (Wormhole)",
    "decimals": 9,
    "logoURI":
        "https://raw.githubusercontent.com/solana-labs/token-list/main/assets/mainnet/T2mo6dnFiutu26KMuCMSjCLBB4ofWvQ3qBJGEMc3JSe/logo.png",
    "tags": ["wrapped", "wormhole"],
    "extensions": {
      "address": "0xa3BeD4E1c75D00fa6f4E5E6922DB7261B5E9AcD2",
      "bridgeContract": "https://etherscan.io/address/0xf92cD566Ea4864356C5491c177A430C222d7e678",
      "assetContract": "https://etherscan.io/address/0xa3BeD4E1c75D00fa6f4E5E6922DB7261B5E9AcD2",
      "coingeckoId": "meta"
    }
  },
  {
    "chainId": 101,
    "address": "HC8SaUm9rhvVZE5ZwBWiUhFAnCuG8byd5FxKYdpFm5MR",
    "symbol": "wRBC",
    "name": "Rubic (Wormhole)",
    "decimals": 9,
    "logoURI":
        "https://raw.githubusercontent.com/solana-labs/token-list/main/assets/mainnet/HC8SaUm9rhvVZE5ZwBWiUhFAnCuG8byd5FxKYdpFm5MR/logo.png",
    "tags": ["wrapped", "wormhole"],
    "extensions": {
      "address": "0xA4EED63db85311E22dF4473f87CcfC3DaDCFA3E3",
      "bridgeContract": "https://etherscan.io/address/0xf92cD566Ea4864356C5491c177A430C222d7e678",
      "assetContract": "https://etherscan.io/address/0xA4EED63db85311E22dF4473f87CcfC3DaDCFA3E3",
      "coingeckoId": "rubic"
    }
  },
  {
    "chainId": 101,
    "address": "9DdtKWoK8cBfLSLhHXHFZzzhxp4rdwHbFEAis8n5AsfQ",
    "symbol": "wNOIA",
    "name": "NOIA Token (Wormhole)",
    "decimals": 9,
    "logoURI":
        "https://raw.githubusercontent.com/solana-labs/token-list/main/assets/mainnet/9DdtKWoK8cBfLSLhHXHFZzzhxp4rdwHbFEAis8n5AsfQ/logo.png",
    "tags": ["wrapped", "wormhole"],
    "extensions": {
      "address": "0xa8c8CfB141A3bB59FEA1E2ea6B79b5ECBCD7b6ca",
      "bridgeContract": "https://etherscan.io/address/0xf92cD566Ea4864356C5491c177A430C222d7e678",
      "assetContract": "https://etherscan.io/address/0xa8c8CfB141A3bB59FEA1E2ea6B79b5ECBCD7b6ca",
      "coingeckoId": "noia-network"
    }
  },
  {
    "chainId": 101,
    "address": "DTQStP2z4DRqbNHRxtwThAujr9aPFPsv4y2kkXTVLVvb",
    "symbol": "wCEL",
    "name": "Celsius (Wormhole)",
    "decimals": 4,
    "logoURI":
        "https://raw.githubusercontent.com/solana-labs/token-list/main/assets/mainnet/DTQStP2z4DRqbNHRxtwThAujr9aPFPsv4y2kkXTVLVvb/logo.png",
    "tags": ["wrapped", "wormhole"],
    "extensions": {
      "address": "0xaaAEBE6Fe48E54f431b0C390CfaF0b017d09D42d",
      "bridgeContract": "https://etherscan.io/address/0xf92cD566Ea4864356C5491c177A430C222d7e678",
      "assetContract": "https://etherscan.io/address/0xaaAEBE6Fe48E54f431b0C390CfaF0b017d09D42d",
      "coingeckoId": "celsius-degree-token"
    }
  },
  {
    "chainId": 101,
    "address": "59NPV18vAbTgwC9aeEGikrmX3EbZHMEMkZfvcsHBNFr9",
    "symbol": "wCWS",
    "name": "Crowns (Wormhole)",
    "decimals": 9,
    "logoURI":
        "https://raw.githubusercontent.com/solana-labs/token-list/main/assets/mainnet/59NPV18vAbTgwC9aeEGikrmX3EbZHMEMkZfvcsHBNFr9/logo.png",
    "tags": ["wrapped", "wormhole"],
    "extensions": {
      "address": "0xaC0104Cca91D167873B8601d2e71EB3D4D8c33e0",
      "bridgeContract": "https://etherscan.io/address/0xf92cD566Ea4864356C5491c177A430C222d7e678",
      "assetContract": "https://etherscan.io/address/0xaC0104Cca91D167873B8601d2e71EB3D4D8c33e0",
      "coingeckoId": "crowns"
    }
  },
  {
    "chainId": 101,
    "address": "4811JP9i35zgAxSFZjGXQwew6xd1qSBE4xdMFik2J14Z",
    "symbol": "wROOM",
    "name": "OptionRoom Token (Wormhole)",
    "decimals": 9,
    "logoURI":
        "https://raw.githubusercontent.com/solana-labs/token-list/main/assets/mainnet/4811JP9i35zgAxSFZjGXQwew6xd1qSBE4xdMFik2J14Z/logo.png",
    "tags": ["wrapped", "wormhole"],
    "extensions": {
      "address": "0xAd4f86a25bbc20FfB751f2FAC312A0B4d8F88c64",
      "bridgeContract": "https://etherscan.io/address/0xf92cD566Ea4864356C5491c177A430C222d7e678",
      "assetContract": "https://etherscan.io/address/0xAd4f86a25bbc20FfB751f2FAC312A0B4d8F88c64",
      "coingeckoId": "option-room"
    }
  },
  {
    "chainId": 101,
    "address": "2VAdvHWMpzMnDYYn64MgqLNpGQ19iCiusCet8JLMtxU5",
    "symbol": "wYOP",
    "name": "YOP (Wormhole)",
    "decimals": 8,
    "logoURI":
        "https://raw.githubusercontent.com/solana-labs/token-list/main/assets/mainnet/2VAdvHWMpzMnDYYn64MgqLNpGQ19iCiusCet8JLMtxU5/logo.png",
    "tags": ["wrapped", "wormhole"],
    "extensions": {
      "address": "0xAE1eaAE3F627AAca434127644371b67B18444051",
      "bridgeContract": "https://etherscan.io/address/0xf92cD566Ea4864356C5491c177A430C222d7e678",
      "assetContract": "https://etherscan.io/address/0xAE1eaAE3F627AAca434127644371b67B18444051",
      "coingeckoId": "yield-optimization-platform"
    }
  },
  {
    "chainId": 101,
    "address": "AKiTcEWZarsnUbKkwQVRjJni5eqwiNeBQsJ3nrADacT4",
    "symbol": "wLGCY",
    "name": "LGCY Network (Wormhole)",
    "decimals": 9,
    "logoURI":
        "https://raw.githubusercontent.com/solana-labs/token-list/main/assets/mainnet/AKiTcEWZarsnUbKkwQVRjJni5eqwiNeBQsJ3nrADacT4/logo.png",
    "tags": ["wrapped", "wormhole"],
    "extensions": {
      "address": "0xaE697F994Fc5eBC000F8e22EbFfeE04612f98A0d",
      "bridgeContract": "https://etherscan.io/address/0xf92cD566Ea4864356C5491c177A430C222d7e678",
      "assetContract": "https://etherscan.io/address/0xaE697F994Fc5eBC000F8e22EbFfeE04612f98A0d",
      "coingeckoId": "lgcy-network"
    }
  },
  {
    "chainId": 101,
    "address": "4kPHTMfSD1k3SytAMKEVRWH5ip6WD5U52tC5q6TuXUNU",
    "symbol": "wRFuel",
    "name": "Rio Fuel Token (Wormhole)",
    "decimals": 9,
    "logoURI":
        "https://raw.githubusercontent.com/solana-labs/token-list/main/assets/mainnet/4kPHTMfSD1k3SytAMKEVRWH5ip6WD5U52tC5q6TuXUNU/logo.png",
    "tags": ["wrapped", "wormhole"],
    "extensions": {
      "address": "0xaf9f549774ecEDbD0966C52f250aCc548D3F36E5",
      "bridgeContract": "https://etherscan.io/address/0xf92cD566Ea4864356C5491c177A430C222d7e678",
      "assetContract": "https://etherscan.io/address/0xaf9f549774ecEDbD0966C52f250aCc548D3F36E5",
      "coingeckoId": "rio-defi"
    }
  },
  {
    "chainId": 101,
    "address": "E1w2uKRsVJeDf1Qqbk7DDKEDe7NCYwh8ySgqCaEZ4BTC",
    "symbol": "wMAHA",
    "name": "MahaDAO (Wormhole)",
    "decimals": 9,
    "logoURI":
        "https://raw.githubusercontent.com/solana-labs/token-list/main/assets/mainnet/E1w2uKRsVJeDf1Qqbk7DDKEDe7NCYwh8ySgqCaEZ4BTC/logo.png",
    "tags": ["wrapped", "wormhole"],
    "extensions": {
      "address": "0xB4d930279552397bbA2ee473229f89Ec245bc365",
      "bridgeContract": "https://etherscan.io/address/0xf92cD566Ea4864356C5491c177A430C222d7e678",
      "assetContract": "https://etherscan.io/address/0xB4d930279552397bbA2ee473229f89Ec245bc365",
      "coingeckoId": "mahadao"
    }
  },
  {
    "chainId": 101,
    "address": "4psmnTirimNyPEPEZtkQkdEPJagTXS3a7wsu1XN9MYK3",
    "symbol": "wRPL",
    "name": "Rocket Pool (Wormhole)",
    "decimals": 9,
    "logoURI":
        "https://raw.githubusercontent.com/solana-labs/token-list/main/assets/mainnet/4psmnTirimNyPEPEZtkQkdEPJagTXS3a7wsu1XN9MYK3/logo.png",
    "tags": ["wrapped", "wormhole"],
    "extensions": {
      "address": "0xB4EFd85c19999D84251304bDA99E90B92300Bd93",
      "bridgeContract": "https://etherscan.io/address/0xf92cD566Ea4864356C5491c177A430C222d7e678",
      "assetContract": "https://etherscan.io/address/0xB4EFd85c19999D84251304bDA99E90B92300Bd93",
      "coingeckoId": "rocket-pool"
    }
  },
  {
    "chainId": 101,
    "address": "FrhQauNRm7ecom9FRprNcyz58agDe5ujAbAtA9NG6jtU",
    "symbol": "wNEXO",
    "name": "Nexo (Wormhole)",
    "decimals": 9,
    "logoURI":
        "https://raw.githubusercontent.com/solana-labs/token-list/main/assets/mainnet/FrhQauNRm7ecom9FRprNcyz58agDe5ujAbAtA9NG6jtU/logo.png",
    "tags": ["wrapped", "wormhole"],
    "extensions": {
      "address": "0xB62132e35a6c13ee1EE0f84dC5d40bad8d815206",
      "bridgeContract": "https://etherscan.io/address/0xf92cD566Ea4864356C5491c177A430C222d7e678",
      "assetContract": "https://etherscan.io/address/0xB62132e35a6c13ee1EE0f84dC5d40bad8d815206",
      "coingeckoId": "nexo"
    }
  },
  {
    "chainId": 101,
    "address": "6G7X1B2f9F7KWcHxS66mn3ax6VPE2UMZud44RX3BzfVo",
    "symbol": "BEHZAT",
    "name": "Behzat Token",
    "decimals": 9,
    "logoURI":
        "https://raw.githubusercontent.com/solana-labs/token-list/main/assets/mainnet/6G7X1B2f9F7KWcHxS66mn3ax6VPE2UMZud44RX3BzfVo/logo.png",
    "tags": ["Token"],
    "extensions": {"twitter": "https://twitter.com/Tunay32718753"}
  },
  {
    "chainId": 101,
    "address": "AoU75vwpnWEVvfarxRALjzRc8vS9UdDhRMkwoDimt9ss",
    "symbol": "wSFI",
    "name": "Spice (Wormhole)",
    "decimals": 9,
    "logoURI":
        "https://raw.githubusercontent.com/solana-labs/token-list/main/assets/mainnet/AoU75vwpnWEVvfarxRALjzRc8vS9UdDhRMkwoDimt9ss/logo.png",
    "tags": ["wrapped", "wormhole"],
    "extensions": {
      "address": "0xb753428af26E81097e7fD17f40c88aaA3E04902c",
      "bridgeContract": "https://etherscan.io/address/0xf92cD566Ea4864356C5491c177A430C222d7e678",
      "assetContract": "https://etherscan.io/address/0xb753428af26E81097e7fD17f40c88aaA3E04902c",
      "coingeckoId": "saffron-finance"
    }
  },
  {
    "chainId": 101,
    "address": "CRZuALvCYjPLB65WFLHh9JkmPWK5C81TXpy2aEEaCjr3",
    "symbol": "wSTBZ",
    "name": "Stabilize Token (Wormhole)",
    "decimals": 9,
    "logoURI":
        "https://raw.githubusercontent.com/solana-labs/token-list/main/assets/mainnet/CRZuALvCYjPLB65WFLHh9JkmPWK5C81TXpy2aEEaCjr3/logo.png",
    "tags": ["wrapped", "wormhole"],
    "extensions": {
      "address": "0xB987D48Ed8f2C468D52D6405624EADBa5e76d723",
      "bridgeContract": "https://etherscan.io/address/0xf92cD566Ea4864356C5491c177A430C222d7e678",
      "assetContract": "https://etherscan.io/address/0xB987D48Ed8f2C468D52D6405624EADBa5e76d723",
      "coingeckoId": "stabilize"
    }
  },
  {
    "chainId": 101,
    "address": "HPYXGSdAwyK5GwmuivL8gDdUVRChtgXq6SRat44k4Pat",
    "symbol": "wBAL",
    "name": "Balancer (Wormhole)",
    "decimals": 9,
    "logoURI":
        "https://raw.githubusercontent.com/solana-labs/token-list/main/assets/mainnet/HPYXGSdAwyK5GwmuivL8gDdUVRChtgXq6SRat44k4Pat/logo.png",
    "tags": ["wrapped", "wormhole"],
    "extensions": {
      "address": "0xba100000625a3754423978a60c9317c58a424e3D",
      "bridgeContract": "https://etherscan.io/address/0xf92cD566Ea4864356C5491c177A430C222d7e678",
      "assetContract": "https://etherscan.io/address/0xba100000625a3754423978a60c9317c58a424e3D",
      "coingeckoId": "balancer"
    }
  },
  {
    "chainId": 101,
    "address": "AV7NgJV2BsgEukzUTrcUMz3LD37xLcLtygFig5WJ3kQN",
    "symbol": "wBAND",
    "name": "BandToken (Wormhole)",
    "decimals": 9,
    "logoURI":
        "https://raw.githubusercontent.com/solana-labs/token-list/main/assets/mainnet/AV7NgJV2BsgEukzUTrcUMz3LD37xLcLtygFig5WJ3kQN/logo.png",
    "tags": ["wrapped", "wormhole"],
    "extensions": {
      "address": "0xBA11D00c5f74255f56a5E366F4F77f5A186d7f55",
      "bridgeContract": "https://etherscan.io/address/0xf92cD566Ea4864356C5491c177A430C222d7e678",
      "assetContract": "https://etherscan.io/address/0xBA11D00c5f74255f56a5E366F4F77f5A186d7f55",
      "coingeckoId": "band-protocol"
    }
  },
  {
    "chainId": 101,
    "address": "4obZok5FFUcQXQoV39hhcqk9xSmo4WnP9wnrNCk1g5BC",
    "symbol": "wSWFL",
    "name": "Swapfolio (Wormhole)",
    "decimals": 9,
    "logoURI":
        "https://raw.githubusercontent.com/solana-labs/token-list/main/assets/mainnet/4obZok5FFUcQXQoV39hhcqk9xSmo4WnP9wnrNCk1g5BC/logo.png",
    "tags": ["wrapped", "wormhole"],
    "extensions": {
      "address": "0xBa21Ef4c9f433Ede00badEFcC2754B8E74bd538A",
      "bridgeContract": "https://etherscan.io/address/0xf92cD566Ea4864356C5491c177A430C222d7e678",
      "assetContract": "https://etherscan.io/address/0xBa21Ef4c9f433Ede00badEFcC2754B8E74bd538A",
      "coingeckoId": "swapfolio"
    }
  },
  {
    "chainId": 101,
    "address": "HCP8hGKS6fUGfTA1tQxBKzbXuQk7yktzz71pY8LXVJyR",
    "symbol": "wLRC",
    "name": "LoopringCoin V2 (Wormhole)",
    "decimals": 9,
    "logoURI":
        "https://raw.githubusercontent.com/solana-labs/token-list/main/assets/mainnet/HCP8hGKS6fUGfTA1tQxBKzbXuQk7yktzz71pY8LXVJyR/logo.png",
    "tags": ["wrapped", "wormhole"],
    "extensions": {
      "address": "0xBBbbCA6A901c926F240b89EacB641d8Aec7AEafD",
      "bridgeContract": "https://etherscan.io/address/0xf92cD566Ea4864356C5491c177A430C222d7e678",
      "assetContract": "https://etherscan.io/address/0xBBbbCA6A901c926F240b89EacB641d8Aec7AEafD",
      "coingeckoId": "loopring"
    }
  },
  {
    "chainId": 101,
    "address": "7kpzQByqsfmZSX5Y71YtncBvuhFVFJBLUvJKqqNMfT8P",
    "symbol": "TSK",
    "name": "TaskDapp",
    "decimals": 6,
    "logoURI":
        "https://raw.githubusercontent.com/solana-labs/token-list/main/assets/mainnet/7kpzQByqsfmZSX5Y71YtncBvuhFVFJBLUvJKqqNMfT8P/logo.svg",
    "tags": ["utility-token"],
    "extensions": {"website": "https://taskdapp.io", "twitter": "https://twitter.com/task_dapp"}
  },
  {
    "chainId": 101,
    "address": "9sNArcS6veh7DLEo7Y1ZSbBCYtkuPVE6S3HhVrcWR2Zw",
    "symbol": "wPERP",
    "name": "Perpetual (Wormhole)",
    "decimals": 9,
    "logoURI":
        "https://raw.githubusercontent.com/solana-labs/token-list/main/assets/mainnet/9sNArcS6veh7DLEo7Y1ZSbBCYtkuPVE6S3HhVrcWR2Zw/logo.png",
    "tags": ["wrapped", "wormhole"],
    "extensions": {
      "address": "0xbC396689893D065F41bc2C6EcbeE5e0085233447",
      "bridgeContract": "https://etherscan.io/address/0xf92cD566Ea4864356C5491c177A430C222d7e678",
      "assetContract": "https://etherscan.io/address/0xbC396689893D065F41bc2C6EcbeE5e0085233447",
      "coingeckoId": "perpetual-protocol"
    }
  },
  {
    "chainId": 101,
    "address": "3XnhArdJydrpbr9Nbj8wNUaozPL9WAo9YDyNWakhTm9X",
    "symbol": "wCOMP",
    "name": "Compound (Wormhole)",
    "decimals": 9,
    "logoURI":
        "https://raw.githubusercontent.com/solana-labs/token-list/main/assets/mainnet/3XnhArdJydrpbr9Nbj8wNUaozPL9WAo9YDyNWakhTm9X/logo.png",
    "tags": ["wrapped", "wormhole"],
    "extensions": {
      "address": "0xc00e94Cb662C3520282E6f5717214004A7f26888",
      "bridgeContract": "https://etherscan.io/address/0xf92cD566Ea4864356C5491c177A430C222d7e678",
      "assetContract": "https://etherscan.io/address/0xc00e94Cb662C3520282E6f5717214004A7f26888",
      "coingeckoId": "compound-governance-token"
    }
  },
  {
    "chainId": 101,
    "address": "CPLNm9UMKfiJKiySQathV99yeSgTVjPDZx4ucFrbp2MD",
    "symbol": "wSNX",
    "name": "Synthetix Network Token (Wormhole)",
    "decimals": 9,
    "logoURI":
        "https://raw.githubusercontent.com/solana-labs/token-list/main/assets/mainnet/CPLNm9UMKfiJKiySQathV99yeSgTVjPDZx4ucFrbp2MD/logo.png",
    "tags": ["wrapped", "wormhole"],
    "extensions": {
      "address": "0xC011a73ee8576Fb46F5E1c5751cA3B9Fe0af2a6F",
      "bridgeContract": "https://etherscan.io/address/0xf92cD566Ea4864356C5491c177A430C222d7e678",
      "assetContract": "https://etherscan.io/address/0xC011a73ee8576Fb46F5E1c5751cA3B9Fe0af2a6F",
      "coingeckoId": "havven"
    }
  },
  {
    "chainId": 101,
    "address": "D6eVKSfLdioqo2zG8LbQYFU2gf66FrjKA7afCYNo1GHt",
    "symbol": "wDUCK",
    "name": "DLP Duck Token (Wormhole)",
    "decimals": 9,
    "logoURI":
        "https://raw.githubusercontent.com/solana-labs/token-list/main/assets/mainnet/D6eVKSfLdioqo2zG8LbQYFU2gf66FrjKA7afCYNo1GHt/logo.png",
    "tags": ["wrapped", "wormhole"],
    "extensions": {
      "address": "0xC0bA369c8Db6eB3924965e5c4FD0b4C1B91e305F",
      "bridgeContract": "https://etherscan.io/address/0xf92cD566Ea4864356C5491c177A430C222d7e678",
      "assetContract": "https://etherscan.io/address/0xC0bA369c8Db6eB3924965e5c4FD0b4C1B91e305F",
      "coingeckoId": "dlp-duck-token"
    }
  },
  {
    "chainId": 101,
    "address": "9PwPi3DAf9Dy4Y6qJmUzF6fX9CjNwScBidsYqJmcApF8",
    "symbol": "wCHAIN",
    "name": "Chain Games (Wormhole)",
    "decimals": 9,
    "logoURI":
        "https://raw.githubusercontent.com/solana-labs/token-list/main/assets/mainnet/9PwPi3DAf9Dy4Y6qJmUzF6fX9CjNwScBidsYqJmcApF8/logo.png",
    "tags": ["wrapped", "wormhole"],
    "extensions": {
      "address": "0xC4C2614E694cF534D407Ee49F8E44D125E4681c4",
      "bridgeContract": "https://etherscan.io/address/0xf92cD566Ea4864356C5491c177A430C222d7e678",
      "assetContract": "https://etherscan.io/address/0xC4C2614E694cF534D407Ee49F8E44D125E4681c4",
      "coingeckoId": "chain-games"
    }
  },
  {
    "chainId": 101,
    "address": "BmxZ1pghpcoyT7aykj7D1o4AxWirTqvD7zD2tNngjirT",
    "symbol": "wGRT",
    "name": "Graph Token (Wormhole)",
    "decimals": 9,
    "logoURI":
        "https://raw.githubusercontent.com/solana-labs/token-list/main/assets/mainnet/BmxZ1pghpcoyT7aykj7D1o4AxWirTqvD7zD2tNngjirT/logo.png",
    "tags": ["wrapped", "wormhole"],
    "extensions": {
      "address": "0xc944E90C64B2c07662A292be6244BDf05Cda44a7",
      "bridgeContract": "https://etherscan.io/address/0xf92cD566Ea4864356C5491c177A430C222d7e678",
      "assetContract": "https://etherscan.io/address/0xc944E90C64B2c07662A292be6244BDf05Cda44a7",
      "coingeckoId": "the-graph"
    }
  },
  {
    "chainId": 101,
    "address": "FMr15arp651N6fR2WEL36pCMBnFecHcN6wDxne2Vf3SK",
    "symbol": "wROOT",
    "name": "RootKit (Wormhole)",
    "decimals": 9,
    "logoURI":
        "https://raw.githubusercontent.com/solana-labs/token-list/main/assets/mainnet/FMr15arp651N6fR2WEL36pCMBnFecHcN6wDxne2Vf3SK/logo.png",
    "tags": ["wrapped", "wormhole"],
    "extensions": {
      "address": "0xCb5f72d37685C3D5aD0bB5F982443BC8FcdF570E",
      "bridgeContract": "https://etherscan.io/address/0xf92cD566Ea4864356C5491c177A430C222d7e678",
      "assetContract": "https://etherscan.io/address/0xCb5f72d37685C3D5aD0bB5F982443BC8FcdF570E",
      "coingeckoId": "rootkit"
    }
  },
  {
    "chainId": 101,
    "address": "E9X7rKAGfSh1gsHC6qh5MVLkDzRcT64KQbjzvHnc5zEq",
    "symbol": "wSWAP",
    "name": "TrustSwap Token (Wormhole)",
    "decimals": 9,
    "logoURI":
        "https://raw.githubusercontent.com/solana-labs/token-list/main/assets/mainnet/E9X7rKAGfSh1gsHC6qh5MVLkDzRcT64KQbjzvHnc5zEq/logo.png",
    "tags": ["wrapped", "wormhole"],
    "extensions": {
      "address": "0xCC4304A31d09258b0029eA7FE63d032f52e44EFe",
      "bridgeContract": "https://etherscan.io/address/0xf92cD566Ea4864356C5491c177A430C222d7e678",
      "assetContract": "https://etherscan.io/address/0xCC4304A31d09258b0029eA7FE63d032f52e44EFe",
      "coingeckoId": "trustswap"
    }
  },
  {
    "chainId": 101,
    "address": "5NEENV1mNvu7MfNNtKuGSDC8zoNStq1tuLkDXFtv6rZd",
    "symbol": "wTVK",
    "name": "Terra Virtua Kolect (Wormhole)",
    "decimals": 9,
    "logoURI":
        "https://raw.githubusercontent.com/solana-labs/token-list/main/assets/mainnet/5NEENV1mNvu7MfNNtKuGSDC8zoNStq1tuLkDXFtv6rZd/logo.png",
    "tags": ["wrapped", "wormhole"],
    "extensions": {
      "address": "0xd084B83C305daFD76AE3E1b4E1F1fe2eCcCb3988",
      "bridgeContract": "https://etherscan.io/address/0xf92cD566Ea4864356C5491c177A430C222d7e678",
      "assetContract": "https://etherscan.io/address/0xd084B83C305daFD76AE3E1b4E1F1fe2eCcCb3988",
      "coingeckoId": "terra-virtua-kolect"
    }
  },
  {
    "chainId": 101,
    "address": "5ZXLGj7onpitgtREJNYb51DwDPddvqV1YLC8jn2sgz48",
    "symbol": "wOMG",
    "name": "OMG Network (Wormhole)",
    "decimals": 9,
    "logoURI":
        "https://raw.githubusercontent.com/solana-labs/token-list/main/assets/mainnet/5ZXLGj7onpitgtREJNYb51DwDPddvqV1YLC8jn2sgz48/logo.png",
    "tags": ["wrapped", "wormhole"],
    "extensions": {
      "address": "0xd26114cd6EE289AccF82350c8d8487fedB8A0C07",
      "bridgeContract": "https://etherscan.io/address/0xf92cD566Ea4864356C5491c177A430C222d7e678",
      "assetContract": "https://etherscan.io/address/0xd26114cd6EE289AccF82350c8d8487fedB8A0C07",
      "coingeckoId": "omisego"
    }
  },
  {
    "chainId": 101,
    "address": "2Xf2yAXJfg82sWwdLUo2x9mZXy6JCdszdMZkcF1Hf4KV",
    "symbol": "wLUNA",
    "name": "Wrapped LUNA Token (Wormhole)",
    "decimals": 9,
    "logoURI":
        "https://raw.githubusercontent.com/solana-labs/token-list/main/assets/mainnet/2Xf2yAXJfg82sWwdLUo2x9mZXy6JCdszdMZkcF1Hf4KV/logo.png",
    "tags": ["wrapped", "wormhole"],
    "extensions": {
      "address": "0xd2877702675e6cEb975b4A1dFf9fb7BAF4C91ea9",
      "bridgeContract": "https://etherscan.io/address/0xf92cD566Ea4864356C5491c177A430C222d7e678",
      "assetContract": "https://etherscan.io/address/0xd2877702675e6cEb975b4A1dFf9fb7BAF4C91ea9",
      "coingeckoId": "wrapped-terra"
    }
  },
  {
    "chainId": 101,
    "address": "5Ro6JxJ4NjSTEppdX2iXUYgWkAEF1dcs9gqMX99E2vkL",
    "symbol": "wBONDLY",
    "name": "Bondly Token (Wormhole)",
    "decimals": 9,
    "logoURI":
        "https://raw.githubusercontent.com/solana-labs/token-list/main/assets/mainnet/5Ro6JxJ4NjSTEppdX2iXUYgWkAEF1dcs9gqMX99E2vkL/logo.png",
    "tags": ["wrapped", "wormhole"],
    "extensions": {
      "address": "0xD2dDa223b2617cB616c1580db421e4cFAe6a8a85",
      "bridgeContract": "https://etherscan.io/address/0xf92cD566Ea4864356C5491c177A430C222d7e678",
      "assetContract": "https://etherscan.io/address/0xD2dDa223b2617cB616c1580db421e4cFAe6a8a85",
      "coingeckoId": "bondly"
    }
  },
  {
    "chainId": 101,
    "address": "5jFzUEqWLnvGvKWb1Pji9nWVYy5vLG2saoXCyVNWEdEi",
    "symbol": "wDETS",
    "name": "Dextrust (Wormhole)",
    "decimals": 9,
    "logoURI":
        "https://raw.githubusercontent.com/solana-labs/token-list/main/assets/mainnet/5jFzUEqWLnvGvKWb1Pji9nWVYy5vLG2saoXCyVNWEdEi/logo.png",
    "tags": ["wrapped", "wormhole"],
    "extensions": {
      "address": "0xd379700999F4805Ce80aa32DB46A94dF64561108",
      "bridgeContract": "https://etherscan.io/address/0xf92cD566Ea4864356C5491c177A430C222d7e678",
      "assetContract": "https://etherscan.io/address/0xd379700999F4805Ce80aa32DB46A94dF64561108",
      "coingeckoId": "dextrust"
    }
  },
  {
    "chainId": 101,
    "address": "BV5tm1uCRWQCQKNgQVFnkseqAjxpmbJkRCXvzFWBdgMp",
    "symbol": "wAMPL",
    "name": "Ampleforth (Wormhole)",
    "decimals": 9,
    "logoURI":
        "https://raw.githubusercontent.com/solana-labs/token-list/main/assets/mainnet/BV5tm1uCRWQCQKNgQVFnkseqAjxpmbJkRCXvzFWBdgMp/logo.png",
    "tags": ["wrapped", "wormhole"],
    "extensions": {
      "address": "0xD46bA6D942050d489DBd938a2C909A5d5039A161",
      "bridgeContract": "https://etherscan.io/address/0xf92cD566Ea4864356C5491c177A430C222d7e678",
      "assetContract": "https://etherscan.io/address/0xD46bA6D942050d489DBd938a2C909A5d5039A161",
      "coingeckoId": "ampleforth"
    }
  },
  {
    "chainId": 101,
    "address": "2PSvGigDY4MVUmv51bBiARBMcHBtXcUBnx5V9BwWbbi2",
    "symbol": "wPOLK",
    "name": "Polkamarkets (Wormhole)",
    "decimals": 9,
    "logoURI":
        "https://raw.githubusercontent.com/solana-labs/token-list/main/assets/mainnet/2PSvGigDY4MVUmv51bBiARBMcHBtXcUBnx5V9BwWbbi2/logo.png",
    "tags": ["wrapped", "wormhole"],
    "extensions": {
      "address": "0xD478161C952357F05f0292B56012Cd8457F1cfbF",
      "bridgeContract": "https://etherscan.io/address/0xf92cD566Ea4864356C5491c177A430C222d7e678",
      "assetContract": "https://etherscan.io/address/0xD478161C952357F05f0292B56012Cd8457F1cfbF",
      "coingeckoId": "polkamarkets"
    }
  },
  {
    "chainId": 101,
    "address": "ApmXkxXCASdxRf3Ln6Ni7oAZ7E6CX1CcJAD8A5qBdhSm",
    "symbol": "wCRV",
    "name": "Curve DAO Token (Wormhole)",
    "decimals": 9,
    "logoURI":
        "https://raw.githubusercontent.com/solana-labs/token-list/main/assets/mainnet/ApmXkxXCASdxRf3Ln6Ni7oAZ7E6CX1CcJAD8A5qBdhSm/logo.png",
    "tags": ["wrapped", "wormhole"],
    "extensions": {
      "address": "0xD533a949740bb3306d119CC777fa900bA034cd52",
      "bridgeContract": "https://etherscan.io/address/0xf92cD566Ea4864356C5491c177A430C222d7e678",
      "assetContract": "https://etherscan.io/address/0xD533a949740bb3306d119CC777fa900bA034cd52",
      "coingeckoId": "curve-dao-token"
    }
  },
  {
    "chainId": 101,
    "address": "DWECGzR56MruYJyo5g5QpoxZbFoydt3oWUkkDsVhxXzs",
    "symbol": "wMEME",
    "name": "MEME (Wormhole)",
    "decimals": 8,
    "logoURI":
        "https://raw.githubusercontent.com/solana-labs/token-list/main/assets/mainnet/DWECGzR56MruYJyo5g5QpoxZbFoydt3oWUkkDsVhxXzs/logo.png",
    "tags": ["wrapped", "wormhole"],
    "extensions": {
      "address": "0xD5525D397898e5502075Ea5E830d8914f6F0affe",
      "bridgeContract": "https://etherscan.io/address/0xf92cD566Ea4864356C5491c177A430C222d7e678",
      "assetContract": "https://etherscan.io/address/0xD5525D397898e5502075Ea5E830d8914f6F0affe",
      "coingeckoId": "degenerator"
    }
  },
  {
    "chainId": 101,
    "address": "3Y2wTtM4kCX8uUSLrKJ8wpajCu1C9LaWWAd7b7Nb2BDw",
    "symbol": "wEXNT",
    "name": "ExNetwork Community Token (Wormhole)",
    "decimals": 9,
    "logoURI":
        "https://raw.githubusercontent.com/solana-labs/token-list/main/assets/mainnet/3Y2wTtM4kCX8uUSLrKJ8wpajCu1C9LaWWAd7b7Nb2BDw/logo.png",
    "tags": ["wrapped", "wormhole"],
    "extensions": {
      "address": "0xD6c67B93a7b248dF608a653d82a100556144c5DA",
      "bridgeContract": "https://etherscan.io/address/0xf92cD566Ea4864356C5491c177A430C222d7e678",
      "assetContract": "https://etherscan.io/address/0xD6c67B93a7b248dF608a653d82a100556144c5DA",
      "coingeckoId": "exnetwork-token"
    }
  },
  {
    "chainId": 101,
    "address": "9w97GdWUYYaamGwdKMKZgGzPduZJkiFizq4rz5CPXRv2",
    "symbol": "wUSDT",
    "name": "Tether USD (Wormhole)",
    "decimals": 6,
    "logoURI":
        "https://raw.githubusercontent.com/solana-labs/token-list/main/assets/mainnet/9w97GdWUYYaamGwdKMKZgGzPduZJkiFizq4rz5CPXRv2/logo.png",
    "tags": ["wrapped", "wormhole"],
    "extensions": {
      "address": "0xdAC17F958D2ee523a2206206994597C13D831ec7",
      "bridgeContract": "https://etherscan.io/address/0xf92cD566Ea4864356C5491c177A430C222d7e678",
      "assetContract": "https://etherscan.io/address/0xdAC17F958D2ee523a2206206994597C13D831ec7",
      "coingeckoId": "tether"
    }
  },
  {
    "chainId": 101,
    "address": "CqWSJtkMMY16q9QLnQxktM1byzVHGRr8b6LCPuZnEeiL",
    "symbol": "wYLD",
    "name": "Yield (Wormhole)",
    "decimals": 9,
    "logoURI":
        "https://raw.githubusercontent.com/solana-labs/token-list/main/assets/mainnet/CqWSJtkMMY16q9QLnQxktM1byzVHGRr8b6LCPuZnEeiL/logo.png",
    "tags": ["wrapped", "wormhole"],
    "extensions": {
      "address": "0xDcB01cc464238396E213a6fDd933E36796eAfF9f",
      "bridgeContract": "https://etherscan.io/address/0xf92cD566Ea4864356C5491c177A430C222d7e678",
      "assetContract": "https://etherscan.io/address/0xDcB01cc464238396E213a6fDd933E36796eAfF9f",
      "coingeckoId": "yield"
    }
  },
  {
    "chainId": 101,
    "address": "26ZzQVGZruwcZPs2sqb8n9ojKt2cviUjHcMjstFtK6ow",
    "symbol": "wKNC",
    "name": "Kyber Network Crystal (Wormhole)",
    "decimals": 9,
    "logoURI":
        "https://raw.githubusercontent.com/solana-labs/token-list/main/assets/mainnet/26ZzQVGZruwcZPs2sqb8n9ojKt2cviUjHcMjstFtK6ow/logo.png",
    "tags": ["wrapped", "wormhole"],
    "extensions": {
      "address": "0xdd974D5C2e2928deA5F71b9825b8b646686BD200",
      "bridgeContract": "https://etherscan.io/address/0xf92cD566Ea4864356C5491c177A430C222d7e678",
      "assetContract": "https://etherscan.io/address/0xdd974D5C2e2928deA5F71b9825b8b646686BD200",
      "coingeckoId": "kyber-network"
    }
  },
  {
    "chainId": 101,
    "address": "HHoHTtntq2kiBPENyVM1DTP7pNrkBXX2Jye29PSyz3qf",
    "symbol": "wCOTI",
    "name": "COTI Token (Wormhole)",
    "decimals": 9,
    "logoURI":
        "https://raw.githubusercontent.com/solana-labs/token-list/main/assets/mainnet/HHoHTtntq2kiBPENyVM1DTP7pNrkBXX2Jye29PSyz3qf/logo.png",
    "tags": ["wrapped", "wormhole"],
    "extensions": {
      "address": "0xDDB3422497E61e13543BeA06989C0789117555c5",
      "bridgeContract": "https://etherscan.io/address/0xf92cD566Ea4864356C5491c177A430C222d7e678",
      "assetContract": "https://etherscan.io/address/0xDDB3422497E61e13543BeA06989C0789117555c5",
      "coingeckoId": "coti"
    }
  },
  {
    "chainId": 101,
    "address": "4sEpUsJ6uJZYi6A2da8EGjKPacRSqYJaPJffPnTqoWVv",
    "symbol": "wINJ",
    "name": "Injective Token (Wormhole)",
    "decimals": 9,
    "logoURI":
        "https://raw.githubusercontent.com/solana-labs/token-list/main/assets/mainnet/4sEpUsJ6uJZYi6A2da8EGjKPacRSqYJaPJffPnTqoWVv/logo.png",
    "tags": ["wrapped", "wormhole"],
    "extensions": {
      "address": "0xe28b3B32B6c345A34Ff64674606124Dd5Aceca30",
      "bridgeContract": "https://etherscan.io/address/0xf92cD566Ea4864356C5491c177A430C222d7e678",
      "assetContract": "https://etherscan.io/address/0xe28b3B32B6c345A34Ff64674606124Dd5Aceca30",
      "coingeckoId": "injective-protocol"
    }
  },
  {
    "chainId": 101,
    "address": "G2jrxYSoCSzmohxERa2JzSJMuRM4kiNvRA3DnCv7Lzcz",
    "symbol": "wZRX",
    "name": "0x Protocol Token (Wormhole)",
    "decimals": 9,
    "logoURI":
        "https://raw.githubusercontent.com/solana-labs/token-list/main/assets/mainnet/G2jrxYSoCSzmohxERa2JzSJMuRM4kiNvRA3DnCv7Lzcz/logo.png",
    "tags": ["wrapped", "wormhole"],
    "extensions": {
      "address": "0xE41d2489571d322189246DaFA5ebDe1F4699F498",
      "bridgeContract": "https://etherscan.io/address/0xf92cD566Ea4864356C5491c177A430C222d7e678",
      "assetContract": "https://etherscan.io/address/0xE41d2489571d322189246DaFA5ebDe1F4699F498",
      "coingeckoId": "0x"
    }
  },
  {
    "chainId": 101,
    "address": "3bkBFHyof411hGBdcsiM1KSDdErw63Xoj3eLB8yNknB4",
    "symbol": "wSUPER",
    "name": "SuperFarm (Wormhole)",
    "decimals": 9,
    "logoURI":
        "https://raw.githubusercontent.com/solana-labs/token-list/main/assets/mainnet/3bkBFHyof411hGBdcsiM1KSDdErw63Xoj3eLB8yNknB4/logo.png",
    "tags": ["wrapped", "wormhole"],
    "extensions": {
      "address": "0xe53EC727dbDEB9E2d5456c3be40cFF031AB40A55",
      "bridgeContract": "https://etherscan.io/address/0xf92cD566Ea4864356C5491c177A430C222d7e678",
      "assetContract": "https://etherscan.io/address/0xe53EC727dbDEB9E2d5456c3be40cFF031AB40A55",
      "coingeckoId": "superfarm"
    }
  },
  {
    "chainId": 101,
    "address": "7kkkoa1MB93ELm3vjvyC8GJ65G7eEgLhfaHU58riJUCx",
    "symbol": "waEth",
    "name": "aEthereum (Wormhole)",
    "decimals": 9,
    "logoURI":
        "https://raw.githubusercontent.com/solana-labs/token-list/main/assets/mainnet/7kkkoa1MB93ELm3vjvyC8GJ65G7eEgLhfaHU58riJUCx/logo.png",
    "tags": ["wrapped", "wormhole"],
    "extensions": {
      "address": "0xE95A203B1a91a908F9B9CE46459d101078c2c3cb",
      "bridgeContract": "https://etherscan.io/address/0xf92cD566Ea4864356C5491c177A430C222d7e678",
      "assetContract": "https://etherscan.io/address/0xE95A203B1a91a908F9B9CE46459d101078c2c3cb",
      "coingeckoId": "ankreth"
    }
  },
  {
    "chainId": 101,
    "address": "F48zUwoQMzgCTf5wihwz8GPN23gdcoVMiT227APqA6hC",
    "symbol": "wSURF",
    "name": "SURF.Finance (Wormhole)",
    "decimals": 9,
    "logoURI":
        "https://raw.githubusercontent.com/solana-labs/token-list/main/assets/mainnet/F48zUwoQMzgCTf5wihwz8GPN23gdcoVMiT227APqA6hC/logo.png",
    "tags": ["wrapped", "wormhole"],
    "extensions": {
      "address": "0xEa319e87Cf06203DAe107Dd8E5672175e3Ee976c",
      "bridgeContract": "https://etherscan.io/address/0xf92cD566Ea4864356C5491c177A430C222d7e678",
      "assetContract": "https://etherscan.io/address/0xEa319e87Cf06203DAe107Dd8E5672175e3Ee976c",
      "coingeckoId": "surf-finance"
    }
  },
  {
    "chainId": 101,
    "address": "EK6iyvvqvQtsWYcySrZVHkXjCLX494r9PhnDWJaX1CPu",
    "symbol": "wrenBTC",
    "name": "renBTC (Wormhole)",
    "decimals": 8,
    "logoURI":
        "https://raw.githubusercontent.com/solana-labs/token-list/main/assets/mainnet/EK6iyvvqvQtsWYcySrZVHkXjCLX494r9PhnDWJaX1CPu/logo.png",
    "tags": ["wrapped", "wormhole"],
    "extensions": {
      "address": "0xEB4C2781e4ebA804CE9a9803C67d0893436bB27D",
      "bridgeContract": "https://etherscan.io/address/0xf92cD566Ea4864356C5491c177A430C222d7e678",
      "assetContract": "https://etherscan.io/address/0xEB4C2781e4ebA804CE9a9803C67d0893436bB27D",
      "coingeckoId": "renbtc"
    }
  },
  {
    "chainId": 101,
    "address": "B2m4B527oLo5WFWLgy2MitP66azhEW2puaazUAuvNgqZ",
    "symbol": "wDMG",
    "name": "DMM: Governance (Wormhole)",
    "decimals": 9,
    "logoURI":
        "https://raw.githubusercontent.com/solana-labs/token-list/main/assets/mainnet/B2m4B527oLo5WFWLgy2MitP66azhEW2puaazUAuvNgqZ/logo.png",
    "tags": ["wrapped", "wormhole"],
    "extensions": {
      "address": "0xEd91879919B71bB6905f23af0A68d231EcF87b14",
      "bridgeContract": "https://etherscan.io/address/0xf92cD566Ea4864356C5491c177A430C222d7e678",
      "assetContract": "https://etherscan.io/address/0xEd91879919B71bB6905f23af0A68d231EcF87b14",
      "coingeckoId": "dmm-governance"
    }
  },
  {
    "chainId": 101,
    "address": "H3iuZNRwaqPsnGUGU5YkDwTU3hQMkzC32hxDko8EtzZw",
    "symbol": "wHEZ",
    "name": "Hermez Network Token (Wormhole)",
    "decimals": 9,
    "logoURI":
        "https://raw.githubusercontent.com/solana-labs/token-list/main/assets/mainnet/H3iuZNRwaqPsnGUGU5YkDwTU3hQMkzC32hxDko8EtzZw/logo.png",
    "tags": ["wrapped", "wormhole"],
    "extensions": {
      "address": "0xEEF9f339514298C6A857EfCfC1A762aF84438dEE",
      "bridgeContract": "https://etherscan.io/address/0xf92cD566Ea4864356C5491c177A430C222d7e678",
      "assetContract": "https://etherscan.io/address/0xEEF9f339514298C6A857EfCfC1A762aF84438dEE",
      "coingeckoId": "hermez-network-token"
    }
  },
  {
    "chainId": 101,
    "address": "DL7873Hud4eMdGScQFD7vrbC6fzWAMQ2LMuoZSn4zUry",
    "symbol": "wRLY",
    "name": "Rally (Wormhole)",
    "decimals": 9,
    "logoURI":
        "https://raw.githubusercontent.com/solana-labs/token-list/main/assets/mainnet/DL7873Hud4eMdGScQFD7vrbC6fzWAMQ2LMuoZSn4zUry/logo.png",
    "tags": ["wrapped", "wormhole"],
    "extensions": {
      "address": "0xf1f955016EcbCd7321c7266BccFB96c68ea5E49b",
      "bridgeContract": "https://etherscan.io/address/0xf92cD566Ea4864356C5491c177A430C222d7e678",
      "assetContract": "https://etherscan.io/address/0xf1f955016EcbCd7321c7266BccFB96c68ea5E49b",
      "coingeckoId": "rally-2"
    }
  },
  {
    "chainId": 101,
    "address": "3N89w9KPUVYUK5MMGNY8yMXhrr89QQ1RQPJxVnQHgMdd",
    "symbol": "wYf-DAI",
    "name": "YfDAI.finance (Wormhole)",
    "decimals": 9,
    "logoURI":
        "https://raw.githubusercontent.com/solana-labs/token-list/main/assets/mainnet/3N89w9KPUVYUK5MMGNY8yMXhrr89QQ1RQPJxVnQHgMdd/logo.png",
    "tags": ["wrapped", "wormhole"],
    "extensions": {
      "address": "0xf4CD3d3Fda8d7Fd6C5a500203e38640A70Bf9577",
      "bridgeContract": "https://etherscan.io/address/0xf92cD566Ea4864356C5491c177A430C222d7e678",
      "assetContract": "https://etherscan.io/address/0xf4CD3d3Fda8d7Fd6C5a500203e38640A70Bf9577",
      "coingeckoId": "yfdai-finance"
    }
  },
  {
    "chainId": 101,
    "address": "8ArKbnnDiq8eRR8hZ1eULMjd2iMAD8AqwyVJRAX7mHQo",
    "symbol": "wFCL",
    "name": "Fractal Protocol Token (Wormhole)",
    "decimals": 9,
    "logoURI":
        "https://raw.githubusercontent.com/solana-labs/token-list/main/assets/mainnet/8ArKbnnDiq8eRR8hZ1eULMjd2iMAD8AqwyVJRAX7mHQo/logo.png",
    "tags": ["wrapped", "wormhole"],
    "extensions": {
      "address": "0xF4d861575ecC9493420A3f5a14F85B13f0b50EB3",
      "bridgeContract": "https://etherscan.io/address/0xf92cD566Ea4864356C5491c177A430C222d7e678",
      "assetContract": "https://etherscan.io/address/0xF4d861575ecC9493420A3f5a14F85B13f0b50EB3",
      "coingeckoId": "fractal"
    }
  },
  {
    "chainId": 101,
    "address": "ZWGxcTgJCNGQqZn6vFdknwj4AFFsYRZ4SDJuhRn3J1T",
    "symbol": "wAXS",
    "name": "Axie Infinity (Wormhole)",
    "decimals": 9,
    "logoURI":
        "https://raw.githubusercontent.com/solana-labs/token-list/main/assets/mainnet/ZWGxcTgJCNGQqZn6vFdknwj4AFFsYRZ4SDJuhRn3J1T/logo.png",
    "tags": ["wrapped", "wormhole"],
    "extensions": {
      "address": "0xF5D669627376EBd411E34b98F19C868c8ABA5ADA",
      "bridgeContract": "https://etherscan.io/address/0xf92cD566Ea4864356C5491c177A430C222d7e678",
      "assetContract": "https://etherscan.io/address/0xF5D669627376EBd411E34b98F19C868c8ABA5ADA",
      "coingeckoId": "axie-infinity"
    }
  },
  {
    "chainId": 101,
    "address": "PEjUEMHFRtfajio8YHKZdUruW1vTzGmz6F7NngjYuou",
    "symbol": "wENJ",
    "name": "Enjin Coin (Wormhole)",
    "decimals": 9,
    "logoURI":
        "https://raw.githubusercontent.com/solana-labs/token-list/main/assets/mainnet/PEjUEMHFRtfajio8YHKZdUruW1vTzGmz6F7NngjYuou/logo.png",
    "tags": ["wrapped", "wormhole"],
    "extensions": {
      "address": "0xF629cBd94d3791C9250152BD8dfBDF380E2a3B9c",
      "bridgeContract": "https://etherscan.io/address/0xf92cD566Ea4864356C5491c177A430C222d7e678",
      "assetContract": "https://etherscan.io/address/0xF629cBd94d3791C9250152BD8dfBDF380E2a3B9c",
      "coingeckoId": "enjincoin"
    }
  },
  {
    "chainId": 101,
    "address": "2cW5deMKeR97C7csq1aMMWUa5RNWkpQFz8tumxk4ZV8w",
    "symbol": "wYLD",
    "name": "Yield (Wormhole)",
    "decimals": 9,
    "logoURI":
        "https://raw.githubusercontent.com/solana-labs/token-list/main/assets/mainnet/2cW5deMKeR97C7csq1aMMWUa5RNWkpQFz8tumxk4ZV8w/logo.png",
    "tags": ["wrapped", "wormhole"],
    "extensions": {
      "address": "0xF94b5C5651c888d928439aB6514B93944eEE6F48",
      "bridgeContract": "https://etherscan.io/address/0xf92cD566Ea4864356C5491c177A430C222d7e678",
      "assetContract": "https://etherscan.io/address/0xF94b5C5651c888d928439aB6514B93944eEE6F48",
      "coingeckoId": "yield-app"
    }
  },
  {
    "chainId": 101,
    "address": "FR5qPX4gbKHPyKMK7Cey6dHZ7wtqmqRogYPJo6bpd5Uw",
    "symbol": "wDDIM",
    "name": "DuckDaoDime (Wormhole)",
    "decimals": 9,
    "logoURI":
        "https://raw.githubusercontent.com/solana-labs/token-list/main/assets/mainnet/FR5qPX4gbKHPyKMK7Cey6dHZ7wtqmqRogYPJo6bpd5Uw/logo.png",
    "tags": ["wrapped", "wormhole"],
    "extensions": {
      "address": "0xFbEEa1C75E4c4465CB2FCCc9c6d6afe984558E20",
      "bridgeContract": "https://etherscan.io/address/0xf92cD566Ea4864356C5491c177A430C222d7e678",
      "assetContract": "https://etherscan.io/address/0xFbEEa1C75E4c4465CB2FCCc9c6d6afe984558E20",
      "coingeckoId": "duckdaodime"
    }
  },
  {
    "chainId": 101,
    "address": "8HCWFQA2GsA6Nm2L5jidM3mus7NeeQ8wp1ri3XFF9WWH",
    "symbol": "wRARI",
    "name": "Rarible (Wormhole)",
    "decimals": 9,
    "logoURI":
        "https://raw.githubusercontent.com/solana-labs/token-list/main/assets/mainnet/8HCWFQA2GsA6Nm2L5jidM3mus7NeeQ8wp1ri3XFF9WWH/logo.png",
    "tags": ["wrapped", "wormhole"],
    "extensions": {
      "address": "0xFca59Cd816aB1eaD66534D82bc21E7515cE441CF",
      "bridgeContract": "https://etherscan.io/address/0xf92cD566Ea4864356C5491c177A430C222d7e678",
      "assetContract": "https://etherscan.io/address/0xFca59Cd816aB1eaD66534D82bc21E7515cE441CF",
      "coingeckoId": "rarible"
    }
  },
  {
    "chainId": 101,
    "address": "Egrv6hURf5o68xJ1AGYeRv8RNj2nXJVuSoA5wwiSALcN",
    "symbol": "wAMP",
    "name": "Amp (Wormhole)",
    "decimals": 9,
    "logoURI":
        "https://raw.githubusercontent.com/solana-labs/token-list/main/assets/mainnet/Egrv6hURf5o68xJ1AGYeRv8RNj2nXJVuSoA5wwiSALcN/logo.png",
    "tags": ["wrapped", "wormhole"],
    "extensions": {
      "address": "0xfF20817765cB7f73d4bde2e66e067E58D11095C2",
      "bridgeContract": "https://etherscan.io/address/0xf92cD566Ea4864356C5491c177A430C222d7e678",
      "assetContract": "https://etherscan.io/address/0xfF20817765cB7f73d4bde2e66e067E58D11095C2",
      "coingeckoId": "amp-token"
    }
  },
  {
    "chainId": 101,
    "address": "GXMaB6jm5cdoQgb65YpkEu61eDYtod3PuVwYYXdZZJ9r",
    "symbol": "wFSW",
    "name": "FalconSwap Token (Wormhole)",
    "decimals": 9,
    "logoURI":
        "https://raw.githubusercontent.com/solana-labs/token-list/main/assets/mainnet/GXMaB6jm5cdoQgb65YpkEu61eDYtod3PuVwYYXdZZJ9r/logo.png",
    "tags": ["wrapped", "wormhole"],
    "extensions": {
      "address": "0xfffffffFf15AbF397dA76f1dcc1A1604F45126DB",
      "bridgeContract": "https://etherscan.io/address/0xf92cD566Ea4864356C5491c177A430C222d7e678",
      "assetContract": "https://etherscan.io/address/0xfffffffFf15AbF397dA76f1dcc1A1604F45126DB",
      "coingeckoId": "fsw-token"
    }
  },
  {
    "chainId": 101,
    "address": "AJ1W9A9N9dEMdVyoDiam2rV44gnBm2csrPDP7xqcapgX",
    "symbol": "wBUSD",
    "name": "Binance USD (Wormhole)",
    "decimals": 9,
    "logoURI":
        "https://raw.githubusercontent.com/solana-labs/token-list/main/assets/mainnet/AJ1W9A9N9dEMdVyoDiam2rV44gnBm2csrPDP7xqcapgX/logo.png",
    "tags": ["wrapped", "wormhole"],
    "extensions": {
      "address": "0x4Fabb145d64652a948d72533023f6E7A623C7C53",
      "bridgeContract": "https://etherscan.io/address/0xf92cD566Ea4864356C5491c177A430C222d7e678",
      "assetContract": "https://etherscan.io/address/0x4Fabb145d64652a948d72533023f6E7A623C7C53",
      "coingeckoId": "binance-usd"
    }
  },
  {
    "chainId": 101,
    "address": "2VmKuXMwdzouMndWcK7BK2951tBEtYVmGsdU4dXbjyaY",
    "symbol": "waDAI",
    "name": "Aave Interest bearing DAI (Wormhole)",
    "decimals": 9,
    "logoURI":
        "https://raw.githubusercontent.com/solana-labs/token-list/main/assets/mainnet/2VmKuXMwdzouMndWcK7BK2951tBEtYVmGsdU4dXbjyaY/logo.svg",
    "tags": ["wrapped", "wormhole"],
    "extensions": {
      "address": "0xfC1E690f61EFd961294b3e1Ce3313fBD8aa4f85d",
      "bridgeContract": "https://etherscan.io/address/0xf92cD566Ea4864356C5491c177A430C222d7e678",
      "assetContract": "https://etherscan.io/address/0xfC1E690f61EFd961294b3e1Ce3313fBD8aa4f85d",
      "coingeckoId": "aave-dai-v1"
    }
  },
  {
    "chainId": 101,
    "address": "AXvWVviBmySSdghmuomYHqYB3AZn7NmAWrHYHKKPJxoL",
    "symbol": "waTUSD",
    "name": "Aave Interest bearing TUSD (Wormhole)",
    "decimals": 9,
    "logoURI":
        "https://raw.githubusercontent.com/solana-labs/token-list/main/assets/mainnet/AXvWVviBmySSdghmuomYHqYB3AZn7NmAWrHYHKKPJxoL/logo.svg",
    "tags": ["wrapped", "wormhole"],
    "extensions": {
      "address": "0x4DA9b813057D04BAef4e5800E36083717b4a0341",
      "bridgeContract": "https://etherscan.io/address/0xf92cD566Ea4864356C5491c177A430C222d7e678",
      "assetContract": "https://etherscan.io/address/0x4DA9b813057D04BAef4e5800E36083717b4a0341",
      "coingeckoId": "aave-tusd-v1"
    }
  },
  {
    "chainId": 101,
    "address": "AkaisFPmasQYZUJsZLD9wPEo2KA7aCRqyRawX18ZRzGr",
    "symbol": "waUSDC",
    "name": "Aave Interest bearing USDC (Wormhole)",
    "decimals": 6,
    "logoURI":
        "https://raw.githubusercontent.com/solana-labs/token-list/main/assets/mainnet/AkaisFPmasQYZUJsZLD9wPEo2KA7aCRqyRawX18ZRzGr/logo.svg",
    "tags": ["wrapped", "wormhole"],
    "extensions": {
      "address": "0x9bA00D6856a4eDF4665BcA2C2309936572473B7E",
      "bridgeContract": "https://etherscan.io/address/0xf92cD566Ea4864356C5491c177A430C222d7e678",
      "assetContract": "https://etherscan.io/address/0x9bA00D6856a4eDF4665BcA2C2309936572473B7E",
      "coingeckoId": "aave-usdc-v1"
    }
  },
  {
    "chainId": 101,
    "address": "FZfQtWMoTQ51Z4jxvHfmFcqj4862u9GzmugBnZUuWqR5",
    "symbol": "waUSDT",
    "name": "Aave Interest bearing USDT (Wormhole)",
    "decimals": 6,
    "logoURI":
        "https://raw.githubusercontent.com/solana-labs/token-list/main/assets/mainnet/FZfQtWMoTQ51Z4jxvHfmFcqj4862u9GzmugBnZUuWqR5/logo.svg",
    "tags": ["wrapped", "wormhole"],
    "extensions": {
      "address": "0x71fc860F7D3A592A4a98740e39dB31d25db65ae8",
      "bridgeContract": "https://etherscan.io/address/0xf92cD566Ea4864356C5491c177A430C222d7e678",
      "assetContract": "https://etherscan.io/address/0x71fc860F7D3A592A4a98740e39dB31d25db65ae8",
      "coingeckoId": "aave-usdt-v1"
    }
  },
  {
    "chainId": 101,
    "address": "BMrbF8DZ9U5KGdJ4F2MJbH5d6KPi5FQVp7EqmLrhDe1f",
    "symbol": "waSUSD",
    "name": "Aave Interest bearing SUSD (Wormhole)",
    "decimals": 9,
    "logoURI":
        "https://raw.githubusercontent.com/solana-labs/token-list/main/assets/mainnet/BMrbF8DZ9U5KGdJ4F2MJbH5d6KPi5FQVp7EqmLrhDe1f/logo.svg",
    "tags": ["wrapped", "wormhole"],
    "extensions": {
      "address": "0x625aE63000f46200499120B906716420bd059240",
      "bridgeContract": "https://etherscan.io/address/0xf92cD566Ea4864356C5491c177A430C222d7e678",
      "assetContract": "https://etherscan.io/address/0x625aE63000f46200499120B906716420bd059240",
      "coingeckoId": "aave-susd-v1"
    }
  },
  {
    "chainId": 101,
    "address": "Fzx4N1xJPDZENAhrAaH79k2izT9CFbfnDEcpcWjiusdY",
    "symbol": "waLEND",
    "name": "Aave Interest bearing LEND (Wormhole)",
    "decimals": 9,
    "logoURI":
        "https://raw.githubusercontent.com/solana-labs/token-list/main/assets/mainnet/Fzx4N1xJPDZENAhrAaH79k2izT9CFbfnDEcpcWjiusdY/logo.svg",
    "tags": ["wrapped", "wormhole"],
    "extensions": {
      "address": "0x7D2D3688Df45Ce7C552E19c27e007673da9204B8",
      "bridgeContract": "https://etherscan.io/address/0xf92cD566Ea4864356C5491c177A430C222d7e678",
      "assetContract": "https://etherscan.io/address/0x7D2D3688Df45Ce7C552E19c27e007673da9204B8"
    }
  },
  {
    "chainId": 101,
    "address": "GCdDiVgZnkWCAnGktUsjhoho2CHab9JfrRy3Q5W51zvC",
    "symbol": "waBAT",
    "name": "Aave Interest bearing BAT (Wormhole)",
    "decimals": 9,
    "logoURI":
        "https://raw.githubusercontent.com/solana-labs/token-list/main/assets/mainnet/GCdDiVgZnkWCAnGktUsjhoho2CHab9JfrRy3Q5W51zvC/logo.svg",
    "tags": ["wrapped", "wormhole"],
    "extensions": {
      "address": "0xE1BA0FB44CCb0D11b80F92f4f8Ed94CA3fF51D00",
      "bridgeContract": "https://etherscan.io/address/0xf92cD566Ea4864356C5491c177A430C222d7e678",
      "assetContract": "https://etherscan.io/address/0xE1BA0FB44CCb0D11b80F92f4f8Ed94CA3fF51D00",
      "coingeckoId": "aave-bat-v1"
    }
  },
  {
    "chainId": 101,
    "address": "FBrfFh7fb7xKfyBMJA32KufMjEkgSgY4AuzLXFKdJFRj",
    "symbol": "waETH",
    "name": "Aave Interest bearing ETH (Wormhole)",
    "decimals": 9,
    "logoURI":
        "https://raw.githubusercontent.com/solana-labs/token-list/main/assets/mainnet/FBrfFh7fb7xKfyBMJA32KufMjEkgSgY4AuzLXFKdJFRj/logo.svg",
    "tags": ["wrapped", "wormhole"],
    "extensions": {
      "address": "0x3a3A65aAb0dd2A17E3F1947bA16138cd37d08c04",
      "bridgeContract": "https://etherscan.io/address/0xf92cD566Ea4864356C5491c177A430C222d7e678",
      "assetContract": "https://etherscan.io/address/0x3a3A65aAb0dd2A17E3F1947bA16138cd37d08c04",
      "coingeckoId": "aave-eth-v1"
    }
  },
  {
    "chainId": 101,
    "address": "Adp88WrQDgExPTu26DdBnbN2ffWMkXLxwqzjTdfRQiJi",
    "symbol": "waLINK",
    "name": "Aave Interest bearing LINK (Wormhole)",
    "decimals": 9,
    "logoURI":
        "https://raw.githubusercontent.com/solana-labs/token-list/main/assets/mainnet/Adp88WrQDgExPTu26DdBnbN2ffWMkXLxwqzjTdfRQiJi/logo.svg",
    "tags": ["wrapped", "wormhole"],
    "extensions": {
      "address": "0xA64BD6C70Cb9051F6A9ba1F163Fdc07E0DfB5F84",
      "bridgeContract": "https://etherscan.io/address/0xf92cD566Ea4864356C5491c177A430C222d7e678",
      "assetContract": "https://etherscan.io/address/0xA64BD6C70Cb9051F6A9ba1F163Fdc07E0DfB5F84",
      "coingeckoId": "aave-link-v1"
    }
  },
  {
    "chainId": 101,
    "address": "3p67dqghWn6reQcVCqNBkufrpU1gtA1ZRAYja6GMXySG",
    "symbol": "waKNC",
    "name": "Aave Interest bearing KNC (Wormhole)",
    "decimals": 9,
    "logoURI":
        "https://raw.githubusercontent.com/solana-labs/token-list/main/assets/mainnet/3p67dqghWn6reQcVCqNBkufrpU1gtA1ZRAYja6GMXySG/logo.svg",
    "tags": ["wrapped", "wormhole"],
    "extensions": {
      "address": "0x9D91BE44C06d373a8a226E1f3b146956083803eB",
      "bridgeContract": "https://etherscan.io/address/0xf92cD566Ea4864356C5491c177A430C222d7e678",
      "assetContract": "https://etherscan.io/address/0x9D91BE44C06d373a8a226E1f3b146956083803eB",
      "coingeckoId": "aave-knc-v1"
    }
  },
  {
    "chainId": 101,
    "address": "A4qYX1xuewaBL9SeZnwA3We6MhG8TYcTceHAJpk7Etdt",
    "symbol": "waREP",
    "name": "Aave Interest bearing REP (Wormhole)",
    "decimals": 9,
    "logoURI":
        "https://raw.githubusercontent.com/solana-labs/token-list/main/assets/mainnet/A4qYX1xuewaBL9SeZnwA3We6MhG8TYcTceHAJpk7Etdt/logo.svg",
    "tags": ["wrapped", "wormhole"],
    "extensions": {
      "address": "0x71010A9D003445aC60C4e6A7017c1E89A477B438",
      "bridgeContract": "https://etherscan.io/address/0xf92cD566Ea4864356C5491c177A430C222d7e678",
      "assetContract": "https://etherscan.io/address/0x71010A9D003445aC60C4e6A7017c1E89A477B438"
    }
  },
  {
    "chainId": 101,
    "address": "3iTtcKUVa5ouzwNZFc3SasuAKkY2ZuMxLERRcWfxQVN3",
    "symbol": "waMKR",
    "name": "Aave Interest bearing MKR (Wormhole)",
    "decimals": 9,
    "logoURI":
        "https://raw.githubusercontent.com/solana-labs/token-list/main/assets/mainnet/3iTtcKUVa5ouzwNZFc3SasuAKkY2ZuMxLERRcWfxQVN3/logo.svg",
    "tags": ["wrapped", "wormhole"],
    "extensions": {
      "address": "0x7deB5e830be29F91E298ba5FF1356BB7f8146998",
      "bridgeContract": "https://etherscan.io/address/0xf92cD566Ea4864356C5491c177A430C222d7e678",
      "assetContract": "https://etherscan.io/address/0x7deB5e830be29F91E298ba5FF1356BB7f8146998",
      "coingeckoId": "aave-mkr-v1"
    }
  },
  {
    "chainId": 101,
    "address": "EMS6TrCU8uBMumZukRSShGS1yzHGqYd3S8hW2sYULX3T",
    "symbol": "waMANA",
    "name": "Aave Interest bearing MANA (Wormhole)",
    "decimals": 9,
    "logoURI":
        "https://raw.githubusercontent.com/solana-labs/token-list/main/assets/mainnet/EMS6TrCU8uBMumZukRSShGS1yzHGqYd3S8hW2sYULX3T/logo.svg",
    "tags": ["wrapped", "wormhole"],
    "extensions": {
      "address": "0x6FCE4A401B6B80ACe52baAefE4421Bd188e76F6f",
      "bridgeContract": "https://etherscan.io/address/0xf92cD566Ea4864356C5491c177A430C222d7e678",
      "assetContract": "https://etherscan.io/address/0x6FCE4A401B6B80ACe52baAefE4421Bd188e76F6f",
      "coingeckoId": "aave-mana-v1"
    }
  },
  {
    "chainId": 101,
    "address": "qhqzfH7AjeukUgqyPXncWHFXTBebFNu5QQUrzhJaLB4",
    "symbol": "waZRX",
    "name": "Aave Interest bearing ZRX (Wormhole)",
    "decimals": 9,
    "logoURI":
        "https://raw.githubusercontent.com/solana-labs/token-list/main/assets/mainnet/qhqzfH7AjeukUgqyPXncWHFXTBebFNu5QQUrzhJaLB4/logo.svg",
    "tags": ["wrapped", "wormhole"],
    "extensions": {
      "address": "0x6Fb0855c404E09c47C3fBCA25f08d4E41f9F062f",
      "bridgeContract": "https://etherscan.io/address/0xf92cD566Ea4864356C5491c177A430C222d7e678",
      "assetContract": "https://etherscan.io/address/0x6Fb0855c404E09c47C3fBCA25f08d4E41f9F062f",
      "coingeckoId": "aave-zrx-v1"
    }
  },
  {
    "chainId": 101,
    "address": "FeU2J26AfMqh2mh7Cf4Lw1HRueAvAkZYxGr8njFNMeQ2",
    "symbol": "waSNX",
    "name": "Aave Interest bearing SNX (Wormhole)",
    "decimals": 9,
    "logoURI":
        "https://raw.githubusercontent.com/solana-labs/token-list/main/assets/mainnet/FeU2J26AfMqh2mh7Cf4Lw1HRueAvAkZYxGr8njFNMeQ2/logo.png",
    "tags": ["wrapped", "wormhole"],
    "extensions": {
      "address": "0x328C4c80BC7aCa0834Db37e6600A6c49E12Da4DE",
      "bridgeContract": "https://etherscan.io/address/0xf92cD566Ea4864356C5491c177A430C222d7e678",
      "assetContract": "https://etherscan.io/address/0x328C4c80BC7aCa0834Db37e6600A6c49E12Da4DE",
      "coingeckoId": "aave-snx-v1"
    }
  },
  {
    "chainId": 101,
    "address": "GveRVvWTUH1s26YxyjUnXh1J5mMdu5crC2K2uQy26KXi",
    "symbol": "waWBTC",
    "name": "Aave Interest bearing WBTC (Wormhole)",
    "decimals": 8,
    "logoURI":
        "https://raw.githubusercontent.com/solana-labs/token-list/main/assets/mainnet/GveRVvWTUH1s26YxyjUnXh1J5mMdu5crC2K2uQy26KXi/logo.svg",
    "tags": ["wrapped", "wormhole"],
    "extensions": {
      "address": "0xFC4B8ED459e00e5400be803A9BB3954234FD50e3",
      "bridgeContract": "https://etherscan.io/address/0xf92cD566Ea4864356C5491c177A430C222d7e678",
      "assetContract": "https://etherscan.io/address/0xFC4B8ED459e00e5400be803A9BB3954234FD50e3",
      "coingeckoId": "aave-wbtc-v1"
    }
  },
  {
    "chainId": 101,
    "address": "F2WgoHLwV4pfxN4WrUs2q6KkmFCsNorGYQ82oaPNUFLP",
    "symbol": "waBUSD",
    "name": "Aave Interest bearing Binance USD (Wormhole)",
    "decimals": 9,
    "logoURI":
        "https://raw.githubusercontent.com/solana-labs/token-list/main/assets/mainnet/F2WgoHLwV4pfxN4WrUs2q6KkmFCsNorGYQ82oaPNUFLP/logo.svg",
    "tags": ["wrapped", "wormhole"],
    "extensions": {
      "address": "0x6Ee0f7BB50a54AB5253dA0667B0Dc2ee526C30a8",
      "bridgeContract": "https://etherscan.io/address/0xf92cD566Ea4864356C5491c177A430C222d7e678",
      "assetContract": "https://etherscan.io/address/0x6Ee0f7BB50a54AB5253dA0667B0Dc2ee526C30a8",
      "coingeckoId": "aave-busd-v1"
    }
  },
  {
    "chainId": 101,
    "address": "3rNUQJgvfZ5eFsZvCkvdYcbd9ZzS6YmtwQsoUTFKmVd4",
    "symbol": "waENJ",
    "name": "Aave Interest bearing ENJ (Wormhole)",
    "decimals": 9,
    "logoURI":
        "https://raw.githubusercontent.com/solana-labs/token-list/main/assets/mainnet/3rNUQJgvfZ5eFsZvCkvdYcbd9ZzS6YmtwQsoUTFKmVd4/logo.svg",
    "tags": ["wrapped", "wormhole"],
    "extensions": {
      "address": "0x712DB54daA836B53Ef1EcBb9c6ba3b9Efb073F40",
      "bridgeContract": "https://etherscan.io/address/0xf92cD566Ea4864356C5491c177A430C222d7e678",
      "assetContract": "https://etherscan.io/address/0x712DB54daA836B53Ef1EcBb9c6ba3b9Efb073F40",
      "coingeckoId": "aave-enj-v1"
    }
  },
  {
    "chainId": 101,
    "address": "BHh8nyDwdUG4uyyQYNqGXGLHPyb83R6Y2fqJrNVKtTsT",
    "symbol": "waREN",
    "name": "Aave Interest bearing REN (Wormhole)",
    "decimals": 9,
    "logoURI":
        "https://raw.githubusercontent.com/solana-labs/token-list/main/assets/mainnet/BHh8nyDwdUG4uyyQYNqGXGLHPyb83R6Y2fqJrNVKtTsT/logo.png",
    "tags": ["wrapped", "wormhole"],
    "extensions": {
      "address": "0x69948cC03f478B95283F7dbf1CE764d0fc7EC54C",
      "bridgeContract": "https://etherscan.io/address/0xf92cD566Ea4864356C5491c177A430C222d7e678",
      "assetContract": "https://etherscan.io/address/0x69948cC03f478B95283F7dbf1CE764d0fc7EC54C",
      "coingeckoId": "aave-ren-v1"
    }
  },
  {
    "chainId": 101,
    "address": "EE58FVYG1UoY6Givy3K3GSRde9sHMj6X1BnocHBtd3sz",
    "symbol": "waYFI",
    "name": "Aave Interest bearing YFI (Wormhole)",
    "decimals": 9,
    "logoURI":
        "https://raw.githubusercontent.com/solana-labs/token-list/main/assets/mainnet/EE58FVYG1UoY6Givy3K3GSRde9sHMj6X1BnocHBtd3sz/logo.png",
    "tags": ["wrapped", "wormhole"],
    "extensions": {
      "address": "0x12e51E77DAAA58aA0E9247db7510Ea4B46F9bEAd",
      "bridgeContract": "https://etherscan.io/address/0xf92cD566Ea4864356C5491c177A430C222d7e678",
      "assetContract": "https://etherscan.io/address/0x12e51E77DAAA58aA0E9247db7510Ea4B46F9bEAd",
      "coingeckoId": "ayfi"
    }
  },
  {
    "chainId": 101,
    "address": "8aYsiHR6oVTAcFUzdXDhaPkgRbn4QYRCkdk3ATmAmY4p",
    "symbol": "waAAVE",
    "name": "Aave Interest bearing Aave Token (Wormhole)",
    "decimals": 9,
    "logoURI":
        "https://raw.githubusercontent.com/solana-labs/token-list/main/assets/mainnet/8aYsiHR6oVTAcFUzdXDhaPkgRbn4QYRCkdk3ATmAmY4p/logo.svg",
    "tags": ["wrapped", "wormhole"],
    "extensions": {
      "address": "0xba3D9687Cf50fE253cd2e1cFeEdE1d6787344Ed5",
      "bridgeContract": "https://etherscan.io/address/0xf92cD566Ea4864356C5491c177A430C222d7e678",
      "assetContract": "https://etherscan.io/address/0xba3D9687Cf50fE253cd2e1cFeEdE1d6787344Ed5"
    }
  },
  {
    "chainId": 101,
    "address": "8kwCLkWbv4qTJPcbSV65tWdQmjURjBGRSv6VtC1JTiL8",
    "symbol": "waUNI",
    "name": "Aave Interest bearing Uniswap (Wormhole)",
    "decimals": 9,
    "logoURI":
        "https://raw.githubusercontent.com/solana-labs/token-list/main/assets/mainnet/8kwCLkWbv4qTJPcbSV65tWdQmjURjBGRSv6VtC1JTiL8/logo.png",
    "tags": ["wrapped", "wormhole"],
    "extensions": {
      "address": "0xB124541127A0A657f056D9Dd06188c4F1b0e5aab",
      "bridgeContract": "https://etherscan.io/address/0xf92cD566Ea4864356C5491c177A430C222d7e678",
      "assetContract": "https://etherscan.io/address/0xB124541127A0A657f056D9Dd06188c4F1b0e5aab"
    }
  },
  {
    "chainId": 101,
    "address": "9NDu1wdjZ7GiY7foAXhia9h1wQU45oTUzyMZKJ31V7JA",
    "symbol": "wstkAAVE",
    "name": "Staked Aave (Wormhole)",
    "decimals": 9,
    "logoURI":
        "https://raw.githubusercontent.com/solana-labs/token-list/main/assets/mainnet/9NDu1wdjZ7GiY7foAXhia9h1wQU45oTUzyMZKJ31V7JA/logo.png",
    "tags": ["wrapped", "wormhole"],
    "extensions": {
      "address": "0x4da27a545c0c5B758a6BA100e3a049001de870f5",
      "bridgeContract": "https://etherscan.io/address/0xf92cD566Ea4864356C5491c177A430C222d7e678",
      "assetContract": "https://etherscan.io/address/0x4da27a545c0c5B758a6BA100e3a049001de870f5"
    }
  },
  {
    "chainId": 101,
    "address": "GNQ1Goajm3Za8uC1Eptt2yfsrbnkZh2eMJoqxg54sj3o",
    "symbol": "wUniDAIETH",
    "name": "Uniswap DAI LP (Wormhole)",
    "decimals": 9,
    "logoURI":
        "https://raw.githubusercontent.com/solana-labs/token-list/main/assets/mainnet/GNQ1Goajm3Za8uC1Eptt2yfsrbnkZh2eMJoqxg54sj3o/logo.png",
    "tags": ["wrapped", "wormhole"],
    "extensions": {
      "address": "0x2a1530C4C41db0B0b2bB646CB5Eb1A67b7158667",
      "bridgeContract": "https://etherscan.io/address/0xf92cD566Ea4864356C5491c177A430C222d7e678",
      "assetContract": "https://etherscan.io/address/0x2a1530C4C41db0B0b2bB646CB5Eb1A67b7158667"
    }
  },
  {
    "chainId": 101,
    "address": "7NFin546WNvWkhtfftfY77z8C1TrxLbUcKmw5TpHGGtC",
    "symbol": "wUniUSDCETH",
    "name": "Uniswap USDC LP (Wormhole)",
    "decimals": 9,
    "logoURI":
        "https://raw.githubusercontent.com/solana-labs/token-list/main/assets/mainnet/7NFin546WNvWkhtfftfY77z8C1TrxLbUcKmw5TpHGGtC/logo.png",
    "tags": ["wrapped", "wormhole"],
    "extensions": {
      "address": "0x97deC872013f6B5fB443861090ad931542878126",
      "bridgeContract": "https://etherscan.io/address/0xf92cD566Ea4864356C5491c177A430C222d7e678",
      "assetContract": "https://etherscan.io/address/0x97deC872013f6B5fB443861090ad931542878126"
    }
  },
  {
    "chainId": 101,
    "address": "7gersKTtU65ERNBNTZKjYgKf7HypR7PDMprcuhQJChaq",
    "symbol": "wUnisETHETH",
    "name": "Uniswap sETH LP (Wormhole)",
    "decimals": 9,
    "logoURI":
        "https://raw.githubusercontent.com/solana-labs/token-list/main/assets/mainnet/7gersKTtU65ERNBNTZKjYgKf7HypR7PDMprcuhQJChaq/logo.png",
    "tags": ["wrapped", "wormhole"],
    "extensions": {
      "address": "0xe9Cf7887b93150D4F2Da7dFc6D502B216438F244",
      "bridgeContract": "https://etherscan.io/address/0xf92cD566Ea4864356C5491c177A430C222d7e678",
      "assetContract": "https://etherscan.io/address/0xe9Cf7887b93150D4F2Da7dFc6D502B216438F244"
    }
  },
  {
    "chainId": 101,
    "address": "4aqNtSCr77eiEZJ9u9BhPErjEMju6FFdLeBKkE1pdxuK",
    "symbol": "wUniLENDETH",
    "name": "Uniswap LEND LP (Wormhole)",
    "decimals": 9,
    "logoURI":
        "https://raw.githubusercontent.com/solana-labs/token-list/main/assets/mainnet/4aqNtSCr77eiEZJ9u9BhPErjEMju6FFdLeBKkE1pdxuK/logo.png",
    "tags": ["wrapped", "wormhole"],
    "extensions": {
      "address": "0xcaA7e4656f6A2B59f5f99c745F91AB26D1210DCe",
      "bridgeContract": "https://etherscan.io/address/0xf92cD566Ea4864356C5491c177A430C222d7e678",
      "assetContract": "https://etherscan.io/address/0xcaA7e4656f6A2B59f5f99c745F91AB26D1210DCe"
    }
  },
  {
    "chainId": 101,
    "address": "FDdoYCHwFghBSbnN6suvFR3VFw6kAzfhfGpkAQAGPLC3",
    "symbol": "wUniMKRETH",
    "name": "Uniswap MKR LP (Wormhole)",
    "decimals": 9,
    "logoURI":
        "https://raw.githubusercontent.com/solana-labs/token-list/main/assets/mainnet/FDdoYCHwFghBSbnN6suvFR3VFw6kAzfhfGpkAQAGPLC3/logo.png",
    "tags": ["wrapped", "wormhole"],
    "extensions": {
      "address": "0x2C4Bd064b998838076fa341A83d007FC2FA50957",
      "bridgeContract": "https://etherscan.io/address/0xf92cD566Ea4864356C5491c177A430C222d7e678",
      "assetContract": "https://etherscan.io/address/0x2C4Bd064b998838076fa341A83d007FC2FA50957"
    }
  },
  {
    "chainId": 101,
    "address": "FSSTfbb1vh1TRe8Ja64hC65QTc7pPUhwHh5uTAWj5haH",
    "symbol": "wUniLINKETH",
    "name": "Uniswap LINK LP (Wormhole)",
    "decimals": 9,
    "logoURI":
        "https://raw.githubusercontent.com/solana-labs/token-list/main/assets/mainnet/FSSTfbb1vh1TRe8Ja64hC65QTc7pPUhwHh5uTAWj5haH/logo.png",
    "tags": ["wrapped", "wormhole"],
    "extensions": {
      "address": "0xF173214C720f58E03e194085B1DB28B50aCDeeaD",
      "bridgeContract": "https://etherscan.io/address/0xf92cD566Ea4864356C5491c177A430C222d7e678",
      "assetContract": "https://etherscan.io/address/0xF173214C720f58E03e194085B1DB28B50aCDeeaD"
    }
  },
  {
    "chainId": 101,
    "address": "Aci9xBGywrgBxQoFnL6LCoCYuX5k6AqaYhimgSZ1Fhrk",
    "symbol": "waUniETH",
    "name": "Aave Interest bearing UniETH (Wormhole)",
    "decimals": 9,
    "logoURI":
        "https://raw.githubusercontent.com/solana-labs/token-list/main/assets/mainnet/Aci9xBGywrgBxQoFnL6LCoCYuX5k6AqaYhimgSZ1Fhrk/logo.png",
    "tags": ["wrapped", "wormhole"],
    "extensions": {
      "address": "0x6179078872605396Ee62960917128F9477a5DdbB",
      "bridgeContract": "https://etherscan.io/address/0xf92cD566Ea4864356C5491c177A430C222d7e678",
      "assetContract": "https://etherscan.io/address/0x6179078872605396Ee62960917128F9477a5DdbB"
    }
  },
  {
    "chainId": 101,
    "address": "GqHK99sW4ym6zy6Kdoh8f7sb2c3qhtB3WRqeyPbAYfmy",
    "symbol": "waUniDAI",
    "name": "Aave Interest bearing UniDAI (Wormhole)",
    "decimals": 9,
    "logoURI":
        "https://raw.githubusercontent.com/solana-labs/token-list/main/assets/mainnet/GqHK99sW4ym6zy6Kdoh8f7sb2c3qhtB3WRqeyPbAYfmy/logo.png",
    "tags": ["wrapped", "wormhole"],
    "extensions": {
      "address": "0x048930eec73c91B44b0844aEACdEBADC2F2b6efb",
      "bridgeContract": "https://etherscan.io/address/0xf92cD566Ea4864356C5491c177A430C222d7e678",
      "assetContract": "https://etherscan.io/address/0x048930eec73c91B44b0844aEACdEBADC2F2b6efb"
    }
  },
  {
    "chainId": 101,
    "address": "4e4TpGVJMYiz5UBrAXuNmiVJ9yvc7ppJeAn8sXmbnmDi",
    "symbol": "waUniUSDC",
    "name": "Aave Interest bearing UniUSDC (Wormhole)",
    "decimals": 6,
    "logoURI":
        "https://raw.githubusercontent.com/solana-labs/token-list/main/assets/mainnet/4e4TpGVJMYiz5UBrAXuNmiVJ9yvc7ppJeAn8sXmbnmDi/logo.png",
    "tags": ["wrapped", "wormhole"],
    "extensions": {
      "address": "0xe02b2Ad63eFF3Ac1D5827cBd7AB9DD3DaC4f4AD0",
      "bridgeContract": "https://etherscan.io/address/0xf92cD566Ea4864356C5491c177A430C222d7e678",
      "assetContract": "https://etherscan.io/address/0xe02b2Ad63eFF3Ac1D5827cBd7AB9DD3DaC4f4AD0"
    }
  },
  {
    "chainId": 101,
    "address": "49LoAnQQdo9171zfcWRUoQLYSScrxXobbuwt14xjvfVm",
    "symbol": "waUniUSDT",
    "name": "Aave Interest bearing UniUSDT (Wormhole)",
    "decimals": 6,
    "logoURI":
        "https://raw.githubusercontent.com/solana-labs/token-list/main/assets/mainnet/49LoAnQQdo9171zfcWRUoQLYSScrxXobbuwt14xjvfVm/logo.png",
    "tags": ["wrapped", "wormhole"],
    "extensions": {
      "address": "0xb977ee318010A5252774171494a1bCB98E7fab65",
      "bridgeContract": "https://etherscan.io/address/0xf92cD566Ea4864356C5491c177A430C222d7e678",
      "assetContract": "https://etherscan.io/address/0xb977ee318010A5252774171494a1bCB98E7fab65"
    }
  },
  {
    "chainId": 101,
    "address": "CvG3gtKYJtKRzEUgMeb42xnd8HDjESgLtyJqQ2kuLncp",
    "symbol": "waUniDAIETH",
    "name": "Aave Interest bearing UniDAIETH (Wormhole)",
    "decimals": 9,
    "logoURI":
        "https://raw.githubusercontent.com/solana-labs/token-list/main/assets/mainnet/CvG3gtKYJtKRzEUgMeb42xnd8HDjESgLtyJqQ2kuLncp/logo.svg",
    "tags": ["wrapped", "wormhole"],
    "extensions": {
      "address": "0xBbBb7F2aC04484F7F04A2C2C16f20479791BbB44",
      "bridgeContract": "https://etherscan.io/address/0xf92cD566Ea4864356C5491c177A430C222d7e678",
      "assetContract": "https://etherscan.io/address/0xBbBb7F2aC04484F7F04A2C2C16f20479791BbB44"
    }
  },
  {
    "chainId": 101,
    "address": "GSv5ECZaMfaceZK4WKKzA4tKVDkqtfBASECcmYFWcy4G",
    "symbol": "waUniUSDCETH",
    "name": "Aave Interest bearing UniUSDCETH (Wormhole)",
    "decimals": 9,
    "logoURI":
        "https://raw.githubusercontent.com/solana-labs/token-list/main/assets/mainnet/GSv5ECZaMfaceZK4WKKzA4tKVDkqtfBASECcmYFWcy4G/logo.svg",
    "tags": ["wrapped", "wormhole"],
    "extensions": {
      "address": "0x1D0e53A0e524E3CC92C1f0f33Ae268FfF8D7E7a5",
      "bridgeContract": "https://etherscan.io/address/0xf92cD566Ea4864356C5491c177A430C222d7e678",
      "assetContract": "https://etherscan.io/address/0x1D0e53A0e524E3CC92C1f0f33Ae268FfF8D7E7a5"
    }
  },
  {
    "chainId": 101,
    "address": "7LUdsedi7qpTJGnFpZo6mWqVtKKpccr9XrQGxJ2xUDPT",
    "symbol": "waUniSETHETH",
    "name": "Aave Interest bearing UniSETHETH (Wormhole)",
    "decimals": 9,
    "logoURI":
        "https://raw.githubusercontent.com/solana-labs/token-list/main/assets/mainnet/7LUdsedi7qpTJGnFpZo6mWqVtKKpccr9XrQGxJ2xUDPT/logo.svg",
    "tags": ["wrapped", "wormhole"],
    "extensions": {
      "address": "0x84BBcaB430717ff832c3904fa6515f97fc63C76F",
      "bridgeContract": "https://etherscan.io/address/0xf92cD566Ea4864356C5491c177A430C222d7e678",
      "assetContract": "https://etherscan.io/address/0x84BBcaB430717ff832c3904fa6515f97fc63C76F"
    }
  },
  {
    "chainId": 101,
    "address": "Hc1zHQxg1k2JVwvuv3kqbCyZDEJYfDdNftBMab4EMUx9",
    "symbol": "waUniLENDETH",
    "name": "Aave Interest bearing UniLENDETH (Wormhole)",
    "decimals": 9,
    "logoURI":
        "https://raw.githubusercontent.com/solana-labs/token-list/main/assets/mainnet/Hc1zHQxg1k2JVwvuv3kqbCyZDEJYfDdNftBMab4EMUx9/logo.svg",
    "tags": ["wrapped", "wormhole"],
    "extensions": {
      "address": "0xc88ebbf7C523f38Ef3eB8A151273C0F0dA421e63",
      "bridgeContract": "https://etherscan.io/address/0xf92cD566Ea4864356C5491c177A430C222d7e678",
      "assetContract": "https://etherscan.io/address/0xc88ebbf7C523f38Ef3eB8A151273C0F0dA421e63"
    }
  },
  {
    "chainId": 101,
    "address": "9PejEmx6NKDHgf6jpgAWwZsibURKifBakjzDQdtCtAXT",
    "symbol": "waUniMKRETH",
    "name": "Aave Interest bearing UniMKRETH (Wormhole)",
    "decimals": 9,
    "logoURI":
        "https://raw.githubusercontent.com/solana-labs/token-list/main/assets/mainnet/9PejEmx6NKDHgf6jpgAWwZsibURKifBakjzDQdtCtAXT/logo.svg",
    "tags": ["wrapped", "wormhole"],
    "extensions": {
      "address": "0x8c69f7A4C9B38F1b48005D216c398Efb2F1Ce3e4",
      "bridgeContract": "https://etherscan.io/address/0xf92cD566Ea4864356C5491c177A430C222d7e678",
      "assetContract": "https://etherscan.io/address/0x8c69f7A4C9B38F1b48005D216c398Efb2F1Ce3e4"
    }
  },
  {
    "chainId": 101,
    "address": "KcHygDp4o7ENsHjevYM4T3u6R7KHa5VyvkJ7kpmJcYo",
    "symbol": "waUniLINKETH",
    "name": "Aave Interest bearing UniLINKETH (Wormhole)",
    "decimals": 9,
    "logoURI":
        "https://raw.githubusercontent.com/solana-labs/token-list/main/assets/mainnet/KcHygDp4o7ENsHjevYM4T3u6R7KHa5VyvkJ7kpmJcYo/logo.svg",
    "tags": ["wrapped", "wormhole"],
    "extensions": {
      "address": "0x9548DB8b1cA9b6c757485e7861918b640390169c",
      "bridgeContract": "https://etherscan.io/address/0xf92cD566Ea4864356C5491c177A430C222d7e678",
      "assetContract": "https://etherscan.io/address/0x9548DB8b1cA9b6c757485e7861918b640390169c"
    }
  },
  {
    "chainId": 101,
    "address": "GNPAF84ZEtKYyfuY2fg8tZVwse7LpTSeyYPSyEKFqa2Y",
    "symbol": "waUSDT",
    "name": "Aave interest bearing USDT (Wormhole)",
    "decimals": 6,
    "logoURI":
        "https://raw.githubusercontent.com/solana-labs/token-list/main/assets/mainnet/GNPAF84ZEtKYyfuY2fg8tZVwse7LpTSeyYPSyEKFqa2Y/logo.svg",
    "tags": ["wrapped", "wormhole"],
    "extensions": {
      "address": "0x3Ed3B47Dd13EC9a98b44e6204A523E766B225811",
      "bridgeContract": "https://etherscan.io/address/0xf92cD566Ea4864356C5491c177A430C222d7e678",
      "assetContract": "https://etherscan.io/address/0x3Ed3B47Dd13EC9a98b44e6204A523E766B225811",
      "coingeckoId": "aave-usdt"
    }
  },
  {
    "chainId": 101,
    "address": "3QTknQ3i27rDKm5hvBaScFLQ34xX9N7J7XfEFwy27qbZ",
    "symbol": "waWBTC",
    "name": "Aave interest bearing WBTC (Wormhole)",
    "decimals": 8,
    "logoURI":
        "https://raw.githubusercontent.com/solana-labs/token-list/main/assets/mainnet/3QTknQ3i27rDKm5hvBaScFLQ34xX9N7J7XfEFwy27qbZ/logo.svg",
    "tags": ["wrapped", "wormhole"],
    "extensions": {
      "address": "0x9ff58f4fFB29fA2266Ab25e75e2A8b3503311656",
      "bridgeContract": "https://etherscan.io/address/0xf92cD566Ea4864356C5491c177A430C222d7e678",
      "assetContract": "https://etherscan.io/address/0x9ff58f4fFB29fA2266Ab25e75e2A8b3503311656",
      "coingeckoId": "aave-wbtc"
    }
  },
  {
    "chainId": 101,
    "address": "EbpkofeWyiQouGyxQAgXxEyGtjgq13NSucX3CNvucNpb",
    "symbol": "waWETH",
    "name": "Aave interest bearing WETH (Wormhole)",
    "decimals": 9,
    "logoURI":
        "https://raw.githubusercontent.com/solana-labs/token-list/main/assets/mainnet/EbpkofeWyiQouGyxQAgXxEyGtjgq13NSucX3CNvucNpb/logo.png",
    "tags": ["wrapped", "wormhole"],
    "extensions": {
      "address": "0x030bA81f1c18d280636F32af80b9AAd02Cf0854e",
      "bridgeContract": "https://etherscan.io/address/0xf92cD566Ea4864356C5491c177A430C222d7e678",
      "assetContract": "https://etherscan.io/address/0x030bA81f1c18d280636F32af80b9AAd02Cf0854e"
    }
  },
  {
    "chainId": 101,
    "address": "67uaa3Z7SX7GC6dqSTjpJLnySLXZpCAK9MHMi3232Bfb",
    "symbol": "waYFI",
    "name": "Aave interest bearing YFI (Wormhole)",
    "decimals": 9,
    "logoURI":
        "https://raw.githubusercontent.com/solana-labs/token-list/main/assets/mainnet/67uaa3Z7SX7GC6dqSTjpJLnySLXZpCAK9MHMi3232Bfb/logo.svg",
    "tags": ["wrapped", "wormhole"],
    "extensions": {
      "address": "0x5165d24277cD063F5ac44Efd447B27025e888f37",
      "bridgeContract": "https://etherscan.io/address/0xf92cD566Ea4864356C5491c177A430C222d7e678",
      "assetContract": "https://etherscan.io/address/0x5165d24277cD063F5ac44Efd447B27025e888f37"
    }
  },
  {
    "chainId": 101,
    "address": "9xS6et5uvQ64QsmaGMfzfXrwTsfYPjwEWuiPnBGFgfw",
    "symbol": "waZRX",
    "name": "Aave interest bearing ZRX (Wormhole)",
    "decimals": 9,
    "logoURI":
        "https://raw.githubusercontent.com/solana-labs/token-list/main/assets/mainnet/9xS6et5uvQ64QsmaGMfzfXrwTsfYPjwEWuiPnBGFgfw/logo.svg",
    "tags": ["wrapped", "wormhole"],
    "extensions": {
      "address": "0xDf7FF54aAcAcbFf42dfe29DD6144A69b629f8C9e",
      "bridgeContract": "https://etherscan.io/address/0xf92cD566Ea4864356C5491c177A430C222d7e678",
      "assetContract": "https://etherscan.io/address/0xDf7FF54aAcAcbFf42dfe29DD6144A69b629f8C9e",
      "coingeckoId": "aave-zrx"
    }
  },
  {
    "chainId": 101,
    "address": "2TZ8s2FwtWqJrWpdFsSf2uM2Fvjw474n6HhTdTEWoLor",
    "symbol": "waUNI",
    "name": "Aave interest bearing UNI (Wormhole)",
    "decimals": 9,
    "logoURI":
        "https://raw.githubusercontent.com/solana-labs/token-list/main/assets/mainnet/2TZ8s2FwtWqJrWpdFsSf2uM2Fvjw474n6HhTdTEWoLor/logo.svg",
    "tags": ["wrapped", "wormhole"],
    "extensions": {
      "address": "0xB9D7CB55f463405CDfBe4E90a6D2Df01C2B92BF1",
      "bridgeContract": "https://etherscan.io/address/0xf92cD566Ea4864356C5491c177A430C222d7e678",
      "assetContract": "https://etherscan.io/address/0xB9D7CB55f463405CDfBe4E90a6D2Df01C2B92BF1"
    }
  },
  {
    "chainId": 101,
    "address": "G1o2fHZXyPCeAEcY4o6as7SmVaUu65DRhcq1S4Cfap9T",
    "symbol": "waAAVE",
    "name": "Aave interest bearing AAVE (Wormhole)",
    "decimals": 9,
    "logoURI":
        "https://raw.githubusercontent.com/solana-labs/token-list/main/assets/mainnet/G1o2fHZXyPCeAEcY4o6as7SmVaUu65DRhcq1S4Cfap9T/logo.svg",
    "tags": ["wrapped", "wormhole"],
    "extensions": {
      "address": "0xFFC97d72E13E01096502Cb8Eb52dEe56f74DAD7B",
      "bridgeContract": "https://etherscan.io/address/0xf92cD566Ea4864356C5491c177A430C222d7e678",
      "assetContract": "https://etherscan.io/address/0xFFC97d72E13E01096502Cb8Eb52dEe56f74DAD7B"
    }
  },
  {
    "chainId": 101,
    "address": "8PeWkyvCDHpSgT5oiGFgZQtXSRBij7ZFLJTHAGBntRDH",
    "symbol": "waBAT",
    "name": "Aave interest bearing BAT (Wormhole)",
    "decimals": 9,
    "logoURI":
        "https://raw.githubusercontent.com/solana-labs/token-list/main/assets/mainnet/8PeWkyvCDHpSgT5oiGFgZQtXSRBij7ZFLJTHAGBntRDH/logo.svg",
    "tags": ["wrapped", "wormhole"],
    "extensions": {
      "address": "0x05Ec93c0365baAeAbF7AefFb0972ea7ECdD39CF1",
      "bridgeContract": "https://etherscan.io/address/0xf92cD566Ea4864356C5491c177A430C222d7e678",
      "assetContract": "https://etherscan.io/address/0x05Ec93c0365baAeAbF7AefFb0972ea7ECdD39CF1",
      "coingeckoId": "aave-bat"
    }
  },
  {
    "chainId": 101,
    "address": "67opsuaXQ3JRSJ1mmF7aPLSq6JaZcwAmXwcMzUN5PSMv",
    "symbol": "waBUSD",
    "name": "Aave interest bearing BUSD (Wormhole)",
    "decimals": 9,
    "logoURI":
        "https://raw.githubusercontent.com/solana-labs/token-list/main/assets/mainnet/67opsuaXQ3JRSJ1mmF7aPLSq6JaZcwAmXwcMzUN5PSMv/logo.svg",
    "tags": ["wrapped", "wormhole"],
    "extensions": {
      "address": "0xA361718326c15715591c299427c62086F69923D9",
      "bridgeContract": "https://etherscan.io/address/0xf92cD566Ea4864356C5491c177A430C222d7e678",
      "assetContract": "https://etherscan.io/address/0xA361718326c15715591c299427c62086F69923D9",
      "coingeckoId": "aave-busd"
    }
  },
  {
    "chainId": 101,
    "address": "4JrrHRS56i9GZkSmGaCY3ZsxMo3JEqQviU64ki7ZJPak",
    "symbol": "waDAI",
    "name": "Aave interest bearing DAI (Wormhole)",
    "decimals": 9,
    "logoURI":
        "https://raw.githubusercontent.com/solana-labs/token-list/main/assets/mainnet/4JrrHRS56i9GZkSmGaCY3ZsxMo3JEqQviU64ki7ZJPak/logo.svg",
    "tags": ["wrapped", "wormhole"],
    "extensions": {
      "address": "0x028171bCA77440897B824Ca71D1c56caC55b68A3",
      "bridgeContract": "https://etherscan.io/address/0xf92cD566Ea4864356C5491c177A430C222d7e678",
      "assetContract": "https://etherscan.io/address/0x028171bCA77440897B824Ca71D1c56caC55b68A3",
      "coingeckoId": "aave-dai"
    }
  },
  {
    "chainId": 101,
    "address": "3LmfKjsSU9hdxfZfcr873DMNR5nnrk8EvdueXg1dTSin",
    "symbol": "waENJ",
    "name": "Aave interest bearing ENJ (Wormhole)",
    "decimals": 9,
    "logoURI":
        "https://raw.githubusercontent.com/solana-labs/token-list/main/assets/mainnet/3LmfKjsSU9hdxfZfcr873DMNR5nnrk8EvdueXg1dTSin/logo.svg",
    "tags": ["wrapped", "wormhole"],
    "extensions": {
      "address": "0xaC6Df26a590F08dcC95D5a4705ae8abbc88509Ef",
      "bridgeContract": "https://etherscan.io/address/0xf92cD566Ea4864356C5491c177A430C222d7e678",
      "assetContract": "https://etherscan.io/address/0xaC6Df26a590F08dcC95D5a4705ae8abbc88509Ef",
      "coingeckoId": "aave-enj"
    }
  },
  {
    "chainId": 101,
    "address": "7VD2Gosm34hB7kughTqu1N3sW92hq3XwKLTi1N1tdKrj",
    "symbol": "waKNC",
    "name": "Aave interest bearing KNC (Wormhole)",
    "decimals": 9,
    "logoURI":
        "https://raw.githubusercontent.com/solana-labs/token-list/main/assets/mainnet/7VD2Gosm34hB7kughTqu1N3sW92hq3XwKLTi1N1tdKrj/logo.svg",
    "tags": ["wrapped", "wormhole"],
    "extensions": {
      "address": "0x39C6b3e42d6A679d7D776778Fe880BC9487C2EDA",
      "bridgeContract": "https://etherscan.io/address/0xf92cD566Ea4864356C5491c177A430C222d7e678",
      "assetContract": "https://etherscan.io/address/0x39C6b3e42d6A679d7D776778Fe880BC9487C2EDA",
      "coingeckoId": "aave-knc"
    }
  },
  {
    "chainId": 101,
    "address": "4erbVWFvdvS5P8ews7kUjqfpCQbA8vurnWyvRLsnZJgv",
    "symbol": "waLINK",
    "name": "Aave interest bearing LINK (Wormhole)",
    "decimals": 9,
    "logoURI":
        "https://raw.githubusercontent.com/solana-labs/token-list/main/assets/mainnet/4erbVWFvdvS5P8ews7kUjqfpCQbA8vurnWyvRLsnZJgv/logo.svg",
    "tags": ["wrapped", "wormhole"],
    "extensions": {
      "address": "0xa06bC25B5805d5F8d82847D191Cb4Af5A3e873E0",
      "bridgeContract": "https://etherscan.io/address/0xf92cD566Ea4864356C5491c177A430C222d7e678",
      "assetContract": "https://etherscan.io/address/0xa06bC25B5805d5F8d82847D191Cb4Af5A3e873E0",
      "coingeckoId": "aave-link"
    }
  },
  {
    "chainId": 101,
    "address": "AXJWqG4SpAEwkMjKYkarKwv6Qfz5rLU3cwt5KtrDAAYe",
    "symbol": "waMANA",
    "name": "Aave interest bearing MANA (Wormhole)",
    "decimals": 9,
    "logoURI":
        "https://raw.githubusercontent.com/solana-labs/token-list/main/assets/mainnet/AXJWqG4SpAEwkMjKYkarKwv6Qfz5rLU3cwt5KtrDAAYe/logo.svg",
    "tags": ["wrapped", "wormhole"],
    "extensions": {
      "address": "0xa685a61171bb30d4072B338c80Cb7b2c865c873E",
      "bridgeContract": "https://etherscan.io/address/0xf92cD566Ea4864356C5491c177A430C222d7e678",
      "assetContract": "https://etherscan.io/address/0xa685a61171bb30d4072B338c80Cb7b2c865c873E",
      "coingeckoId": "aave-mana"
    }
  },
  {
    "chainId": 101,
    "address": "4kJmfagJzQFuwto5RX6f1xScWYbEVBzEpdjmiqTCnzjJ",
    "symbol": "waMKR",
    "name": "Aave interest bearing MKR (Wormhole)",
    "decimals": 9,
    "logoURI":
        "https://raw.githubusercontent.com/solana-labs/token-list/main/assets/mainnet/4kJmfagJzQFuwto5RX6f1xScWYbEVBzEpdjmiqTCnzjJ/logo.svg",
    "tags": ["wrapped", "wormhole"],
    "extensions": {
      "address": "0xc713e5E149D5D0715DcD1c156a020976e7E56B88",
      "bridgeContract": "https://etherscan.io/address/0xf92cD566Ea4864356C5491c177A430C222d7e678",
      "assetContract": "https://etherscan.io/address/0xc713e5E149D5D0715DcD1c156a020976e7E56B88",
      "coingeckoId": "aave-mkr"
    }
  },
  {
    "chainId": 101,
    "address": "DN8jPo8YZTXhLMyDMKcnwFuKqY8wfn2UrpX8ct4rc8Bc",
    "symbol": "waREN",
    "name": "Aave interest bearing REN (Wormhole)",
    "decimals": 9,
    "logoURI":
        "https://raw.githubusercontent.com/solana-labs/token-list/main/assets/mainnet/DN8jPo8YZTXhLMyDMKcnwFuKqY8wfn2UrpX8ct4rc8Bc/logo.svg",
    "tags": ["wrapped", "wormhole"],
    "extensions": {
      "address": "0xCC12AbE4ff81c9378D670De1b57F8e0Dd228D77a",
      "bridgeContract": "https://etherscan.io/address/0xf92cD566Ea4864356C5491c177A430C222d7e678",
      "assetContract": "https://etherscan.io/address/0xCC12AbE4ff81c9378D670De1b57F8e0Dd228D77a",
      "coingeckoId": "aave-ren"
    }
  },
  {
    "chainId": 101,
    "address": "HWbJZXJ7s1D1zi5P7yVgRUmZPXvYSFv6vsYU765Ti422",
    "symbol": "waSNX",
    "name": "Aave interest bearing SNX (Wormhole)",
    "decimals": 9,
    "logoURI":
        "https://raw.githubusercontent.com/solana-labs/token-list/main/assets/mainnet/HWbJZXJ7s1D1zi5P7yVgRUmZPXvYSFv6vsYU765Ti422/logo.svg",
    "tags": ["wrapped", "wormhole"],
    "extensions": {
      "address": "0x35f6B052C598d933D69A4EEC4D04c73A191fE6c2",
      "bridgeContract": "https://etherscan.io/address/0xf92cD566Ea4864356C5491c177A430C222d7e678",
      "assetContract": "https://etherscan.io/address/0x35f6B052C598d933D69A4EEC4D04c73A191fE6c2",
      "coingeckoId": "aave-snx"
    }
  },
  {
    "chainId": 101,
    "address": "2LForywWWpHzmR5NjSEyF1kcw9ffyLuJX7V7hne2fHfY",
    "symbol": "waSUSD",
    "name": "Aave interest bearing SUSD (Wormhole)",
    "decimals": 9,
    "logoURI":
        "https://raw.githubusercontent.com/solana-labs/token-list/main/assets/mainnet/2LForywWWpHzmR5NjSEyF1kcw9ffyLuJX7V7hne2fHfY/logo.svg",
    "tags": ["wrapped", "wormhole"],
    "extensions": {
      "address": "0x6C5024Cd4F8A59110119C56f8933403A539555EB",
      "bridgeContract": "https://etherscan.io/address/0xf92cD566Ea4864356C5491c177A430C222d7e678",
      "assetContract": "https://etherscan.io/address/0x6C5024Cd4F8A59110119C56f8933403A539555EB",
      "coingeckoId": "aave-susd"
    }
  },
  {
    "chainId": 101,
    "address": "Badj3S29a2u1auxmijwg5vGjhPLb1K6WLPoigtWjKPXp",
    "symbol": "waTUSD",
    "name": "Aave interest bearing TUSD (Wormhole)",
    "decimals": 9,
    "logoURI":
        "https://raw.githubusercontent.com/solana-labs/token-list/main/assets/mainnet/Badj3S29a2u1auxmijwg5vGjhPLb1K6WLPoigtWjKPXp/logo.svg",
    "tags": ["wrapped", "wormhole"],
    "extensions": {
      "address": "0x101cc05f4A51C0319f570d5E146a8C625198e636",
      "bridgeContract": "https://etherscan.io/address/0xf92cD566Ea4864356C5491c177A430C222d7e678",
      "assetContract": "https://etherscan.io/address/0x101cc05f4A51C0319f570d5E146a8C625198e636",
      "coingeckoId": "aave-tusd"
    }
  },
  {
    "chainId": 101,
    "address": "BZCPpva12M9SqJgcpf8jtP9Si6rMANFoUR3i7nchha7M",
    "symbol": "waUSDC",
    "name": "Aave interest bearing USDC (Wormhole)",
    "decimals": 6,
    "logoURI":
        "https://raw.githubusercontent.com/solana-labs/token-list/main/assets/mainnet/BZCPpva12M9SqJgcpf8jtP9Si6rMANFoUR3i7nchha7M/logo.svg",
    "tags": ["wrapped", "wormhole"],
    "extensions": {
      "address": "0xBcca60bB61934080951369a648Fb03DF4F96263C",
      "bridgeContract": "https://etherscan.io/address/0xf92cD566Ea4864356C5491c177A430C222d7e678",
      "assetContract": "https://etherscan.io/address/0xBcca60bB61934080951369a648Fb03DF4F96263C",
      "coingeckoId": "aave-usdc"
    }
  },
  {
    "chainId": 101,
    "address": "D3ajQoyBGJz3JCXCPsxHZJbLQKGt9UgxLavgurieGNcD",
    "symbol": "wSDT",
    "name": "Stake DAO Token (Wormhole)",
    "decimals": 9,
    "logoURI":
        "https://raw.githubusercontent.com/solana-labs/token-list/main/assets/mainnet/D3ajQoyBGJz3JCXCPsxHZJbLQKGt9UgxLavgurieGNcD/logo.png",
    "tags": ["wrapped", "wormhole"],
    "extensions": {
      "address": "0x73968b9a57c6e53d41345fd57a6e6ae27d6cdb2f",
      "bridgeContract": "https://etherscan.io/address/0xf92cD566Ea4864356C5491c177A430C222d7e678",
      "assetContract": "https://etherscan.io/address/0x73968b9a57c6e53d41345fd57a6e6ae27d6cdb2f",
      "coingeckoId": "stake-dao"
    }
  },
  {
    "chainId": 101,
    "address": "4pk3pf9nJDN1im1kNwWJN1ThjE8pCYCTexXYGyFjqKVf",
    "symbol": "oDOP",
    "name": "Dominican Pesos",
    "decimals": 9,
    "logoURI":
        "https://raw.githubusercontent.com/solana-labs/token-list/main/assets/mainnet/4pk3pf9nJDN1im1kNwWJN1ThjE8pCYCTexXYGyFjqKVf/logo.png",
    "tags": ["stablecoin"],
    "extensions": {"website": "https://Odop.io/"}
  },
  {
    "chainId": 101,
    "address": "5kjfp2qfRbqCXTQeUYgHNnTLf13eHoKjC5hHynW9DvQE",
    "symbol": "AAPE",
    "name": "AAPE",
    "decimals": 9,
    "logoURI":
        "https://raw.githubusercontent.com/solana-labs/token-list/main/assets/mainnet/5kjfp2qfRbqCXTQeUYgHNnTLf13eHoKjC5hHynW9DvQE/logo.png",
    "tags": [],
    "extensions": {"website": "https://aape.io/"}
  },
  {
    "chainId": 101,
    "address": "5LkvF71ZicV2HhbwYio6XMiFxNv3VUn62eBQ2nppG5D",
    "symbol": "CAPF",
    "name": "Capital Fusion",
    "decimals": 6,
    "logoURI":
        "https://raw.githubusercontent.com/capitalfusion/token-list/main/assets/mainnet/5LkvF71ZicV2HhbwYio6XMiFxNv3VUn62eBQ2nppG5D/logo.png",
    "tags": [],
    "extensions": {"website": "https://capitalfusion.io/"}
  },
  {
    "chainId": 101,
    "address": "3K6rftdAaQYMPunrtNRHgnK2UAtjm2JwyT2oCiTDouYE",
    "symbol": "XCOPE",
    "name": "XCOPE",
    "decimals": 0,
    "logoURI":
        "https://raw.githubusercontent.com/solana-labs/token-list/main/assets/mainnet/3K6rftdAaQYMPunrtNRHgnK2UAtjm2JwyT2oCiTDouYE/logo.png",
    "tags": ["trading", "index", "Algos"],
    "extensions": {
      "website": "https://www.unlimitedcope.com/",
      "serumV3Usdc": "7MpMwArporUHEGW7quUpkPZp5L5cHPs9eKUfKCdaPHq2",
      "coingeckoId": "cope"
    }
  },
  {
    "chainId": 101,
    "address": "8HGyAAB1yoM1ttS7pXjHMa3dukTFGQggnFFH3hJZgzQh",
    "symbol": "COPE",
    "name": "COPE",
    "decimals": 6,
    "logoURI":
        "https://raw.githubusercontent.com/solana-labs/token-list/main/assets/mainnet/8HGyAAB1yoM1ttS7pXjHMa3dukTFGQggnFFH3hJZgzQh/logo.png",
    "tags": ["trading", "index", "Algos"],
    "extensions": {
      "website": "https://www.unlimitedcope.com/",
      "serumV3Usdc": "6fc7v3PmjZG9Lk2XTot6BywGyYLkBQuzuFKd4FpCsPxk",
      "coingeckoId": "cope"
    }
  },
  {
    "chainId": 101,
    "address": "2prC8tcVsXwVJAinhxd2zeMeWMWaVyzPoQeLKyDZRFKd",
    "symbol": "MCAPS",
    "name": "Mango Market Caps",
    "decimals": 0,
    "logoURI":
        "https://raw.githubusercontent.com/solana-labs/token-list/main/assets/mainnet/2prC8tcVsXwVJAinhxd2zeMeWMWaVyzPoQeLKyDZRFKd/logo.png",
    "tags": ["mango"],
    "extensions": {"website": "https://initialcapoffering.com/", "coingeckoId": "mango-market-caps"}
  },
  {
    "chainId": 101,
    "address": "2reKm5Y9rmAWfaw5jraYz1BXwGLHMofGMs3iNoBLt4VC",
    "symbol": "DOCE",
    "name": "Doce Finance",
    "decimals": 6,
    "logoURI":
        "https://raw.githubusercontent.com/solana-labs/token-list/main/assets/mainnet/2reKm5Y9rmAWfaw5jraYz1BXwGLHMofGMs3iNoBLt4VC/logo.png",
    "tags": [],
    "extensions": {"website": "https://swap.doce.finance/"}
  },
  {
    "chainId": 101,
    "address": "E1PvPRPQvZNivZbXRL61AEGr71npZQ5JGxh4aWX7q9QA",
    "symbol": "INO",
    "name": "NoGoalToken",
    "decimals": 9,
    "logoURI":
        "https://raw.githubusercontent.com/solana-labs/token-list/main/assets/mainnet/E1PvPRPQvZNivZbXRL61AEGr71npZQ5JGxh4aWX7q9QA/logo.png",
    "tags": [],
    "extensions": {
      "website": "http://token.nogoal.click/",
      "discord": "https://discord.gg/mHS3qbBaZk",
      "serumV3Usdc": "HyERWE8TEQmDX157oLEpwaTc59ECzmvjUgZhZ2RNtNdn"
    }
  },
  {
    "chainId": 101,
    "address": "8PMHT4swUMtBzgHnh5U564N5sjPSiUz2cjEQzFnnP1Fo",
    "symbol": "ROPE",
    "name": "Rope Token",
    "decimals": 9,
    "logoURI":
        "https://raw.githubusercontent.com/solana-labs/token-list/main/assets/mainnet/8PMHT4swUMtBzgHnh5U564N5sjPSiUz2cjEQzFnnP1Fo/logo.svg",
    "tags": [],
    "extensions": {
      "website": "https://ropesolana.com/",
      "coingeckoId": "rope-token",
      "serumV3Usdc": "4Sg1g8U2ZuGnGYxAhc6MmX9MX7yZbrrraPkCQ9MdCPtF",
      "waterfallbot": "https://bit.ly/ROPEwaterfall"
    }
  },
  {
    "chainId": 101,
    "address": "2XkWD6spByDUoR3VDEjPXz4kxFV8e1skwaRSBArRLG3a",
    "symbol": "DROIDF",
    "name": "DROID FINANCE",
    "decimals": 8,
    "logoURI":
        "https://raw.githubusercontent.com/solana-labs/token-list/main/assets/mainnet/2XkWD6spByDUoR3VDEjPXz4kxFV8e1skwaRSBArRLG3a/logo.png",
    "tags": [],
    "extensions": {"website": "https://www.droid.finance/"}
  },
  {
    "chainId": 101,
    "address": "5dhkWqrq37F92jBmEyhQP1vbMkbVRz59V7288HH2wBC7",
    "symbol": "SLOCK",
    "name": "SOLLock",
    "decimals": 9,
    "logoURI":
        "https://raw.githubusercontent.com/solana-labs/token-list/main/assets/mainnet/5dhkWqrq37F92jBmEyhQP1vbMkbVRz59V7288HH2wBC7/logo.png",
    "tags": ["utility-token"],
    "extensions": {
      "website": "https://sollock.org/",
      "twitter": "https://twitter.com/@SOLLockOfficial",
      "github": "https://github.com/SOLLock",
      "tgann": "https://t.me/SOLLockAnn",
      "tggroup": "https://t.me/SOLLock"
    }
  },
  {
    "chainId": 101,
    "address": "ETAtLmCmsoiEEKfNrHKJ2kYy3MoABhU6NQvpSfij5tDs",
    "symbol": "MEDIA",
    "name": "Media Network",
    "decimals": 6,
    "logoURI":
        "https://raw.githubusercontent.com/solana-labs/token-list/main/assets/mainnet/ETAtLmCmsoiEEKfNrHKJ2kYy3MoABhU6NQvpSfij5tDs/logo.png",
    "tags": ["utility-token"],
    "extensions": {
      "website": "https://media.network/",
      "coingeckoId": "media-network",
      "serumV3Usdc": "FfiqqvJcVL7oCCu8WQUMHLUC2dnHQPAPjTdSzsERFWjb",
      "waterfallbot": "https://bit.ly/MEDIAwaterfall"
    }
  },
  {
    "chainId": 101,
    "address": "StepAscQoEioFxxWGnh2sLBDFp9d8rvKz2Yp39iDpyT",
    "symbol": "STEP",
    "name": "Step",
    "decimals": 9,
    "logoURI":
        "https://raw.githubusercontent.com/solana-labs/token-list/main/assets/mainnet/StepAscQoEioFxxWGnh2sLBDFp9d8rvKz2Yp39iDpyT/logo.png",
    "tags": ["utility-token"],
    "extensions": {
      "website": "https://step.finance/",
      "twitter": "https://twitter.com/StepFinance_",
      "coingeckoId": "step-finance",
      "serumV3Usdc": "97qCB4cAVSTthvJu3eNoEx6AY6DLuRDtCoPm5Tdyg77S",
      "waterfallbot": "https://bit.ly/STEPwaterfall"
    }
  },
  {
    "chainId": 101,
    "address": "xStpgUCss9piqeFUk2iLVcvJEGhAdJxJQuwLkXP555G",
    "symbol": "xSTEP",
    "name": "Staked Step",
    "decimals": 9,
    "logoURI":
        "https://raw.githubusercontent.com/solana-labs/token-list/main/assets/mainnet/xStpgUCss9piqeFUk2iLVcvJEGhAdJxJQuwLkXP555G/logo.svg",
    "tags": ["utility-token"],
    "extensions": {
      "website": "https://step.finance/",
      "twitter": "https://twitter.com/StepFinance_",
      "waterfallbot": "https://bit.ly/STEPwaterfall"
    }
  },
  {
    "chainId": 101,
    "address": "7Geyz6iiRe8buvunsU6TXndxnpLt9mg6iPxqhn6cr3c6",
    "symbol": "ANFT",
    "name": "AffinityLabs",
    "decimals": 9,
    "logoURI":
        "https://raw.githubusercontent.com/solana-labs/token-list/main/assets/mainnet/7Geyz6iiRe8buvunsU6TXndxnpLt9mg6iPxqhn6cr3c6/logo.png",
    "tags": ["nft"],
    "extensions": {"website": "https://affinitylabs.tech/"}
  },
  {
    "chainId": 102,
    "address": "So11111111111111111111111111111111111111112",
    "symbol": "wSOL",
    "name": "Wrapped SOL",
    "decimals": 9,
    "logoURI":
        "https://raw.githubusercontent.com/solana-labs/token-list/main/assets/mainnet/So11111111111111111111111111111111111111112/logo.png",
    "tags": [],
    "extensions": {"website": "https://www.solana.com/", "coingeckoId": "solana"}
  },
  {
    "chainId": 102,
    "address": "CpMah17kQEL2wqyMKt3mZBdTnZbkbfx4nqmQMFDP5vwp",
    "symbol": "USDC",
    "name": "USD Coin",
    "decimals": 6,
    "logoURI":
        "https://raw.githubusercontent.com/solana-labs/token-list/main/assets/mainnet/CpMah17kQEL2wqyMKt3mZBdTnZbkbfx4nqmQMFDP5vwp/logo.png",
    "tags": ["stablecoin"],
    "extensions": {"website": "https://www.centre.io/", "coingeckoId": "usd-coin"}
  },
  {
    "chainId": 102,
    "address": "Gmk71cM7j2RMorRsQrsyysM4HsByQx5PuDGtDdqGLWCS",
    "symbol": "spSOL",
    "name": "Stake pool SOL",
    "decimals": 9,
    "logoURI":
        "https://raw.githubusercontent.com/solana-labs/token-list/main/assets/mainnet/Gmk71cM7j2RMorRsQrsyysM4HsByQx5PuDGtDdqGLWCS/logo.png",
    "tags": ["stake-pool"],
    "extensions": {"website": "https://www.solana.com/"}
  },
  {
    "chainId": 102,
    "address": "2jQc2jDHVCewoWsQJK7JPLetP7UjqXvaFdno8rtrD8Kg",
    "symbol": "sHOG",
    "name": "sHOG",
    "decimals": 6,
    "tags": ["stablecoin"]
  },
  {
    "chainId": 101,
    "address": "7udMmYXh6cuWVY6qQVCd9b429wDVn2J71r5BdxHkQADY",
    "symbol": "COBAN",
    "name": "COBAN",
    "decimals": 3,
    "logoURI":
        "https://raw.githubusercontent.com/solana-labs/token-list/main/assets/assets/7udMmYXh6cuWVY6qQVCd9b429wDVn2J71r5BdxHkQADY/logo.png",
    "tags": [],
    "extensions": {"website": "https://coban.io"}
  },
  {
    "chainId": 102,
    "address": "ASpA3U8G2qHnyo6ag1jwtpZNj9E2MymbVDq6twi3ZvRN",
    "symbol": "USDT_ILT",
    "name": "USDT_ILT_Token_Test",
    "decimals": 6,
    "tags": ["stablecoin"]
  },
  {
    "chainId": 103,
    "address": "3MoHgE6bJ2Ak1tEvTt5SVgSN2oXiwt6Gk5s6wbBxdmmN",
    "symbol": "USDT_ILT",
    "name": "USDT_ILT_Token_Test",
    "decimals": 6,
    "tags": ["stablecoin"]
  },
  {
    "chainId": 103,
    "address": "So11111111111111111111111111111111111111112",
    "symbol": "SOL",
    "name": "Wrapped SOL",
    "decimals": 9,
    "logoURI":
        "https://raw.githubusercontent.com/solana-labs/token-list/main/assets/mainnet/So11111111111111111111111111111111111111112/logo.png",
    "tags": [],
    "extensions": {"coingeckoId": "solana"}
  },
  {
    "chainId": 103,
    "address": "7Cab8z1Lz1bTC9bQNeY7VQoZw5a2YbZoxmvFSvPgcTEL",
    "symbol": "LGGD",
    "name": "LGG Dev Fan Token",
    "decimals": 0,
    "logoURI":
        "https://raw.githubusercontent.com/solana-labs/token-list/main/assets/mainnet/7Cab8z1Lz1bTC9bQNeY7VQoZw5a2YbZoxmvFSvPgcTEL/logo.png",
    "tags": ["LGG"],
    "extensions": {"website": "https://lgg-hacks.art"}
  },
  {
    "chainId": 103,
    "address": "DEhAasscXF4kEGxFgJ3bq4PpVGp5wyUxMRvn6TzGVHaw",
    "symbol": "XYZ",
    "name": "XYZ Test",
    "decimals": 6,
    "logoURI":
        "https://raw.githubusercontent.com/solana-labs/token-list/main/assets/mainnet/DEhAasscXF4kEGxFgJ3bq4PpVGp5wyUxMRvn6TzGVHaw/logo.png",
    "tags": []
  },
  {
    "chainId": 103,
    "address": "2rg5syU3DSwwWs778FQ6yczDKhS14NM3vP4hqnkJ2jsM",
    "symbol": "pSOL",
    "name": "SOL stake pool",
    "decimals": 9,
    "logoURI":
        "https://raw.githubusercontent.com/solana-labs/token-list/main/assets/mainnet/2rg5syU3DSwwWs778FQ6yczDKhS14NM3vP4hqnkJ2jsM/logo.png",
    "tags": [],
    "extensions": {
      "website": "https://solana.com/",
      "background":
          "https://solana.com/static/8c151e179d2d7e80255bdae6563209f2/6833b/validators.webp"
    }
  },
  {
    "chainId": 103,
    "address": "SRMuApVNdxXokk5GT7XD5cUUgXMBCoAz2LHeuAoKWRt",
    "symbol": "SRM",
    "name": "Serum",
    "decimals": 6,
    "logoURI":
        "https://raw.githubusercontent.com/solana-labs/token-list/main/assets/mainnet/SRMuApVNdxXokk5GT7XD5cUUgXMBCoAz2LHeuAoKWRt/logo.png",
    "tags": [],
    "extensions": {"website": "https://projectserum.com/", "coingeckoId": "serum"}
  },
  {
    "chainId": 103,
    "address": "StepAscQoEioFxxWGnh2sLBDFp9d8rvKz2Yp39iDpyT",
    "symbol": "STEP",
    "name": "Step",
    "decimals": 9,
    "logoURI":
        "https://raw.githubusercontent.com/solana-labs/token-list/main/assets/mainnet/StepAscQoEioFxxWGnh2sLBDFp9d8rvKz2Yp39iDpyT/logo.png",
    "tags": ["utility-token"],
    "extensions": {
      "website": "https://step.finance/",
      "twitter": "https://twitter.com/StepFinance_",
      "coingeckoId": "step-finance",
      "waterfallbot": "https://bit.ly/STEPwaterfall"
    }
  },
  {
    "chainId": 103,
    "address": "xStpgUCss9piqeFUk2iLVcvJEGhAdJxJQuwLkXP555G",
    "symbol": "xSTEP",
    "name": "Staked Step",
    "decimals": 9,
    "logoURI":
        "https://raw.githubusercontent.com/solana-labs/token-list/main/assets/mainnet/xStpgUCss9piqeFUk2iLVcvJEGhAdJxJQuwLkXP555G/logo.svg",
    "tags": ["utility-token"],
    "extensions": {
      "website": "https://step.finance/",
      "twitter": "https://twitter.com/StepFinance_",
      "waterfallbot": "https://bit.ly/STEPwaterfall"
    }
  },
  {
    "chainId": 103,
    "address": "7STJWT74tAZzhbNNPRH8WuGDy9GZg27968EwALWuezrH",
    "symbol": "wSUSHI",
    "name": "SushiSwap (Wormhole)",
    "decimals": 9,
    "logoURI":
        "https://raw.githubusercontent.com/solana-labs/token-list/main/assets/mainnet/7STJWT74tAZzhbNNPRH8WuGDy9GZg27968EwALWuezrH/logo.png",
    "tags": ["wrapped", "wormhole"],
    "extensions": {
      "website": "https://sushi.com",
      "background": "https://sushi.com/static/media/Background-sm.fd449814.jpg/",
      "address": "0x6B3595068778DD592e39A122f4f5a5cF09C90fE2",
      "bridgeContract": "https://etherscan.io/address/0xf92cD566Ea4864356C5491c177A430C222d7e678",
      "assetContract": "https://etherscan.io/address/0x6B3595068778DD592e39A122f4f5a5cF09C90fE2",
      "coingeckoId": "sushi"
    }
  },
  {
    "chainId": 103,
    "address": "3aMbgP7aGsP1sVcFKc6j65zu7UiziP57SMFzf6ptiCSX",
    "symbol": "sHOG",
    "name": "Devnet StableHog",
    "decimals": 6,
    "logoURI":
        "https://raw.githubusercontent.com/solana-labs/token-list/main/assets/mainnet/3aMbgP7aGsP1sVcFKc6j65zu7UiziP57SMFzf6ptiCSX/logo.png",
    "tags": ["stablecoin"]
  },
  {
    "chainId": 101,
    "address": "3cXftQWJJEeoysZrhAEjpfCHe9tSKyhYG63xpbue8m3s",
    "symbol": "Kreechures",
    "name": "Kreechures",
    "decimals": 0,
    "logoURI":
        "https://raw.githubusercontent.com/solana-labs/token-list/main/assets/mainnet/3cXftQWJJEeoysZrhAEjpfCHe9tSKyhYG63xpbue8m3s/logo.svg",
    "tags": ["nft"],
    "extensions": {
      "website": "https://www.kreechures.com/",
      "attributes": [
        {
          "image":
              "https://gateway.pinata.cloud/ipfs/QmWcMyAYpaX3BHJoDq6Fyub71TjaHbRHqErT7MmbDvCXYJ/3cXftQWJJEeoysZrhAEjpfCHe9tSKyhYG63xpbue8m3s.jpg",
          "Generation": 0,
          "Species": 6,
          "Base Rest": 262
        }
      ]
    }
  },
  {
    "chainId": 101,
    "address": "4DrV8khCoPS3sWRj6t1bb2DzT9jD4mZp6nc7Jisuuv1b",
    "symbol": "SPD",
    "name": "Solpad",
    "decimals": 9,
    "logoURI":
        "https://raw.githubusercontent.com/solana-labs/token-list/main/assets/mainnet/4DrV8khCoPS3sWRj6t1bb2DzT9jD4mZp6nc7Jisuuv1b/logo.png",
    "tags": [],
    "extensions": {"website": "https://www.solpad.io/"}
  },
  {
    "chainId": 101,
    "address": "7p7AMM6QoA8wPRKeqF87Pt51CRWmWvXPH5TBNMyDWhbH",
    "symbol": "Kreechures",
    "name": "Kreechures",
    "decimals": 0,
    "logoURI":
        "https://raw.githubusercontent.com/solana-labs/token-list/main/assets/mainnet/7p7AMM6QoA8wPRKeqF87Pt51CRWmWvXPH5TBNMyDWhbH/logo.svg",
    "tags": ["nft"],
    "extensions": {
      "website": "https://www.kreechures.com/",
      "attributes": [
        {
          "image":
              "https://gateway.pinata.cloud/ipfs/QmWcMyAYpaX3BHJoDq6Fyub71TjaHbRHqErT7MmbDvCXYJ/7p7AMM6QoA8wPRKeqF87Pt51CRWmWvXPH5TBNMyDWhbH.jpg",
          "Generation": 0,
          "Species": 4,
          "Base Rest": 335
        }
      ]
    }
  },
  {
    "chainId": 101,
    "address": "6ybxMQpMgQhtsTLhvHZqk8uqao7kvoexY6e8JmCTqAB1",
    "symbol": "QUEST",
    "name": "QUEST",
    "decimals": 4,
    "logoURI":
        "https://raw.githubusercontent.com/solana-labs/token-list/main/assets/mainnet/6ybxMQpMgQhtsTLhvHZqk8uqao7kvoexY6e8JmCTqAB1/logo.png",
    "tags": [],
    "extensions": {"website": "https://questcoin.org/"}
  },
  {
    "chainId": 101,
    "address": "97qAF7ZKEdPdQaUkhASGA59Jpa2Wi7QqVmnFdEuPqEDc",
    "symbol": "DIAMOND",
    "name": "LOVE",
    "decimals": 6,
    "logoURI":
        "https://raw.githubusercontent.com/solana-labs/token-list/main/assets/mainnet/97qAF7ZKEdPdQaUkhASGA59Jpa2Wi7QqVmnFdEuPqEDc/logo.png",
    "tags": ["Diamond Love"],
    "extensions": {"website": "https://diamondlove.io/", "telegram": "https://t.me/DiamondLoveX"}
  },
  {
    "chainId": 101,
    "address": "xxxxa1sKNGwFtw2kFn8XauW9xq8hBZ5kVtcSesTT9fW",
    "symbol": "SLIM",
    "name": "Solanium",
    "decimals": 6,
    "logoURI":
        "https://raw.githubusercontent.com/solana-labs/token-list/main/assets/mainnet/xxxxa1sKNGwFtw2kFn8XauW9xq8hBZ5kVtcSesTT9fW/logo.png",
    "tags": [],
    "extensions": {
      "website": "https://www.solanium.io/",
      "coingeckoId": "solanium",
      "twitter": "https://twitter.com/solanium_io",
      "telegram": "https://t.me/solanium_io"
    }
  },
  {
    "chainId": 101,
    "address": "8GPUjUHFxfNhaSS8kUkix8txRRXszeUAsHTjUmHuygZT",
    "symbol": "NINJA NFT1",
    "name": "NINJA NFT1",
    "decimals": 0,
    "logoURI":
        "https://raw.githubusercontent.com/yuzu-ninjaprotocol/ninjaprotocol/main/NINJA%20NFT%201.png",
    "tags": [],
    "extensions": {"website": "http://ninjaprotocol.io"}
  },
  {
    "chainId": 101,
    "address": "HcJCPYck2UsTMgiPfjn6CS1wrC5iBXtuqPSjt8Qy8Sou",
    "symbol": "GANGS",
    "name": "Gangs of Solana",
    "decimals": 4,
    "logoURI":
        "https://raw.githubusercontent.com/solana-labs/token-list/main/assets/mainnet/HcJCPYck2UsTMgiPfjn6CS1wrC5iBXtuqPSjt8Qy8Sou/logo.svg",
    "tags": [],
    "extensions": {"website": "https://gangsofsolana.com/"}
  },
  {
    "chainId": 101,
    "address": "2rEiLkpQ3mh4DGxv1zcSdW5r5HK2nehif5sCaF5Ss9E1",
    "symbol": "RECO",
    "name": "Reboot ECO",
    "decimals": 0,
    "logoURI":
        "https://raw.githubusercontent.com/solana-labs/token-list/main/assets/mainnet/2rEiLkpQ3mh4DGxv1zcSdW5r5HK2nehif5sCaF5Ss9E1/logo.png",
    "tags": [],
    "extensions": {"website": "https://reboot.eco/"}
  },
  {
    "chainId": 101,
    "address": "BXhAKUxkGvFbAarA3K1SUYnqXRhEBC1bhUaCaxvzgyJ1",
    "symbol": "ISA",
    "name": "Interstellar",
    "decimals": 9,
    "logoURI":
        "https://raw.githubusercontent.com/solana-labs/token-list/main/assets/mainnet/BXhAKUxkGvFbAarA3K1SUYnqXRhEBC1bhUaCaxvzgyJ1/logo.png",
    "tags": [],
    "extensions": {"website": "https://interstellaralliance.gitbook.io/isa/"}
  },
  {
    "chainId": 101,
    "address": "7xKXtg2CW87d97TXJSDpbD5jBkheTqA83TZRuJosgAsU",
    "symbol": "SAMO",
    "name": "Samoyed Coin",
    "decimals": 9,
    "logoURI":
        "https://raw.githubusercontent.com/solana-labs/token-list/main/assets/mainnet/7xKXtg2CW87d97TXJSDpbD5jBkheTqA83TZRuJosgAsU/logo.png",
    "tags": [],
    "extensions": {
      "website": "https://samoyedcoin.com/",
      "coingeckoId": "samoyedcoin",
      "serumV3Usdc": "FR3SPJmgfRSKKQ2ysUZBu7vJLpzTixXnjzb84bY3Diif"
    }
  },
  {
    "chainId": 101,
    "address": "ATLASXmbPQxBUYbxPsV97usA3fPQYEqzQBUHgiFCUsXx",
    "symbol": "ATLAS",
    "name": "Star Atlas",
    "decimals": 8,
    "logoURI":
        "https://raw.githubusercontent.com/solana-labs/token-list/main/assets/mainnet/ATLASXmbPQxBUYbxPsV97usA3fPQYEqzQBUHgiFCUsXx/logo.png",
    "waterfallbot": "https://bit.ly/ATLASwaterfall",
    "tags": ["utility-token"],
    "extensions": {
      "website": "https://staratlas.com",
      "description": "Star Atlas Token",
      "coingeckoId": "star-atlas",
      "serumV3Usdc": "Di66GTLsV64JgCCYGVcY21RZ173BHkjJVgPyezNN7P1K"
    }
  },
  {
    "chainId": 101,
    "address": "poLisWXnNRwC6oBu1vHiuKQzFjGL4XDSu4g9qjz9qVk",
    "symbol": "POLIS",
    "name": "Star Atlas DAO",
    "decimals": 8,
    "logoURI":
        "https://raw.githubusercontent.com/solana-labs/token-list/main/assets/mainnet/poLisWXnNRwC6oBu1vHiuKQzFjGL4XDSu4g9qjz9qVk/logo.png",
    "waterfallbot": "https://bit.ly/POLISwaterfall",
    "tags": ["utility-token"],
    "extensions": {
      "website": "https://staratlas.com",
      "description": "Star Atlas DAO Token",
      "coingeckoId": "star-atlas-dao",
      "serumV3Usdc": "HxFLKUAmAMLz1jtT3hbvCMELwH5H9tpM2QugP8sKyfhW"
    }
  },
  {
    "chainId": 101,
    "address": "HAWy8kV3bD4gaN6yy6iK2619x2dyzLUBj1PfJiihTisE",
    "symbol": "DOI",
    "name": "Discovery of Iris",
    "decimals": 0,
    "logoURI":
        "https://raw.githubusercontent.com/solana-labs/token-list/main/assets/mainnet/HAWy8kV3bD4gaN6yy6iK2619x2dyzLUBj1PfJiihTisE/logo.png",
    "tags": ["nft"],
    "extensions": {
      "website": "https://www.staratlas.com",
      "imageUrl":
          "https://storage.googleapis.com/nft-assets/ReBirth/poster-1/discovery-of-iris.jpg",
      "description":
          "The rogue planet, Iris, dense with invaluable materials, draws in and collides with seven child planets in a remote region of space, creating what is henceforth referred to as 'The Cataclysm'. When combined, these eight elements create a form of free energy. The collision creates a massively valuable debris field.",
      "serumV3Usdc": "AYXTVttPfhYmn3jryX5XbRjwPK2m9445mbN2iLyRD6nq"
    }
  },
  {
    "chainId": 101,
    "address": "ATSPo9f9TJ3Atx8SuoTYdzSMh4ctQBzYzDiNukQDmoF7",
    "symbol": "HOSA",
    "name": "The Heart of Star Atlas",
    "decimals": 0,
    "logoURI":
        "https://raw.githubusercontent.com/solana-labs/token-list/main/assets/mainnet/ATSPo9f9TJ3Atx8SuoTYdzSMh4ctQBzYzDiNukQDmoF7/logo.png",
    "tags": ["nft"],
    "extensions": {
      "website": "https://www.staratlas.com",
      "imageUrl":
          "https://storage.googleapis.com/nft-assets/ReBirth/poster-2/the-heart-of-star-atlas.jpg",
      "description":
          "At the core of Star Atlas lies a treasure trove of priceless data. After an unsuspecting deep space explorer discovers “The Cataclysm”, he scans its riches, creating what will once be known as the first intergalactic data block. He sells this invaluable information to all three rival factions, igniting a lethal spark that forever changes the course of history.",
      "serumV3Usdc": "5Erzgrw9pTjNWLeqHp2sChJq7smB7WXRQYw9wvkvA59t"
    }
  },
  {
    "chainId": 101,
    "address": "36s6AFRXzE9KVdUyoJQ5y6mwxXw21LawYqqwNiQUMD8s",
    "symbol": "TCW",
    "name": "The Convergence War",
    "decimals": 0,
    "logoURI":
        "https://raw.githubusercontent.com/solana-labs/token-list/main/assets/mainnet/36s6AFRXzE9KVdUyoJQ5y6mwxXw21LawYqqwNiQUMD8s/logo.png",
    "tags": ["nft"],
    "extensions": {
      "website": "https://www.staratlas.com",
      "imageUrl":
          "https://storage.googleapis.com/nft-assets/ReBirth/poster-3/the-convergence-war.jpg",
      "description":
          "All three factions, thinking they were the sole owners of the cataclysmic data drop, converge to settle the area. A devastating war breaks out across the galaxy after their inability to settle the disputed territory.",
      "serumV3Usdc": "DXPv2ZyMD6Y2mDenqYkAhkvGSjNahkuMkm4zv6DqB7RF"
    }
  },
  {
    "chainId": 101,
    "address": "BgiTVxW9uLuHHoafTd2qjYB5xjCc5Y1EnUuYNfmTwhvp",
    "symbol": "LOST",
    "name": "Short Story of a Lost Astronaut",
    "decimals": 0,
    "logoURI":
        "https://raw.githubusercontent.com/solana-labs/token-list/main/assets/mainnet/BgiTVxW9uLuHHoafTd2qjYB5xjCc5Y1EnUuYNfmTwhvp/logo.png",
    "tags": ["nft"],
    "extensions": {
      "website": "https://www.staratlas.com",
      "imageUrl":
          "https://storage.googleapis.com/nft-assets/ReBirth/poster-4/short-story-of-a-lost-astronaut.jpg",
      "description":
          "He thought it would be just another routine exploration mission. Get there, scan, save data blocks and return. But when a surprise radiation storm knocked out his spaceship and swept him up into its high-velocity current, the only thing that saved him from certain doom was his custom ion shield.",
      "serumV3Usdc": "73d9N7BbWVKBG6A2xwwwEHcxzPB26YzbMnRjue3DPzqs"
    }
  },
  {
    "chainId": 101,
    "address": "4G85c5aUsRTrRPqE5VjY7ebD9b2ktTF6NEVGiCddRBDX",
    "symbol": "LOVE",
    "name": "B ❤ P",
    "decimals": 0,
    "logoURI":
        "https://raw.githubusercontent.com/solana-labs/token-list/main/assets/mainnet/4G85c5aUsRTrRPqE5VjY7ebD9b2ktTF6NEVGiCddRBDX/logo.png",
    "tags": ["nft"],
    "extensions": {
      "website": "https://www.staratlas.com",
      "imageUrl": "https://storage.googleapis.com/nft-assets/ReBirth/poster-5/love-story.jpg",
      "description":
          "Paizul, the charismatic and brilliant leader of the ONI consortium, vividly recalls the first time she saw her one true love. It was a warm summer day, full of raging ionic storms. Lightning was piercing the sky as Bekalu took off his helmet and locked eyes with her. “What are the chances of nearly colliding with someone flying through these wastelands on a day like this”, he smiled with his booming voice. “Perhaps it’s destiny,” she smiled back mysteriously. There was another strike of lightning, but this time the sky remained calm.",
      "serumV3Usdc": "AM9sNDh48N2qhYSgpA58m9dHvrMoQongtyYu2u2XoYTc"
    }
  },
  {
    "chainId": 101,
    "address": "7dr7jVyXf1KUnYq5FTpV2vCZjKRR4MV94jzerb8Fi16Q",
    "symbol": "MRDR",
    "name": "The Assassination of Paizul",
    "decimals": 0,
    "logoURI":
        "https://raw.githubusercontent.com/solana-labs/token-list/main/assets/mainnet/7dr7jVyXf1KUnYq5FTpV2vCZjKRR4MV94jzerb8Fi16Q/logo.png",
    "tags": ["nft"],
    "extensions": {
      "website": "https://www.staratlas.com",
      "imageUrl":
          "https://storage.googleapis.com/nft-assets/ReBirth/poster-6/assassination-of-paizul.jpg",
      "description":
          "Suffering one of the cruelest fates in the universe, the Sogmian race of aliens was driven to the brink of extinction. With only 10,000 members left, they put all hope of salvation in the hands of their leader Paizul. After she was assassinated in a gruesome public way, so much fear was struck in the hearts of survivors that they set out to build their 'Last Stand'.",
      "serumV3Usdc": "BJiV2gCLwMvj2c1CbhnMjjy68RjqoMzYT8brDrpVyceA"
    }
  },
  {
    "chainId": 101,
    "address": "G1bE9ge8Yoq43hv7QLcumxTFhHqFMdcL4y2d6ZdzMG4b",
    "symbol": "PFP",
    "name": "Paizul Funeral Procession",
    "decimals": 0,
    "logoURI":
        "https://raw.githubusercontent.com/solana-labs/token-list/main/assets/mainnet/G1bE9ge8Yoq43hv7QLcumxTFhHqFMdcL4y2d6ZdzMG4b/logo.png",
    "tags": ["nft"],
    "extensions": {
      "website": "https://www.staratlas.com",
      "imageUrl":
          "https://storage.googleapis.com/nft-assets/ReBirth/poster-7/paizul-funeral-procession.jpg",
      "description":
          "The sound of wailing echoes across the plains. The Sogmian procession solemnly marches in step past their ancestors’ gravestones, still haunted by the fate of their leader. The sun begins to set as they bring Paizul’s cryopod at the top of the Rock of Light. As a beam of light consumes the pod to upload it to eternal rest with the ancients, Bekalu falls to his knees with a wrathful howl. The crowd is rattled to the core, a foreboding of things to come.",
      "serumV3Usdc": "7JzaEAuVfjkrZyMwJgZF5aQkiEyVyCaTWA3N1fQK7Y6V"
    }
  },
  {
    "chainId": 101,
    "address": "6bD8mr8DyuVqN5dXd1jnqmCL66b5KUV14jYY1HSmnxTE",
    "symbol": "AVE",
    "name": "Ahr Visits Earth",
    "decimals": 0,
    "logoURI":
        "https://raw.githubusercontent.com/solana-labs/token-list/main/assets/mainnet/6bD8mr8DyuVqN5dXd1jnqmCL66b5KUV14jYY1HSmnxTE/logo.png",
    "tags": ["nft"],
    "extensions": {
      "website": "https://www.staratlas.com",
      "imageUrl": "https://storage.googleapis.com/nft-assets/ReBirth/poster-8/ahr-visits-earth.jpg",
      "description":
          "Humankind is visited by Ahr, a mysterious being of pure light. But not all is as it seems… For through the power of illusion, we are tricked into forming a space-based religion, plundering the planet and launching ourselves towards the stars, permanently leaving the Earth.",
      "serumV3Usdc": "8yQzsbraXJFoPG5PdX73B8EVYFuPR9aC2axAqWearGKu"
    }
  },
  {
    "chainId": 101,
    "address": "9vi6PTKBFHR2hXgyjoTZx6h7WXNkFAA5dCsZRSi4higK",
    "symbol": "ASF",
    "name": "Armstrong Forever",
    "decimals": 0,
    "logoURI":
        "https://raw.githubusercontent.com/solana-labs/token-list/main/assets/mainnet/9vi6PTKBFHR2hXgyjoTZx6h7WXNkFAA5dCsZRSi4higK/logo.png",
    "tags": ["nft"],
    "extensions": {
      "website": "https://www.staratlas.com",
      "imageUrl":
          "https://storage.googleapis.com/nft-assets/ReBirth/poster-15/armstrong-forever.jpg",
      "description":
          "When humans were racing to expand into outer space under Ahr’s influence, the devastation they inflicted upon the planet was so great that it weakened the Earth’s geomagnetic field. The reckless way the planet’s orbit was populated by machines and debris led to distortions in the gravity field. All this culminated in a disastrous slingshot effect for the many satellites orbiting the blue dot, altering their trajectories to loosen the direct gravity pull of the planet and scatter into deep space. Some of these satellites contained valuable data that was lost forever.  In 2621, the Council of Peace put a bounty on these ancient artifacts to integrate them into Star Atlas, leading to a hunt for them across the galaxy. One of the most sought-after satellites in history records bears the name of Neil Armstrong, the first human to set foot on the Moon.  Initially launched into medium Earth orbit as a cornerstone of the global positioning system (GPS), the satellite had untold additional capabilities that made it more and more valuable as it drifted off into the void.",
      "serumV3Usdc": "8yQzsbraXJFoPG5PdX73B8EVYFuPR9aC2axAqWearGKu"
    }
  },
  {
    "chainId": 101,
    "address": "Hfjgcs9ix17EwgXVVbKjo6NfMm2CXfr34cwty3xWARUm",
    "symbol": "TLS",
    "name": "The Last Stand",
    "decimals": 0,
    "logoURI":
        "https://raw.githubusercontent.com/solana-labs/token-list/main/assets/mainnet/Hfjgcs9ix17EwgXVVbKjo6NfMm2CXfr34cwty3xWARUm/logo.png",
    "tags": ["nft"],
    "extensions": {
      "website": "https://www.staratlas.com",
      "serumV3Usdc": "AVHndcEDUjP9Liz5dfcvAPAMffADXG6KMPn8sWB1XhFQ"
    }
  },
  {
    "chainId": 101,
    "address": "8EXX5kG7qWTjgpNSGX7PnB6hJZ8xhXUcCafVJaBEJo32",
    "symbol": "SPT",
    "name": "The Signing of the Peace Treaty",
    "decimals": 0,
    "logoURI":
        "https://raw.githubusercontent.com/solana-labs/token-list/main/assets/mainnet/8EXX5kG7qWTjgpNSGX7PnB6hJZ8xhXUcCafVJaBEJo32/logo.png",
    "tags": ["nft"],
    "extensions": {
      "website": "https://www.staratlas.com",
      "serumV3Usdc": "FZ9xhZbkt9bKKVpWmFxRhEJyzgxqU5w5xu3mXcF6Eppe"
    }
  },
  {
    "chainId": 101,
    "address": "62FWgS4XaMJrUrAYw7mHMRye4iY9hqgqnJLBiT8QyPJv",
    "symbol": "COFFEE",
    "name": "CoffeeMaker",
    "decimals": 18,
    "logoURI": "https://cdn.jsdelivr.net/gh/cofeeswap/logo/coffeev2.png",
    "tags": ["nft", "swap", "nft marketplace"],
    "extensions": {"website": "https://coffeemaker.finance"}
  },
  {
    "chainId": 101,
    "address": "CAjoJeGCCRae9oDwHYXzkeUDonp3dZLWV5GKHysLwjnx",
    "symbol": "PBA",
    "name": "The Peacebringers Archive",
    "decimals": 0,
    "logoURI":
        "https://raw.githubusercontent.com/solana-labs/token-list/main/assets/mainnet/CAjoJeGCCRae9oDwHYXzkeUDonp3dZLWV5GKHysLwjnx/logo.png",
    "tags": ["nft"],
    "extensions": {
      "website": "https://www.staratlas.com",
      "serumV3Usdc": "4jN1R453Acv9egnr7Dry3x9Xe3jqh1tqz5RokniaeVhy"
    }
  },
  {
    "chainId": 101,
    "address": "FPnwwNiL1tXqd4ZbGjFYsCw5qsQw91VN79SNcU4Bc732",
    "symbol": "UWB",
    "name": "Ustur Wod.bod",
    "decimals": 0,
    "logoURI":
        "https://raw.githubusercontent.com/solana-labs/token-list/main/assets/mainnet/FPnwwNiL1tXqd4ZbGjFYsCw5qsQw91VN79SNcU4Bc732/logo.png",
    "tags": ["nft"],
    "extensions": {
      "website": "https://www.staratlas.com",
      "serumV3Usdc": "J99HsFQEWKR3UiFQpKTnF11iaNiR1enf2LxHfgsbVc59"
    }
  },
  {
    "chainId": 101,
    "address": "DB76aiNQeLzHPwvFhzgwfpe6HGHCDTQ6snW6UD7AnHid",
    "symbol": "OMPH",
    "name": "Om Photoli",
    "decimals": 0,
    "logoURI":
        "https://raw.githubusercontent.com/solana-labs/token-list/main/assets/mainnet/DB76aiNQeLzHPwvFhzgwfpe6HGHCDTQ6snW6UD7AnHid/logo.png",
    "tags": ["nft"],
    "extensions": {
      "website": "https://www.staratlas.com",
      "serumV3Usdc": "HdvXMScwAQQh9pEvLZjuaaeJcLTmixxYoMFefeqHFn2E"
    }
  },
  {
    "chainId": 101,
    "address": "BrzwWsG845VttbTsacZMLKhyc2jAZU12MaPkTYrJHoqm",
    "symbol": "SATM",
    "name": "Star Atlas - The Movie",
    "decimals": 0,
    "logoURI":
        "https://raw.githubusercontent.com/solana-labs/token-list/main/assets/mainnet/BrzwWsG845VttbTsacZMLKhyc2jAZU12MaPkTYrJHoqm/logo.png",
    "tags": ["nft"],
    "extensions": {
      "website": "https://www.staratlas.com",
      "imageUrl":
          "https://storage.googleapis.com/nft-assets/ReBirth/poster-14/star-at-atlas-movie.jpg",
      "description":
          "“The first to arrive at the universe’s next frontier is the first to knock on the gates of prosperity.” — Ustur Armi.eldr",
      "serumV3Usdc": "KHw8L2eE6kpp8ziWPghBTtiAVCUvdSKMvGtT1e9AuJd"
    }
  },
  {
    "chainId": 101,
    "address": "8ymi88q5DtmdNTn2sPRNFkvMkszMHuLJ1e3RVdWjPa3s",
    "symbol": "SDOGE",
    "name": "SolDoge",
    "decimals": 0,
    "logoURI":
        "https://raw.githubusercontent.com/solana-labs/token-list/main/assets/mainnet/8ymi88q5DtmdNTn2sPRNFkvMkszMHuLJ1e3RVdWjPa3s/logo.png",
    "tags": [],
    "extensions": {
      "website": "https://www.soldoge.org",
      "serumV3Usdc": "9aruV2p8cRWxybx6wMsJwPFqeN7eQVPR74RrxdM3DNdu"
    }
  },
  {
    "chainId": 101,
    "address": "DQRNdQWz5NzbYgknGsZqSSXbdhQWvXSe8S56mrtNAs1b",
    "symbol": "ENTROPPP",
    "name": "ENTROPPP (Entropy for security)",
    "decimals": 6,
    "logoURI":
        "https://raw.githubusercontent.com/solana-labs/token-list/main/assets/mainnet/DQRNdQWz5NzbYgknGsZqSSXbdhQWvXSe8S56mrtNAs1b/logo.png",
    "tags": ["Cryptography", "Blockchain security", "Randomness and entropy"],
    "extensions": {"website": "https://www.entroppp.com"}
  },
  {
    "chainId": 101,
    "address": "8RYSc3rrS4X4bvBCtSJnhcpPpMaAJkXnVKZPzANxQHgz",
    "symbol": "YARD",
    "name": "SolYard Finance",
    "decimals": 9,
    "logoURI":
        "https://raw.githubusercontent.com/solana-labs/token-list/main/assets/mainnet/8RYSc3rrS4X4bvBCtSJnhcpPpMaAJkXnVKZPzANxQHgz/logo.png",
    "tags": [],
    "extensions": {"website": "https://solyard.finance/"}
  },
  {
    "chainId": 101,
    "address": "nope9HWCJcXVFkG49CDk7oYFtgGsUzsRvHdcJeL2aCL",
    "symbol": "NOPE",
    "name": "NOPE FINANCE",
    "decimals": 9,
    "logoURI":
        "https://raw.githubusercontent.com/solana-labs/token-list/main/assets/mainnet/nope9HWCJcXVFkG49CDk7oYFtgGsUzsRvHdcJeL2aCL/logo.png",
    "tags": [],
    "extensions": {"website": "https://nopefinance.xyz/"}
  },
  {
    "chainId": 101,
    "address": "43VWkd99HjqkhFTZbWBpMpRhjG469nWa7x7uEsgSH7We",
    "symbol": "STNK",
    "name": "Stonks",
    "decimals": 9,
    "logoURI":
        "https://raw.githubusercontent.com/solana-labs/token-list/main/assets/mainnet/43VWkd99HjqkhFTZbWBpMpRhjG469nWa7x7uEsgSH7We/logo.png",
    "tags": [],
    "extensions": {"website": "https://stonkscoin.org/"}
  },
  {
    "chainId": 101,
    "address": "4368jNGeNq7Tt4Vzr98UWxL647PYu969VjzAsWGVaVH2",
    "symbol": "MEAL",
    "name": "HUNGRY",
    "decimals": 8,
    "logoURI":
        "https://raw.githubusercontent.com/solana-labs/token-list/main/assets/mainnet/4368jNGeNq7Tt4Vzr98UWxL647PYu969VjzAsWGVaVH2/logo.png",
    "tags": [],
    "extensions": {"website": "https://hungrycoin.io/"}
  },
  {
    "chainId": 101,
    "address": "8GQsW3f7mdwfjqJon2myADcBsSsRjpXmxHYDG8q1pvV6",
    "symbol": "HOLD",
    "name": "Holdana",
    "decimals": 9,
    "logoURI":
        "https://raw.githubusercontent.com/solana-labs/token-list/main/assets/mainnet/8GQsW3f7mdwfjqJon2myADcBsSsRjpXmxHYDG8q1pvV6/logo.png",
    "tags": [],
    "extensions": {
      "medium": "https://holdanatoken.medium.com/",
      "twitter": "https://twitter.com/HoldanaOfficial",
      "serumV3Usdc": "G2j5zKtfymPcWMq1YRoKrfUWy64SZ6ZxDVscHSyPQqmz"
    }
  },
  {
    "chainId": 101,
    "address": "64SqEfHtu4bZ6jr1mAxaWrLFdMngbKbru9AyaG2Dyk5T",
    "symbol": "wen-token",
    "name": "wen-token",
    "decimals": 0,
    "logoURI":
        "https://raw.githubusercontent.com/solana-labs/token-list/main/assets/mainnet/64SqEfHtu4bZ6jr1mAxaWrLFdMngbKbru9AyaG2Dyk5T/logo.png",
    "tags": ["nft"],
    "extensions": {"website": "https://pythians.pyth.network"}
  },
  {
    "chainId": 101,
    "address": "9axWWN2FY8njSSQReepkiSE56U2yAvPFGuaXRQNdkZaS",
    "symbol": "wen-token-2",
    "name": "wen-token-2",
    "decimals": 0,
    "logoURI":
        "https://raw.githubusercontent.com/solana-labs/token-list/main/assets/mainnet/9axWWN2FY8njSSQReepkiSE56U2yAvPFGuaXRQNdkZaS/logo.png",
    "tags": ["nft"],
    "extensions": {"website": "https://pythians.pyth.network"}
  },
  {
    "chainId": 101,
    "address": "4dmKkXNHdgYsXqBHCuMikNQWwVomZURhYvkkX5c4pQ7y",
    "symbol": "SNY",
    "name": "Synthetify",
    "decimals": 6,
    "logoURI":
        "https://raw.githubusercontent.com/solana-labs/token-list/main/assets/mainnet/4dmKkXNHdgYsXqBHCuMikNQWwVomZURhYvkkX5c4pQ7y/logo.png",
    "tags": [],
    "extensions": {
      "website": "https://synthetify.io/",
      "twitter": "https://twitter.com/synthetify",
      "coingeckoId": "synthetify-token"
    }
  },
  {
    "chainId": 101,
    "address": "4wTMJsh3q66PmAkmwEW47qVDevMZMVVWU3n1Yhqztwi6",
    "symbol": "ARCD",
    "name": "Arcade Token (Wormhole)",
    "decimals": 9,
    "logoURI":
        "https://raw.githubusercontent.com/solana-labs/token-list/main/assets/mainnet/4wTMJsh3q66PmAkmwEW47qVDevMZMVVWU3n1Yhqztwi6/logo.png",
    "tags": ["wrapped", "wormhole"],
    "extensions": {
      "address": "0xb581E3a7dB80fBAA821AB39342E9Cbfd2ce33c23",
      "bridgeContract": "https://etherscan.io/address/0xf92cD566Ea4864356C5491c177A430C222d7e678",
      "assetContract": "https://etherscan.io/address/0xb581E3a7dB80fBAA821AB39342E9Cbfd2ce33c23",
      "website": "https://arcade.city",
      "twitter": "https://twitter.com/ArcadeCityHall"
    }
  },
  {
    "chainId": 101,
    "address": "Amt5wUJREJQC5pX7Z48YSK812xmu4j3sQVupNhtsEuY8",
    "symbol": "FROG",
    "name": "FROG",
    "decimals": 6,
    "logoURI":
        "https://raw.githubusercontent.com/solana-labs/token-list/main/assets/mainnet/Amt5wUJREJQC5pX7Z48YSK812xmu4j3sQVupNhtsEuY8/logo.png",
    "tags": [],
    "extensions": {
      "website": "https://www.froglana.com/",
      "serumV3Usdc": "2Si6XDdpv5zcvYna221eZZrsjsp5xeYoz9W1TVdMdbnt"
    }
  },
  {
    "chainId": 101,
    "address": "DEAdry5qhNoSkF3mbFrTa6udGbMwUoLnQhvchCu26Ak1",
    "symbol": "JUEL",
    "name": "Juel Token",
    "decimals": 9,
    "logoURI":
        "https://raw.githubusercontent.com/solana-labs/token-list/main/assets/mainnet/DEAdry5qhNoSkF3mbFrTa6udGbMwUoLnQhvchCu26Ak1/logo.png",
    "tags": [],
    "extensions": {"website": "http://juel.gg"}
  },
  {
    "chainId": 101,
    "address": "9Y8NT5HT9z2EsmCbYMgKXPRq3h3aa6tycEqfFiXjfZM7",
    "symbol": "CRT",
    "name": "CARROT",
    "decimals": 9,
    "logoURI":
        "https://raw.githubusercontent.com/solana-labs/token-list/main/assets/mainnet/9Y8NT5HT9z2EsmCbYMgKXPRq3h3aa6tycEqfFiXjfZM7/logo.png",
    "tags": [],
    "extensions": {
      "website": "https://farmerscarrot.com/",
      "serumV3Usdc": "Aa8mN8bXAobmcuHDpbbZh55SoadUry6WdsYz2886Ymqf"
    }
  },
  {
    "chainId": 101,
    "address": "AMdnw9H5DFtQwZowVFr4kUgSXJzLokKSinvgGiUoLSps",
    "symbol": "MOLA",
    "name": "MOONLANA",
    "decimals": 9,
    "logoURI":
        "https://raw.githubusercontent.com/solana-labs/token-list/main/assets/mainnet/AMdnw9H5DFtQwZowVFr4kUgSXJzLokKSinvgGiUoLSps/logo.png",
    "tags": [],
    "extensions": {
      "website": "https://moonlana.com/",
      "twitter": "https://twitter.com/xMoonLana",
      "medium": "https://moonlana.medium.com/",
      "coingeckoId": "moonlana"
    }
  },
  {
    "chainId": 101,
    "address": "3x7UeXDF4imKSKnizK9mYyx1M5bTNzpeALfPeB8S6XT9",
    "symbol": "SKEM",
    "name": "SKEM",
    "decimals": 9,
    "logoURI":
        "https://raw.githubusercontent.com/solana-labs/token-list/main/assets/mainnet/3x7UeXDF4imKSKnizK9mYyx1M5bTNzpeALfPeB8S6XT9/logo.svg",
    "tags": [],
    "extensions": {
      "website": "https://skem.finance/",
      "serumV3Usdc": "HkYJ3dX8CLSGyGZzfuqYiuoDjDmrDiu1vZhPtFJZa5Vt"
    }
  },
  {
    "chainId": 101,
    "address": "GHvFFSZ9BctWsEc5nujR1MTmmJWY7tgQz2AXE6WVFtGN",
    "symbol": "SOLAPE",
    "name": "SolAPE Token",
    "decimals": 9,
    "logoURI":
        "https://raw.githubusercontent.com/solana-labs/token-list/main/assets/mainnet/GHvFFSZ9BctWsEc5nujR1MTmmJWY7tgQz2AXE6WVFtGN/logo.png",
    "tags": ["utility-token"],
    "extensions": {
      "coingeckoId": "solape-token",
      "website": "https://solape.io",
      "twitter": "https://twitter.com/SolApeFinance",
      "serumV3Usdc": "4zffJaPyeXZ2wr4whHgP39QyTfurqZ2BEd4M5W6SEuon"
    }
  },
  {
    "chainId": 101,
    "address": "9nEqaUcb16sQ3Tn1psbkWqyhPdLmfHWjKGymREjsAgTE",
    "symbol": "WOOF",
    "name": "WOOFENOMICS",
    "decimals": 6,
    "logoURI":
        "https://raw.githubusercontent.com/solana-labs/token-list/main/assets/mainnet/9nEqaUcb16sQ3Tn1psbkWqyhPdLmfHWjKGymREjsAgTE/logo.png",
    "tags": [],
    "extensions": {
      "website": "https://woofsolana.com",
      "serumV3Usdc": "CwK9brJ43MR4BJz2dwnDM7EXCNyHhGqCJDrAdsEts8n5"
    }
  },
  {
    "chainId": 101,
    "address": "MERt85fc5boKw3BW1eYdxonEuJNvXbiMbs6hvheau5K",
    "symbol": "MER",
    "name": "Mercurial",
    "decimals": 6,
    "logoURI":
        "https://raw.githubusercontent.com/solana-labs/token-list/main/assets/mainnet/MERt85fc5boKw3BW1eYdxonEuJNvXbiMbs6hvheau5K/logo.png",
    "tags": [],
    "extensions": {
      "coingeckoId": "mercurial",
      "website": "https://www.mercurial.finance/",
      "serumV3Usdc": "G4LcexdCzzJUKZfqyVDQFzpkjhB1JoCNL8Kooxi9nJz5",
      "waterfallbot": "https://bit.ly/MERwaterfall"
    }
  },
  {
    "chainId": 101,
    "address": "9MhNoxy1PbmEazjPo9kiZPCcG7BiFbhi3bWZXZgacfpp",
    "symbol": "ACMN",
    "name": "ACUMEN",
    "decimals": 9,
    "logoURI":
        "https://raw.githubusercontent.com/solana-labs/token-list/main/assets/mainnet/9MhNoxy1PbmEazjPo9kiZPCcG7BiFbhi3bWZXZgacfpp/logo.png",
    "tags": [],
    "extensions": {"website": "https://acumen.network/"}
  },
  {
    "chainId": 101,
    "address": "HRhCiCe8WLC4Jsy43Jkhq3poEWpjgXKD1U26XACReimt",
    "symbol": "zSOL",
    "name": "zSOL (ACUMEN)",
    "decimals": 9,
    "logoURI":
        "https://raw.githubusercontent.com/solana-labs/token-list/main/assets/mainnet/HRhCiCe8WLC4Jsy43Jkhq3poEWpjgXKD1U26XACReimt/logo.png",
    "tags": [],
    "extensions": {"website": "https://acumen.network/"}
  },
  {
    "chainId": 101,
    "address": "2LBYxD4Jzipk1bEREW6vQk163cj27mUSxmHzW2ujXFNy",
    "symbol": "zUSDC",
    "name": "zUSDC (ACUMEN)",
    "decimals": 6,
    "logoURI":
        "https://raw.githubusercontent.com/solana-labs/token-list/main/assets/mainnet/2LBYxD4Jzipk1bEREW6vQk163cj27mUSxmHzW2ujXFNy/logo.png",
    "tags": [],
    "extensions": {"website": "https://acumen.network/"}
  },
  {
    "chainId": 101,
    "address": "DFTZmEopSWrj6YcsmQAAxypN7cHM3mnruEisJPQFJbs7",
    "symbol": "zBTC",
    "name": "zBTC (ACUMEN)",
    "decimals": 6,
    "logoURI":
        "https://raw.githubusercontent.com/solana-labs/token-list/main/assets/mainnet/DFTZmEopSWrj6YcsmQAAxypN7cHM3mnruEisJPQFJbs7/logo.png",
    "tags": [],
    "extensions": {"website": "https://acumen.network/"}
  },
  {
    "chainId": 101,
    "address": "A8pnvbKWmTjjnUMzmY6pDJRHy3QdQNdqJdL1VFYXX4oW",
    "symbol": "zETH",
    "name": "zETH (ACUMEN)",
    "decimals": 6,
    "logoURI":
        "https://raw.githubusercontent.com/solana-labs/token-list/main/assets/mainnet/A8pnvbKWmTjjnUMzmY6pDJRHy3QdQNdqJdL1VFYXX4oW/logo.png",
    "tags": [],
    "extensions": {"website": "https://acumen.network/"}
  },
  {
    "chainId": 101,
    "address": "9hZt5mP139TvzDBZHtruXxAyjYHiovKXfxW6XNYiofae",
    "symbol": "zSRM",
    "name": "zSRM (ACUMEN)",
    "decimals": 6,
    "logoURI":
        "https://raw.githubusercontent.com/solana-labs/token-list/main/assets/mainnet/9hZt5mP139TvzDBZHtruXxAyjYHiovKXfxW6XNYiofae/logo.png",
    "tags": [],
    "extensions": {"website": "https://acumen.network/"}
  },
  {
    "chainId": 101,
    "address": "BR31LZKtry5tyjVtZ49PFZoZjtE5SeS4rjVMuL9Xiyer",
    "symbol": "zSTEP",
    "name": "zSTEP (ACUMEN)",
    "decimals": 9,
    "logoURI":
        "https://raw.githubusercontent.com/solana-labs/token-list/main/assets/mainnet/BR31LZKtry5tyjVtZ49PFZoZjtE5SeS4rjVMuL9Xiyer/logo.png",
    "tags": [],
    "extensions": {"website": "https://acumen.network/"}
  },
  {
    "chainId": 101,
    "address": "7wZsSyzD4Ba8ZkPhRh62KshQc8TQYiB5KtdNknywE3k4",
    "symbol": "zRAY",
    "name": "zRAY (ACUMEN)",
    "decimals": 6,
    "logoURI":
        "https://raw.githubusercontent.com/solana-labs/token-list/main/assets/mainnet/BR31LZKtry5tyjVtZ49PFZoZjtE5SeS4rjVMuL9Xiyer/logo.png",
    "tags": [],
    "extensions": {"website": "https://acumen.network/"}
  },
  {
    "chainId": 101,
    "address": "EfLvzNsqmkoSneiML5t7uHCPEVRaWCpG4N2WsS39nWCU",
    "symbol": "MUDLEY",
    "name": "MUDLEY",
    "decimals": 9,
    "logoURI":
        "https://raw.githubusercontent.com/solana-labs/token-list/main/assets/mainnet/EfLvzNsqmkoSneiML5t7uHCPEVRaWCpG4N2WsS39nWCU/logo.png",
    "tags": [],
    "extensions": {"website": "https://www.mudley.io/"}
  },
  {
    "chainId": 101,
    "address": "GpYMp8eP3HADY8x1jLVfFVBVYqxFNxT5mFhZAZt9Poco",
    "symbol": "CAPE",
    "name": "Crazy Ape Coin",
    "decimals": 9,
    "logoURI":
        "https://raw.githubusercontent.com/solana-labs/token-list/main/assets/mainnet/GpYMp8eP3HADY8x1jLVfFVBVYqxFNxT5mFhZAZt9Poco/logo.png",
    "tags": [],
    "extensions": {"website": "https://www.crazyapecoin.com/"}
  },
  {
    "chainId": 101,
    "address": "7ApYvMWwHJSgWz9BvMuNzqzUAqYbxByjzZu31t8FkYDy",
    "symbol": "SFairy",
    "name": "Fairy Finance",
    "decimals": 9,
    "logoURI": "https://raw.githubusercontent.com/debianos1/logo-token/main/fairyfinane%20.png",
    "tags": [],
    "extensions": {"twitter": "https://twitter.com/fairy_finance"}
  },
  {
    "chainId": 101,
    "address": "7Csho7qjseDjgX3hhBxfwP1W3LYARK3QH3PM2x55we14",
    "symbol": "LOTTO",
    "name": "Lotto",
    "decimals": 6,
    "logoURI":
        "https://raw.githubusercontent.com/solana-labs/token-list/main/assets/mainnet/7Csho7qjseDjgX3hhBxfwP1W3LYARK3QH3PM2x55we14/logo.png",
    "tags": [],
    "extensions": {
      "serumV3Usdc": "9MZKfgZzPgeidAukYpHtsLYm4eAdJFnR7nhPosWT8jiv",
      "coingeckoId": "lotto",
      "website": "lotto.finance",
      "address": "0xb0dfd28d3cf7a5897c694904ace292539242f858",
      "assetContract": "https://etherscan.io/address/0xb0dfd28d3cf7a5897c694904ace292539242f858",
      "tggroup": "https://t.me/lottofinance"
    }
  },
  {
    "chainId": 101,
    "address": "7uv3ZvZcQLd95bUp5WMioxG7tyAZVXFfr8JYkwhMYrnt",
    "symbol": "BOLE",
    "name": "Bole Token",
    "decimals": 4,
    "logoURI":
        "https://raw.githubusercontent.com/solana-labs/token-list/main/assets/mainnet/7uv3ZvZcQLd95bUp5WMioxG7tyAZVXFfr8JYkwhMYrnt/logo.png",
    "tags": [],
    "extensions": {
      "website": "https://tokenbole.com/",
      "serumV3Usdc": "9yGqsboBtvztDgGbGFEaBBT2G8dUMhxewXDQpy6T3eDm",
      "coingeckoId": "bole-token"
    }
  },
  {
    "chainId": 101,
    "address": "7Qbjc2DZ6K2t6NtQhQnJfsi9V2Aa2KSmKyWZZEdfTXsT",
    "symbol": "XTAG",
    "name": "XTAG",
    "decimals": 9,
    "logoURI": "https://pbs.twimg.com/profile_images/1422971633048834054/PqdED5l7.png",
    "tags": [],
    "extensions": {
      "website": "https://www.xhashtag.io/",
      "medium": "https://medium.com/xhashtag",
      "twitter": "https://twitter.com/xhashtagio"
    }
  },
  {
    "chainId": 101,
    "address": "Bxp46xCB6CLjiqE99QaTcJAaY1hYF1o63DUUrXAS7QFu",
    "symbol": "mBRZ",
    "name": "SolMiner Bronze",
    "decimals": 9,
    "logoURI":
        "https://raw.githubusercontent.com/solana-labs/token-list/main/assets/mainnet/Bxp46xCB6CLjiqE99QaTcJAaY1hYF1o63DUUrXAS7QFu/logo.png",
    "tags": [],
    "extensions": {
      "website": "https://solminer.app",
      "medium": "https://solminer.medium.com/",
      "twitter": "https://twitter.com/SolMinerproject"
    }
  },
  {
    "chainId": 101,
    "address": "GZNrMEdrt6Vg428JzvJYRGGPpVxgjUPsg6WLqKBvmNLw",
    "symbol": "mPLAT",
    "name": "SolMiner Platinum",
    "decimals": 9,
    "logoURI":
        "https://raw.githubusercontent.com/solana-labs/token-list/main/assets/mainnet/GZNrMEdrt6Vg428JzvJYRGGPpVxgjUPsg6WLqKBvmNLw/logo.png",
    "tags": [],
    "extensions": {
      "website": "https://solminer.app",
      "medium": "https://solminer.medium.com/",
      "twitter": "https://twitter.com/SolMinerproject"
    }
  },
  {
    "chainId": 101,
    "address": "Er7a3ugS6kkAqj6sp3UmXEFAFrDdLMRQEkV9QH2fwRYA",
    "symbol": "mDIAM",
    "name": "SolMiner Diamond",
    "decimals": 9,
    "logoURI":
        "https://raw.githubusercontent.com/solana-labs/token-list/main/assets/mainnet/Er7a3ugS6kkAqj6sp3UmXEFAFrDdLMRQEkV9QH2fwRYA/logo.png",
    "tags": [],
    "extensions": {
      "website": "https://solminer.app",
      "medium": "https://solminer.medium.com/",
      "twitter": "https://twitter.com/SolMinerproject"
    }
  },
  {
    "chainId": 101,
    "address": "5JnZ667P3VcjDinkJFysWh2K2KtViy63FZ3oL5YghEhW",
    "symbol": "APYS",
    "name": "APYSwap",
    "decimals": 9,
    "logoURI":
        "https://raw.githubusercontent.com/solana-labs/token-list/main/assets/mainnet/5JnZ667P3VcjDinkJFysWh2K2KtViy63FZ3oL5YghEhW/logo.png",
    "tags": ["wrapped"],
    "extensions": {"website": "https://apyswap.com", "coingeckoId": "apyswap"}
  },
  {
    "chainId": 101,
    "address": "ss1gxEUiufJyumsXfGbEwFe6maraPmc53fqbnjbum15",
    "symbol": "SS1",
    "name": "Naked Shorts",
    "decimals": 0,
    "logoURI":
        "https://raw.githubusercontent.com/solana-labs/token-list/main/assets/mainnet/ss1gxEUiufJyumsXfGbEwFe6maraPmc53fqbnjbum15/logo.png",
    "tags": ["nft"],
    "extensions": {
      "website": "https://www.sol-talk.com/sol-survivor",
      "twitter": "https://twitter.com/sol__survivor",
      "imageUrl": "https://www.arweave.net/N-RGNyi1o1evhr7jTCXxHQlSndNPdnHWEzUTbTGMCl4",
      "animationUrl": "https://www.arweave.net/KBzRUmQNX6VKDH41N_uOETtJH21YtWXrOz270b8eqyo?ext=glb",
      "description":
          "After a gamma squeeze event he was left covered in theta. Due to the accident he lost his memories but gained the ability to refract light. He joins the tournament hoping to discover more about his past. His only clue is a damaged ID card with the word Malvin inscribed. Special: 'Now You See Me'"
    }
  },
  {
    "chainId": 101,
    "address": "GfJ3Vq2eSTYf1hJP6kKLE9RT6u7jF9gNszJhZwo5VPZp",
    "symbol": "SOLPAD",
    "name": "Solpad Finance",
    "decimals": 9,
    "logoURI":
        "https://raw.githubusercontent.com/solana-labs/token-list/main/assets/mainnet/GfJ3Vq2eSTYf1hJP6kKLE9RT6u7jF9gNszJhZwo5VPZp/logo.png",
    "tags": ["utility-token"],
    "extensions": {
      "website": "https://www.solpad.finance/",
      "twitter": "https://twitter.com/FinanceSolpad",
      "github": "https://github.com/solpad-finance",
      "tgann": "https://t.me/solpadfinance",
      "tggroup": "https://t.me/solpadfinance_chat"
    }
  },
  {
    "chainId": 101,
    "address": "ERPueLaiBW48uBhqX1CvCYBv2ApHN6ZFuME1MeQGTdAi",
    "symbol": "MIT",
    "name": "Muskimum Impact Token",
    "decimals": 8,
    "logoURI":
        "https://raw.githubusercontent.com/solana-labs/token-list/main/assets/mainnet/ERPueLaiBW48uBhqX1CvCYBv2ApHN6ZFuME1MeQGTdAi/logo.png",
    "tags": ["mit", "musk"],
    "extensions": {
      "website": "https://muskimum.win/",
      "twitter": "https://twitter.com/muskimum",
      "serumV3Usdc": "3mhrhTFrHtxe7uZhvzBhzneR3bD3hDyWcgEkR8EcvNZk"
    }
  },
  {
    "chainId": 101,
    "address": "BsDrXiQaFd147Fxq1fQYbJQ77P6tmPkRJQJzkKvspDKo",
    "symbol": "SOLA",
    "name": "SolaPAD Token (deprecated)",
    "decimals": 8,
    "logoURI":
        "https://raw.githubusercontent.com/solana-labs/token-list/main/assets/mainnet/BsDrXiQaFd147Fxq1fQYbJQ77P6tmPkRJQJzkKvspDKo/logo.png",
    "tags": ["SOLA", "LaunchPAD"],
    "extensions": {"website": "https://www.solapad.org/", "twitter": "https://twitter.com/SolaPAD"}
  },
  {
    "chainId": 101,
    "address": "7fCzz6ZDHm4UWC9Se1RPLmiyeuQ6kStxpcAP696EuE1E",
    "symbol": "SHBL",
    "name": "Shoebill Coin",
    "decimals": 9,
    "logoURI":
        "https://raw.githubusercontent.com/solana-labs/token-list/main/assets/mainnet/7fCzz6ZDHm4UWC9Se1RPLmiyeuQ6kStxpcAP696EuE1E/logo.png",
    "tags": [],
    "extensions": {"website": "https://shoebillco.in/"}
  },
  {
    "chainId": 101,
    "address": "GnaFnTihwQFjrLeJNeVdBfEZATMdaUwZZ1RPxLwjbVwb",
    "symbol": "SHBL-USDC",
    "name": "Raydium Permissionless LP Token (SHBL-USDC)",
    "decimals": 9,
    "logoURI":
        "https://raw.githubusercontent.com/solana-labs/token-list/main/assets/mainnet/GnaFnTihwQFjrLeJNeVdBfEZATMdaUwZZ1RPxLwjbVwb/logo.png",
    "tags": ["lp-token"],
    "extensions": {"website": "https://raydium.io/"}
  },
  {
    "chainId": 101,
    "address": "Djoz8btdR7p6xWHoVtPYF3zyN9LU5BBfMoDk4HczSDqc",
    "symbol": "AUSS",
    "name": "Ausshole",
    "decimals": 9,
    "logoURI":
        "https://raw.githubusercontent.com/solana-labs/token-list/main/assets/mainnet/Djoz8btdR7p6xWHoVtPYF3zyN9LU5BBfMoDk4HczSDqc/logo.svg",
    "tags": [],
    "extensions": {
      "website": "https://auss.finance/",
      "twitter": "https://twitter.com/ausstoken",
      "serumV3Usdc": "bNbYoc2KawipbXj76BiXbUdf2NcGKWkdp4S9uDvWXB1"
    }
  },
  {
    "chainId": 101,
    "address": "TuLipcqtGVXP9XR62wM8WWCm6a9vhLs7T1uoWBk6FDs",
    "symbol": "TULIP",
    "name": "Tulip",
    "decimals": 6,
    "logoURI":
        "https://raw.githubusercontent.com/solana-labs/token-list/main/assets/mainnet/TuLipcqtGVXP9XR62wM8WWCm6a9vhLs7T1uoWBk6FDs/logo.svg",
    "tags": ["tulip", "solfarm", "vaults"],
    "extensions": {
      "website": "https://solfarm.io",
      "twitter": "https://twitter.com/Solfarmio",
      "coingeckoId": "solfarm",
      "serumV3Usdc": "8GufnKq7YnXKhnB3WNhgy5PzU9uvHbaaRrZWQK6ixPxW",
      "waterfallbot": "https://bit.ly/TULIPwaterfall"
    }
  },
  {
    "chainId": 101,
    "address": "5trVBqv1LvHxiSPMsHtEZuf8iN82wbpDcR5Zaw7sWC3s",
    "symbol": "JPYC",
    "name": "JPY Coin(Sollet)(Deprecated)",
    "decimals": 6,
    "logoURI":
        "https://raw.githubusercontent.com/solana-labs/token-list/main/assets/mainnet/5trVBqv1LvHxiSPMsHtEZuf8iN82wbpDcR5Zaw7sWC3s/logo.png",
    "tags": ["stablecoin", "ethereum", "wrapped-sollet"],
    "extensions": {"website": "https://jpyc.jp/"}
  },
  {
    "chainId": 101,
    "address": "3QuAYThYKFXSmrTcSHsdd7sAxaFBobaCkLy2DBYJLMDs",
    "symbol": "TYNA",
    "name": "wTYNA",
    "decimals": 3,
    "logoURI":
        "https://raw.githubusercontent.com/solana-labs/token-list/main/assets/mainnet/3QuAYThYKFXSmrTcSHsdd7sAxaFBobaCkLy2DBYJLMDs/logo.png",
    "tags": ["ERC20", "ethereum"],
    "extensions": {
      "address": "0x4ae54790c130B21E8CbaCAB011C6170e079e6eF5",
      "bridgeContract": "https://etherscan.io/address/0xeae57ce9cc1984f202e15e038b964bb8bdf7229a",
      "assetContract": "https://etherscan.io/address/0x4ae54790c130B21E8CbaCAB011C6170e079e6eF5",
      "website": "http://lendingbot.s3-website-us-east-1.amazonaws.com/whitepaper.html",
      "twitter": "https://twitter.com/btc_AP"
    }
  },
  {
    "chainId": 101,
    "address": "7zsKqN7Fg2s9VsqAq6XBoiShCVohpGshSUvoWBc6jKYh",
    "symbol": "ARDX",
    "name": "Wrapped ArdCoin (Sollet)",
    "decimals": 2,
    "logoURI":
        "https://raw.githubusercontent.com/solana-labs/token-list/main/assets/mainnet/7zsKqN7Fg2s9VsqAq6XBoiShCVohpGshSUvoWBc6jKYh/logo.png",
    "tags": ["wrapped-sollet", "ethereum"],
    "extensions": {"website": "https://ardcoin.com", "coingeckoId": "ardcoin"}
  },
  {
    "chainId": 101,
    "address": "7zphtJVjKyECvQkdfxJNPx83MNpPT6ZJyujQL8jyvKcC",
    "symbol": "SSHIB",
    "name": "SolShib",
    "decimals": 9,
    "logoURI":
        "https://raw.githubusercontent.com/solana-labs/token-list/main/assets/mainnet/7zphtJVjKyECvQkdfxJNPx83MNpPT6ZJyujQL8jyvKcC/logo.png",
    "tags": [],
    "extensions": {"website": "https://solshib.com/"}
  },
  {
    "chainId": 101,
    "address": "HoSWnZ6MZzqFruS1uoU69bU7megzHUv6MFPQ5nqC6Pj2",
    "symbol": "SGI",
    "name": "SolGift",
    "decimals": 9,
    "logoURI":
        "https://raw.githubusercontent.com/solana-labs/token-list/main/assets/mainnet/HoSWnZ6MZzqFruS1uoU69bU7megzHUv6MFPQ5nqC6Pj2/logo.png",
    "tags": [],
    "extensions": {"website": "https://solshib.com/"}
  },
  {
    "chainId": 101,
    "address": "GpS9AavHtSUspaBnL1Tu26FWbUAdW8tm3MbacsNvwtGu",
    "symbol": "SOLT",
    "name": "Soltriever",
    "decimals": 9,
    "logoURI":
        "https://raw.githubusercontent.com/solana-labs/token-list/main/assets/mainnet/GpS9AavHtSUspaBnL1Tu26FWbUAdW8tm3MbacsNvwtGu/logo.png",
    "tags": [],
    "extensions": {
      "website": "http://soltriever.info/",
      "twitter": "https://twitter.com/_Soltriever"
    }
  },
  {
    "chainId": 101,
    "address": "2QK9vxydd7WoDwvVFT5JSU8cwE9xmbJSzeqbRESiPGMG",
    "symbol": "KEKW",
    "name": "kekwcoin",
    "decimals": 9,
    "logoURI":
        "https://raw.githubusercontent.com/solana-labs/token-list/main/assets/mainnet/2QK9vxydd7WoDwvVFT5JSU8cwE9xmbJSzeqbRESiPGMG/logo.png",
    "tags": [],
    "extensions": {
      "website": "https://kekw.io/",
      "twitter": "https://twitter.com/kekwcoin",
      "medium": "https://kekwcoin.medium.com/",
      "discord": "discord.gg/kekw",
      "description":
          "Kekwcoin is a creative community platform for content creators to monetize their artwork and get financial support from investors.",
      "serumV3Usdc": "N99ngemA29qSKqdDW7kRiZHS7h2wEFpdgRvgE3N2jy6"
    }
  },
  {
    "chainId": 101,
    "address": "qs9Scx8YwNXS6zHYPCnDnyHQcRHg3QwXxpyCXs5tdM8",
    "symbol": "POCO",
    "name": "POWER COIN",
    "decimals": 9,
    "logoURI":
        "https://raw.githubusercontent.com/solana-labs/token-list/main/assets/mainnet/qs9Scx8YwNXS6zHYPCnDnyHQcRHg3QwXxpyCXs5tdM8/logo.png",
    "tags": ["social-token", "poco"]
  },
  {
    "chainId": 101,
    "address": "FxCvbCVAtNUEKSiKoF6xt2pWPfpXuYFWYbuQySaRnV5R",
    "symbol": "LOOP",
    "name": "LC Andy Social Token",
    "decimals": 9,
    "logoURI":
        "https://raw.githubusercontent.com/solana-labs/token-list/main/assets/mainnet/FxCvbCVAtNUEKSiKoF6xt2pWPfpXuYFWYbuQySaRnV5R/logo.png",
    "tags": ["social-token", "loop"]
  },
  {
    "chainId": 101,
    "address": "3iXydLpqi38CeGDuLFF1WRbPrrkNbUsgVf98cNSg6NaA",
    "symbol": "Spro",
    "name": "Sproken Token",
    "decimals": 9,
    "logoURI": "https://cdn.jsdelivr.net/gh/kechricc/Sproken-Token-Logo/SprokenToken.png",
    "tags": ["Sprocket Token", "Mini Aussie", "Currency of the Sprokonomy"],
    "extensions": {"website": "https://www.sprokentoken.com/"}
  },
  {
    "chainId": 101,
    "address": "H5gczCNbrtso6BqGKihF97RaWaxpUEZnFuFUKK4YX3s2",
    "symbol": "BDE",
    "name": "Big Defi Energy",
    "decimals": 9,
    "logoURI":
        "https://raw.githubusercontent.com/solana-labs/token-list/main/assets/mainnet/H5gczCNbrtso6BqGKihF97RaWaxpUEZnFuFUKK4YX3s2/logo.png",
    "tags": [],
    "extensions": {"website": "bigdefienergy.com", "twitter": "https://twitter.com/Bigdefi"}
  },
  {
    "chainId": 101,
    "address": "cREsCN7KAyXcBG2xZc8qrfNHMRgC3MhTb4n3jBnNysv",
    "symbol": "DWT",
    "name": "DARK WEB TOKEN",
    "decimals": 2,
    "logoURI":
        "https://raw.githubusercontent.com/solana-labs/token-list/main/assets/mainnet/cREsCN7KAyXcBG2xZc8qrfNHMRgC3MhTb4n3jBnNysv/logo.png",
    "tags": ["MEME"],
    "extensions": {
      "serumV3Usdc": "526WW289h5wibg1Q55sK16CGoNip8H5d2AXVbaAGcUMb",
      "website": "https://www.darkwebtoken.live"
    }
  },
  {
    "chainId": 101,
    "address": "EdGAZ8JyFTFbmVedVTbaAEQRb6bxrvi3AW3kz8gABz2E",
    "symbol": "DOGA",
    "name": "Dogana",
    "decimals": 9,
    "logoURI":
        "https://raw.githubusercontent.com/solana-labs/token-list/main/assets/mainnet/EdGAZ8JyFTFbmVedVTbaAEQRb6bxrvi3AW3kz8gABz2E/logo.png",
    "tags": [],
    "extensions": {
      "twitter": "https://twitter.com/DoganaOfficial",
      "serumV3Usdc": "H1Ywt7nSZkLDb2o3vpA5yupnBc9jr1pXtdjMm4Jgk1ay"
    }
  },
  {
    "chainId": 101,
    "address": "3FoUAsGDbvTD6YZ4wVKJgTB76onJUKz7GPEBNiR5b8wc",
    "symbol": "CHEEMS",
    "name": "Cheems",
    "decimals": 4,
    "logoURI":
        "https://raw.githubusercontent.com/solana-labs/token-list/main/assets/mainnet/3FoUAsGDbvTD6YZ4wVKJgTB76onJUKz7GPEBNiR5b8wc/logo.png",
    "tags": [],
    "extensions": {
      "website": "https://cheems.co/",
      "twitter": "https://twitter.com/theCheemsToken",
      "serumV3Usdc": "5WVBCaUPZF4HP3io9Z56N71cPMJt8qh3c4ZwSjRDeuut",
      "coingeckoId": "cheems"
    }
  },
  {
    "chainId": 101,
    "address": "AWW5UQfMBnPsTaaxCK7cSEmkj1kbX2zUrqvgKXStjBKx",
    "symbol": "SBFC",
    "name": "SBF Coin",
    "decimals": 6,
    "logoURI":
        "https://raw.githubusercontent.com/solana-labs/token-list/main/assets/mainnet/AWW5UQfMBnPsTaaxCK7cSEmkj1kbX2zUrqvgKXStjBKx/logo.png",
    "tags": ["utility-token", "SBF", "sbfcoin", "SBFC"],
    "extensions": {"website": "https://www.sbfcoin.org/", "twitter": "https://twitter.com/sbfcoin"}
  },
  {
    "chainId": 101,
    "address": "FRbqQnbuLoMbUG4gtQMeULgCDHyY6YWF9NRUuLa98qmq",
    "symbol": "ECOP",
    "name": "EcoPoo",
    "decimals": 0,
    "logoURI":
        "https://raw.githubusercontent.com/solana-labs/token-list/main/assets/mainnet/FRbqQnbuLoMbUG4gtQMeULgCDHyY6YWF9NRUuLa98qmq/logo.png",
    "tags": ["meme"],
    "extensions": {"twitter": "https://twitter.com/EcoPoo_Official"}
  },
  {
    "chainId": 101,
    "address": "5p2zjqCd1WJzAVgcEnjhb9zWDU7b9XVhFhx4usiyN7jB",
    "symbol": "CATO",
    "name": "CATO",
    "decimals": 9,
    "logoURI":
        "https://raw.githubusercontent.com/solana-labs/token-list/main/assets/mainnet/5p2zjqCd1WJzAVgcEnjhb9zWDU7b9XVhFhx4usiyN7jB/logo.png",
    "tags": ["Meme-Token"],
    "extensions": {
      "website": "https://official.catodex.com",
      "twitter": "https://twitter.com/SolanaCATO",
      "telegram": "https://t.me/SolanaCATO",
      "serumV3Usdc": "9fe1MWiKqUdwift3dEpxuRHWftG72rysCRHbxDy6i9xB",
      "coingeckoId": "cato"
    }
  },
  {
    "chainId": 101,
    "address": "J81fW7aza8wVUG1jjzhExsNMs3MrzwT5WrofgFqMjnSA",
    "symbol": "TOM",
    "name": "Tombili",
    "decimals": 9,
    "logoURI":
        "https://raw.githubusercontent.com/solana-labs/token-list/main/assets/mainnet/J81fW7aza8wVUG1jjzhExsNMs3MrzwT5WrofgFqMjnSA/logo.png",
    "tags": [],
    "extensions": {
      "website": "https://cryptomindex.com",
      "twitter": "https://twitter.com/cryptomindex"
    }
  },
  {
    "chainId": 101,
    "address": "GunpHq4fn9gSSyGbPMYXTzs9nBS8RY88CX1so4V8kCiF",
    "symbol": "FABLE",
    "name": "Fable",
    "decimals": 0,
    "logoURI":
        "https://raw.githubusercontent.com/solana-labs/token-list/main/assets/mainnet/GunpHq4fn9gSSyGbPMYXTzs9nBS8RY88CX1so4V8kCiF/logo.png",
    "tags": [],
    "extensions": {
      "website": "https://fable.finance",
      "twitter": "https://twitter.com/fable_finance"
    }
  },
  {
    "chainId": 101,
    "address": "6L5DzH3p1t1PrCrVkudasuUnWbK7Jq9tYwcwWQiV6yd7",
    "symbol": "LZD",
    "name": "Lizard",
    "decimals": 6,
    "logoURI":
        "https://raw.githubusercontent.com/solana-labs/token-list/main/assets/mainnet/6L5DzH3p1t1PrCrVkudasuUnWbK7Jq9tYwcwWQiV6yd7/logo.png",
    "tags": [],
    "extensions": {"website": "https://www.lzdsol.io", "twitter": "https://twitter.com/lzd_sol"}
  },
  {
    "chainId": 101,
    "address": "EZqcdU8RLu9EChZgrY2BNVg8eovfdGyTiY2bd69EsPgQ",
    "symbol": "FELON",
    "name": "FuckElon",
    "decimals": 9,
    "logoURI":
        "https://raw.githubusercontent.com/solana-labs/token-list/main/assets/mainnet/EZqcdU8RLu9EChZgrY2BNVg8eovfdGyTiY2bd69EsPgQ/logo.png",
    "tags": [],
    "extensions": {
      "website": "https://fuckelonmusk.godaddysites.com/",
      "twitter": "https://twitter.com/FuckElonMusk8",
      "tgann": "https://t.me/fuckelonmusktoday",
      "tggroup": "https://t.me/joinchat/cgUOCIRSTJ9hZmY1"
    }
  },
  {
    "chainId": 101,
    "address": "HBHMiauecxer5FCzPeXgE2A8ZCf7fQgxxwo4vfkFtC7s",
    "symbol": "SLNDN",
    "name": "Solanadon",
    "decimals": 9,
    "logoURI":
        "https://raw.githubusercontent.com/solana-labs/token-list/main/assets/mainnet/HBHMiauecxer5FCzPeXgE2A8ZCf7fQgxxwo4vfkFtC7s/logo.png",
    "tags": [],
    "extensions": {
      "website": "https://solanadon.com/",
      "twitter": "https://twitter.com/SolanadonCoin",
      "tgann": "https://t.me/solanadonann"
    }
  },
  {
    "chainId": 101,
    "address": "GReBHpMgCadZRij4B111c94cqU9TktvJ45rWZRQ5b1A5",
    "symbol": "PINGU",
    "name": "Penguincoin",
    "decimals": 9,
    "logoURI":
        "https://raw.githubusercontent.com/solana-labs/token-list/main/assets/mainnet/GReBHpMgCadZRij4B111c94cqU9TktvJ45rWZRQ5b1A5/logo.png",
    "tags": [],
    "extensions": {"twitter": "https://twitter.com/penguincoin1"}
  },
  {
    "chainId": 101,
    "address": "5WUab7TCvth43Au5vk6wKjchTzWFeyPEUSJE1MPJtTZE",
    "symbol": "KEKN1",
    "name": "KEKW In Solana Tripping",
    "decimals": 0,
    "logoURI":
        "https://raw.githubusercontent.com/solana-labs/token-list/main/assets/mainnet/5WUab7TCvth43Au5vk6wKjchTzWFeyPEUSJE1MPJtTZE/logo.png",
    "tags": ["nft"],
    "extensions": {"website": "https://www.kekw.io/", "twitter": "https://twitter.com/kekwcoin"}
  },
  {
    "chainId": 101,
    "address": "9KEe6o1jRTqFDFBo2AezsskcxBNwuq1rVeVat1Td8zbV",
    "symbol": "MPAD",
    "name": "MercuryPAD Token",
    "decimals": 9,
    "logoURI":
        "https://raw.githubusercontent.com/solana-labs/token-list/main/assets/mainnet/9KEe6o1jRTqFDFBo2AezsskcxBNwuq1rVeVat1Td8zbV/logo.png",
    "tags": ["MPAD", "LaunchPAD"],
    "extensions": {
      "website": "https://mercurypad.com/",
      "twitter": "https://twitter.com/MercuryPad"
    }
  },
  {
    "chainId": 101,
    "address": "4KAFf8ZpNCn1SWLZFo5tbeZsKpVemsobbVZdERWxRvd2",
    "symbol": "SGT",
    "name": "Sangga Token",
    "decimals": 8,
    "logoURI":
        "https://raw.githubusercontent.com/solana-labs/token-list/main/assets/mainnet/4KAFf8ZpNCn1SWLZFo5tbeZsKpVemsobbVZdERWxRvd2/logo.png",
    "tags": [],
    "extensions": {"website": "https://sanggatalk.io"}
  },
  {
    "chainId": 101,
    "address": "Ae1aeYK9WrB2kP29jJU4aUUK7Y1vzsGNZFKoe4BG2h6P",
    "symbol": "OLDNINJA",
    "name": "OLDNINJA",
    "decimals": 0,
    "logoURI":
        "https://raw.githubusercontent.com/solana-labs/token-list/main/assets/mainnet/Ae1aeYK9WrB2kP29jJU4aUUK7Y1vzsGNZFKoe4BG2h6P/logo.png",
    "tags": [],
    "extensions": {"website": "https://www.ninjaprotocol.io/oldninja/"}
  },
  {
    "chainId": 101,
    "address": "FgX1WD9WzMU3yLwXaFSarPfkgzjLb2DZCqmkx9ExpuvJ",
    "symbol": "NINJA",
    "name": "NINJA",
    "decimals": 6,
    "logoURI":
        "https://raw.githubusercontent.com/solana-labs/token-list/main/assets/mainnet/FgX1WD9WzMU3yLwXaFSarPfkgzjLb2DZCqmkx9ExpuvJ/logo.png",
    "tags": [],
    "extensions": {
      "website": "https://www.ninjaprotocol.io/",
      "serumV3Usdc": "J4oPt5Q3FYxrznkXLkbosAWrJ4rZLqJpGqz7vZUL4eMM"
    }
  },
  {
    "chainId": 101,
    "address": "E6UBhrtvP4gYHAEgoBi8kDU6DrPPmQxTAJvASo4ptNev",
    "symbol": "SOLDOG",
    "name": "SOLDOG",
    "decimals": 0,
    "logoURI":
        "https://raw.githubusercontent.com/solana-labs/token-list/main/assets/mainnet/E6UBhrtvP4gYHAEgoBi8kDU6DrPPmQxTAJvASo4ptNev/logo.png",
    "tags": [],
    "extensions": {"website": "https://solanadog.io", "twitter": "https://twitter.com/solanadog"}
  },
  {
    "chainId": 102,
    "address": "rz251Qbsa27sL8Y1H7h4qu71j6Q7ukNmskg5ZDhPCg3",
    "symbol": "HIRO",
    "name": "Hiro LaunchDAO",
    "decimals": 6,
    "logoURI":
        "https://raw.githubusercontent.com/solana-labs/token-list/main/assets/mainnet/rz251Qbsa27sL8Y1H7h4qu71j6Q7ukNmskg5ZDhPCg3/logo.png",
    "tags": [],
    "extensions": {
      "website": "https://hiro-finance.github.io/",
      "twitter": "https://twitter.com/HiroLaunchdao"
    }
  },
  {
    "chainId": 101,
    "address": "9nusLQeFKiocswDt6NQsiErm1M43H2b8x6v5onhivqKv",
    "symbol": "LLAMA",
    "name": "SOLLAMA",
    "decimals": 1,
    "logoURI":
        "https://raw.githubusercontent.com/solana-labs/token-list/main/assets/mainnet/9nusLQeFKiocswDt6NQsiErm1M43H2b8x6v5onhivqKv/logo.png",
    "tags": [],
    "extensions": {
      "website": "https://sollama.finance",
      "twitter": "https://twitter.com/SollamaFinance"
    }
  },
  {
    "chainId": 101,
    "address": "BLwTnYKqf7u4qjgZrrsKeNs2EzWkMLqVCu6j8iHyrNA3",
    "symbol": "BOP",
    "name": "Boring Protocol",
    "decimals": 8,
    "logoURI": "https://raw.githubusercontent.com/boringprotocol/brand-assets/main/boplogo.png",
    "tags": ["security-token", "utility-token"],
    "extensions": {
      "website": "https://boringprotocol.io",
      "twitter": "https://twitter.com/BoringProtocol",
      "serumV3Usdc": "7MmPwD1K56DthW14P1PnWZ4zPCbPWemGs3YggcT1KzsM",
      "coingeckoId": "boring-protocol"
    }
  },
  {
    "chainId": 101,
    "address": "ER8Xa8YxJLC3CFJgdAxJs46Rdhb7B3MjgbPZsVg1aAFV",
    "symbol": "MOLAMON",
    "name": "MOLAMON",
    "decimals": 0,
    "logoURI":
        "https://raw.githubusercontent.com/solana-labs/token-list/main/assets/mainnet/ER8Xa8YxJLC3CFJgdAxJs46Rdhb7B3MjgbPZsVg1aAFV/logo.png",
    "tags": [],
    "extensions": {
      "website": "https://moonlana.com/",
      "twitter": "https://twitter.com/xMoonLana",
      "medium": "https://moonlana.medium.com/",
      "imageUrl":
          "https://gateway.pinata.cloud/ipfs/QmbdEesuzVUMzqaumrZNaWnwnz4WwDvqDyfrFneVDjqr2e/molamonbg.gif",
      "description": "The first \$MOLA NFT on Solana Blockchain."
    }
  },
  {
    "chainId": 101,
    "address": "4ezHExHThrwnnoqKcMNbUwcVYXzdkDerHFGfegnTqA2E",
    "symbol": "STUD",
    "name": "SolanaToolsUtilityDapp",
    "decimals": 9,
    "logoURI":
        "https://raw.githubusercontent.com/solana-labs/token-list/main/assets/mainnet/4ezHExHThrwnnoqKcMNbUwcVYXzdkDerHFGfegnTqA2E/logo.png",
    "tags": [],
    "extensions": {"website": "https://www.solanatools.io/"}
  },
  {
    "chainId": 101,
    "address": "AZtNYaEAHDBeK5AvdzquZWjc4y8cj5sKWH1keUJGMuPV",
    "symbol": "RESP",
    "name": "RESPECT",
    "decimals": 8,
    "logoURI":
        "https://raw.githubusercontent.com/solana-labs/token-list/main/assets/mainnet/AZtNYaEAHDBeK5AvdzquZWjc4y8cj5sKWH1keUJGMuPV/logo.png",
    "tags": [],
    "extensions": {"website": "https://respect.cash"}
  },
  {
    "chainId": 101,
    "address": "5j6BmiZTfHssaWPT23EQYQci3w57VTw7QypKArQZbSZ9",
    "symbol": "CHAD",
    "name": "ChadTrader Token",
    "decimals": 9,
    "logoURI":
        "https://raw.githubusercontent.com/solana-labs/token-list/main/assets/mainnet/5j6BmiZTfHssaWPT23EQYQci3w57VTw7QypKArQZbSZ9/logo.png",
    "tags": ["utility-token"],
    "extensions": {
      "website": "https://chadtrader.io/",
      "twitter": "https://twitter.com/chadtraderio"
    }
  },
  {
    "chainId": 101,
    "address": "GsNzxJfFn6zQdJGeYsupJWzUAm57Ba7335mfhWvFiE9Z",
    "symbol": "DXL",
    "name": "Dexlab",
    "decimals": 6,
    "logoURI":
        "https://raw.githubusercontent.com/solana-labs/token-list/main/assets/mainnet/GsNzxJfFn6zQdJGeYsupJWzUAm57Ba7335mfhWvFiE9Z/logo.png",
    "tags": [],
    "extensions": {
      "website": "https://www.dexlab.space/",
      "serumV3Usdc": "DYfigimKWc5VhavR4moPBibx9sMcWYVSjVdWvPztBPTa",
      "twitter": "https://twitter.com/dexlab_official",
      "coingeckoId": "dexlab"
    }
  },
  {
    "chainId": 101,
    "address": "APvgd1J98PGW77H1fDa7W7Y4fcbFwWfs71RNyJKuYs1Y",
    "symbol": "FUZ",
    "name": "Fuzzy.One",
    "decimals": 8,
    "logoURI":
        "https://raw.githubusercontent.com/solana-labs/token-list/main/assets/mainnet/APvgd1J98PGW77H1fDa7W7Y4fcbFwWfs71RNyJKuYs1Y/logo.png",
    "tags": ["Fuzzy.One", "FUZ", "Supply chain token"],
    "extensions": {"website": "https://www.fuzzy.one/"}
  },
  {
    "chainId": 101,
    "address": "6TCbtxs6eYfMKVF9ppTNvbUemW2YnpFig6z1jSqgM16e",
    "symbol": "STRANGE",
    "name": "STRANGE",
    "decimals": 6,
    "logoURI":
        "https://raw.githubusercontent.com/solana-labs/token-list/main/assets/mainnet/6TCbtxs6eYfMKVF9ppTNvbUemW2YnpFig6z1jSqgM16e/logo.png",
    "tags": ["utility-token"],
    "extensions": {"website": "https://safepluto.tech"}
  },
  {
    "chainId": 101,
    "address": "BYNHheaKFX2WRGQTpMZNsM6vAyJXvkeMoMcixKfVKxY9",
    "symbol": "PLUTES",
    "name": "Plutonium",
    "decimals": 6,
    "logoURI":
        "https://raw.githubusercontent.com/solana-labs/token-list/main/assets/mainnet/BYNHheaKFX2WRGQTpMZNsM6vAyJXvkeMoMcixKfVKxY9/logo.png",
    "tags": ["utility-token"],
    "extensions": {"website": "https://safepluto.tech"}
  },
  {
    "chainId": 101,
    "address": "8upjSpvjcdpuzhfR1zriwg5NXkwDruejqNE9WNbPRtyA",
    "symbol": "GRAPE",
    "name": "Grape",
    "decimals": 6,
    "logoURI":
        "https://lh3.googleusercontent.com/y7Wsemw9UVBc9dtjtRfVilnS1cgpDt356PPAjne5NvMXIwWz9_x7WKMPH99teyv8vXDmpZinsJdgiFQ16_OAda1dNcsUxlpw9DyMkUk=s0",
    "tags": [],
    "extensions": {"coingeckoId": "grape-2", "website": "https://grapes.network"}
  },
  {
    "chainId": 101,
    "address": "7xzovRepzLvXbbpVZLYKzEBhCNgStEv1xpDqf1rMFFKX",
    "symbol": "KERMIT",
    "name": "Kermit",
    "decimals": 8,
    "logoURI":
        "https://raw.githubusercontent.com/solana-labs/token-list/main/assets/mainnet/7xzovRepzLvXbbpVZLYKzEBhCNgStEv1xpDqf1rMFFKX/logo.png",
    "tags": ["utility-token"],
    "extensions": {
      "website": "https://www.kermitfinance.com",
      "twitter": "https://twitter.com/KermitFinance"
    }
  },
  {
    "chainId": 101,
    "address": "3VhB8EAL8dZ457SiksLPpMUR1pyACpbNh5rTjQUEVCcH",
    "symbol": "TUTL",
    "name": "TurtleTraders",
    "decimals": 9,
    "logoURI":
        "https://raw.githubusercontent.com/solana-labs/token-list/main/assets/mainnet/3VhB8EAL8dZ457SiksLPpMUR1pyACpbNh5rTjQUEVCcH/logo.png",
    "tags": ["social-token", "Turtles"],
    "extensions": {"twitter": "https://twitter.com/Turtle_Traders"}
  },
  {
    "chainId": 101,
    "address": "8tbAqS4dFNEeC6YGWpNnusc3JcxoFLMiiLPyHctgGYFe",
    "symbol": "PIPANA",
    "name": "Pipana",
    "decimals": 9,
    "logoURI":
        "https://raw.githubusercontent.com/solana-labs/token-list/main/assets/mainnet/8tbAqS4dFNEeC6YGWpNnusc3JcxoFLMiiLPyHctgGYFe/logo.png",
    "tags": [],
    "extensions": {
      "website": "https://pip.monster",
      "twitter": "https://twitter.com/itspipana",
      "serumV3Usdc": "EHCty8rwVcE1T8Ccd6Emrd1oB2yNeMXz6kcgmE1Qa6sG"
    }
  },
  {
    "chainId": 101,
    "address": "8s9FCz99Wcr3dHpiauFRi6bLXzshXfcGTfgQE7UEopVx",
    "symbol": "CKC",
    "name": "ChikinCoin",
    "decimals": 6,
    "logoURI":
        "https://raw.githubusercontent.com/solana-labs/token-list/main/assets/mainnet/8s9FCz99Wcr3dHpiauFRi6bLXzshXfcGTfgQE7UEopVx/logo.svg",
    "tags": [],
    "extensions": {"website": "https://chikin.run", "twitter": "https://twitter.com/ChikinDev"}
  },
  {
    "chainId": 101,
    "address": "ATxXyewb1cXThrQFmwHUy4dtPTErfsuqkg7JcUXgLgqo",
    "symbol": "SPW",
    "name": "SpiderSwap",
    "decimals": 9,
    "logoURI":
        "https://raw.githubusercontent.com/solana-labs/token-list/main/assets/mainnet/ATxXyewb1cXThrQFmwHUy4dtPTErfsuqkg7JcUXgLgqo/logo.png",
    "tags": [],
    "extensions": {
      "website": "https://www.spiderswap.org",
      "twitter": "https://twitter.com/Spider_swap"
    }
  },
  {
    "chainId": 101,
    "address": "BrwgXmUtNd32dTKdP5teie68EmBnjGq8Wp3MukHehUBY",
    "symbol": "GSTONKS",
    "name": "Gamestonks",
    "decimals": 9,
    "logoURI":
        "https://raw.githubusercontent.com/solana-labs/token-list/main/assets/mainnet/BrwgXmUtNd32dTKdP5teie68EmBnjGq8Wp3MukHehUBY/logo.png",
    "tags": [],
    "extensions": {"website": "https://www.game-stonks.com/"}
  },
  {
    "chainId": 101,
    "address": "HAgX1HSfok8DohiNCS54FnC2UJkDSrRVnT38W3iWFwc8",
    "symbol": "MEOW",
    "name": "SOL-CATS",
    "decimals": 9,
    "logoURI":
        "https://raw.githubusercontent.com/solana-labs/token-list/main/assets/mainnet/HAgX1HSfok8DohiNCS54FnC2UJkDSrRVnT38W3iWFwc8/logo.png",
    "tags": [],
    "extensions": {"website": "https://www.solcats.xyz", "twitter": "https://twitter.com/solcat777"}
  },
  {
    "chainId": 101,
    "address": "8p758d6ZMkLUYQ949XZa6s1Mo31mhPpLcaaAPUBMeAmx",
    "symbol": "BOO",
    "name": "Gene Crucean",
    "decimals": 9,
    "logoURI":
        "https://raw.githubusercontent.com/solana-labs/token-list/main/assets/mainnet/8p758d6ZMkLUYQ949XZa6s1Mo31mhPpLcaaAPUBMeAmx/logo.png",
    "tags": ["utility-token"],
    "extensions": {"website": "https://www.genecrucean.com/"}
  },
  {
    "chainId": 101,
    "address": "Gro98oTmXxCVX8HKr3q2tMnP5ztoC77q6KehFDnAB983",
    "symbol": "SOLMO",
    "name": "SolMoon",
    "decimals": 4,
    "logoURI":
        "https://raw.githubusercontent.com/solana-labs/token-list/main/assets/mainnet/Gro98oTmXxCVX8HKr3q2tMnP5ztoC77q6KehFDnAB983/logo.png",
    "tags": [],
    "extensions": {
      "website": "https://www.solmoonfinance.com",
      "twitter": "https://twitter.com/solmoonfinance"
    }
  },
  {
    "chainId": 101,
    "address": "2wBXHm4oxmed7ZoDkPL4DU8BuRfMYkubVu8T4N38vXdb",
    "symbol": "MSC",
    "name": "MasterCoin",
    "decimals": 9,
    "logoURI":
        "https://raw.githubusercontent.com/solana-labs/token-list/main/assets/mainnet/2wBXHm4oxmed7ZoDkPL4DU8BuRfMYkubVu8T4N38vXdb/logo.png",
    "tags": [],
    "extensions": {
      "website": "https://mastercoin.site",
      "twitter": "https://twitter.com/MasterCoin_",
      "discord": "https://t.co/CXZN9Ncd6Q?amp=1",
      "medium": "https://medium.com/@mastercoin-eu"
    }
  },
  {
    "chainId": 101,
    "address": "8b9mQo6ZU2rwZQgSFqGNQvXzrUSHDTRpKSKi9XXdGmqN",
    "symbol": "CHANGPENGUIN",
    "name": "CHANGPENGUIN",
    "decimals": 9,
    "logoURI":
        "https://raw.githubusercontent.com/solana-labs/token-list/main/assets/mainnet/8b9mQo6ZU2rwZQgSFqGNQvXzrUSHDTRpKSKi9XXdGmqN/logo.png",
    "tags": [],
    "extensions": {"website": "https://artbomb.xyz"}
  },
  {
    "chainId": 101,
    "address": "3KnVxWhoYdc9UwDr5WMVkZp2LpF7gnojg7We7MUd6ixQ",
    "symbol": "WOLFE",
    "name": "Wolfecoin",
    "decimals": 9,
    "logoURI":
        "https://raw.githubusercontent.com/solana-labs/token-list/main/assets/mainnet/3KnVxWhoYdc9UwDr5WMVkZp2LpF7gnojg7We7MUd6ixQ/logo.png",
    "tags": [],
    "extensions": {"website": "https://www.wolfecoin.online/"}
  },
  {
    "chainId": 101,
    "address": "BxHJqGtC629c55swCqWXFGA2rRF1igbbTmh22H8ePUWG",
    "symbol": "PGNT",
    "name": "PigeonSol Token",
    "decimals": 4,
    "logoURI":
        "https://raw.githubusercontent.com/solana-labs/token-list/main/assets/mainnet/BxHJqGtC629c55swCqWXFGA2rRF1igbbTmh22H8ePUWG/logo.png",
    "tags": [],
    "extensions": {"website": "https://pigeonsol.xyz", "twitter": "https://twitter.com/PigeonSol"}
  },
  {
    "chainId": 101,
    "address": "51tMb3zBKDiQhNwGqpgwbavaGH54mk8fXFzxTc1xnasg",
    "symbol": "APEX",
    "name": "APEX",
    "decimals": 9,
    "logoURI":
        "https://raw.githubusercontent.com/solana-labs/token-list/main/assets/mainnet/51tMb3zBKDiQhNwGqpgwbavaGH54mk8fXFzxTc1xnasg/logo.png",
    "tags": [],
    "extensions": {
      "coingeckoId": "apexit-finance",
      "website": "https://apexit.finance/",
      "twitter": "https://twitter.com/apeXit_finance",
      "discord": "https://discord.gg/aASQy2dWsN",
      "tggroup": "https://t.me/apexit_finance"
    }
  },
  {
    "chainId": 101,
    "address": "4NPzwMK2gfgQ6rTv8x4EE1ZvKW6MYyYTSrAZCx7zxyaX",
    "symbol": "KLB",
    "name": "Black Label",
    "decimals": 0,
    "logoURI":
        "https://raw.githubusercontent.com/solana-labs/token-list/main/assets/mainnet/4NPzwMK2gfgQ6rTv8x4EE1ZvKW6MYyYTSrAZCx7zxyaX/logo.svg",
    "tags": [],
    "extensions": {
      "website": "https://klbtoken.com",
      "twitter": "https://twitter.com/klbtoken",
      "serumV3Usdc": "AVC5hkVjWqRzD9RXXwjcNiVAAR2rUvDGwhqoCd2TQNY8",
      "coingeckoId": "black-label"
    }
  },
  {
    "chainId": 101,
    "address": "5v6tZ1SiAi7G8Qg4rBF1ZdAn4cn6aeQtefewMr1NLy61",
    "symbol": "SOLD",
    "name": "Solanax",
    "decimals": 9,
    "logoURI":
        "https://raw.githubusercontent.com/solana-labs/token-list/main/assets/mainnet/5v6tZ1SiAi7G8Qg4rBF1ZdAn4cn6aeQtefewMr1NLy61/logo.png",
    "tags": [],
    "extensions": {
      "website": "https://solanax.org",
      "twitter": "https://twitter.com/Solanaxorg",
      "telegram": "https://t.me/solanaxcommunity"
    }
  },
  {
    "chainId": 101,
    "address": "3RSafdgu7P2smSGHJvSGQ6kZVkcErZXfZTtynJYboyAu",
    "symbol": "SINE",
    "name": "SINE",
    "decimals": 9,
    "logoURI":
        "https://raw.githubusercontent.com/solana-labs/token-list/main/assets/mainnet/3RSafdgu7P2smSGHJvSGQ6kZVkcErZXfZTtynJYboyAu/logo.svg",
    "tags": ["security-token", "utility-token"],
    "extensions": {
      "website": "https://solainetwork.com/",
      "twitter": "https://twitter.com/SolAiNetwork"
    }
  },
  {
    "chainId": 101,
    "address": "SioTkQxHyAs98ouRiyi1YDv3gLMSrX3eNBg61GH7NrM",
    "symbol": "SIO",
    "name": "Simplio",
    "decimals": 8,
    "logoURI":
        "https://raw.githubusercontent.com/solana-labs/token-list/main/assets/mainnet/SioTkQxHyAs98ouRiyi1YDv3gLMSrX3eNBg61GH7NrM/logo.png",
    "tags": [],
    "extensions": {
      "website": "https://simplio.io/",
      "twitter": "https://twitter.com/simplioOfficial",
      "discord": "https://discord.com/invite/aKhjuwZmdP"
    }
  },
  {
    "chainId": 101,
    "address": "orcaEKTdK7LKz57vaAYr9QeNsVEPfiu6QeMU1kektZE",
    "symbol": "ORCA",
    "name": "Orca",
    "decimals": 6,
    "logoURI":
        "https://raw.githubusercontent.com/solana-labs/token-list/main/assets/mainnet/orcaEKTdK7LKz57vaAYr9QeNsVEPfiu6QeMU1kektZE/logo.png",
    "tags": [],
    "extensions": {
      "website": "https://orca.so",
      "twitter": "https://twitter.com/orca_so",
      "telegram": "https://t.me/orca_so",
      "medium": "https://orca-so.medium.com",
      "discord": "https://discord.com/invite/nSwGWn5KSG",
      "coingeckoId": "orca",
      "serumV3Usdc": "8N1KkhaCYDpj3awD58d85n973EwkpeYnRp84y1kdZpMX"
    }
  },
  {
    "chainId": 101,
    "address": "guppyrZyEX9iTPSu92pi8T71Zka7xd6PrsTJrXRW6u1",
    "symbol": "GUPPY",
    "name": "Orca Guppy Collectible",
    "decimals": 0,
    "logoURI":
        "https://raw.githubusercontent.com/solana-labs/token-list/main/assets/mainnet/guppyrZyEX9iTPSu92pi8T71Zka7xd6PrsTJrXRW6u1/logo.png",
    "tags": ["nft"],
    "extensions": {"website": "https://orca.so", "twitter": "https://twitter.com/orca_so"}
  },
  {
    "chainId": 101,
    "address": "whaLeHav12EhGK19u6kKbLRwC9E1EATGnm6MWbBCcUW",
    "symbol": "WHALE",
    "name": "Orca Whale Collectible",
    "decimals": 0,
    "logoURI":
        "https://raw.githubusercontent.com/solana-labs/token-list/main/assets/mainnet/whaLeHav12EhGK19u6kKbLRwC9E1EATGnm6MWbBCcUW/logo.png",
    "tags": ["nft"],
    "extensions": {"website": "https://orca.so", "twitter": "https://twitter.com/orca_so"}
  },
  {
    "chainId": 101,
    "address": "kLwhLkZRt6CadPHRBsgfhRCKXX426WMBnhoGozTduvk",
    "symbol": "KILLER-WHALE",
    "name": "Orca Killer Whale Collectible",
    "decimals": 0,
    "logoURI":
        "https://raw.githubusercontent.com/solana-labs/token-list/main/assets/mainnet/kLwhLkZRt6CadPHRBsgfhRCKXX426WMBnhoGozTduvk/logo.png",
    "tags": ["nft"],
    "extensions": {"website": "https://orca.so", "twitter": "https://twitter.com/orca_so"}
  },
  {
    "chainId": 101,
    "address": "star2pH7rVWscs743JGdCAL8Lc9nyJeqx7YQXkGUnWf",
    "symbol": "STARFISH",
    "name": "Orca Starfish Collectible",
    "decimals": 6,
    "logoURI":
        "https://raw.githubusercontent.com/solana-labs/token-list/main/assets/mainnet/star2pH7rVWscs743JGdCAL8Lc9nyJeqx7YQXkGUnWf/logo.png",
    "tags": ["nft"],
    "extensions": {"website": "https://orca.so", "twitter": "https://twitter.com/orca_so"}
  },
  {
    "chainId": 101,
    "address": "cLownTTaiiQMoyMmFjfmSGowi8HyNhCtTLFcrNKnqX6",
    "symbol": "CLOWNFISH",
    "name": "Orca Clownfish Collectible",
    "decimals": 0,
    "logoURI":
        "https://raw.githubusercontent.com/solana-labs/token-list/main/assets/mainnet/cLownTTaiiQMoyMmFjfmSGowi8HyNhCtTLFcrNKnqX6/logo.png",
    "tags": ["nft"],
    "extensions": {"website": "https://orca.so", "twitter": "https://twitter.com/orca_so"}
  },
  {
    "chainId": 101,
    "address": "porpKs9ZZERXKkg55f1GRXCiXZK89Uz6VKS8Bv9qWqM",
    "symbol": "PORPOISE",
    "name": "Orca Porpoise Collectible",
    "decimals": 6,
    "logoURI":
        "https://raw.githubusercontent.com/solana-labs/token-list/main/assets/mainnet/porpKs9ZZERXKkg55f1GRXCiXZK89Uz6VKS8Bv9qWqM/logo.svg",
    "tags": ["nft"],
    "extensions": {"website": "https://www.orca.so", "twitter": "https://twitter.com/orca_so"}
  },
  {
    "chainId": 101,
    "address": "8kWk6CuCAfaxhWQZvQva6qkB1DkWNHq9LRKKN6n9joUG",
    "symbol": "pSOL/USDC",
    "name": "Orca Aquafarm Token (pSOL/USDC)",
    "decimals": 6,
    "logoURI":
        "https://raw.githubusercontent.com/solana-labs/token-list/main/assets/mainnet/8kWk6CuCAfaxhWQZvQva6qkB1DkWNHq9LRKKN6n9joUG/logo.svg",
    "tags": ["lp-token"],
    "extensions": {"website": "https://www.orca.so", "twitter": "https://twitter.com/orca_so"}
  },
  {
    "chainId": 101,
    "address": "7YFfqZGTxkj3Zeq3Et23kMznCaEYZ1WBZDt6CVrxwfqd",
    "symbol": "SOCN/USDC",
    "name": "Orca Aquafarm Token (SOCN/USDC)",
    "decimals": 6,
    "logoURI":
        "https://raw.githubusercontent.com/solana-labs/token-list/main/assets/mainnet/7YFfqZGTxkj3Zeq3Et23kMznCaEYZ1WBZDt6CVrxwfqd/logo.svg",
    "tags": ["lp-token"],
    "extensions": {"website": "https://www.orca.so", "twitter": "https://twitter.com/orca_so"}
  },
  {
    "chainId": 101,
    "address": "CNqmEKGjZUUARVFHcz4w9CvX5pR8Ae2c6imHDNqsbxgj",
    "symbol": "SOCN/SOL",
    "name": "Orca Aquafarm Token (SOCN/SOL)",
    "decimals": 6,
    "logoURI":
        "https://raw.githubusercontent.com/solana-labs/token-list/main/assets/mainnet/CNqmEKGjZUUARVFHcz4w9CvX5pR8Ae2c6imHDNqsbxgj/logo.svg",
    "tags": ["lp-token"],
    "extensions": {"website": "https://www.orca.so", "twitter": "https://twitter.com/orca_so"}
  },
  {
    "chainId": 101,
    "address": "Cum6sRPGpWYQHZapekDtMhbZ1BQ2QkYv9PAwQjypxMVo",
    "symbol": "SBR/USDC",
    "name": "Orca Aquafarm Token (SBR/USDC)",
    "decimals": 6,
    "logoURI":
        "https://raw.githubusercontent.com/solana-labs/token-list/main/assets/mainnet/Cum6sRPGpWYQHZapekDtMhbZ1BQ2QkYv9PAwQjypxMVo/logo.svg",
    "tags": ["lp-token"],
    "extensions": {"website": "https://www.orca.so", "twitter": "https://twitter.com/orca_so"}
  },
  {
    "chainId": 101,
    "address": "3RTGL7gPF4V1ns1AeGFApT7cBEGVDfmJ77DqQi9AC6uG",
    "symbol": "mSOL/SOL",
    "name": "Orca Aquafarm Token (mSOL/SOL)",
    "decimals": 6,
    "logoURI":
        "https://raw.githubusercontent.com/solana-labs/token-list/main/assets/mainnet/3RTGL7gPF4V1ns1AeGFApT7cBEGVDfmJ77DqQi9AC6uG/logo.svg",
    "tags": ["lp-token"],
    "extensions": {"website": "https://www.orca.so", "twitter": "https://twitter.com/orca_so"}
  },
  {
    "chainId": 101,
    "address": "4aEi4A91hRbERJVDYxRWbbSrBrsxoM1Hm33KRoRzWMht",
    "symbol": "ORCA/PAI",
    "name": "Orca Aquafarm Token (ORCA/PAI)",
    "decimals": 6,
    "logoURI":
        "https://raw.githubusercontent.com/solana-labs/token-list/main/assets/mainnet/4aEi4A91hRbERJVDYxRWbbSrBrsxoM1Hm33KRoRzWMht/logo.svg",
    "tags": ["lp-token"],
    "extensions": {"website": "https://www.orca.so", "twitter": "https://twitter.com/orca_so"}
  },
  {
    "chainId": 101,
    "address": "3Duk5b6fLztPmS4ryV48FM1Q9WXUSMwz9jehAT4UtqpE",
    "symbol": "ORCA/mSOL",
    "name": "Orca Aquafarm Token (ORCA/mSOL)",
    "decimals": 6,
    "logoURI":
        "https://raw.githubusercontent.com/solana-labs/token-list/main/assets/mainnet/3Duk5b6fLztPmS4ryV48FM1Q9WXUSMwz9jehAT4UtqpE/logo.svg",
    "tags": ["lp-token"],
    "extensions": {"website": "https://www.orca.so", "twitter": "https://twitter.com/orca_so"}
  },
  {
    "chainId": 101,
    "address": "ECFcUGwHHMaZynAQpqRHkYeTBnS5GnPWZywM8aggcs3A",
    "symbol": "SOL/USDC",
    "name": "Orca LP Token (SOL/USDC)",
    "decimals": 9,
    "logoURI":
        "https://raw.githubusercontent.com/solana-labs/token-list/main/assets/mainnet/ECFcUGwHHMaZynAQpqRHkYeTBnS5GnPWZywM8aggcs3A/logo.svg",
    "tags": ["lp-token"],
    "extensions": {"website": "https://orca.so", "twitter": "https://twitter.com/orca_so"}
  },
  {
    "chainId": 101,
    "address": "3H5XKkE9uVvxsdrFeN4BLLGCmohiQN6aZJVVcJiXQ4WC",
    "symbol": "USDC/USDT",
    "name": "Orca LP Token (USDC/USDT)",
    "decimals": 9,
    "logoURI":
        "https://raw.githubusercontent.com/solana-labs/token-list/main/assets/mainnet/3H5XKkE9uVvxsdrFeN4BLLGCmohiQN6aZJVVcJiXQ4WC/logo.svg",
    "tags": ["lp-token"],
    "extensions": {"website": "https://orca.so", "twitter": "https://twitter.com/orca_so"}
  },
  {
    "chainId": 101,
    "address": "8qNqTaKKbdZuzQPWWXy5wNVkJh54ex8zvvnEnTFkrKMP",
    "symbol": "USDC/USDT-SRM",
    "name": "Orca LP Token (USDC/USDT-SRM)",
    "decimals": 9,
    "logoURI":
        "https://raw.githubusercontent.com/solana-labs/token-list/main/assets/mainnet/8qNqTaKKbdZuzQPWWXy5wNVkJh54ex8zvvnEnTFkrKMP/logo.svg",
    "tags": ["lp-token"],
    "extensions": {"website": "https://orca.so", "twitter": "https://twitter.com/orca_so"}
  },
  {
    "chainId": 101,
    "address": "7TYb32qkwYosUQfUspU45cou7Bb3nefJocVMFX2mEGTT",
    "symbol": "ETH/USDC",
    "name": "Orca LP Token (ETH/USDC)",
    "decimals": 9,
    "logoURI":
        "https://raw.githubusercontent.com/solana-labs/token-list/main/assets/mainnet/7TYb32qkwYosUQfUspU45cou7Bb3nefJocVMFX2mEGTT/logo.svg",
    "tags": ["lp-token"],
    "extensions": {"website": "https://orca.so", "twitter": "https://twitter.com/orca_so"}
  },
  {
    "chainId": 101,
    "address": "EhBAmhkgEsMa8McFB5bpqZaRpZvGBBJ4jN59T5xToPdG",
    "symbol": "ETH/USDT-SRM",
    "name": "Orca LP Token (ETH/USDT-SRM)",
    "decimals": 9,
    "logoURI":
        "https://raw.githubusercontent.com/solana-labs/token-list/main/assets/mainnet/EhBAmhkgEsMa8McFB5bpqZaRpZvGBBJ4jN59T5xToPdG/logo.svg",
    "tags": ["lp-token"],
    "extensions": {"website": "https://orca.so", "twitter": "https://twitter.com/orca_so"}
  },
  {
    "chainId": 101,
    "address": "8pFwdcuXM7pvHdEGHLZbUR8nNsjj133iUXWG6CgdRHk2",
    "symbol": "BTC/ETH",
    "name": "Orca LP Token (BTC/ETH)",
    "decimals": 9,
    "logoURI":
        "https://raw.githubusercontent.com/solana-labs/token-list/main/assets/mainnet/8pFwdcuXM7pvHdEGHLZbUR8nNsjj133iUXWG6CgdRHk2/logo.svg",
    "tags": ["lp-token"],
    "extensions": {"website": "https://orca.so", "twitter": "https://twitter.com/orca_so"}
  },
  {
    "chainId": 101,
    "address": "7bb88DAnQY7LSoWEuqezCcbk4vutQbuRqgJMqpX8h6dL",
    "symbol": "ETH/SOL",
    "name": "Orca LP Token (ETH/SOL)",
    "decimals": 9,
    "logoURI":
        "https://raw.githubusercontent.com/solana-labs/token-list/main/assets/mainnet/7bb88DAnQY7LSoWEuqezCcbk4vutQbuRqgJMqpX8h6dL/logo.svg",
    "tags": ["lp-token"],
    "extensions": {"website": "https://orca.so", "twitter": "https://twitter.com/orca_so"}
  },
  {
    "chainId": 101,
    "address": "GWEmABT4rD3sGhyghv9rKbfdiaFe5uMHeJqr6hhu3XvA",
    "symbol": "RAY/SOL",
    "name": "Orca LP Token (RAY/SOL)",
    "decimals": 9,
    "logoURI":
        "https://raw.githubusercontent.com/solana-labs/token-list/main/assets/mainnet/GWEmABT4rD3sGhyghv9rKbfdiaFe5uMHeJqr6hhu3XvA/logo.svg",
    "tags": ["lp-token"],
    "extensions": {"website": "https://orca.so", "twitter": "https://twitter.com/orca_so"}
  },
  {
    "chainId": 101,
    "address": "BmZNYGt7aApGTUUxAQUYsW64cMbb6P7uniokCWaptj4D",
    "symbol": "SOL/USDT",
    "name": "Orca LP Token (SOL/USDT)",
    "decimals": 9,
    "logoURI":
        "https://raw.githubusercontent.com/solana-labs/token-list/main/assets/mainnet/BmZNYGt7aApGTUUxAQUYsW64cMbb6P7uniokCWaptj4D/logo.svg",
    "tags": ["lp-token"],
    "extensions": {"website": "https://orca.so", "twitter": "https://twitter.com/orca_so"}
  },
  {
    "chainId": 101,
    "address": "E4cthfUFaDd4x5t1vbeBNBHm7isqhM8kapthPzPJz1M2",
    "symbol": "SOL/USDT-SRM",
    "name": "Orca LP Token (SOL/USDT-SRM)",
    "decimals": 9,
    "logoURI":
        "https://raw.githubusercontent.com/solana-labs/token-list/main/assets/mainnet/E4cthfUFaDd4x5t1vbeBNBHm7isqhM8kapthPzPJz1M2/logo.svg",
    "tags": ["lp-token"],
    "extensions": {"website": "https://orca.so", "twitter": "https://twitter.com/orca_so"}
  },
  {
    "chainId": 101,
    "address": "6ojPekCSQimAjDjaMApLvh3jF6wnZeNEVRVVoGNzEXvV",
    "symbol": "SOL/SRM",
    "name": "Orca LP Token (SOL/SRM)",
    "decimals": 9,
    "logoURI":
        "https://raw.githubusercontent.com/solana-labs/token-list/main/assets/mainnet/6ojPekCSQimAjDjaMApLvh3jF6wnZeNEVRVVoGNzEXvV/logo.png",
    "tags": ["lp-token"],
    "extensions": {"website": "https://orca.so", "twitter": "https://twitter.com/orca_so"}
  },
  {
    "chainId": 101,
    "address": "YJRknE9oPhUMtq1VvhjVzG5WnRsjQtLsWg3nbaAwCQ5",
    "symbol": "FTT/SOL",
    "name": "Orca LP Token (FTT/SOL)",
    "decimals": 9,
    "logoURI":
        "https://raw.githubusercontent.com/solana-labs/token-list/main/assets/mainnet/YJRknE9oPhUMtq1VvhjVzG5WnRsjQtLsWg3nbaAwCQ5/logo.svg",
    "tags": ["lp-token"],
    "extensions": {"website": "https://orca.so", "twitter": "https://twitter.com/orca_so"}
  },
  {
    "chainId": 101,
    "address": "C9PKvetJPrrPD53PR2aR8NYtVZzucCRkHYzcFXbZXEqu",
    "symbol": "KIN/SOL",
    "name": "Orca LP Token (KIN/SOL)",
    "decimals": 9,
    "logoURI":
        "https://raw.githubusercontent.com/solana-labs/token-list/main/assets/mainnet/C9PKvetJPrrPD53PR2aR8NYtVZzucCRkHYzcFXbZXEqu/logo.svg",
    "tags": ["lp-token"],
    "extensions": {"website": "https://orca.so", "twitter": "https://twitter.com/orca_so"}
  },
  {
    "chainId": 101,
    "address": "6SfhBAmuaGf9p3WAxeHJYCWMABnYUMrdzNdK5Stvvj4k",
    "symbol": "ROPE/SOL",
    "name": "Orca LP Token (ROPE/SOL)",
    "decimals": 9,
    "logoURI":
        "https://raw.githubusercontent.com/solana-labs/token-list/main/assets/mainnet/6SfhBAmuaGf9p3WAxeHJYCWMABnYUMrdzNdK5Stvvj4k/logo.svg",
    "tags": ["lp-token"],
    "extensions": {"website": "https://orca.so", "twitter": "https://twitter.com/orca_so"}
  },
  {
    "chainId": 101,
    "address": "9r1n79TmerAgQJboUT8QvrChX3buZBfuSrBTtYM1cW4h",
    "symbol": "SOL/STEP",
    "name": "Orca LP Token (SOL/STEP)",
    "decimals": 9,
    "logoURI":
        "https://raw.githubusercontent.com/solana-labs/token-list/main/assets/mainnet/9r1n79TmerAgQJboUT8QvrChX3buZBfuSrBTtYM1cW4h/logo.svg",
    "tags": ["lp-token"],
    "extensions": {"website": "https://orca.so", "twitter": "https://twitter.com/orca_so"}
  },
  {
    "chainId": 101,
    "address": "ELLELFtgvWBgLkdY9EFx4Vb3SLNj4DJEhzZLWy1wCh4Y",
    "symbol": "OXY/SOL",
    "name": "Orca LP Token (OXY/SOL)",
    "decimals": 9,
    "logoURI":
        "https://raw.githubusercontent.com/solana-labs/token-list/main/assets/mainnet/ELLELFtgvWBgLkdY9EFx4Vb3SLNj4DJEhzZLWy1wCh4Y/logo.svg",
    "tags": ["lp-token"],
    "extensions": {"website": "https://orca.so", "twitter": "https://twitter.com/orca_so"}
  },
  {
    "chainId": 101,
    "address": "BXM9ph4AuhCUzf94HQu5FnfeVThKj5oyrnb1krY1zax5",
    "symbol": "MER/SOL",
    "name": "Orca LP Token (MER/SOL)",
    "decimals": 9,
    "logoURI":
        "https://raw.githubusercontent.com/solana-labs/token-list/main/assets/mainnet/BXM9ph4AuhCUzf94HQu5FnfeVThKj5oyrnb1krY1zax5/logo.svg",
    "tags": ["lp-token"],
    "extensions": {"website": "https://orca.so", "twitter": "https://twitter.com/orca_so"}
  },
  {
    "chainId": 101,
    "address": "FJ9Q9ojA7vdf5rFbcTc6dd7D3nLpwSxdtFSE8cwfuvqt",
    "symbol": "FIDA/SOL",
    "name": "Orca LP Token (FIDA/SOL)",
    "decimals": 9,
    "logoURI":
        "https://raw.githubusercontent.com/solana-labs/token-list/main/assets/mainnet/FJ9Q9ojA7vdf5rFbcTc6dd7D3nLpwSxdtFSE8cwfuvqt/logo.svg",
    "tags": ["lp-token"],
    "extensions": {"website": "https://orca.so", "twitter": "https://twitter.com/orca_so"}
  },
  {
    "chainId": 101,
    "address": "EHkfnhKLLTUqo1xMZLxhM9EusEgpN6RXPpZsGpUsewaa",
    "symbol": "MAPS/SOL",
    "name": "Orca LP Token (MAPS/SOL)",
    "decimals": 9,
    "logoURI":
        "https://raw.githubusercontent.com/solana-labs/token-list/main/assets/mainnet/EHkfnhKLLTUqo1xMZLxhM9EusEgpN6RXPpZsGpUsewaa/logo.svg",
    "tags": ["lp-token"],
    "extensions": {"website": "https://orca.so", "twitter": "https://twitter.com/orca_so"}
  },
  {
    "chainId": 101,
    "address": "9rguDaKqTrVjaDXafq6E7rKGn7NPHomkdb8RKpjKCDm2",
    "symbol": "SAMO/SOL",
    "name": "Orca LP Token (SAMO/SOL)",
    "decimals": 9,
    "logoURI":
        "https://raw.githubusercontent.com/solana-labs/token-list/main/assets/mainnet/9rguDaKqTrVjaDXafq6E7rKGn7NPHomkdb8RKpjKCDm2/logo.svg",
    "tags": ["lp-token"],
    "extensions": {"website": "https://orca.so", "twitter": "https://twitter.com/orca_so"}
  },
  {
    "chainId": 101,
    "address": "2697FyJ4vD9zwAVPr33fdVPDv54pyZZiBv9S2AoKMyQf",
    "symbol": "COPE/SOL",
    "name": "Orca LP Token (COPE/SOL)",
    "decimals": 9,
    "logoURI":
        "https://raw.githubusercontent.com/solana-labs/token-list/main/assets/mainnet/2697FyJ4vD9zwAVPr33fdVPDv54pyZZiBv9S2AoKMyQf/logo.svg",
    "tags": ["lp-token"],
    "extensions": {"website": "https://orca.so", "twitter": "https://twitter.com/orca_so"}
  },
  {
    "chainId": 101,
    "address": "57vGdcMZLnbNr4TZ4hgrpGJZGR9vTPhu8L9bNKDrqxKT",
    "symbol": "LIQ/USDC",
    "name": "Orca Aquafarm Token (LIQ/USDC)",
    "decimals": 6,
    "logoURI":
        "https://raw.githubusercontent.com/solana-labs/token-list/main/assets/mainnet/57vGdcMZLnbNr4TZ4hgrpGJZGR9vTPhu8L9bNKDrqxKT/logo.svg",
    "tags": ["lp-token"],
    "extensions": {"website": "https://orca.so"}
  },
  {
    "chainId": 101,
    "address": "FFdjrSvNALfdgxANNpt3x85WpeVMdQSH5SEP2poM8fcK",
    "symbol": "SOL/USDC",
    "name": "Orca Aquafarm Token (SOL/USDC)",
    "decimals": 6,
    "logoURI":
        "https://raw.githubusercontent.com/solana-labs/token-list/main/assets/mainnet/FFdjrSvNALfdgxANNpt3x85WpeVMdQSH5SEP2poM8fcK/logo.svg",
    "tags": ["lp-token"],
    "extensions": {"website": "https://orca.so"}
  },
  {
    "chainId": 101,
    "address": "71vZ7Jvu8fTyFzpX399dmoSovoz24rVbipLrRn2wBNzW",
    "symbol": "SOL/USDT",
    "name": "Orca Aquafarm Token (SOL/USDT)",
    "decimals": 6,
    "logoURI":
        "https://raw.githubusercontent.com/solana-labs/token-list/main/assets/mainnet/71vZ7Jvu8fTyFzpX399dmoSovoz24rVbipLrRn2wBNzW/logo.svg",
    "tags": ["lp-token"],
    "extensions": {"website": "https://orca.so"}
  },
  {
    "chainId": 101,
    "address": "CGFTRh4jKLPbS9r4hZtbDfaRuC7qcA8rZpbLnVTzJBer",
    "symbol": "ETH/SOL",
    "name": "Orca Aquafarm Token (ETH/SOL)",
    "decimals": 6,
    "logoURI":
        "https://raw.githubusercontent.com/solana-labs/token-list/main/assets/mainnet/CGFTRh4jKLPbS9r4hZtbDfaRuC7qcA8rZpbLnVTzJBer/logo.svg",
    "tags": ["lp-token"],
    "extensions": {"website": "https://orca.so"}
  },
  {
    "chainId": 101,
    "address": "HDP2AYFmvLz6sWpoSuNS62JjvW4HjMKp7doXucqpWN56",
    "symbol": "ETH/USDC",
    "name": "Orca Aquafarm Token (ETH/USDC)",
    "decimals": 6,
    "logoURI":
        "https://raw.githubusercontent.com/solana-labs/token-list/main/assets/mainnet/HDP2AYFmvLz6sWpoSuNS62JjvW4HjMKp7doXucqpWN56/logo.svg",
    "tags": ["lp-token"],
    "extensions": {"website": "https://orca.so"}
  },
  {
    "chainId": 101,
    "address": "AUkn5f4N4TqPA5BiWirTDHWnG3SePfmeDpDqrFmhSgKb",
    "symbol": "RAY/SOL",
    "name": "Orca Aquafarm Token (RAY/SOL)",
    "decimals": 6,
    "logoURI":
        "https://raw.githubusercontent.com/solana-labs/token-list/main/assets/mainnet/AUkn5f4N4TqPA5BiWirTDHWnG3SePfmeDpDqrFmhSgKb/logo.svg",
    "tags": ["lp-token"],
    "extensions": {"website": "https://orca.so"}
  },
  {
    "chainId": 101,
    "address": "xpPyQwQ1HXHyEpvFGyTQRLY6rmj6jtAdEgLMV5uoz4m",
    "symbol": "ROPE/SOL",
    "name": "Orca Aquafarm Token (ROPE/SOL)",
    "decimals": 6,
    "logoURI":
        "https://raw.githubusercontent.com/solana-labs/token-list/main/assets/mainnet/xpPyQwQ1HXHyEpvFGyTQRLY6rmj6jtAdEgLMV5uoz4m/logo.svg",
    "tags": ["lp-token"],
    "extensions": {"website": "https://orca.so"}
  },
  {
    "chainId": 101,
    "address": "GwrBA1F8rGummDCDd8NY9Eu1cLNuJqbT8WaGxgWpFwGL",
    "symbol": "STEP/SOL",
    "name": "Orca Aquafarm Token (STEP/SOL)",
    "decimals": 6,
    "logoURI":
        "https://raw.githubusercontent.com/solana-labs/token-list/main/assets/mainnet/GwrBA1F8rGummDCDd8NY9Eu1cLNuJqbT8WaGxgWpFwGL/logo.svg",
    "tags": ["lp-token"],
    "extensions": {"website": "https://orca.so"}
  },
  {
    "chainId": 101,
    "address": "D659zwnbeTgquChbaWC3KDHrkYoqMuz1doGLHTFaqTtD",
    "symbol": "SRM/SOL",
    "name": "Orca Aquafarm Token (SRM/SOL)",
    "decimals": 6,
    "logoURI":
        "https://raw.githubusercontent.com/solana-labs/token-list/main/assets/mainnet/D659zwnbeTgquChbaWC3KDHrkYoqMuz1doGLHTFaqTtD/logo.svg",
    "tags": ["lp-token"],
    "extensions": {"website": "https://orca.so"}
  },
  {
    "chainId": 101,
    "address": "9r9BcPwCon96P5Y6JSdRAog7Uknz9p9GrnuHm4VzuB9k",
    "symbol": "FTT/SOL",
    "name": "Orca Aquafarm Token (FTT/SOL)",
    "decimals": 6,
    "logoURI":
        "https://raw.githubusercontent.com/solana-labs/token-list/main/assets/mainnet/9r9BcPwCon96P5Y6JSdRAog7Uknz9p9GrnuHm4VzuB9k/logo.svg",
    "tags": ["lp-token"],
    "extensions": {"website": "https://orca.so"}
  },
  {
    "chainId": 101,
    "address": "7CT19h7n2YBKiCFCaxXqMM79jNM4cmUvjXhNMjJNRYa",
    "symbol": "COPE/SOL",
    "name": "Orca Aquafarm Token (COPE/SOL)",
    "decimals": 6,
    "logoURI":
        "https://raw.githubusercontent.com/solana-labs/token-list/main/assets/mainnet/7CT19h7n2YBKiCFCaxXqMM79jNM4cmUvjXhNMjJNRYa/logo.svg",
    "tags": ["lp-token"],
    "extensions": {"website": "https://orca.so"}
  },
  {
    "chainId": 101,
    "address": "G48RkwsNYd3A4rBfuQhCswr9YUE63fFmZGyhgH95dq3S",
    "symbol": "OXY/SOL",
    "name": "Orca Aquafarm Token (OXY/SOL)",
    "decimals": 6,
    "logoURI":
        "https://raw.githubusercontent.com/solana-labs/token-list/main/assets/mainnet/G48RkwsNYd3A4rBfuQhCswr9YUE63fFmZGyhgH95dq3S/logo.svg",
    "tags": ["lp-token"],
    "extensions": {"website": "https://orca.so"}
  },
  {
    "chainId": 101,
    "address": "GxmjQZvgwNCh3QSRNB8CPED81hzySem62PDDuMp4B379",
    "symbol": "BTC/SOL",
    "name": "Orca Aquafarm Token (BTC/SOL)",
    "decimals": 6,
    "logoURI":
        "https://raw.githubusercontent.com/solana-labs/token-list/main/assets/mainnet/GxmjQZvgwNCh3QSRNB8CPED81hzySem62PDDuMp4B379/logo.svg",
    "tags": ["lp-token"],
    "extensions": {"website": "https://orca.so"}
  },
  {
    "chainId": 101,
    "address": "CrKVRnH6iGbFXxEnXMn3Emwv3Fe7VwxEqpA8zNbwsgkH",
    "symbol": "MER/SOL",
    "name": "Orca Aquafarm Token (MER/SOL)",
    "decimals": 6,
    "logoURI":
        "https://raw.githubusercontent.com/solana-labs/token-list/main/assets/mainnet/CrKVRnH6iGbFXxEnXMn3Emwv3Fe7VwxEqpA8zNbwsgkH/logo.svg",
    "tags": ["lp-token"],
    "extensions": {"website": "https://orca.so"}
  },
  {
    "chainId": 101,
    "address": "E9cEFhgcx8bKUjy5oQ1YFKbCDVu8dShjJYJ5EJVkF4kr",
    "symbol": "SWORD",
    "name": "SWORDIAN",
    "decimals": 9,
    "logoURI":
        "https://raw.githubusercontent.com/solana-labs/token-list/main/assets/mainnet/E9cEFhgcx8bKUjy5oQ1YFKbCDVu8dShjJYJ5EJVkF4kr/logo.png",
    "tags": [],
    "extensions": {"website": "https://www.swordians.com"}
  },
  {
    "chainId": 101,
    "address": "4geGcEfgVjzJGZAaT8iTicPm1XLDPjdSpVhtA99sZ7jX",
    "symbol": "FIDA/SOL",
    "name": "Orca Aquafarm Token (FIDA/SOL)",
    "decimals": 6,
    "logoURI":
        "https://raw.githubusercontent.com/solana-labs/token-list/main/assets/mainnet/4geGcEfgVjzJGZAaT8iTicPm1XLDPjdSpVhtA99sZ7jX/logo.svg",
    "tags": ["lp-token"],
    "extensions": {"website": "https://orca.so"}
  },
  {
    "chainId": 101,
    "address": "7Dy84zJNHzEM9335BrtFjCuunt2VgxJ7KBT6PJarxKMq",
    "symbol": "MAPS/SOL",
    "name": "Orca Aquafarm Token (MAPS/SOL)",
    "decimals": 6,
    "logoURI":
        "https://raw.githubusercontent.com/solana-labs/token-list/main/assets/mainnet/7Dy84zJNHzEM9335BrtFjCuunt2VgxJ7KBT6PJarxKMq/logo.svg",
    "tags": ["lp-token"],
    "extensions": {"website": "https://orca.so"}
  },
  {
    "chainId": 101,
    "address": "GjpXgKwn4VW4J2pZdS3dovM58hiXWLJtopTfqG83zY2f",
    "symbol": "USDC/USDT[stable]",
    "name": "Orca Aquafarm Token (USDC/USDT[stable])",
    "decimals": 6,
    "logoURI":
        "https://raw.githubusercontent.com/solana-labs/token-list/main/assets/mainnet/GjpXgKwn4VW4J2pZdS3dovM58hiXWLJtopTfqG83zY2f/logo.svg",
    "tags": ["lp-token"],
    "extensions": {"website": "https://orca.so"}
  },
  {
    "chainId": 101,
    "address": "B5waaKnsmtqFawPspUwcuy1cRjAC7u2LrHSwxPSxK4sZ",
    "symbol": "ORCA/SOL",
    "name": "Orca Aquafarm Token (ORCA/SOL)",
    "decimals": 6,
    "logoURI":
        "https://raw.githubusercontent.com/solana-labs/token-list/main/assets/mainnet/B5waaKnsmtqFawPspUwcuy1cRjAC7u2LrHSwxPSxK4sZ/logo.svg",
    "tags": ["lp-token"],
    "extensions": {"website": "https://orca.so"}
  },
  {
    "chainId": 101,
    "address": "Gc7W5U66iuHQcC1cQyeX9hxkPF2QUVJPTf1NWbW8fNrt",
    "symbol": "ORCA/USDC",
    "name": "Orca Aquafarm Token (ORCA/USDC)",
    "decimals": 6,
    "logoURI":
        "https://raw.githubusercontent.com/solana-labs/token-list/main/assets/mainnet/Gc7W5U66iuHQcC1cQyeX9hxkPF2QUVJPTf1NWbW8fNrt/logo.svg",
    "tags": ["lp-token"],
    "extensions": {"website": "https://orca.so"}
  },
  {
    "chainId": 101,
    "address": "7Ho3ht7krdFELBcPAsGXFfQMyG4PUvYSfpz4aNBRP3Ek",
    "symbol": "KIN/SOL",
    "name": "Orca Aquafarm Token (KIN/SOL)",
    "decimals": 6,
    "logoURI":
        "https://raw.githubusercontent.com/solana-labs/token-list/main/assets/mainnet/7Ho3ht7krdFELBcPAsGXFfQMyG4PUvYSfpz4aNBRP3Ek/logo.svg",
    "tags": ["lp-token"],
    "extensions": {"website": "https://orca.so"}
  },
  {
    "chainId": 101,
    "address": "CNf8gZtLahBWxKe3YwsqywLHMTewGqvq6pJ5ecg3cTYU",
    "symbol": "SAMO/SOL",
    "name": "Orca Aquafarm Token (SAMO/SOL)",
    "decimals": 6,
    "logoURI":
        "https://raw.githubusercontent.com/solana-labs/token-list/main/assets/mainnet/CNf8gZtLahBWxKe3YwsqywLHMTewGqvq6pJ5ecg3cTYU/logo.svg",
    "tags": ["lp-token"],
    "extensions": {"website": "https://orca.so"}
  },
  {
    "chainId": 101,
    "address": "6Qw5Gzf1TkM3YRe7Dh6yMVMo2wnJxRiCUBP8abTTn9Yg",
    "symbol": "SNY/USDC",
    "name": "Orca Aquafarm Token (SNY/USDC)",
    "decimals": 6,
    "logoURI":
        "https://raw.githubusercontent.com/solana-labs/token-list/main/assets/mainnet/6Qw5Gzf1TkM3YRe7Dh6yMVMo2wnJxRiCUBP8abTTn9Yg/logo.svg",
    "tags": ["lp-token"],
    "extensions": {"website": "https://orca.so"}
  },
  {
    "chainId": 101,
    "address": "5r3vDsNTGXXb9cGQfqyNuYD2bjhRPymGJBfDmKosR9Ev",
    "symbol": "mSOL/USDC",
    "name": "Orca Aquafarm Token (mSOL/USDC)",
    "decimals": 6,
    "logoURI":
        "https://raw.githubusercontent.com/solana-labs/token-list/main/assets/mainnet/5r3vDsNTGXXb9cGQfqyNuYD2bjhRPymGJBfDmKosR9Ev/logo.svg",
    "tags": ["lp-token"],
    "extensions": {"website": "https://orca.so"}
  },
  {
    "chainId": 101,
    "address": "66xCxkffQZKBZLiHV3PDcfR8ANJTfnDRxPCaBdv4wxB7",
    "symbol": "SLRS/USDC",
    "name": "Orca Aquafarm Token (SLRS/USDC)",
    "decimals": 6,
    "logoURI":
        "https://raw.githubusercontent.com/solana-labs/token-list/main/assets/mainnet/66xCxkffQZKBZLiHV3PDcfR8ANJTfnDRxPCaBdv4wxB7/logo.svg",
    "tags": ["lp-token"],
    "extensions": {"website": "https://orca.so"}
  },
  {
    "chainId": 101,
    "address": "4CGxvZdwiZgVMLXiTdJHTkJRUTpTSJCtmtCRbSkAxerE",
    "symbol": "PORT/USDC",
    "name": "Orca Aquafarm Token (PORT/USDC)",
    "decimals": 6,
    "logoURI":
        "https://raw.githubusercontent.com/solana-labs/token-list/main/assets/mainnet/4CGxvZdwiZgVMLXiTdJHTkJRUTpTSJCtmtCRbSkAxerE/logo.svg",
    "tags": ["lp-token"],
    "extensions": {"website": "https://orca.so"}
  },
  {
    "chainId": 101,
    "address": "HEhMLvpSdPviukafKwVN8BnBUTamirptsQ6Wxo5Cyv8s",
    "symbol": "FTR",
    "name": "Future",
    "decimals": 9,
    "logoURI":
        "https://raw.githubusercontent.com/solana-labs/token-list/main/assets/mainnet/HEhMLvpSdPviukafKwVN8BnBUTamirptsQ6Wxo5Cyv8s/logo.png",
    "tags": [],
    "extensions": {"website": "https://future-ftr.io", "twitter": "https://twitter.com/ftr_finance"}
  },
  {
    "chainId": 101,
    "address": "6oJ8Mp1VnKxN5MvGf9LfpeaRvTv8N1xFbvtdEbLLWUDT",
    "symbol": "ESC",
    "name": "ESCoin",
    "decimals": 9,
    "logoURI":
        "https://raw.githubusercontent.com/solana-labs/token-list/main/assets/mainnet/6oJ8Mp1VnKxN5MvGf9LfpeaRvTv8N1xFbvtdEbLLWUDT/logo.png",
    "tags": [],
    "extensions": {"website": "https://escoin.company/", "twitter": "https://twitter.com/coin_esc"}
  },
  {
    "chainId": 101,
    "address": "Da1jboBKU3rqXUqPL3L3BxJ8e67ogVgVKcqy4rWsS7LC",
    "symbol": "UBE",
    "name": "UBE Token",
    "decimals": 9,
    "logoURI":
        "https://raw.githubusercontent.com/solana-labs/token-list/main/assets/mainnet/Da1jboBKU3rqXUqPL3L3BxJ8e67ogVgVKcqy4rWsS7LC/logo.png",
    "tags": [],
    "extensions": {
      "website": "https://www.ubetoken.com",
      "twitter": "https://twitter.com/ube_token"
    }
  },
  {
    "chainId": 101,
    "address": "CDJWUqTcYTVAKXAVXoQZFes5JUFc7owSeq7eMQcDSbo5",
    "symbol": "renBTC",
    "name": "renBTC",
    "decimals": 8,
    "logoURI":
        "https://raw.githubusercontent.com/solana-labs/token-list/main/assets/mainnet/CDJWUqTcYTVAKXAVXoQZFes5JUFc7owSeq7eMQcDSbo5/logo.png",
    "tags": [],
    "extensions": {
      "coingeckoId": "renbtc",
      "website": "https://renproject.io/",
      "serumV3Usdc": "74Ciu5yRzhe8TFTHvQuEVbFZJrbnCMRoohBK33NNiPtv"
    }
  },
  {
    "chainId": 101,
    "address": "G1a6jxYz3m8DVyMqYnuV7s86wD4fvuXYneWSpLJkmsXj",
    "symbol": "renBCH",
    "name": "renBCH",
    "decimals": 8,
    "logoURI":
        "https://raw.githubusercontent.com/solana-labs/token-list/main/assets/mainnet/G1a6jxYz3m8DVyMqYnuV7s86wD4fvuXYneWSpLJkmsXj/logo.png",
    "tags": [],
    "extensions": {
      "coingeckoId": "renbch",
      "website": "https://renproject.io/",
      "serumV3Usdc": "FS8EtiNZCH72pAK83YxqXaGAgk3KKFYphiTcYA2yRPis"
    }
  },
  {
    "chainId": 101,
    "address": "FKJvvVJ242tX7zFtzTmzqoA631LqHh4CdgcN8dcfFSju",
    "symbol": "renDGB",
    "name": "renDGB",
    "decimals": 8,
    "logoURI":
        "https://raw.githubusercontent.com/solana-labs/token-list/main/assets/mainnet/FKJvvVJ242tX7zFtzTmzqoA631LqHh4CdgcN8dcfFSju/logo.png",
    "tags": [],
    "extensions": {"website": "https://renproject.io/"}
  },
  {
    "chainId": 101,
    "address": "ArUkYE2XDKzqy77PRRGjo4wREWwqk6RXTfM9NeqzPvjU",
    "symbol": "renDOGE",
    "name": "renDOGE",
    "decimals": 8,
    "logoURI":
        "https://raw.githubusercontent.com/solana-labs/token-list/main/assets/mainnet/ArUkYE2XDKzqy77PRRGjo4wREWwqk6RXTfM9NeqzPvjU/logo.png",
    "tags": [],
    "extensions": {
      "coingeckoId": "rendoge",
      "website": "https://renproject.io/",
      "serumV3Usdc": "5FpKCWYXgHWZ9CdDMHjwxAfqxJLdw2PRXuAmtECkzADk"
    }
  },
  {
    "chainId": 101,
    "address": "8wv2KAykQstNAj2oW6AHANGBiFKVFhvMiyyzzjhkmGvE",
    "symbol": "renLUNA",
    "name": "renLUNA",
    "decimals": 6,
    "logoURI":
        "https://raw.githubusercontent.com/solana-labs/token-list/main/assets/mainnet/8wv2KAykQstNAj2oW6AHANGBiFKVFhvMiyyzzjhkmGvE/logo.png",
    "tags": [],
    "extensions": {
      "website": "https://renproject.io/",
      "serumV3Usdc": "CxDhLbbM9uAA2AXfSPar5qmyfmC69NLj3vgJXYAsSVBT"
    }
  },
  {
    "chainId": 101,
    "address": "E99CQ2gFMmbiyK2bwiaFNWUUmwz4r8k2CVEFxwuvQ7ue",
    "symbol": "renZEC",
    "name": "renZEC",
    "decimals": 8,
    "logoURI":
        "https://raw.githubusercontent.com/solana-labs/token-list/main/assets/mainnet/E99CQ2gFMmbiyK2bwiaFNWUUmwz4r8k2CVEFxwuvQ7ue/logo.png",
    "tags": [],
    "extensions": {
      "coingeckoId": "renzec",
      "website": "https://renproject.io/",
      "serumV3Usdc": "2ahbUT5UryyRVxPnELtTmDLLneN26UjBQFgfMVvbWDTb"
    }
  },
  {
    "chainId": 101,
    "address": "GkXP719hnhLtizWHcQyGVYajuJqVsJJ6fyeUob9BPCFC",
    "symbol": "KROWZ",
    "name": "Mike Krow's Official Best Friend Super Kawaii Kasu Token",
    "decimals": 9,
    "logoURI":
        "https://raw.githubusercontent.com/solana-labs/token-list/main/assets/mainnet/GkXP719hnhLtizWHcQyGVYajuJqVsJJ6fyeUob9BPCFC/logo.png",
    "tags": ["social-token", "krowz"],
    "extensions": {
      "website": "https://mikekrow.com/",
      "twitter": "https://twitter.com/space_asylum"
    }
  },
  {
    "chainId": 101,
    "address": "6kwTqmdQkJd8qRr9RjSnUX9XJ24RmJRSrU1rsragP97Y",
    "symbol": "SAIL",
    "name": "SAIL",
    "decimals": 6,
    "logoURI":
        "https://raw.githubusercontent.com/solana-labs/token-list/main/assets/mainnet/6kwTqmdQkJd8qRr9RjSnUX9XJ24RmJRSrU1rsragP97Y/logo.png",
    "tags": ["utility-token"],
    "extensions": {
      "website": "https://www.solanasail.com",
      "coingeckoId": "sail",
      "twitter": "https://twitter.com/SolanaSail"
    }
  },
  {
    "chainId": 101,
    "address": "E5ndSkaB17Dm7CsD22dvcjfrYSDLCxFcMd6z8ddCk5wp",
    "symbol": "RIN",
    "name": "Aldrin",
    "decimals": 9,
    "logoURI":
        "https://raw.githubusercontent.com/solana-labs/token-list/main/assets/mainnet/E5ndSkaB17Dm7CsD22dvcjfrYSDLCxFcMd6z8ddCk5wp/logo.png",
    "tags": [],
    "extensions": {
      "website": "https://rin.aldrin.com/",
      "twitter": "https://twitter.com/Aldrin_Exchange",
      "serumV3Usdc": "7gZNLDbWE73ueAoHuAeFoSu7JqmorwCLpNTBXHtYSFTa",
      "coingeckoId": "aldrin"
    }
  },
  {
    "chainId": 101,
    "address": "7LmGzEgnQZTxxeCThgxsv3xe4JQmiy9hxEGBPCF66KgH",
    "symbol": "SNEK",
    "name": "Snek Coin",
    "decimals": 0,
    "logoURI":
        "https://raw.githubusercontent.com/solana-labs/token-list/main/assets/mainnet/7LmGzEgnQZTxxeCThgxsv3xe4JQmiy9hxEGBPCF66KgH/logo.png",
    "tags": [],
    "extensions": {"twitter": "https://twitter.com/snekcoin"}
  },
  {
    "chainId": 101,
    "address": "AhRozpV8CDLJ5z9k8CJWF4P12MVvxdnnU2y2qUhUuNS5",
    "symbol": "ARK",
    "name": "Sol.Ark",
    "decimals": 8,
    "logoURI":
        "https://raw.githubusercontent.com/solana-labs/token-list/main/assets/mainnet/AhRozpV8CDLJ5z9k8CJWF4P12MVvxdnnU2y2qUhUuNS5/logo.png",
    "tags": ["meme"],
    "extensions": {
      "website": "https://www.solark.xyz/",
      "twitter": "https://twitter.com/SOLARK67275852"
    }
  },
  {
    "chainId": 101,
    "address": "ss26ybWnrhSYbGBjDT9bEwRiyAVUgiKCbgAfFkksj4R",
    "symbol": "SS2",
    "name": "POH",
    "decimals": 0,
    "logoURI":
        "https://raw.githubusercontent.com/solana-labs/token-list/main/assets/mainnet/ss26ybWnrhSYbGBjDT9bEwRiyAVUgiKCbgAfFkksj4R/logo.png",
    "tags": ["nft"],
    "extensions": {
      "website": "https://www.sol-talk.com/sol-survivor",
      "twitter": "https://twitter.com/sol__survivor",
      "imageUrl": "https://www.arweave.net/fDxzEtzfu9IjFDh0ID-rOGaGw__F6-OD2ADoa23sayo?ext=gif",
      "animationUrl":
          "https://vww4cphi4lv3ldd4dtidi4njkbilvngmvuaofo3rv2oa3ozepeea.arweave.net/ra3BPOji67WMfBzQNHGpUFC6tMytAOK7ca6cDbskeQg?ext=glb",
      "description":
          "Sensing a disturbance in the timeline, the tournament organizers send Poh back in time to the beginning of the tournament. He is tasked with finding the origin of the disturbance and restoring the original timeline. Special:'Out of Order'"
    }
  },
  {
    "chainId": 101,
    "address": "6dGR9kAt499jzsojDHCvDArKxpTarNbhdSkiS7jeMAib",
    "symbol": "AKI",
    "name": "AKIHIGE Token",
    "decimals": 9,
    "logoURI":
        "https://raw.githubusercontent.com/solana-labs/token-list/main/assets/mainnet/6dGR9kAt499jzsojDHCvDArKxpTarNbhdSkiS7jeMAib/logo.png",
    "tags": ["aki"]
  },
  {
    "chainId": 101,
    "address": "SCYfrGCw8aDiqdgcpdGjV6jp4UVVQLuphxTDLNWu36f",
    "symbol": "SCY",
    "name": "Synchrony",
    "decimals": 9,
    "logoURI":
        "https://raw.githubusercontent.com/solana-labs/token-list/main/assets/mainnet/SCYfrGCw8aDiqdgcpdGjV6jp4UVVQLuphxTDLNWu36f/logo.png",
    "tags": [],
    "extensions": {"website": "https://synchrony.fi", "twitter": "https://twitter.com/SynchronyFi"}
  },
  {
    "chainId": 101,
    "address": "BKMWPkPS8jXw59ezYwK2ueNTZRF4m8MYHDjh9HwUmkQ7",
    "symbol": "SDC",
    "name": "SandDollarClassic",
    "decimals": 9,
    "logoURI":
        "https://raw.githubusercontent.com/solana-labs/token-list/main/assets/mainnet/BKMWPkPS8jXw59ezYwK2ueNTZRF4m8MYHDjh9HwUmkQ7/logo.png",
    "tags": ["utility-token"],
    "extensions": {
      "website": "https://sanddollar.bs",
      "twitter": "https://twitter.com/SandDollar_BS"
    }
  },
  {
    "chainId": 101,
    "address": "Bx4ykEMurwPQBAFNvthGj73fMBVTvHa8e9cbAyaK4ZSh",
    "symbol": "TOX",
    "name": "trollbox",
    "decimals": 9,
    "logoURI":
        "https://raw.githubusercontent.com/solana-labs/token-list/main/assets/mainnet/Bx4ykEMurwPQBAFNvthGj73fMBVTvHa8e9cbAyaK4ZSh/logo.png",
    "tags": ["utility-token"],
    "extensions": {"website": "https://trollbox.io", "twitter": "https://twitter.com/trollboxio"}
  },
  {
    "chainId": 101,
    "address": "E7WqtfRHcY8YW8z65u9WmD7CfMmvtrm2qPVicSzDxLaT",
    "symbol": "PPUG",
    "name": "PizzaPugCoin",
    "decimals": 9,
    "logoURI":
        "https://raw.githubusercontent.com/solana-labs/token-list/main/assets/mainnet/E7WqtfRHcY8YW8z65u9WmD7CfMmvtrm2qPVicSzDxLaT/logo.png",
    "tags": [],
    "extensions": {
      "website": "https://www.pizzapugcoin.com",
      "twitter": "https://twitter.com/pizzapugcoin"
    }
  },
  {
    "chainId": 101,
    "address": "FZgL5motNWEDEa24xgfSdBDfXkB9Ru9KxfEsey9S58bb",
    "symbol": "VCC",
    "name": "VentureCapital",
    "decimals": 6,
    "logoURI":
        "https://raw.githubusercontent.com/solana-labs/token-list/main/assets/mainnet/FZgL5motNWEDEa24xgfSdBDfXkB9Ru9KxfEsey9S58bb/logo.svg",
    "tags": ["venture capital", "liquidator", "IDO", "incubator"],
    "extensions": {
      "website": "https://www.vcc.finance/",
      "twitter": "https://twitter.com/vcc_finance"
    }
  },
  {
    "chainId": 101,
    "address": "4TGxgCSJQx2GQk9oHZ8dC5m3JNXTYZHjXumKAW3vLnNx",
    "symbol": "OXS",
    "name": "Oxbull Sol",
    "decimals": 9,
    "logoURI":
        "https://raw.githubusercontent.com/solana-labs/token-list/main/assets/mainnet/4TGxgCSJQx2GQk9oHZ8dC5m3JNXTYZHjXumKAW3vLnNx/logo.png",
    "tags": ["utility-token"],
    "extensions": {
      "website": "https://www.oxbull.tech/#/home",
      "twitter": "https://twitter.com/OxBull5",
      "medium": "https://medium.com/@oxbull",
      "tgann": "https://t.me/Oxbull_tech",
      "coingeckoId": "oxbull-solana",
      "github": "https://github.com/OxBull"
    }
  },
  {
    "chainId": 101,
    "address": "EdAhkbj5nF9sRM7XN7ewuW8C9XEUMs8P7cnoQ57SYE96",
    "symbol": "FAB",
    "name": "FABRIC",
    "decimals": 9,
    "logoURI":
        "https://raw.githubusercontent.com/solana-labs/token-list/main/assets/mainnet/EdAhkbj5nF9sRM7XN7ewuW8C9XEUMs8P7cnoQ57SYE96/logo.png",
    "tags": [],
    "extensions": {
      "website": "https://fsynth.io/",
      "twitter": "https://twitter.com/official_fabric",
      "coingeckoId": "fabric"
    }
  },
  {
    "chainId": 101,
    "address": "GEYrotdkRitGUK5UMv3aMttEhVAZLhRJMcG82zKYsaWB",
    "symbol": "POTATO",
    "name": "POTATO",
    "decimals": 3,
    "logoURI":
        "https://raw.githubusercontent.com/solana-labs/token-list/main/assets/mainnet/GEYrotdkRitGUK5UMv3aMttEhVAZLhRJMcG82zKYsaWB/logo.png",
    "tags": [],
    "extensions": {
      "website": "https://potatocoinspl.com/",
      "serumV3Usdc": "6dn7tgTHe5rZEAscMWWY3xmPGVEKVkM9s7YRV11z399z"
    }
  },
  {
    "chainId": 101,
    "address": "FmJ1fo7wK5FF6rDvQxow5Gj7A2ctLmR5orCKLZ45Q3Cq",
    "symbol": "DGEN",
    "name": "Degen Banana",
    "decimals": 6,
    "logoURI":
        "https://raw.githubusercontent.com/solana-labs/token-list/main/assets/mainnet/FmJ1fo7wK5FF6rDvQxow5Gj7A2ctLmR5orCKLZ45Q3Cq/logo.png",
    "tags": [],
    "extensions": {
      "website": "https://degen.finance/",
      "twitter": "https://twitter.com/degenbanana"
    }
  },
  {
    "chainId": 101,
    "address": "FciGvHj9FjgSGgCBF1b9HY814FM9D28NijDd5SJrKvPo",
    "symbol": "TGT",
    "name": "Twirl Governance Token",
    "decimals": 6,
    "logoURI":
        "https://raw.githubusercontent.com/solana-labs/token-list/main/assets/mainnet/FciGvHj9FjgSGgCBF1b9HY814FM9D28NijDd5SJrKvPo/logo.png",
    "tags": [],
    "extensions": {
      "website": "https://twirlfinance.com/",
      "twitter": "https://twitter.com/twirlfinance"
    }
  },
  {
    "chainId": 101,
    "address": "A9EEvcRcT7Q9XAa6NfqrqJChoc4XGDhd2mtc4xfniQkS",
    "symbol": "BILBY",
    "name": "Bilby Finance",
    "decimals": 9,
    "logoURI":
        "https://raw.githubusercontent.com/solana-labs/token-list/main/assets/mainnet/A9EEvcRcT7Q9XAa6NfqrqJChoc4XGDhd2mtc4xfniQkS/logo.png",
    "tags": ["utility-token"],
    "extensions": {"website": "https://bilby.finance/"}
  },
  {
    "chainId": 101,
    "address": "8NGgmXzBzhsXz46pTC3ioSBxeE3w2EXpc741N3EQ8E6r",
    "symbol": "JOKE",
    "name": "JOKESMEMES",
    "decimals": 9,
    "logoURI":
        "https://raw.githubusercontent.com/solana-labs/token-list/main/assets/mainnet/8NGgmXzBzhsXz46pTC3ioSBxeE3w2EXpc741N3EQ8E6r/logo.png",
    "tags": [],
    "extensions": {
      "website": "https://jokesmemes.finance",
      "twitter": "https://twitter.com/Jokesmemes11"
    }
  },
  {
    "chainId": 101,
    "address": "Fp4gjLpTsPqBN6xDGpDHwtnuEofjyiZKxxZxzvJnjxV6",
    "symbol": "NAXAR",
    "name": "Naxar",
    "decimals": 4,
    "logoURI":
        "https://raw.githubusercontent.com/solana-labs/token-list/main/assets/mainnet/Fp4gjLpTsPqBN6xDGpDHwtnuEofjyiZKxxZxzvJnjxV6/logo.png",
    "tags": [],
    "extensions": {
      "website": "https://naxar.ru",
      "instagram": "https://instagram.com/naxar__",
      "twitter": "https://twitter.com/_Naxar",
      "coingeckoId": "naxar",
      "telegram": "https://t.me/naxar_official"
    }
  },
  {
    "chainId": 101,
    "address": "5jqTNKonR9ZZvbmX9JHwcPSEg6deTyNKR7PxQ9ZPdd2w",
    "symbol": "JBUS",
    "name": "Jebus",
    "decimals": 0,
    "logoURI":
        "https://raw.githubusercontent.com/solana-labs/token-list/main/assets/mainnet/5jqTNKonR9ZZvbmX9JHwcPSEg6deTyNKR7PxQ9ZPdd2w/logo.png",
    "tags": [],
    "extensions": {"website": "https://jebus.live"}
  },
  {
    "chainId": 101,
    "address": "29UWGmi1MxJRi3izeritN8VvhZbUiX37KUVnGv46mzev",
    "symbol": "KLBx",
    "name": "Black Label X",
    "decimals": 4,
    "logoURI":
        "https://raw.githubusercontent.com/solana-labs/token-list/main/assets/mainnet/29UWGmi1MxJRi3izeritN8VvhZbUiX37KUVnGv46mzev/logo.svg",
    "tags": [],
    "extensions": {"website": "https://klbtoken.com/x"}
  },
  {
    "chainId": 101,
    "address": "GACHAfpmbpk4FLfZcGkT2NUmaEqMygssAknhqnn8DVHP",
    "symbol": "GACHA",
    "name": "Gachapon",
    "decimals": 9,
    "logoURI":
        "https://raw.githubusercontent.com/solana-labs/token-list/main/assets/mainnet/GACHAfpmbpk4FLfZcGkT2NUmaEqMygssAknhqnn8DVHP/logo.png",
    "tags": [],
    "extensions": {"twitter": "https://twitter.com/GACHAPON7777"}
  },
  {
    "chainId": 101,
    "address": "9zoqdwEBKWEi9G5Ze8BSkdmppxGgVv1Kw4LuigDiNr9m",
    "symbol": "STR",
    "name": "Solster",
    "decimals": 9,
    "logoURI":
        "https://raw.githubusercontent.com/solana-labs/token-list/main/assets/mainnet/9zoqdwEBKWEi9G5Ze8BSkdmppxGgVv1Kw4LuigDiNr9m/logo.png",
    "tags": [],
    "extensions": {
      "website": "https://solster.finance",
      "twitter": "https://twitter.com/solster_finance"
    }
  },
  {
    "chainId": 101,
    "address": "A2T2jDe2bxyEHkKtS8AtrTRmJ9VZRwyY8Kr7oQ8xNyfb",
    "symbol": "HAMS",
    "name": "Space Hamster",
    "decimals": 9,
    "logoURI":
        "https://raw.githubusercontent.com/solana-labs/token-list/main/assets/mainnet/A2T2jDe2bxyEHkKtS8AtrTRmJ9VZRwyY8Kr7oQ8xNyfb/logo.png",
    "tags": [],
    "extensions": {
      "website": "https://www.solhamster.space/",
      "twitter": "https://twitter.com/sol_hamster",
      "telegram": "https://t.me/SolHamster",
      "dex-website": "https://dex-solhamster.space/"
    }
  },
  {
    "chainId": 101,
    "address": "EGN2774kzKyUnJs2Gv5poK6ymiMVkdyCQD2gGnJ84sDk",
    "symbol": "NEFT",
    "name": "Neftea Labs Coin",
    "decimals": 9,
    "logoURI":
        "https://raw.githubusercontent.com/solana-labs/token-list/main/assets/mainnet/EGN2774kzKyUnJs2Gv5poK6ymiMVkdyCQD2gGnJ84sDk/logo.png",
    "tags": ["Neftea", "NFT", "utility-token"],
    "extensions": {"website": "https://www.neftealabs.com/"}
  },
  {
    "chainId": 101,
    "address": "DK64rmGSZupv1dLYn57e3pUVgs9jL9EKLXDVZZPsMDz8",
    "symbol": "ABOMB",
    "name": "ArtBomb",
    "decimals": 5,
    "logoURI":
        "https://raw.githubusercontent.com/solana-labs/token-list/main/assets/mainnet/DK64rmGSZupv1dLYn57e3pUVgs9jL9EKLXDVZZPsMDz8/logo.png",
    "tags": ["utility-token", "artbomb"],
    "extensions": {"website": "https://artbomb.xyz"}
  },
  {
    "chainId": 101,
    "address": "AnyCsr1VCBZcwVAxbKPuHhKDP5DQQSnRxGAo4ycgRMi2",
    "symbol": "DAL",
    "name": "Dalmatiancoin",
    "decimals": 9,
    "logoURI":
        "https://raw.githubusercontent.com/solana-labs/token-list/main/assets/mainnet/AnyCsr1VCBZcwVAxbKPuHhKDP5DQQSnRxGAo4ycgRMi2/logo.png",
    "tags": [],
    "extensions": {
      "website": "https://dalmatiancoin.org/",
      "twitter": "https://twitter.com/coindalmatian"
    }
  },
  {
    "chainId": 101,
    "address": "HiL1j5VMR9XtRnCA4mxaVoXr6PMHpbh8wUgfPsAP4CNF",
    "symbol": "SolNHD",
    "name": "SolNHD",
    "decimals": 9,
    "logoURI":
        "https://raw.githubusercontent.com/solana-labs/token-list/main/assets/mainnet/HiL1j5VMR9XtRnCA4mxaVoXr6PMHpbh8wUgfPsAP4CNF/logo.png",
    "tags": [],
    "extensions": {"website": "https://www.solnhd.com", "twitter": "https://twitter.com/zororoaz01"}
  },
  {
    "chainId": 101,
    "address": "qXu8Tj65H5XR8KHuaKKoyLCWj592KbTG3YWJwsuFrPS",
    "symbol": "STVA",
    "name": "SOLtiva",
    "decimals": 3,
    "logoURI":
        "https://raw.githubusercontent.com/solana-labs/token-list/main/assets/mainnet/qXu8Tj65H5XR8KHuaKKoyLCWj592KbTG3YWJwsuFrPS/logo.svg",
    "tags": [],
    "extensions": {
      "website": "https://soltiva.co",
      "serumV3Usdc": "8srnqriKDYXQNSiNh3F5qhkEt8USwWcJyeR65TxavoAf"
    }
  },
  {
    "chainId": 101,
    "address": "D3gHoiYT4RY5VSndne1fEnpM3kCNAyBhkp5xjNUqqPj9",
    "symbol": "PROEXIS",
    "name": "ProExis Prova de Existência Blockchain",
    "decimals": 9,
    "logoURI":
        "https://raw.githubusercontent.com/solana-labs/token-list/main/assets/mainnet/D3gHoiYT4RY5VSndne1fEnpM3kCNAyBhkp5xjNUqqPj9/logo.png",
    "tags": ["proof of-existence", "utility-token", "prova de existencia", "proexis"],
    "extensions": {
      "website": "https://provadeexistencia.com.br",
      "twitter": "https://twitter.com/provaexistencia",
      "facebook": "https://facebook.com/provadeexistencia",
      "instagram": "https://instagram.com/provadeexistencia",
      "github": "https://github.com/provadeexistencia",
      "tgann": "https://t.me/provadeexistencia",
      "tggroup": "https://t.me/provadeexistenciagrupo"
    }
  },
  {
    "chainId": 101,
    "address": "5DWFxYBxjETuqFX3P2Z1uq8UbcCT1F4sABGiBZMnWKvR",
    "symbol": "PLDO",
    "name": "PLEIDO",
    "decimals": 6,
    "logoURI":
        "https://raw.githubusercontent.com/solana-labs/token-list/main/assets/mainnet/5DWFxYBxjETuqFX3P2Z1uq8UbcCT1F4sABGiBZMnWKvR/logo.svg",
    "tags": ["pleido", "game-coin"],
    "extensions": {"website": "https://pleido.com/"}
  },
  {
    "chainId": 101,
    "address": "6uB5eEC8SzMbUdsPpe3eiNvHyvxdqUWnDEtpFQxkhNTP",
    "symbol": "MOLANIUM",
    "name": "MOLANIUM",
    "decimals": 0,
    "logoURI":
        "https://raw.githubusercontent.com/solana-labs/token-list/main/assets/mainnet/6uB5eEC8SzMbUdsPpe3eiNvHyvxdqUWnDEtpFQxkhNTP/logo.png",
    "tags": [],
    "extensions": {
      "website": "https://moonlana.com/",
      "imageUrl": "https://i.imgur.com/hOMe38E.png",
      "twitter": "https://twitter.com/xMoonLana",
      "medium": "https://moonlana.medium.com/"
    }
  },
  {
    "chainId": 101,
    "address": "5KV2W2XPdSo97wQWcuAVi6G4PaCoieg4Lhhi61PAMaMJ",
    "symbol": "GÜ",
    "name": "GÜ",
    "decimals": 9,
    "logoURI":
        "https://raw.githubusercontent.com/solana-labs/token-list/main/assets/mainnet/5KV2W2XPdSo97wQWcuAVi6G4PaCoieg4Lhhi61PAMaMJ/logo.png",
    "tags": ["utility-token"],
    "extensions": {
      "website": "https://kugle.org",
      "twitter": "https://twitter.com/Kugle_",
      "coingeckoId": "gu"
    }
  },
  {
    "chainId": 101,
    "address": "72fFy4SNGcHoEC1TTFTUkxNHriJqg3hBPsa2jSr2cZgb",
    "symbol": "BZX",
    "name": "BlizeX",
    "decimals": 6,
    "logoURI":
        "https://raw.githubusercontent.com/solana-labs/token-list/main/assets/mainnet/72fFy4SNGcHoEC1TTFTUkxNHriJqg3hBPsa2jSr2cZgb/logo.png",
    "tags": [],
    "extensions": {"website": "https://www.blizex.co", "twitter": "https://twitter.com/blizex_en"}
  },
  {
    "chainId": 101,
    "address": "5fEo6ZbvpV6zdyzowtAwgMcWHZe1yJy9NxQM6gC19QW5",
    "symbol": "GREEN",
    "name": "Green DEX",
    "decimals": 9,
    "logoURI":
        "https://raw.githubusercontent.com/solana-labs/token-list/main/assets/mainnet/5fEo6ZbvpV6zdyzowtAwgMcWHZe1yJy9NxQM6gC19QW5/logo.svg",
    "tags": ["Green DEX"],
    "extensions": {
      "website": "https://greendex.network/",
      "twitter": "https://twitter.com/GreendexN"
    }
  },
  {
    "chainId": 101,
    "address": "Bx1fDtvTN6NvE4kjdPHQXtmGSg582bZx9fGy4DQNMmAT",
    "symbol": "SOLC",
    "name": "Solcubator",
    "decimals": 9,
    "logoURI":
        "https://raw.githubusercontent.com/solana-labs/token-list/main/assets/mainnet/Bx1fDtvTN6NvE4kjdPHQXtmGSg582bZx9fGy4DQNMmAT/logo.png",
    "tags": [],
    "extensions": {"website": "http://solcubator.io", "twitter": "https://twitter.com/Solcubator"}
  },
  {
    "chainId": 101,
    "address": "ABxCiDz4jjKt1t7Syu5Tb37o8Wew9ADpwngZh6kpLbLX",
    "symbol": "XSOL",
    "name": "XSOL Token",
    "decimals": 8,
    "logoURI":
        "https://raw.githubusercontent.com/solana-labs/token-list/main/assets/mainnet/ABxCiDz4jjKt1t7Syu5Tb37o8Wew9ADpwngZh6kpLbLX/logo.png",
    "tags": ["utility-token"],
    "extensions": {
      "website": "https://0xsol.network",
      "twitter": "https://twitter.com/0xSol_Network"
    }
  },
  {
    "chainId": 101,
    "address": "DrcPRJPBiakQcWqon3gZms7sviAqdQS5zS5wvaG5v6wu",
    "symbol": "BLD",
    "name": "BladesToken",
    "decimals": 4,
    "logoURI":
        "https://raw.githubusercontent.com/solana-labs/token-list/main/assets/mainnet/DrcPRJPBiakQcWqon3gZms7sviAqdQS5zS5wvaG5v6wu/logo.png",
    "tags": [],
    "extensions": {
      "website": "https://blades.finance/",
      "twitter": "https://twitter.com/bladesfinance"
    }
  },
  {
    "chainId": 101,
    "address": "6D7E4mstMboABmfoaPrtVDgewjUCbGdvcYVaHa9SDiTg",
    "symbol": "QWK",
    "name": "QwikPay.io Token",
    "decimals": 9,
    "logoURI":
        "https://raw.githubusercontent.com/solana-labs/token-list/main/assets/mainnet/6D7E4mstMboABmfoaPrtVDgewjUCbGdvcYVaHa9SDiTg/logo.png",
    "tags": [],
    "extensions": {"website": "https://www.qwikpay.io", "twitter": "https://twitter.com/QwikpayIO"}
  },
  {
    "chainId": 101,
    "address": "BTyJg5zMbaN2KMfn7LsKhpUsV675aCUSUMrgB1YGxBBP",
    "symbol": "GOOSEBERRY",
    "name": "Gooseberry",
    "decimals": 9,
    "logoURI":
        "https://raw.githubusercontent.com/solana-labs/token-list/main/assets/mainnet/BTyJg5zMbaN2KMfn7LsKhpUsV675aCUSUMrgB1YGxBBP/logo.png",
    "tags": [],
    "extensions": {
      "website": "https://gooseberry.changr.ca",
      "twitter": "https://twitter.com/gooseberrycoin"
    }
  },
  {
    "chainId": 101,
    "address": "5GG1LbgY4EEvPR51YQPNr65QKcZemrHWPooTqC5gRPBA",
    "symbol": "DXB",
    "name": "DefiXBet Token",
    "decimals": 9,
    "logoURI":
        "https://raw.githubusercontent.com/solana-labs/token-list/main/assets/mainnet/5GG1LbgY4EEvPR51YQPNr65QKcZemrHWPooTqC5gRPBA/logo.png",
    "tags": [],
    "extensions": {
      "website": "https://DefiXBet.com/",
      "twitter": "https://twitter.com/DefiXBet",
      "medium": "https://defixbet.medium.com/",
      "tgann": "https://t.me/DefiXBet"
    }
  },
  {
    "chainId": 101,
    "address": "7a4cXVvVT7kF6hS5q5LDqtzWfHfys4a9PoK6pf87RKwf",
    "symbol": "LUNY",
    "name": "Luna Yield",
    "decimals": 9,
    "logoURI":
        "https://raw.githubusercontent.com/solana-labs/token-list/main/assets/mainnet/7a4cXVvVT7kF6hS5q5LDqtzWfHfys4a9PoK6pf87RKwf/logo.png",
    "tags": [],
    "extensions": {
      "website": "https://www.lunayield.com",
      "twitter": "https://twitter.com/Luna_Yield"
    }
  },
  {
    "chainId": 101,
    "address": "AP58G14hoy4GGgZS4L8TzZgqXnk3hBvciFKW2Cb1RQ2J",
    "symbol": "YARDv1",
    "name": "SolYard Finance Beta",
    "decimals": 9,
    "logoURI":
        "https://raw.githubusercontent.com/solana-labs/token-list/main/assets/mainnet/AP58G14hoy4GGgZS4L8TzZgqXnk3hBvciFKW2Cb1RQ2J/logo.png",
    "tags": [],
    "extensions": {"website": "https://solyard.finance/"}
  },
  {
    "chainId": 101,
    "address": "6Y7LbYB3tfGBG6CSkyssoxdtHb77AEMTRVXe8JUJRwZ7",
    "symbol": "DINO",
    "name": "DINO",
    "decimals": 6,
    "logoURI":
        "https://raw.githubusercontent.com/solana-labs/token-list/main/assets/mainnet/6Y7LbYB3tfGBG6CSkyssoxdtHb77AEMTRVXe8JUJRwZ7/logo.png",
    "tags": [],
    "extensions": {
      "website": "https://www.solanadino.com",
      "twitter": "https://twitter.com/solanadino"
    }
  },
  {
    "chainId": 101,
    "address": "4wjPQJ6PrkC4dHhYghwJzGBVP78DkBzA2U3kHoFNBuhj",
    "symbol": "LIQ",
    "name": "LIQ Protocol",
    "decimals": 6,
    "logoURI":
        "https://raw.githubusercontent.com/solana-labs/token-list/main/assets/mainnet/4wjPQJ6PrkC4dHhYghwJzGBVP78DkBzA2U3kHoFNBuhj/logo.png",
    "tags": [],
    "extensions": {
      "website": "https://liqsolana.com/",
      "coingeckoId": "liq-protocol",
      "twitter": "https://twitter.com/liqsolana",
      "discord": "https://discord.gg/MkfjambeU7",
      "serumV3Usdc": "FLKUQGh9VAG4otn4njLPUf5gaUPx5aAZ2Q6xWiD3hH5u"
    }
  },
  {
    "chainId": 101,
    "address": "DubwWZNWiNGMMeeQHPnMATNj77YZPZSAz2WVR5WjLJqz",
    "symbol": "CRP",
    "name": "CropperFinance",
    "decimals": 9,
    "logoURI":
        "https://raw.githubusercontent.com/solana-labs/token-list/main/assets/mainnet/DubwWZNWiNGMMeeQHPnMATNj77YZPZSAz2WVR5WjLJqz/logo.png",
    "tags": [],
    "extensions": {
      "website": "https://cropper.finance/",
      "twitter": "https://twitter.com/cropperfinance"
    }
  },
  {
    "chainId": 101,
    "address": "B3Ggjjj3QargPkFTAJiR6BaD8CWKFUaWRXGcDQ1nyeeD",
    "symbol": "PARTI",
    "name": "PARTI",
    "decimals": 9,
    "logoURI":
        "https://raw.githubusercontent.com/solana-labs/token-list/main/assets/mainnet/B3Ggjjj3QargPkFTAJiR6BaD8CWKFUaWRXGcDQ1nyeeD/logo.png",
    "tags": [],
    "extensions": {
      "website": "https://parti.finance",
      "twitter": "https://twitter.com/ParticleFinance",
      "medium": "https://particlefinance.medium.com"
    }
  },
  {
    "chainId": 101,
    "address": "5igDhdTnXif5E5djBpRt4wUKo5gtf7VicHi8r5ada4Hj",
    "symbol": "NIA",
    "name": "NIALABS",
    "decimals": 0,
    "logoURI":
        "https://raw.githubusercontent.com/solana-labs/token-list/main/assets/mainnet/5igDhdTnXif5E5djBpRt4wUKo5gtf7VicHi8r5ada4Hj/logo.png",
    "tags": [],
    "extensions": {"website": "https://www.nialabs.com/"}
  },
  {
    "chainId": 101,
    "address": "GQnN5M1M6oTjsziAwcRYd1P7pRBBQKURj5QeAjN1npnE",
    "symbol": "CORV",
    "name": "Project Corvus",
    "decimals": 9,
    "logoURI":
        "https://raw.githubusercontent.com/solana-labs/token-list/main/assets/mainnet/GQnN5M1M6oTjsziAwcRYd1P7pRBBQKURj5QeAjN1npnE/logo.png",
    "tags": [],
    "extensions": {"website": "https://dixon.company/"}
  },
  {
    "chainId": 101,
    "address": "3FRQnT5djQMATCg6TNXBhi2bBkbTyGdywsLmLa8BbEKz",
    "symbol": "HLTH",
    "name": "HLTH",
    "decimals": 4,
    "logoURI":
        "https://raw.githubusercontent.com/solana-labs/token-list/main/assets/mainnet/3FRQnT5djQMATCg6TNXBhi2bBkbTyGdywsLmLa8BbEKz/logo.png",
    "extensions": {
      "website": "https://hlth.network/",
      "twitter": "https://twitter.com/hlthnetwork",
      "telegram": "https://t.me/HLTHnetwork"
    }
  },
  {
    "chainId": 101,
    "address": "SLRSSpSLUTP7okbCUBYStWCo1vUgyt775faPqz8HUMr",
    "symbol": "SLRS",
    "name": "Solrise Finance",
    "decimals": 6,
    "logoURI":
        "https://raw.githubusercontent.com/solana-labs/token-list/main/assets/mainnet/SLRSSpSLUTP7okbCUBYStWCo1vUgyt775faPqz8HUMr/logo.png",
    "tags": [],
    "extensions": {
      "website": "https://solrise.finance",
      "twitter": "https://twitter.com/SolriseFinance",
      "telegram": "https://t.me/solrisefinance",
      "medium": "https://blog.solrise.finance",
      "discord": "https://discord.gg/xNbGgMUJfU",
      "serumV3Usdc": "2Gx3UfV831BAh8uQv1FKSPKS9yajfeeD8GJ4ZNb2o2YP",
      "coingeckoId": "solrise-finance"
    }
  },
  {
    "chainId": 101,
    "address": "Hejznrp39zCfcmq4WpihfAeyhzhqeFtj4PURHFqMaHSS",
    "symbol": "SE",
    "name": "Snake Eyes",
    "decimals": 9,
    "logoURI":
        "https://raw.githubusercontent.com/solana-labs/token-list/main/assets/mainnet/Hejznrp39zCfcmq4WpihfAeyhzhqeFtj4PURHFqMaHSS/logo.png",
    "tags": [],
    "extensions": {"discord": "https://discord.gg/g94SubKn"}
  },
  {
    "chainId": 101,
    "address": "Fx14roJm9m27zngJQwmt81npHvPc5pmF772nxDhNnsh5",
    "symbol": "LIQ-USDC",
    "name": "Raydium LP Token (LIQ-USDC)",
    "decimals": 6,
    "logoURI":
        "https://raw.githubusercontent.com/solana-labs/token-list/main/assets/mainnet/AKJHspCwDhABucCxNLXUSfEzb7Ny62RqFtC9uNjJi4fq/logo.png",
    "tags": ["lp-token"],
    "extensions": {"website": "https://raydium.io/"}
  },
  {
    "chainId": 101,
    "address": "D7U3BPHr5JBbFmPTaVNpmEKGBPFdQS3udijyte1QtuLk",
    "symbol": "STAR",
    "name": "SolStar",
    "decimals": 9,
    "logoURI":
        "https://raw.githubusercontent.com/solana-labs/token-list/main/assets/mainnet/D7U3BPHr5JBbFmPTaVNpmEKGBPFdQS3udijyte1QtuLk/logo.png",
    "tags": ["community", "web3", "utility-token"],
    "extensions": {
      "website": "https://solstar.finance",
      "twitter": "https://twitter.com/SolStarFinance",
      "discord": "https://discord.gg/j6B3q5Xk5N",
      "medium": "https://solstar.medium.com",
      "telegram": "https://t.me/SolStarFinance"
    }
  },
  {
    "chainId": 101,
    "address": "GtQ48z7NNjs7sVyp3M7iuiDcTRjeWPd1fkdiWQNy1UR6",
    "symbol": "LIQ-SOL",
    "name": "Raydium LP Token (LIQ-SOL)",
    "decimals": 6,
    "logoURI":
        "https://raw.githubusercontent.com/solana-labs/token-list/main/assets/mainnet/AKJHspCwDhABucCxNLXUSfEzb7Ny62RqFtC9uNjJi4fq/logo.png",
    "tags": ["lp-token"],
    "extensions": {"website": "https://raydium.io/"}
  },
  {
    "chainId": 101,
    "address": "DHojuFwy5Pb8HTUhyRGQ285s5KYgk8tGAjAcmjkEAGbY",
    "symbol": "RFK",
    "name": "Refrak",
    "decimals": 2,
    "logoURI":
        "https://raw.githubusercontent.com/solana-labs/token-list/main/assets/mainnet/DHojuFwy5Pb8HTUhyRGQ285s5KYgk8tGAjAcmjkEAGbY/logo.png",
    "tags": [],
    "extensions": {"website": "https://refrak.io/", "discord": "https://discord.gg/ZAWbnebFVK"}
  },
  {
    "chainId": 101,
    "address": "JAhTGv1g19KzE2n58Jzhxpu5SSNioanAzj3wL7epiNUL",
    "symbol": "RFKP",
    "name": "Refrak Platinum",
    "decimals": 8,
    "logoURI":
        "https://raw.githubusercontent.com/solana-labs/token-list/main/assets/mainnet/JAhTGv1g19KzE2n58Jzhxpu5SSNioanAzj3wL7epiNUL/logo.png",
    "tags": [],
    "extensions": {"website": "https://refrak.io/", "discord": "https://discord.gg/ZAWbnebFVK"}
  },
  {
    "chainId": 101,
    "address": "7Jimij6hkEjjgmf3HamW44d2Cf5kj2gHnfCDDPGxWut",
    "symbol": "GQO",
    "name": "GIGQO",
    "decimals": 9,
    "logoURI": "https://gigqo.com/images/new-gqo-logo.png",
    "tags": [],
    "extensions": {"website": "https://gigqo.com/", "twitter": "https://twitter.com/gigqoapp"}
  },
  {
    "chainId": 101,
    "address": "E5rk3nmgLUuKUiS94gg4bpWwWwyjCMtddsAXkTFLtHEy",
    "symbol": "WOO",
    "name": "Wootrade Network",
    "decimals": 6,
    "logoURI":
        "https://raw.githubusercontent.com/solana-labs/token-list/main/assets/mainnet/E5rk3nmgLUuKUiS94gg4bpWwWwyjCMtddsAXkTFLtHEy/logo.png",
    "tags": [],
    "extensions": {"website": "https://woo.network", "twitter": "https://twitter.com/wootraderS"}
  },
  {
    "chainId": 101,
    "address": "9s6dXtMgV5E6v3rHqBF2LejHcA2GWoZb7xNUkgXgsBqt",
    "symbol": "USDC-USDT-PAI",
    "name": "Mercurial LP Token (USDC-USDT-PAI)",
    "decimals": 6,
    "logoURI":
        "https://raw.githubusercontent.com/solana-labs/token-list/main/assets/mainnet/9s6dXtMgV5E6v3rHqBF2LejHcA2GWoZb7xNUkgXgsBqt/logo.png",
    "tags": ["lp-token"],
    "extensions": {"website": "https://www.mercurial.finance/"}
  },
  {
    "chainId": 101,
    "address": "8kRacWW5qZ34anyH8s9gu2gC4FpXtncqBDPpd2a6DnZE",
    "symbol": "MECA",
    "name": "Coinmeca",
    "decimals": 9,
    "logoURI":
        "https://raw.githubusercontent.com/solana-labs/token-list/main/assets/mainnet/8kRacWW5qZ34anyH8s9gu2gC4FpXtncqBDPpd2a6DnZE/logo.svg",
    "tags": ["utility-token"],
    "extensions": {
      "website": "https://coinmeca.net/",
      "medium": "https://coinmeca.medium.com/",
      "twitter": "https://twitter.com/coinmeca",
      "telegram": "https://t.me/coinmeca",
      "discord": "https://discord.gg/coinmeca",
      "reddit": "https://reddit.com/r/coinmeca"
    }
  },
  {
    "chainId": 101,
    "address": "6h6uy8yAfaAb5sPE2bvXQEB93LnUMEdcCRU2kfiErTct",
    "symbol": "ZMR",
    "name": "ZMIRROR",
    "decimals": 9,
    "logoURI":
        "https://raw.githubusercontent.com/solana-labs/token-list/main/assets/mainnet/6h6uy8yAfaAb5sPE2bvXQEB93LnUMEdcCRU2kfiErTct/logo.JPG",
    "tags": []
  },
  {
    "chainId": 101,
    "address": "sodaNXUbtjMvHe9c5Uw7o7VAcVpXPHAvtaRaiPVJQuE",
    "symbol": "SODA",
    "name": "cheesesoda token",
    "decimals": 0,
    "logoURI":
        "https://raw.githubusercontent.com/solana-labs/token-list/main/assets/mainnet/sodaNXUbtjMvHe9c5Uw7o7VAcVpXPHAvtaRaiPVJQuE/logo.svg",
    "tags": [],
    "extensions": {
      "website": "https://token.cheesesoda.com",
      "twitter": "https://twitter.com/cheesesodadex",
      "serumV3Usdc": "6KFs2wUzME8Z3AeWL4HfKkXbtik5zVvebdg5qCxqt4hB",
      "coingeckoId": "cheesesoda-token"
    }
  },
  {
    "chainId": 101,
    "address": "sodaoT6Wh1nxHaarw4kDh7AkK4oZnERK1QgDUtHPR3H",
    "symbol": "SODAO",
    "name": "cheesesodaDAO",
    "decimals": 4,
    "logoURI":
        "https://raw.githubusercontent.com/solana-labs/token-list/main/assets/mainnet/sodaoT6Wh1nxHaarw4kDh7AkK4oZnERK1QgDUtHPR3H/logo.svg",
    "tags": [],
    "extensions": {
      "website": "https://dao.cheesesoda.com",
      "twitter": "https://twitter.com/cheesesodadex"
    }
  },
  {
    "chainId": 101,
    "address": "49YUsDrThJosHSagCn1F59Uc9NRxbr9thVrZikUnQDXy",
    "symbol": "LIQ-RAY",
    "name": "Raydium LP Token (LIQ-RAY)",
    "decimals": 6,
    "logoURI":
        "https://raw.githubusercontent.com/solana-labs/token-list/main/assets/mainnet/AKJHspCwDhABucCxNLXUSfEzb7Ny62RqFtC9uNjJi4fq/logo.png",
    "tags": ["lp-token"],
    "extensions": {"website": "https://raydium.io/"}
  },
  {
    "chainId": 101,
    "address": "FGmeGqUqKzVX2ajkXaFSQxNcBRWnJg1vi5fugRJrDJ3k",
    "symbol": "FCS",
    "name": "FCS",
    "decimals": 9,
    "logoURI":
        "https://raw.githubusercontent.com/solana-labs/token-list/main/assets/mainnet/FGmeGqUqKzVX2ajkXaFSQxNcBRWnJg1vi5fugRJrDJ3k/logo.png",
    "tags": [],
    "extensions": {"website": "https://www.fcs.com/"}
  },
  {
    "chainId": 101,
    "address": "CjpDCj8zLSM37669qng5znYP25JuoDPCvLSLLd7pxAsr",
    "symbol": "Nordic Energy Token",
    "name": "NET",
    "decimals": 9,
    "logoURI":
        "https://raw.githubusercontent.com/solana-labs/token-list/main/assets/mainnet/CjpDCj8zLSM37669qng5znYP25JuoDPCvLSLLd7pxAsr/logo.png",
    "tags": [],
    "extensions": {
      "website": "https://nordicenergy.io/",
      "twitter": "https://twitter.com/nordicenergy1",
      "telegram": "https://t.me/nordicenergy"
    }
  },
  {
    "chainId": 101,
    "address": "9eaAUFp7S38DKXxbjwzEG8oq1H1AipPkUuieUkVJ9krt",
    "symbol": "KDC",
    "name": "KDC (KURZ Digital Currency)",
    "decimals": 2,
    "logoURI": "https://kurzdigital.com/images/KDC_logo.png",
    "tags": ["stablecoin", "kdc"],
    "extensions": {"website": "https://www.kurzdigital.com"}
  },
  {
    "chainId": 101,
    "address": "A1C9Shy732BThWvHAN936f33N7Wm1HbFvxb2zDSoBx8F",
    "symbol": "PKR2",
    "name": "PKR2",
    "decimals": 9,
    "logoURI":
        "https://raw.githubusercontent.com/C-e-r-b-e-r-u-s/token-list/main/assets/mainnet/A1C9Shy732BThWvHAN936f33N7Wm1HbFvxb2zDSoBx8F/pkr2-logo.png",
    "tags": ["https://www.pokerrrrapp.com/", "Club Code: 03m91"],
    "extensions": {
      "website": "https://twitter.com/PKR2_Token",
      "twitter": "https://twitter.com/PKR2_Token",
      "serumV3Usdt": "AUYZV5BbKePrAkMiWCMhc1EbZCPNHDrK7Jf8jYy8noF6",
      "description": "A new architecture for a high performance money powered by Solana."
    }
  },
  {
    "chainId": 101,
    "address": "35KgRun5UMT2Kjtjw4cNG1tXHcgBxuxji6Yp6ciz7yX7",
    "symbol": "VPE",
    "name": "VPOWER",
    "decimals": 9,
    "logoURI":
        "https://raw.githubusercontent.com/solana-labs/token-list/main/assets/mainnet/35KgRun5UMT2Kjtjw4cNG1tXHcgBxuxji6Yp6ciz7yX7/logo.png",
    "extensions": {
      "website": "https://vpowerswap.com/",
      "twitter": "https://twitter.com/vpowerswap",
      "telegram": "https://t.me/vpowerswap_channel"
    }
  },
  {
    "chainId": 101,
    "address": "GSaiLQxREzaxUcE3v28HxBacoUQPZNtXx1eQsCFsX9Bg",
    "symbol": "XgSAIL",
    "name": "gSAIL DEPRECATED",
    "decimals": 9,
    "logoURI":
        "https://raw.githubusercontent.com/solana-labs/token-list/main/assets/mainnet/GSaiLQxREzaxUcE3v28HxBacoUQPZNtXx1eQsCFsX9Bg/logo.png",
    "tags": ["utility-token"],
    "extensions": {
      "website": "https://www.solanasail.com",
      "twitter": "https://twitter.com/SolanaSail"
    }
  },
  {
    "chainId": 101,
    "address": "ELyNEh5HC33sQLhGiQ5dimmwqiJCiqVJp3eQxpX3pKhQ",
    "symbol": "JCS",
    "name": "Jogys Crypto School Token",
    "decimals": 9,
    "logoURI":
        "https://raw.githubusercontent.com/solana-labs/token-list/main/assets/mainnet/ELyNEh5HC33sQLhGiQ5dimmwqiJCiqVJp3eQxpX3pKhQ/logo.png",
    "tags": [],
    "extensions": {
      "website": "https://instagram.com/jogyscryptoschool?utm_medium=copy_link",
      "instagram": "https://instagram.com/jogyscryptoschool?utm_medium=copy_link",
      "telegram": "https://t.me/JCS_JogysCryptoSchool"
    }
  },
  {
    "chainId": 101,
    "address": "3bRTivrVsitbmCTGtqwp7hxXPsybkjn4XLNtPsHqa3zR",
    "symbol": "LIKE",
    "name": "Only1 (LIKE)",
    "decimals": 9,
    "logoURI": "https://only1.io/like-token.svg",
    "tags": ["utility-token"],
    "extensions": {
      "website": "https://only1.io/",
      "medium": "https://only1nft.medium.com/",
      "twitter": "https://twitter.com/only1nft",
      "telegram": "https://t.me/only1nft",
      "discord": "https://discord.gg/SrsKwTFA",
      "coingeckoId": "only1"
    }
  },
  {
    "chainId": 101,
    "address": "CXLBjMMcwkc17GfJtBos6rQCo1ypeH6eDbB82Kby4MRm",
    "symbol": "wUST",
    "name": "Wrapped UST (Wormhole)",
    "decimals": 9,
    "logoURI":
        "https://raw.githubusercontent.com/solana-labs/token-list/main/assets/mainnet/CXLBjMMcwkc17GfJtBos6rQCo1ypeH6eDbB82Kby4MRm/logo.png",
    "tags": ["wrapped", "wormhole"],
    "extensions": {
      "website": "https://terra.money",
      "address": "0xa47c8bf37f92aBed4A126BDA807A7b7498661acD",
      "bridgeContract": "https://etherscan.io/address/0xf92cD566Ea4864356C5491c177A430C222d7e678",
      "assetContract": "https://etherscan.io/address/0xa47c8bf37f92aBed4A126BDA807A7b7498661acD",
      "coingeckoId": "terrausd"
    }
  },
  {
    "chainId": 101,
    "address": "A7SXXA9wveT2quqqzh5m6Zf3ueCb9kBezQdpnYxHwzLt",
    "symbol": "ZINTI",
    "name": "Zia Inti",
    "decimals": 9,
    "logoURI":
        "https://raw.githubusercontent.com/solana-labs/token-list/main/assets/mainnet/A7SXXA9wveT2quqqzh5m6Zf3ueCb9kBezQdpnYxHwzLt/logo.png",
    "tags": [],
    "extensions": {"website": "https://www.ziainti.com/"}
  },
  {
    "chainId": 101,
    "address": "3Ztt53vwGhQGoEp3n1RjSu4CFnGRfqzwo6L8KN8gmXfd",
    "symbol": "METAS",
    "name": "METASEER",
    "decimals": 9,
    "logoURI": "https://metaseer.io/img/home-one/logo256.png",
    "tags": ["utility-token"],
    "extensions": {
      "website": "https://metaseer.io/",
      "twitter": "https://twitter.com/MSEERofficial"
    }
  },
  {
    "chainId": 101,
    "address": "EssczqGURZtsSuzEoH471KCRNDWfS4aQpEJVXWL3DvdK",
    "symbol": "VIVA",
    "name": "Viva coin",
    "decimals": 9,
    "logoURI":
        "https://raw.githubusercontent.com/solana-labs/token-list/main/assets/mainnet/EssczqGURZtsSuzEoH471KCRNDWfS4aQpEJVXWL3DvdK/logo.png",
    "tags": ["utility-token"],
    "extensions": {
      "website": "https://www.inkresearch.com",
      "twitter": "https://twitter.com/inkresearch"
    }
  },
  {
    "chainId": 101,
    "address": "EWS2ATMt5fQk89NWLJYNRmGaNoji8MhFZkUB4DiWCCcz",
    "symbol": "SOLBERRY",
    "name": "SOLBERRY",
    "decimals": 6,
    "logoURI":
        "https://raw.githubusercontent.com/solana-labs/token-list/main/assets/mainnet/EWS2ATMt5fQk89NWLJYNRmGaNoji8MhFZkUB4DiWCCcz/logo.png",
    "tags": [],
    "extensions": {
      "website": "https://www.solberry.tech",
      "twitter": "https://twitter.com/berrysol"
    }
  },
  {
    "chainId": 101,
    "address": "FJJT7yUJM9X9SHpkVr4wLgyfJ3vtVLoReUqTsCPWzof2",
    "symbol": "KEKW-USDC",
    "name": "Raydium LP Token (KEKW-USDC)",
    "decimals": 9,
    "logoURI": "https://www.kekw.io/images/kekwusdc.png",
    "tags": ["lp-token"],
    "extensions": {
      "website": "https://kekw.io/",
      "twitter": "https://twitter.com/kekwcoin",
      "medium": "https://kekwcoin.medium.com/",
      "discord": "https://discord.gg/kekw"
    }
  },
  {
    "chainId": 101,
    "address": "5Z6jnA9fDUDVjQyaTbYWwCTE47wMAuyvAQjg5angY12C",
    "symbol": "DNDZ",
    "name": "Dinarius Token",
    "decimals": 9,
    "logoURI": "https://raw.githubusercontent.com/Boukezzoula/Dinarius/master/dinariuslogo.png",
    "tags": ["stablecoin"],
    "extensions": {"website": "http://dinarius.net"}
  },
  {
    "chainId": 101,
    "address": "EqbY2zaTsJesaVviL5unHKjDsjoQZJhQAQz3iWQxAu1X",
    "symbol": "RnV",
    "name": "RADONTOKEN",
    "decimals": 9,
    "logoURI":
        "https://raw.githubusercontent.com/solana-labs/token-list/main/assets/mainnet/EqbY2zaTsJesaVviL5unHKjDsjoQZJhQAQz3iWQxAu1X/logo.png",
    "tags": [],
    "extensions": {"website": "https://www.radonvalue.com/"}
  },
  {
    "chainId": 101,
    "address": "5pXLmRJyfrTDYMCp1xyiqRDcbb7vYjYiMYzhBza2ht62",
    "symbol": "CRYN",
    "name": "Crayon",
    "decimals": 6,
    "logoURI":
        "https://raw.githubusercontent.com/solana-labs/token-list/main/assets/mainnet/5pXLmRJyfrTDYMCp1xyiqRDcbb7vYjYiMYzhBza2ht62/crayon.png",
    "tags": [],
    "extensions": {
      "website": "https://solanacrayon.com",
      "twitter": "https://twitter.com/SolanaCrayon",
      "serumV3Usdc": "CjBssusBjX4b2UBvMZhiZCQshW1afpQPA1Mv29Chn6vj",
      "description": "Crayon is a meme token, Dex, and Dapps on Solana."
    }
  },
  {
    "chainId": 101,
    "address": "z9WZXekbCtwoxyfAwEJn1euXybvqLzPVv3NDzJzkq7C",
    "symbol": "CRC",
    "name": "Care Coin Token",
    "decimals": 9,
    "logoURI":
        "https://raw.githubusercontent.com/solana-labs/token-list/main/assets/mainnet/z9WZXekbCtwoxyfAwEJn1euXybvqLzPVv3NDzJzkq7C/logo.png",
    "tags": [],
    "extensions": {
      "twitter": " https://twitter.com/carecointoken_",
      "website": "https://www.carecoin.site"
    }
  },
  {
    "chainId": 101,
    "address": "9aPjLUGR9e6w6xU2NEQNtP3jg3mq2mJjSUZoQS4RKz35",
    "symbol": "SOUL",
    "name": "Soulana",
    "decimals": 9,
    "logoURI":
        "https://raw.githubusercontent.com/solana-labs/token-list/main/assets/mainnet/9aPjLUGR9e6w6xU2NEQNtP3jg3mq2mJjSUZoQS4RKz35/logo.png",
    "tags": [],
    "extensions": {"twitter": "https://twitter.com/Soulanadefi"}
  },
  {
    "chainId": 101,
    "address": "26W4xxHbWJfrswaMNh14ag2s4PZTQuu2ypHGj6YEVXkT",
    "symbol": "DCASH",
    "name": "Diabolo Token",
    "decimals": 9,
    "logoURI":
        "https://raw.githubusercontent.com/solana-labs/token-list/main/assets/mainnet/26W4xxHbWJfrswaMNh14ag2s4PZTQuu2ypHGj6YEVXkT/dcash-logo.png",
    "tags": [],
    "extensions": {"website": "https://diabolo.io"}
  },
  {
    "chainId": 101,
    "address": "8CWgMvZe7ntNLbky4T3JhSgtCYzeorgRiUY8xfXZztXx",
    "symbol": "IOTC",
    "name": "IoTcoin",
    "decimals": 9,
    "logoURI":
        "https://raw.githubusercontent.com/solana-labs/token-list/main/assets/mainnet/8CWgMvZe7ntNLbky4T3JhSgtCYzeorgRiUY8xfXZztXx/logo.jpg",
    "tags": [],
    "extensions": {
      "website": "https://www.iotworlds.com",
      "twitter": "https://twitter.com/iotworlds",
      "facebook": "https://facebook.com/iotworlds",
      "instagram": "https://instagram.com/iotworlds",
      "linkedin": "https://www.linkedin.com/company/iotworlds"
    }
  },
  {
    "chainId": 101,
    "address": "FqJE1neoCJrRwxfC9mRL6FduuZ1gCX2FUbya5hi8EQgA",
    "symbol": "VLDC",
    "name": "Viloid Coin",
    "decimals": 9,
    "logoURI":
        "https://raw.githubusercontent.com/solana-labs/token-list/main/assets/mainnet/FqJE1neoCJrRwxfC9mRL6FduuZ1gCX2FUbya5hi8EQgA/logo.png",
    "tags": ["social-token"],
    "extensions": {"website": "https://viloidcoin.com", "github": "https://github.com/viloidcoin"}
  },
  {
    "chainId": 101,
    "address": "C98A4nkJXhpVZNAZdHUA95RpTF3T4whtQubL3YobiUX9",
    "symbol": "C98",
    "name": "Coin98",
    "decimals": 6,
    "waterfallbot": "https://bit.ly/C98waterfall",
    "logoURI": "https://coin98.s3.ap-southeast-1.amazonaws.com/Coin/c98-512.svg",
    "tags": ["social-token"],
    "extensions": {
      "website": "https://coin98.com",
      "twitter": "https://twitter.com/coin98_finance",
      "telegram": "https://t.me/coin98_finance",
      "github": "https://github.com/coin98",
      "coingeckoId": "coin98"
    }
  },
  {
    "chainId": 101,
    "address": "Saber2gLauYim4Mvftnrasomsv6NvAuncvMEZwcLpD1",
    "symbol": "SBR",
    "name": "Saber Protocol Token",
    "decimals": 6,
    "logoURI":
        "https://raw.githubusercontent.com/solana-labs/token-list/main/assets/mainnet/Saber2gLauYim4Mvftnrasomsv6NvAuncvMEZwcLpD1/logo.svg",
    "waterfallbot": "https://bit.ly/SBRwaterfall",
    "tags": [],
    "extensions": {
      "website": "https://saber.so",
      "twitter": "https://twitter.com/saber_hq",
      "github": "https://github.com/saber-hq",
      "medium": "https://blog.saber.so",
      "discord": "https://chat.saber.so",
      "serumV3Usdc": "HXBi8YBwbh4TXF6PjVw81m8Z3Cc4WBofvauj5SBFdgUs",
      "coingeckoId": "saber"
    }
  },
  {
    "chainId": 101,
    "address": "2juwHtqBUEaV26WM5sVvjFsjvCXfwP3ZPndmr5ywVwgZ",
    "symbol": "ADAM",
    "name": "adamho",
    "decimals": 7,
    "logoURI":
        "https://raw.githubusercontent.com/solana-labs/token-list/main/assets/mainnet/2juwHtqBUEaV26WM5sVvjFsjvCXfwP3ZPndmr5ywVwgZ/adamho_250x250.jpg",
    "tags": ["social-token"],
    "extensions": {"twitter": "https://twitter.com/takwah"}
  },
  {
    "chainId": 101,
    "address": "FMJotGUW16AzexRD3vXJQ94AL71cwrhtFaCTGtK1QHXm",
    "symbol": "LRA",
    "name": "Lumos Rewards",
    "decimals": 9,
    "logoURI":
        "https://raw.githubusercontent.com/solana-labs/token-list/main/assets/mainnet/FMJotGUW16AzexRD3vXJQ94AL71cwrhtFaCTGtK1QHXm/logo.png",
    "tags": ["social-token"],
    "extensions": {"website": "https://lumos.exchange"}
  },
  {
    "chainId": 101,
    "address": "AWTE7toEwKdSRd7zh3q45SjKhmYVFp3zk4quWHsM92bj",
    "symbol": "ZAU",
    "name": "Zaucoin",
    "decimals": 9,
    "logoURI":
        "https://raw.githubusercontent.com/solana-labs/token-list/main/assets/mainnet/AWTE7toEwKdSRd7zh3q45SjKhmYVFp3zk4quWHsM92bj/logo.png",
    "tags": ["utility-token"],
    "extensions": {"website": "zaucoin.crypto"}
  },
  {
    "chainId": 101,
    "address": "ABFPEo4pUy1is4Atf33zZoYpG2nkB66W3fsTwAeCUSkA",
    "symbol": "SAM",
    "name": "Swiss and Makeup",
    "decimals": 9,
    "logoURI":
        "https://raw.githubusercontent.com/solana-labs/token-list/main/assets/mainnet/ABFPEo4pUy1is4Atf33zZoYpG2nkB66W3fsTwAeCUSkA/logo.png",
    "tags": ["fan-token"],
    "extensions": {"instagram": "https://www.instagram.com/swissandmakeup/"}
  },
  {
    "chainId": 101,
    "address": "5ToouaoWhGCiaicANcewnaNKJssdZTxPATDhqJXARiJG",
    "symbol": "NUR",
    "name": "Nur Coin",
    "decimals": 9,
    "logoURI":
        "https://raw.githubusercontent.com/solana-labs/token-list/main/assets/mainnet/5ToouaoWhGCiaicANcewnaNKJssdZTxPATDhqJXARiJG/logo.png",
    "tags": ["kazakhstan", "qazaqstan", "kz"]
  },
  {
    "chainId": 101,
    "address": "9ysRLs872GMvmAjjFZEFccnJBF3tYEVT1x7dFE1WPqTY",
    "symbol": "VRNT",
    "name": "Variant",
    "decimals": 9,
    "logoURI":
        "https://raw.githubusercontent.com/solana-labs/token-list/main/assets/mainnet/9ysRLs872GMvmAjjFZEFccnJBF3tYEVT1x7dFE1WPqTY/logo.png",
    "tags": ["utility-token"],
    "extensions": {"website": "https://www.variantresearch.io"}
  },
  {
    "chainId": 101,
    "address": "8pBc4v9GAwCBNWPB5XKA93APexMGAS4qMr37vNke9Ref",
    "symbol": "wHBTC",
    "name": "HBTC (Wormhole)",
    "decimals": 9,
    "logoURI":
        "https://raw.githubusercontent.com/solana-labs/token-list/main/assets/mainnet/8pBc4v9GAwCBNWPB5XKA93APexMGAS4qMr37vNke9Ref/logo.png",
    "tags": ["wrapped", "wormhole"],
    "extensions": {
      "address": "0x0316EB71485b0Ab14103307bf65a021042c6d380",
      "bridgeContract": "https://etherscan.io/address/0xf92cD566Ea4864356C5491c177A430C222d7e678",
      "assetContract": "https://etherscan.io/address/0x0316EB71485b0Ab14103307bf65a021042c6d380",
      "coingeckoId": "huobi-btc"
    }
  },
  {
    "chainId": 101,
    "address": "CjEm7iRHr5cwWTjtF7Xk58hnRiH4rz9NXboeeWjueFCc",
    "symbol": "DSPWN",
    "name": "Despawn",
    "decimals": 8,
    "logoURI":
        "https://raw.githubusercontent.com/solana-labs/token-list/main/assets/mainnet/CjEm7iRHr5cwWTjtF7Xk58hnRiH4rz9NXboeeWjueFCc/logo.png",
    "tags": ["utility-token"],
    "extensions": {"website": "https://despawn.io/dspwn"}
  },
  {
    "chainId": 101,
    "address": "Dg7d2va8PEKhPH1gfDoDUw21eRVbZPGRXrKEVafgEVgw",
    "symbol": "PVK",
    "name": "PlatinumO2",
    "decimals": 8,
    "logoURI":
        "https://raw.githubusercontent.com/solana-labs/token-list/main/assets/mainnet/Dg7d2va8PEKhPH1gfDoDUw21eRVbZPGRXrKEVafgEVgw/logo.png",
    "tags": ["utility-token"],
    "extensions": {"website": "https://plantinumo2.com/"}
  },
  {
    "chainId": 101,
    "address": "az4Nt1UtDp7Vo8nabW7SokKejpHUAju79JUaYDnXgkF",
    "symbol": "PNDR",
    "name": "PANDER",
    "decimals": 8,
    "logoURI":
        "https://raw.githubusercontent.com/solana-labs/token-list/main/assets/mainnet/az4Nt1UtDp7Vo8nabW7SokKejpHUAju79JUaYDnXgkF/logo.png",
    "tags": ["utility-token"],
    "extensions": {"website": "https://pander.network"}
  },
  {
    "chainId": 101,
    "address": "BybpSTBoZHsmKnfxYG47GDhVPKrnEKX31CScShbrzUhX",
    "symbol": "wHUSD",
    "name": "HUSD Stablecoin (Wormhole)",
    "decimals": 8,
    "logoURI":
        "https://raw.githubusercontent.com/solana-labs/token-list/main/assets/mainnet/BybpSTBoZHsmKnfxYG47GDhVPKrnEKX31CScShbrzUhX/logo.png",
    "tags": ["wrapped", "wormhole"],
    "extensions": {
      "website": "https://www.stcoins.com/",
      "address": "0xdf574c24545e5ffecb9a659c229253d4111d87e1",
      "bridgeContract": "https://etherscan.io/address/0xf92cD566Ea4864356C5491c177A430C222d7e678",
      "assetContract": "https://etherscan.io/address/0xdf574c24545e5ffecb9a659c229253d4111d87e1",
      "coingeckoId": "husd"
    }
  },
  {
    "chainId": 101,
    "address": "6VNKqgz9hk7zRShTFdg5AnkfKwZUcojzwAkzxSH3bnUm",
    "symbol": "wHAPI",
    "name": "Wrapped HAPI",
    "decimals": 9,
    "logoURI":
        "https://raw.githubusercontent.com/solana-labs/token-list/main/assets/mainnet/6VNKqgz9hk7zRShTFdg5AnkfKwZUcojzwAkzxSH3bnUm/logo.png",
    "tags": ["wrapped", "utility-token"],
    "extensions": {
      "website": "https://hapi.one",
      "twitter": "https://twitter.com/i_am_hapi_one",
      "medium": "https://medium.com/i-am-hapi",
      "telegram": "http://t.me/hapiHF",
      "github": "https://github.com/HAPIprotocol/HAPI/"
    }
  },
  {
    "chainId": 101,
    "address": "Lrxqnh6ZHKbGy3dcrCED43nsoLkM1LTzU2jRfWe8qUC",
    "symbol": "LARIX",
    "name": "Larix",
    "decimals": 6,
    "logoURI":
        "https://raw.githubusercontent.com/solana-labs/token-list/main/assets/mainnet/Lrxqnh6ZHKbGy3dcrCED43nsoLkM1LTzU2jRfWe8qUC/logo.jpg",
    "tags": [],
    "extensions": {
      "website": "projectlarix.com",
      "twitter": "https://twitter.com/ProjectLarix",
      "discord": "http://discord.gg/hfnRFV9Ngt",
      "medium": "http://projectlarix.medium.com",
      "telegram": "http://t.me/projectlarix",
      "github": "https://github.com/ProjectLarix/Larix-Lending-Project-Rep"
    }
  },
  {
    "chainId": 101,
    "address": "BYvGwtPx6Nw4YUVVwqx7qh657EcdxBSfE8JcaPmWWa6E",
    "symbol": "TOSTI",
    "name": "Tosti Coin",
    "decimals": 9,
    "logoURI":
        "https://raw.githubusercontent.com/solana-labs/token-list/main/assets/mainnet/BYvGwtPx6Nw4YUVVwqx7qh657EcdxBSfE8JcaPmWWa6E/logo.png",
    "tags": ["utility-token"],
    "extensions": {"website": "https://tosti.app"}
  },
  {
    "chainId": 101,
    "address": "EKEjv7VJTsKsfyZMNgPfoKkdk7pYNSgb3tg2h3zUe4PT",
    "symbol": "SIMP",
    "name": "Simp.",
    "decimals": 9,
    "logoURI":
        "https://raw.githubusercontent.com/solana-labs/token-list/main/assets/mainnet/EKEjv7VJTsKsfyZMNgPfoKkdk7pYNSgb3tg2h3zUe4PT/logo.png",
    "tags": ["utility-token"],
    "extensions": {
      "website": "https://functional-spirit-e72.notion.site/Simp-090cf60910024a228d8b163dcaf23a84",
      "discord": "https://discord.gg/5293AzqtHU"
    }
  },
  {
    "chainId": 101,
    "address": "5ZsPxmhdh9jeDMCrWu6LvNvcvNtpbpwhQvrKkeMYZE7R",
    "symbol": "BECO",
    "name": "Beco Club",
    "decimals": 6,
    "logoURI":
        "https://raw.githubusercontent.com/solana-labs/token-list/main/assets/mainnet/5ZsPxmhdh9jeDMCrWu6LvNvcvNtpbpwhQvrKkeMYZE7R/logo.png",
    "tags": ["utility-token"],
    "extensions": {"website": "https://beco.club/"}
  },
  {
    "chainId": 101,
    "address": "32uwQKZibFm5C9EjY6raGC1ZjAAQQWy1LvJxeriJEzEt",
    "symbol": "DGX",
    "name": "DGX",
    "decimals": 9,
    "logoURI": "https://i.ibb.co/YBw0zVc/LOGO-new.png",
    "tags": [],
    "extensions": {"website": "https://solanadgx.com/", "twitter": "https://twitter.com/dgxsolana"}
  },
  {
    "chainId": 101,
    "address": "57h4LEnBooHrKbacYWGCFghmrTzYPVn8PwZkzTzRLvHa",
    "symbol": "USDC-USDT-UST",
    "name": "Mercurial LP Token (USDC-USDT-UST)",
    "decimals": 9,
    "logoURI":
        "https://raw.githubusercontent.com/solana-labs/token-list/main/assets/mainnet/57h4LEnBooHrKbacYWGCFghmrTzYPVn8PwZkzTzRLvHa/logo.svg",
    "tags": ["lp-token"],
    "extensions": {"website": "https://www.mercurial.finance/"}
  },
  {
    "chainId": 101,
    "address": "9VgfFUFkGGrRePvpKLPkp9DR3crRepf6CJsYU3UmudtY",
    "symbol": "WEEB",
    "name": "Weeb Finance Token",
    "decimals": 9,
    "logoURI":
        "https://raw.githubusercontent.com/solana-labs/token-list/main/assets/mainnet/9VgfFUFkGGrRePvpKLPkp9DR3crRepf6CJsYU3UmudtY/logo.png",
    "tags": ["utility-token", "anime"],
    "extensions": {
      "website": "https://weeb.finance/",
      "twitter": "https://twitter.com/WeebFinance",
      "discord": "https://discord.gg/fzZbyXAzaG",
      "medium": "https://medium.com/@WeebFinance",
      "telegram": "http://t.me/weeb_finance"
    }
  },
  {
    "chainId": 101,
    "address": "8EDaoeBqpcVACwvkYXh1vAcU29HiBiNhqoF4pRsuUsZS",
    "symbol": "sSOL",
    "name": "SunnySideUp staked SOL (sSOL)",
    "decimals": 9,
    "logoURI":
        "https://raw.githubusercontent.com/solana-labs/token-list/main/assets/mainnet/8EDaoeBqpcVACwvkYXh1vAcU29HiBiNhqoF4pRsuUsZS/logo.png",
    "tags": [],
    "extensions": {
      "website": "https://www.sunnysideup.finance",
      "twitter": "https://twitter.com/SunnySideUp_io",
      "medium": "https://medium.com/@officialsunnysideup72",
      "github": "https://github.com/sunnysideup72"
    }
  },
  {
    "chainId": 101,
    "address": "mSoLzYCxHdYgdzU16g5QSh3i5K3z3KZK7ytfqcJm7So",
    "symbol": "mSOL",
    "name": "Marinade staked SOL (mSOL)",
    "decimals": 9,
    "logoURI":
        "https://raw.githubusercontent.com/solana-labs/token-list/main/assets/mainnet/mSoLzYCxHdYgdzU16g5QSh3i5K3z3KZK7ytfqcJm7So/logo.png",
    "tags": [],
    "extensions": {
      "website": "https://marinade.finance",
      "twitter": "https://twitter.com/MarinadeFinance",
      "discord": "https://discord.gg/mGqZA5pjRN",
      "medium": "https://medium.com/marinade-finance",
      "github": "https://github.com/marinade-finance"
    }
  },
  {
    "chainId": 101,
    "address": "LPmSozJJ8Jh69ut2WP3XmVohTjL4ipR18yiCzxrUmVj",
    "symbol": "mSOL-SOL-LP",
    "name": "Marinade LP token",
    "decimals": 9,
    "logoURI":
        "https://raw.githubusercontent.com/solana-labs/token-list/main/assets/mainnet/LPmSozJJ8Jh69ut2WP3XmVohTjL4ipR18yiCzxrUmVj/logo.png",
    "tags": ["lp-token"],
    "extensions": {
      "website": "https://marinade.finance",
      "twitter": "https://twitter.com/MarinadeFinance",
      "discord": "https://discord.gg/mGqZA5pjRN",
      "medium": "https://medium.com/marinade-finance",
      "github": "https://github.com/marinade-finance"
    }
  },
  {
    "chainId": 101,
    "address": "3k8BDobgihmk72jVmXYLE168bxxQUhqqyESW4dQVktqC",
    "symbol": "STEP-USDC",
    "name": "Raydium LP Token V4 (STEP-USDC)",
    "decimals": 9,
    "logoURI":
        "https://raw.githubusercontent.com/solana-labs/token-list/main/assets/mainnet/3k8BDobgihmk72jVmXYLE168bxxQUhqqyESW4dQVktqC/logo.png",
    "tags": ["lp-token"],
    "extensions": {"website": "https://raydium.io/"}
  },
  {
    "chainId": 101,
    "address": "3UMYcByZNQVHHyyqVfXMKr8XWP64omYBFVvf7bD6wBiA",
    "symbol": "BET",
    "name": "SOLBET",
    "decimals": 2,
    "logoURI":
        "https://raw.githubusercontent.com/solana-labs/token-list/main/assets/mainnet/3UMYcByZNQVHHyyqVfXMKr8XWP64omYBFVvf7bD6wBiA/logo.svg",
    "tags": ["utility-token"],
    "extensions": {
      "website": "https://solbet.org/",
      "telegram": "https://t.me/solbet_official",
      "discord": "https://solbet.org/discord",
      "twitter": "https://twitter.com/solbet_official/",
      "serumV3Usdc": "GsWX1FgWP35jchi5R9uiNys2g6GftruEiHVpPS2b7Vq8",
      "description":
          "SOLBET seeks to facilitate P2P speculation and provide trustless on-chain escrow services for speculative ventures utilizing on-chain data, oracle services, and private data node operators to verify outcomes for all parties involved."
    }
  },
  {
    "chainId": 101,
    "address": "A5zanvgtioZGiJMdEyaKN4XQmJsp1p7uVxaq2696REvQ",
    "symbol": "MEDIA-USDC",
    "name": "Raydium LP Token V4 (MEDIA-USDC)",
    "decimals": 6,
    "logoURI":
        "https://raw.githubusercontent.com/solana-labs/token-list/main/assets/mainnet/A5zanvgtioZGiJMdEyaKN4XQmJsp1p7uVxaq2696REvQ/logo.png",
    "tags": ["lp-token"],
    "extensions": {"website": "https://raydium.io/"}
  },
  {
    "chainId": 101,
    "address": "Cq4HyW5xia37tKejPF2XfZeXQoPYW6KfbPvxvw5eRoUE",
    "symbol": "ROPE-USDC",
    "name": "Raydium LP Token V4 (ROPE-USDC)",
    "decimals": 9,
    "logoURI":
        "https://raw.githubusercontent.com/solana-labs/token-list/main/assets/mainnet/Cq4HyW5xia37tKejPF2XfZeXQoPYW6KfbPvxvw5eRoUE/logo.png",
    "tags": ["lp-token"],
    "extensions": {"website": "https://raydium.io/"}
  },
  {
    "chainId": 101,
    "address": "3H9NxvaZoxMZZDZcbBDdWMKbrfNj7PCF5sbRwDr7SdDW",
    "symbol": "MER-USDC",
    "name": "Raydium LP Token V4 (MER-USDC)",
    "decimals": 6,
    "logoURI":
        "https://raw.githubusercontent.com/solana-labs/token-list/main/assets/mainnet/3H9NxvaZoxMZZDZcbBDdWMKbrfNj7PCF5sbRwDr7SdDW/logo.png",
    "tags": ["lp-token"],
    "extensions": {"website": "https://raydium.io/"}
  },
  {
    "chainId": 101,
    "address": "Cz1kUvHw98imKkrqqu95GQB9h1frY8RikxPojMwWKGXf",
    "symbol": "COPE-USDC",
    "name": "Raydium LP Token V4 (COPE-USDC)",
    "decimals": 6,
    "logoURI":
        "https://raw.githubusercontent.com/solana-labs/token-list/main/assets/mainnet/Cz1kUvHw98imKkrqqu95GQB9h1frY8RikxPojMwWKGXf/logo.png",
    "tags": ["lp-token"],
    "extensions": {"website": "https://raydium.io/"}
  },
  {
    "chainId": 101,
    "address": "iUDasAP2nXm5wvTukAHEKSdSXn8vQkRtaiShs9ceGB7",
    "symbol": "ALEPH-USDC",
    "name": "Raydium LP Token V4 (ALEPH-USDC)",
    "decimals": 6,
    "logoURI":
        "https://raw.githubusercontent.com/solana-labs/token-list/main/assets/mainnet/iUDasAP2nXm5wvTukAHEKSdSXn8vQkRtaiShs9ceGB7/logo.png",
    "tags": ["lp-token"],
    "extensions": {"website": "https://raydium.io/"}
  },
  {
    "chainId": 101,
    "address": "7cu42ao8Jgrd5A3y3bNQsCxq5poyGZNmTydkGfJYQfzh",
    "symbol": "WOO-USDC",
    "name": "Raydium LP Token V4 (WOO-USDC)",
    "decimals": 6,
    "logoURI":
        "https://raw.githubusercontent.com/solana-labs/token-list/main/assets/mainnet/7cu42ao8Jgrd5A3y3bNQsCxq5poyGZNmTydkGfJYQfzh/logo.png",
    "tags": ["lp-token"],
    "extensions": {"website": "https://raydium.io/"}
  },
  {
    "chainId": 101,
    "address": "G8qcfeFqxwbCqpxv5LpLWxUCd1PyMB5nWb5e5YyxLMKg",
    "symbol": "SNY-USDC",
    "name": "Raydium LP Token V4 (SNY-USDC)",
    "decimals": 6,
    "logoURI":
        "https://raw.githubusercontent.com/solana-labs/token-list/main/assets/mainnet/G8qcfeFqxwbCqpxv5LpLWxUCd1PyMB5nWb5e5YyxLMKg/logo.png",
    "tags": ["lp-token"],
    "extensions": {"website": "https://raydium.io/"}
  },
  {
    "chainId": 101,
    "address": "9nQPYJvysyfnXhQ6nkK5V7sZG26hmDgusfdNQijRk5LD",
    "symbol": "BOP-RAY",
    "name": "Raydium LP Token V4 (BOP-RAY)",
    "decimals": 8,
    "logoURI":
        "https://raw.githubusercontent.com/solana-labs/token-list/main/assets/mainnet/9nQPYJvysyfnXhQ6nkK5V7sZG26hmDgusfdNQijRk5LD/logo.png",
    "tags": ["lp-token"],
    "extensions": {"website": "https://raydium.io/"}
  },
  {
    "chainId": 101,
    "address": "2Xxbm1hdv5wPeen5ponDSMT3VqhGMTQ7mH9stNXm9shU",
    "symbol": "SLRS-USDC",
    "name": "Raydium LP Token V4 (SLRS-USDC)",
    "decimals": 6,
    "logoURI":
        "https://raw.githubusercontent.com/solana-labs/token-list/main/assets/mainnet/2Xxbm1hdv5wPeen5ponDSMT3VqhGMTQ7mH9stNXm9shU/logo.png",
    "tags": ["lp-token"],
    "extensions": {"website": "https://raydium.io/"}
  },
  {
    "chainId": 101,
    "address": "HwzkXyX8B45LsaHXwY8su92NoRBS5GQC32HzjQRDqPnr",
    "symbol": "SAMO-RAY",
    "name": "Raydium LP Token V4 (SAMO-RAY)",
    "decimals": 9,
    "logoURI":
        "https://raw.githubusercontent.com/solana-labs/token-list/main/assets/mainnet/HwzkXyX8B45LsaHXwY8su92NoRBS5GQC32HzjQRDqPnr/logo.png",
    "tags": ["lp-token"],
    "extensions": {"website": "https://raydium.io/"}
  },
  {
    "chainId": 101,
    "address": "CTEpsih91ZLo5gunvryLpJ3pzMjmt5jbS6AnSQrzYw7V",
    "symbol": "renBTC-USDC",
    "name": "Raydium LP Token V4 (renBTC-USDC)",
    "decimals": 8,
    "logoURI":
        "https://raw.githubusercontent.com/solana-labs/token-list/main/assets/mainnet/CTEpsih91ZLo5gunvryLpJ3pzMjmt5jbS6AnSQrzYw7V/logo.png",
    "tags": ["lp-token"],
    "extensions": {"website": "https://raydium.io/"}
  },
  {
    "chainId": 101,
    "address": "Hb8KnZNKvRxu7pgMRWJgoMSMcepfvNiBFFDDrdf9o3wA",
    "symbol": "renDOGE-USDC",
    "name": "Raydium LP Token V4 (renDOGE-USDC)",
    "decimals": 8,
    "logoURI":
        "https://raw.githubusercontent.com/solana-labs/token-list/main/assets/mainnet/Hb8KnZNKvRxu7pgMRWJgoMSMcepfvNiBFFDDrdf9o3wA/logo.png",
    "tags": ["lp-token"],
    "extensions": {"website": "https://raydium.io/"}
  },
  {
    "chainId": 101,
    "address": "FbC6K13MzHvN42bXrtGaWsvZY9fxrackRSZcBGfjPc7m",
    "symbol": "RAY-USDC",
    "name": "Raydium LP Token V4 (RAY-USDC)",
    "decimals": 6,
    "logoURI":
        "https://raw.githubusercontent.com/solana-labs/token-list/main/assets/mainnet/FbC6K13MzHvN42bXrtGaWsvZY9fxrackRSZcBGfjPc7m/logo.png",
    "tags": ["lp-token"],
    "extensions": {"website": "https://raydium.io/"}
  },
  {
    "chainId": 101,
    "address": "7P5Thr9Egi2rvMmEuQkLn8x8e8Qro7u2U7yLD2tU2Hbe",
    "symbol": "RAY-SRM",
    "name": "Raydium LP Token V4 (RAY-SRM)",
    "decimals": 6,
    "logoURI":
        "https://raw.githubusercontent.com/solana-labs/token-list/main/assets/mainnet/7P5Thr9Egi2rvMmEuQkLn8x8e8Qro7u2U7yLD2tU2Hbe/logo.png",
    "tags": ["lp-token"],
    "extensions": {"website": "https://raydium.io/"}
  },
  {
    "chainId": 101,
    "address": "mjQH33MqZv5aKAbKHi8dG3g3qXeRQqq1GFcXceZkNSr",
    "symbol": "RAY-ETH",
    "name": "Raydium LP Token V4 (RAY-ETH)",
    "decimals": 6,
    "logoURI":
        "https://raw.githubusercontent.com/solana-labs/token-list/main/assets/mainnet/mjQH33MqZv5aKAbKHi8dG3g3qXeRQqq1GFcXceZkNSr/logo.png",
    "tags": ["lp-token"],
    "extensions": {"website": "https://raydium.io/"}
  },
  {
    "chainId": 101,
    "address": "89ZKE4aoyfLBe2RuV6jM3JGNhaV18Nxh8eNtjRcndBip",
    "symbol": "RAY-SOL",
    "name": "Raydium LP Token V4 (RAY-SOL)",
    "decimals": 6,
    "logoURI":
        "https://raw.githubusercontent.com/solana-labs/token-list/main/assets/mainnet/89ZKE4aoyfLBe2RuV6jM3JGNhaV18Nxh8eNtjRcndBip/logo.png",
    "tags": ["lp-token"],
    "extensions": {"website": "https://raydium.io/"}
  },
  {
    "chainId": 101,
    "address": "Hmatmu1ktLbobSvim94mfpZmjL5iiyoM1zidtXJRAdLZ",
    "symbol": "PSOL",
    "name": "Parasol",
    "decimals": 7,
    "logoURI": "https://raw.githubusercontent.com/parasol-labs-org/white-paper/main/logo.png",
    "tags": ["utility-token"],
    "extensions": {
      "website": "https://parasol-labs.org",
      "discord": "https://discord.gg/WTwm2V45UZ"
    }
  },
  {
    "chainId": 101,
    "address": "4HFaSvfgskipvrzT1exoVKsUZ174JyExEsA8bDfsAdY5",
    "symbol": "DXL-USDC",
    "name": "Raydium LP Token V4 (DXL-USDC)",
    "decimals": 6,
    "logoURI":
        "https://raw.githubusercontent.com/solana-labs/token-list/main/assets/mainnet/4HFaSvfgskipvrzT1exoVKsUZ174JyExEsA8bDfsAdY5/logo.png",
    "tags": ["lp-token"],
    "extensions": {"website": "https://raydium.io/"}
  },
  {
    "chainId": 101,
    "address": "4dydh8EGNEdTz6grqnGBxpduRg55eLnwNZXoNZJetadu",
    "symbol": "MIM",
    "name": "MIM",
    "decimals": 8,
    "logoURI":
        "https://raw.githubusercontent.com/solana-labs/token-list/main/assets/mainnet/4dydh8EGNEdTz6grqnGBxpduRg55eLnwNZXoNZJetadu/logo.png",
    "tags": [],
    "extensions": {
      "website": "https://mim-swarm.com",
      "twitter": "https://twitter.com/mimswarm",
      "discord": "https://discord.gg/8mHbKWczpB",
      "telegram": "https://t.me/mimswarm",
      "github": "https://github.com/kyonym/MIM"
    }
  },
  {
    "chainId": 101,
    "address": "9SC3YkrWSWeroDUQnAuQ8fkziko2N6QydZPfVbDFjK8Z",
    "symbol": "PHC",
    "name": "Phosphine Coin",
    "decimals": 0,
    "logoURI":
        "https://raw.githubusercontent.com/solana-labs/token-list/main/assets/mainnet/9SC3YkrWSWeroDUQnAuQ8fkziko2N6QydZPfVbDFjK8Z/logo.png",
    "tags": ["phosphine"],
    "extensions": {"website": "https://phosphinecoin.org/"}
  },
  {
    "chainId": 101,
    "address": "cjZmbt8sJgaoyWYUttomAu5LJYU44ZrcKTbzTSEPDVw",
    "symbol": "LIKE-USDC",
    "name": "Raydium LP Token V4 (LIKE-USDC)",
    "decimals": 9,
    "logoURI":
        "https://raw.githubusercontent.com/solana-labs/token-list/main/assets/mainnet/cjZmbt8sJgaoyWYUttomAu5LJYU44ZrcKTbzTSEPDVw/logo.png",
    "tags": ["lp-token"],
    "extensions": {"website": "https://raydium.io/"}
  },
  {
    "chainId": 101,
    "address": "PoRTjZMPXb9T7dyU7tpLEZRQj7e6ssfAE62j2oQuc6y",
    "symbol": "PORT",
    "name": "Port Finance Token",
    "decimals": 6,
    "logoURI":
        "https://raw.githubusercontent.com/solana-labs/token-list/main/assets/mainnet/PoRTjZMPXb9T7dyU7tpLEZRQj7e6ssfAE62j2oQuc6y/PORT.png",
    "waterfallbot": "https://bit.ly/PORTwaterfall",
    "tags": [],
    "extensions": {
      "website": "https://port.finance/",
      "twitter": "https://twitter.com/port_finance",
      "github": "https://github.com/port-finance/",
      "medium": "https://medium.com/port-finance",
      "discord": "https://discord.gg/nAMXAYhTb2",
      "telegram": "https://t.me/port_finance",
      "serumV3Usdc": "8x8jf7ikJwgP9UthadtiGFgfFuyyyYPHL3obJAuxFWko",
      "coingeckoId": "port-finance"
    }
  },
  {
    "chainId": 101,
    "address": "C3vBJEuNvrUqJYQ5ki8TSrCndphJQ7wwiXEwvuy1AJkW",
    "symbol": "BONGO",
    "name": "Bongocoin",
    "decimals": 9,
    "logoURI":
        "https://raw.githubusercontent.com/solana-labs/token-list/assets/mainnet/C3vBJEuNvrUqJYQ5ki8TSrCndphJQ7wwiXEwvuy1AJkW/logo.png",
    "tags": [],
    "extensions": {"website": "https://www.bongocoin.org"}
  },
  {
    "chainId": 101,
    "address": "6CssfnBjF4Vo56EithaLHLWDF95fLrt48QHsUfZwNnhv",
    "symbol": "JPYC",
    "name": "JPY Coin(Wormhole)",
    "decimals": 6,
    "logoURI":
        "https://raw.githubusercontent.com/solana-labs/token-list/main/assets/mainnet/5trVBqv1LvHxiSPMsHtEZuf8iN82wbpDcR5Zaw7sWC3s/logo.png",
    "tags": ["stablecoin", "ethereum", "wrapped", "wormhole"],
    "extensions": {
      "website": "https://jpyc.jp/",
      "twitter": "https://twitter.com/jpy_coin",
      "coingeckoId": "jpyc",
      "assetContract": "https://etherscan.io/address/0x2370f9d504c7a6e775bf6e14b3f12846b594cd53"
    }
  },
  {
    "chainId": 101,
    "address": "D1EjNd9c7MgepvQCS31x5TpdXpvtDwDNCLwLGEYg6hYo",
    "symbol": "AUTOS",
    "name": "Autostorm",
    "decimals": 8,
    "logoURI":
        "https://raw.githubusercontent.com/autostorm-org/img/cb78b86a54f6f4f637e4e6cbe961e002966b4844/avatar.png",
    "tags": ["cars", "auto", "marketplace"],
    "extensions": {
      "website": "https://www.autostorm.io/",
      "discord": "https://discord.gg/yWjkHgnPD3"
    }
  },
  {
    "chainId": 101,
    "address": "BL6X5awy2TstWE6gJGZMLXwW1Wi3VsdCDWEzzK2cuzrw",
    "symbol": "ARIES",
    "name": "SOLARIES Financial Token",
    "decimals": 9,
    "logoURI":
        "https://github.com/ariesfinancial/Aries-Financial/raw/f2946ff1e295fef66e3cfa5e590daef7bb8559c2/logo-120-120%403x.png",
    "tags": [],
    "extensions": {
      "website": "https://solaries.network/",
      "telegram": "https://t.me/aries_financial_official",
      "discord": "https://discord.gg/cRFc6kEu",
      "twitter": "https://twitter.com/_AriesFinancial",
      "github": "https://github.com/ariesfinancial",
      "medium": "https://aries-financial.medium.com/"
    }
  },
  {
    "chainId": 101,
    "address": "GJQpf6Zjvokd3YK5EprXqZUah9jxkn8aG4pTeWL7Gkju",
    "symbol": "OKI",
    "name": "HDOKI",
    "decimals": 8,
    "logoURI":
        "https://raw.githubusercontent.com/solana-labs/token-list/main/assets/mainnet/GJQpf6Zjvokd3YK5EprXqZUah9jxkn8aG4pTeWL7Gkju/logo.png",
    "tags": [],
    "extensions": {"website": "https://hdoki.com/"}
  },
  {
    "chainId": 101,
    "address": "MangoCzJ36AjZyKwVj3VnYU4GTonjfVEnJmvvWaxLac",
    "symbol": "MNGO",
    "name": "Mango",
    "decimals": 6,
    "logoURI":
        "https://raw.githubusercontent.com/solana-labs/token-list/main/assets/mainnet/MangoCzJ36AjZyKwVj3VnYU4GTonjfVEnJmvvWaxLac/token.png",
    "tags": [],
    "extensions": {
      "website": "https://mango.markets/",
      "serumV3Usdc": "3d4rzwpy9iGdCZvgxcu7B1YocYffVLsQXPXkBZKt2zLc",
      "coingeckoId": "mango-markets",
      "twitter": "https://twitter.com/mangomarkets",
      "discord": "https://discord.gg/67jySBhxrg"
    }
  },
  {
    "chainId": 101,
    "address": "9X4EK8E59VAVi6ChnNvvd39m6Yg9RtkBbAPq1mDVJT57",
    "symbol": "SLIM-SOL",
    "name": "Raydium LP Token V4 (SLIM-SOL)",
    "decimals": 6,
    "logoURI":
        "https://raw.githubusercontent.com/solana-labs/token-list/main/assets/mainnet/xxxxa1sKNGwFtw2kFn8XauW9xq8hBZ5kVtcSesTT9fW/logo.png",
    "tags": ["lp-token"],
    "extensions": {"website": "https://raydium.io/"}
  },
  {
    "chainId": 101,
    "address": "8BNNxGUinfDgwXodroVfGQde1RnwsA2DW34gc89YcBH9",
    "symbol": "RDZ",
    "name": "RADIOZONE26",
    "decimals": 9,
    "logoURI": "https://cdn.jsdelivr.net/gh/Radiozone26/RDZtoken/RDZlogo.png",
    "tags": ["social-token"],
    "extensions": {
      "website": "https://radiozone26.com/",
      "twitter": "https://twitter.com/radio_zone26",
      "facebook": "https://www.facebook.com/Rzone26"
    }
  },
  {
    "chainId": 101,
    "address": "F34jmbEEAEHCKqCLUXEEKyMWZLTAfFuF6mKQejySSZSN",
    "symbol": "MOGO",
    "name": "Mogotrovio",
    "decimals": 1,
    "logoURI":
        "https://raw.githubusercontent.com/solana-labs/token-list/main/assets/mainnet/F34jmbEEAEHCKqCLUXEEKyMWZLTAfFuF6mKQejySSZSN/symbol.png",
    "tags": [],
    "extensions": {"website": "https://mogotrov.io/", "discord": "https://discord.gg/zwgxUqypy9"}
  },
  {
    "chainId": 101,
    "address": "EwJN2GqUGXXzYmoAciwuABtorHczTA5LqbukKXV1viH7",
    "symbol": "UPS",
    "name": "UPS token (UPFI Network)",
    "decimals": 6,
    "logoURI":
        "https://raw.githubusercontent.com/solana-labs/token-list/main/assets/mainnet/EwJN2GqUGXXzYmoAciwuABtorHczTA5LqbukKXV1viH7/logo.png",
    "tags": [],
    "extensions": {
      "website": "https://upfi.network/",
      "twitter": "https://twitter.com/upfi_network",
      "medium": "https://upfinetwork.medium.com",
      "discord": "https://discord.gg/nHMDdyAggx",
      "telegram": "https://t.me/upfinetworkchannel",
      "facebook": "https://www.facebook.com/UPFInetwork",
      "serumV3Usdc": "DByPstQRx18RU2A8DH6S9mT7bpT6xuLgD2TTFiZJTKZP"
    }
  },
  {
    "chainId": 101,
    "address": "Gsai2KN28MTGcSZ1gKYFswUpFpS7EM9mvdR9c8f6iVXJ",
    "symbol": "gSAIL",
    "name": "SolanaSail Governance Token V2",
    "decimals": 9,
    "logoURI":
        "https://raw.githubusercontent.com/solanasail/token-list/main/assets/mainnet/Gsai2KN28MTGcSZ1gKYFswUpFpS7EM9mvdR9c8f6iVXJ/logo.png",
    "tags": ["utility-token"],
    "extensions": {
      "website": "https://www.solanasail.com",
      "coingeckoId": "solanasail-governance-token",
      "twitter": "https://twitter.com/SolanaSail"
    }
  },
  {
    "chainId": 101,
    "address": "Ea5SjE2Y6yvCeW5dYTn7PYMuW5ikXkvbGdcmSnXeaLjS",
    "symbol": "PAI",
    "name": "PAI (Parrot USD)",
    "decimals": 6,
    "logoURI":
        "https://raw.githubusercontent.com/solana-labs/token-list/main/assets/mainnet/Ea5SjE2Y6yvCeW5dYTn7PYMuW5ikXkvbGdcmSnXeaLjS/logo.svg",
    "tags": ["utility-token"],
    "extensions": {
      "website": "https://parrot.fi",
      "twitter": "https://twitter.com/gopartyparrot",
      "telegram": "https://t.me/gopartyparrot",
      "medium": "https://gopartyparrot.medium.com/",
      "discord": "https://discord.gg/gopartyparrot"
    }
  },
  {
    "chainId": 101,
    "address": "PRT88RkA4Kg5z7pKnezeNH4mafTvtQdfFgpQTGRjz44",
    "symbol": "PRT",
    "name": "PRT (Parrot Protocol)",
    "decimals": 6,
    "logoURI":
        "https://raw.githubusercontent.com/solana-labs/token-list/main/assets/mainnet/PRT88RkA4Kg5z7pKnezeNH4mafTvtQdfFgpQTGRjz44/logo.svg",
    "tags": ["utility-token"],
    "extensions": {
      "website": "https://parrot.fi",
      "twitter": "https://twitter.com/gopartyparrot",
      "telegram": "https://t.me/gopartyparrot",
      "medium": "https://gopartyparrot.medium.com/",
      "discord": "https://discord.gg/gopartyparrot"
    }
  },
  {
    "chainId": 101,
    "address": "DYDWu4hE4MN3aH897xQ3sRTs5EAjJDmQsKLNhbpUiKun",
    "symbol": "pBTC",
    "name": "pBTC (Parrot BTC)",
    "decimals": 6,
    "logoURI":
        "https://raw.githubusercontent.com/solana-labs/token-list/main/assets/mainnet/DYDWu4hE4MN3aH897xQ3sRTs5EAjJDmQsKLNhbpUiKun/logo.svg",
    "tags": ["stablecoin"],
    "extensions": {
      "website": "https://parrot.fi",
      "twitter": "https://twitter.com/gopartyparrot",
      "telegram": "https://t.me/gopartyparrot",
      "medium": "https://gopartyparrot.medium.com/",
      "discord": "https://discord.gg/gopartyparrot"
    }
  },
  {
    "chainId": 101,
    "address": "9EaLkQrbjmbbuZG9Wdpo8qfNUEjHATJFSycEmw6f1rGX",
    "symbol": "pSOL",
    "name": "pSOL (Parrot SOL)",
    "decimals": 6,
    "logoURI":
        "https://raw.githubusercontent.com/solana-labs/token-list/main/assets/mainnet/9EaLkQrbjmbbuZG9Wdpo8qfNUEjHATJFSycEmw6f1rGX/logo.svg",
    "tags": ["stablecoin"],
    "extensions": {
      "website": "https://parrot.fi",
      "twitter": "https://twitter.com/gopartyparrot",
      "telegram": "https://t.me/gopartyparrot",
      "medium": "https://gopartyparrot.medium.com/",
      "discord": "https://discord.gg/gopartyparrot"
    }
  },
  {
    "chainId": 101,
    "address": "6veSH51HZGQKP9icyDis69v21eWUmJLfKNgPADzngEWJ",
    "symbol": "ZKL",
    "name": "zkrollup cross chain link",
    "decimals": 9,
    "logoURI": "http://www.kikenn.com/logo/zklink.png",
    "tags": [],
    "extensions": {"website": "https://zk.link"}
  },
  {
    "chainId": 101,
    "address": "3N4MaMn4fPm7puzE6oPEwAUody9h5pLUTxc6hZGFdpgM",
    "symbol": "ULA",
    "name": "Solana Mobile App UlaPay Token",
    "decimals": 9,
    "logoURI": "http://www.kikenn.com/logo/ulapay.png",
    "tags": [],
    "extensions": {"website": "http://kikenn.com/"}
  },
  {
    "chainId": 101,
    "address": "SUNNYWgPQmFxe9wTZzNK7iPnJ3vYDrkgnxJRJm1s3ag",
    "symbol": "SUNNY",
    "name": "Sunny Governance Token",
    "decimals": 6,
    "logoURI":
        "https://raw.githubusercontent.com/solana-labs/token-list/main/assets/mainnet/SUNNYWgPQmFxe9wTZzNK7iPnJ3vYDrkgnxJRJm1s3ag/logo.svg",
    "tags": [],
    "waterfallbot": "https://bit.ly/SUNNYwaterfall",
    "extensions": {
      "website": "https://sunny.ag/",
      "twitter": "https://twitter.com/SunnyAggregator",
      "github": "https://github.com/SunnyAggregator",
      "medium": "https://medium.com/sunny-aggregator",
      "discord": "https://chat.sunny.ag",
      "serumV3Usdc": "Aubv1QBFh4bwB2wbP1DaPW21YyQBLfgjg8L4PHTaPzRc",
      "coingeckoId": "sunny-aggregator"
    }
  },
  {
    "chainId": 101,
    "address": "BRLsMczKuaR5w9vSubF4j8HwEGGprVAyyVgS4EX7DKEg",
    "symbol": "CYS",
    "name": "Cyclos",
    "decimals": 6,
    "logoURI":
        "https://raw.githubusercontent.com/solana-labs/token-list/main/assets/mainnet/BRLsMczKuaR5w9vSubF4j8HwEGGprVAyyVgS4EX7DKEg/logo.svg",
    "tags": ["utility-token"],
    "extensions": {
      "website": "https://cyclos.io/",
      "telegram": "https://t.me/cyclosofficialchat",
      "discord": "https://discord.gg/vpbTxzHWYg",
      "twitter": "https://twitter.com/cyclosfi",
      "email": "contact@cyclos.io",
      "github": "https://github.com/cyclos-io",
      "coinmarketcap": "https://coinmarketcap.com/currencies/cyclos/",
      "solanium": "https://www.solanium.io/project/cyclos/",
      "medium": "https://medium.com/@cyclosfinance",
      "serumV3Usdc": "6V6y6QFi17QZC9qNRpVp7SaPiHpCTp2skbRQkUyZZXPW",
      "coingeckoId": "cyclos"
    }
  },
  {
    "chainId": 101,
    "address": "FxjbQMfvQYMtZZK7WGEJwWfsDcdMuuaee8uPxDFFShWh",
    "symbol": "UPFI",
    "name": "UPFI stablecoin (UPFI Network)",
    "decimals": 6,
    "logoURI":
        "https://raw.githubusercontent.com/solana-labs/token-list/main/assets/mainnet/FxjbQMfvQYMtZZK7WGEJwWfsDcdMuuaee8uPxDFFShWh/logo.png",
    "tags": ["stablecoin"],
    "extensions": {
      "website": "https://upfi.network/",
      "twitter": "https://twitter.com/upfi_network",
      "medium": "https://upfinetwork.medium.com",
      "discord": "https://discord.gg/nHMDdyAggx",
      "telegram": "https://t.me/upfinetworkchannel",
      "facebook": "https://www.facebook.com/UPFInetwork",
      "serumV3Usdc": "SyQ4KyF5Y1MPPkkf9LGNA6JpkVmis53HrpPvJ1ZUFwK"
    }
  },
  {
    "chainId": 101,
    "address": "7dHbWXmci3dT8UFYWYZweBLXgycu7Y3iL6trKn1Y7ARj",
    "symbol": "stSOL",
    "name": "Lido Staked SOL",
    "decimals": 9,
    "logoURI":
        "https://raw.githubusercontent.com/solana-labs/token-list/main/assets/mainnet/7dHbWXmci3dT8UFYWYZweBLXgycu7Y3iL6trKn1Y7ARj/logo.png",
    "tags": [],
    "extensions": {
      "website": "https://solana.lido.fi/",
      "twitter": "https://twitter.com/LidoFinance/"
    }
  },
  {
    "chainId": 101,
    "address": "H2mf9QNdU2Niq6QR7367Ua2trBsvscLyX5bz7R3Pw5sE",
    "symbol": "stETH",
    "name": "Lido Staked ETH",
    "decimals": 8,
    "logoURI":
        "https://raw.githubusercontent.com/solana-labs/token-list/main/assets/mainnet/H2mf9QNdU2Niq6QR7367Ua2trBsvscLyX5bz7R3Pw5sE/logo.png",
    "tags": ["stake", "wrapped"],
    "extensions": {
      "website": "https://lido.fi/",
      "twitter": "https://twitter.com/LidoFinance/",
      "telegram": "https://t.me/lidofinance",
      "discord": "https://discord.gg/WhhnWwsFXz",
      "github": "https://github.com/lidofinance",
      "coingeckoId": "lido-staked-ether"
    }
  },
  {
    "chainId": 101,
    "address": "ZScHuTtqZukUrtZS43teTKGs2VqkKL8k4QCouR2n6Uo",
    "symbol": "wstETH",
    "name": "Lido Wrapped Staked ETH",
    "decimals": 8,
    "logoURI":
        "https://raw.githubusercontent.com/solana-labs/token-list/main/assets/mainnet/ZScHuTtqZukUrtZS43teTKGs2VqkKL8k4QCouR2n6Uo/logo.png",
    "tags": ["stake", "wrapped"],
    "extensions": {
      "website": "https://lido.fi/",
      "twitter": "https://twitter.com/LidoFinance/",
      "telegram": "https://t.me/lidofinance",
      "discord": "https://discord.gg/WhhnWwsFXz",
      "github": "https://github.com/lidofinance"
    }
  },
  {
    "chainId": 101,
    "address": "3ewm17jCxn8EkEpar45mnY6qk7wc93uPg5D41KMeHZhf",
    "symbol": "CSH",
    "name": "CSH Token",
    "decimals": 8,
    "logoURI":
        "https://raw.githubusercontent.com/solana-labs/token-list/main/assets/mainnet/3ewm17jCxn8EkEpar45mnY6qk7wc93uPg5D41KMeHZhf/logo.png",
    "tags": ["utility-token", "shchoi"]
  },
  {
    "chainId": 101,
    "address": "2Kc38rfQ49DFaKHQaWbijkE7fcymUMLY5guUiUsDmFfn",
    "symbol": "KURO",
    "name": "Kurobi",
    "decimals": 6,
    "logoURI":
        "https://raw.githubusercontent.com/solana-labs/token-list/main/assets/mainnet/2Kc38rfQ49DFaKHQaWbijkE7fcymUMLY5guUiUsDmFfn/logo.png",
    "tags": ["utility-token"],
    "extensions": {
      "website": "https://kurobi.io/",
      "medium": "https://kurobi.medium.com/",
      "github": "https://github.com/KurobiHq/",
      "telegram": "https://t.me/kurobi_io",
      "twitter": "https://twitter.com/kurobi_io"
    }
  },
  {
    "chainId": 101,
    "address": "FiCiuX9DetEE89PgRAU1hmoptnem8b1fkpEq8PGYTYkd",
    "symbol": "MM",
    "name": "Million",
    "decimals": 9,
    "logoURI":
        "https://raw.githubusercontent.com/solana-labs/token-list/main/assets/mainnet/FiCiuX9DetEE89PgRAU1hmoptnem8b1fkpEq8PGYTYkd/logo.svg",
    "tags": ["wrapped", "wormhole"],
    "extensions": {
      "website": "https://www.milliontoken.org/",
      "address": "0x6b4c7a5e3f0b99fcd83e9c089bddd6c7fce5c611",
      "bridgeContract": "https://etherscan.io/address/0xf92cd566ea4864356c5491c177a430c222d7e678",
      "assetContract": "https://etherscan.io/address/0x6b4c7a5e3f0b99fcd83e9c089bddd6c7fce5c611",
      "coingeckoId": "million",
      "reddit": "https://www.reddit.com/r/milliontoken/",
      "twitter": "https://twitter.com/Million__Token",
      "discord": "http://app.milliontoken.org/discord",
      "facebook": "https://facebook.com/groups/milliontoken",
      "instagram": "https://instagram.com/milliontokenofficial",
      "telegram": "https://t.me/millionjacuzzibar"
    }
  },
  {
    "chainId": 101,
    "address": "Bqd2ujCTEzpKzfjb1FHL7FKrdM6n1rZSnRecJK57EoKz",
    "symbol": "HOTTO",
    "name": "HottoShotto",
    "decimals": 9,
    "logoURI":
        "https://raw.githubusercontent.com/solana-labs/token-list/main/assets/mainnet/Bqd2ujCTEzpKzfjb1FHL7FKrdM6n1rZSnRecJK57EoKz/logo.png",
    "tags": ["utility-token"],
    "extensions": {
      "website": "https://hottoshotto.com",
      "serumV3Usdc": "76d1Gv8649Fhn7HtZTxaPCMFA4fYxaQ3jbna7pGMGA6"
    }
  },
  {
    "chainId": 101,
    "address": "FossiLkXJZ1rePN8jWBqHDZZ3F7ET8p1dRGhYKHbQcZR",
    "symbol": "Fossil",
    "name": "Scallop Fossil Decorations",
    "decimals": 0,
    "logoURI":
        "https://raw.githubusercontent.com/solana-labs/token-list/main/assets/mainnet/FossiLkXJZ1rePN8jWBqHDZZ3F7ET8p1dRGhYKHbQcZR/logo.png",
    "tags": ["nft"],
    "extensions": {
      "website": "https://www.scallop.io/",
      "twitter": "https://twitter.com/Scallop_io",
      "discord": "https://discord.gg/Scallop",
      "telegram": "https://t.me/scallop_io",
      "medium": "https://scallopio.medium.com/",
      "facebook": "https://www.facebook.com/Scallop.io",
      "instagram": "https://www.instagram.com/scallop.io"
    }
  },
  {
    "chainId": 101,
    "address": "FM8yfVgaEHrpSzNZeZ1o4v5iLZuT9soNuqaWD72bJyqs",
    "symbol": "HOTTO-USDC",
    "name": "Raydium LP Token V4 (HOTTO-USDC)",
    "decimals": 9,
    "logoURI":
        "https://raw.githubusercontent.com/solana-labs/token-list/main/assets/mainnet/FM8yfVgaEHrpSzNZeZ1o4v5iLZuT9soNuqaWD72bJyqs/logo.png",
    "tags": ["lp-token"],
    "extensions": {"website": "https://raydium.io/"}
  },
  {
    "chainId": 101,
    "address": "SeawdHf3NHG6gxCrezQxr5oJAHTLJd6JsQxxd144yaz",
    "symbol": "Seagrass",
    "name": "Scallop Seagrass Decorations",
    "decimals": 0,
    "logoURI":
        "https://raw.githubusercontent.com/solana-labs/token-list/main/assets/mainnet/SeawdHf3NHG6gxCrezQxr5oJAHTLJd6JsQxxd144yaz/logo.png",
    "tags": ["nft"],
    "extensions": {
      "website": "https://www.scallop.io/",
      "twitter": "https://twitter.com/Scallop_io",
      "discord": "https://discord.gg/Scallop",
      "telegram": "https://t.me/scallop_io",
      "medium": "https://scallopio.medium.com/",
      "facebook": "https://www.facebook.com/Scallop.io",
      "instagram": "https://www.instagram.com/scallop.io"
    }
  },
  {
    "chainId": 101,
    "address": "78CeyRBJSu4MFmaDi8Q8QZ3szB6Xwp93sVaMLYSy5SMZ",
    "symbol": "HOTTO-SOL",
    "name": "Raydium LP Token V4 (HOTTO-SOL)",
    "decimals": 9,
    "logoURI":
        "https://raw.githubusercontent.com/solana-labs/token-list/main/assets/mainnet/78CeyRBJSu4MFmaDi8Q8QZ3szB6Xwp93sVaMLYSy5SMZ/logo.png",
    "tags": ["lp-token"],
    "extensions": {"website": "https://raydium.io/"}
  },
  {
    "chainId": 101,
    "address": "ScaLopYHz9eKtDdKs4yLswwq2RSUtNMZVdPynMcYcc9",
    "symbol": "SCA",
    "name": "Scallop",
    "decimals": 6,
    "logoURI":
        "https://raw.githubusercontent.com/solana-labs/token-list/main/assets/mainnet/ScaLopYHz9eKtDdKs4yLswwq2RSUtNMZVdPynMcYcc9/logo.png",
    "tags": [],
    "extensions": {
      "website": "https://www.scallop.io/",
      "twitter": "https://twitter.com/Scallop_io",
      "discord": "https://discord.gg/Scallop",
      "telegram": "https://t.me/scallop_io",
      "medium": "https://scallopio.medium.com/",
      "facebook": "https://www.facebook.com/Scallop.io",
      "instagram": "https://www.instagram.com/scallop.io"
    }
  },
  {
    "chainId": 101,
    "address": "FnKE9n6aGjQoNWRBZXy4RW6LZVao7qwBonUbiD7edUmZ",
    "symbol": "SYP",
    "name": "Sypool",
    "decimals": 10,
    "logoURI":
        "https://raw.githubusercontent.com/solana-labs/token-list/main/assets/mainnet/FnKE9n6aGjQoNWRBZXy4RW6LZVao7qwBonUbiD7edUmZ/logo.png",
    "tags": [],
    "extensions": {"website": "https://www.sypool.io/"}
  },
  {
    "chainId": 101,
    "address": "FGpMT3xLwk67hWsT7Lgp7WjovS3rejx9KBmCG1bBtB9U",
    "symbol": "ALTREC",
    "name": "ALTREC Coin",
    "decimals": 8,
    "logoURI":
        "https://raw.githubusercontent.com/SmonkeyMonkey/token-list/main/assets/mainnet/FGpMT3xLwk67hWsT7Lgp7WjovS3rejx9KBmCG1bBtB9U/logo.png",
    "tags": ["utility-token"]
  },
  {
    "chainId": 101,
    "address": "2YxGppCJJY2KGoAwFdFASE6tnD4cENM7nThwUgdpXwjE",
    "symbol": "COD-sc1",
    "name": "Sceptre Token v1 (Sceptre-TOKEN)",
    "decimals": 0,
    "logoURI":
        "https://raw.githubusercontent.com/solana-labs/token-list/main/assets/mainnet/2YxGppCJJY2KGoAwFdFASE6tnD4cENM7nThwUgdpXwjE/logo.png",
    "tags": ["social-token"],
    "extensions": {"website": "https://kokeshi.finance/"}
  },
  {
    "chainId": 101,
    "address": "HbrmyoumgcK6sDFBi6EZQDi4i4ZgoN16eRB2JseKc7Hi",
    "symbol": "CRY",
    "name": "Crystal",
    "decimals": 9,
    "logoURI":
        "https://raw.githubusercontent.com/solana-labs/token-list/main/assets/mainnet/HbrmyoumgcK6sDFBi6EZQDi4i4ZgoN16eRB2JseKc7Hi/logo.png",
    "tags": ["crystal-token"],
    "extensions": {
      "website": "http://solcry.io/",
      "telegram": "https://t.me/sol_cry",
      "discord": "http://discord.gg/ghnnPvQNgS",
      "email": "contact@solcry.io",
      "github": "https://github.com/sol-crystal",
      "medium": "https://solcrystal.medium.com/",
      "serumV3Usdc": "H3e7YziokpHJfFAMAy2PK6sNph72f38P1ELd5TUQaocv",
      "serumV3Usdt": "ESmbZckdRFv1F8aJ9CfcAsQ9JQchCVgXMEd2UimcujHU",
      "twitter": "https://twitter.com/Crystal80955369"
    }
  },
  {
    "chainId": 101,
    "address": "HRBrRXGCrPro6TtryKQkLXuZqg3LdBMN9ZWx2v66pT4L",
    "symbol": "WNAV",
    "name": "Wrapped Navcoin",
    "decimals": 8,
    "logoURI":
        "https://raw.githubusercontent.com/solana-labs/token-list/main/assets/mainnet/HRBrRXGCrPro6TtryKQkLXuZqg3LdBMN9ZWx2v66pT4L/logo.png",
    "tags": ["ethereum"],
    "extensions": {"website": "https://navcoin.org"}
  },
  {
    "chainId": 101,
    "address": "2TxM6S3ZozrBHZGHEPh9CtM74a9SVXbr7NQ7UxkRvQij",
    "symbol": "DINOEGG",
    "name": "DINOEGG",
    "decimals": 6,
    "logoURI":
        "https://raw.githubusercontent.com/solana-labs/token-list/main/assets/mainnet/2TxM6S3ZozrBHZGHEPh9CtM74a9SVXbr7NQ7UxkRvQij/logo.png",
    "tags": [],
    "extensions": {
      "website": "https://www.solanadino.com",
      "twitter": "https://twitter.com/solanadino"
    }
  },
  {
    "chainId": 101,
    "address": "Fh4e5vX2euTBzyGK2FXN1P3A4VUoH73oPVuemfRWXK2Y",
    "symbol": "FOX",
    "name": "ShapeShift FOX Token (Wormhole)",
    "decimals": 9,
    "logoURI":
        "https://raw.githubusercontent.com/solana-labs/token-list/main/assets/mainnet/Fh4e5vX2euTBzyGK2FXN1P3A4VUoH73oPVuemfRWXK2Y/logo.png",
    "tags": ["wrapped", "wormhole"],
    "extensions": {
      "address": "0xc770eefad204b5180df6a14ee197d99d808ee52d",
      "bridgeContract": "https://etherscan.io/address/0xf92cD566Ea4864356C5491c177A430C222d7e678",
      "assetContract": "https://etherscan.io/address/0xc770eefad204b5180df6a14ee197d99d808ee52d",
      "coingeckoId": "shapeshift-fox-token",
      "website": "https://shapeshift.com/",
      "github": "https://github.com/shapeshift",
      "twitter": "https://twitter.com/ShapeShift_io"
    }
  },
  {
    "chainId": 101,
    "address": "FY6XDSCubMhpkU9FAsUjB7jmN8YHYZGezHTWo9RHBSyX",
    "symbol": "ASH",
    "name": "Ashera",
    "decimals": 4,
    "logoURI":
        "https://raw.githubusercontent.com/solana-labs/token-list/main/assets/mainnet/FY6XDSCubMhpkU9FAsUjB7jmN8YHYZGezHTWo9RHBSyX/logo.png",
    "tags": [],
    "extensions": {
      "website": "https://asherasol.com/",
      "twitter": "https://twitter.com/SolAshera",
      "discord": "https://discord.gg/b3qYsNyBkz",
      "medium": "https://solashera.medium.com/",
      "telegram": "https://twitter.com/SolAshera",
      "github": "https://github.com/asherasol"
    }
  },
  {
    "chainId": 101,
    "address": "333iHoRM2Awhf9uVZtSyTfU8AekdGrgQePZsKMFPgKmS",
    "symbol": "ISOLA",
    "name": "Intersola",
    "decimals": 6,
    "logoURI":
        "https://raw.githubusercontent.com/solana-labs/token-list/main/assets/mainnet/333iHoRM2Awhf9uVZtSyTfU8AekdGrgQePZsKMFPgKmS/logo.png",
    "tags": ["utility-token"],
    "extensions": {
      "website": "https://intersola.io/",
      "medium": "https://intersola.medium.com/",
      "telegram": "https://t.me/intersola/",
      "twitter": "https://twitter.com/intersola_io",
      "github": "https://github.com/Intersolaio/",
      "serumV3Usdt": "42QVcMqoXmHT94zaBXm9KeU7pqDfBuAPHYN9ADW8weCF"
    }
  },
  {
    "chainId": 101,
    "address": "EYDEQW4xQzLqHcFwHTgGvpdjsa5EFn74KzuqLX5emjD2",
    "symbol": "BST",
    "name": "Balisari",
    "decimals": 9,
    "logoURI":
        "https://raw.githubusercontent.com/solana-labs/token-list/main/assets/mainnet/EYDEQW4xQzLqHcFwHTgGvpdjsa5EFn74KzuqLX5emjD2.png",
    "tags": ["social-token"],
    "extensions": {"website": "https://www.balisaritrans.site/"}
  },
  {
    "chainId": 101,
    "address": "8FXW4GSS9SNDVP5UhaWNsaZbxvRJXNrwvwvToXRnvuWL",
    "symbol": "KNB",
    "name": "KNB",
    "decimals": 9,
    "logoURI":
        "https://raw.githubusercontent.com/solana-labs/token-list/main/assets/mainnet/8FXW4GSS9SNDVP5UhaWNsaZbxvRJXNrwvwvToXRnvuWL/logo.png",
    "tags": ["knb-token"],
    "extensions": {"website": "https://solatoken.net/"}
  },
  {
    "chainId": 101,
    "address": "Dypr2gWcVuqt3z6Uh31YD8Wm2V2ZCqWVBYEWhZNF9odk",
    "symbol": "SOLJAV",
    "name": "SOLJAV",
    "decimals": 6,
    "logoURI":
        "https://raw.githubusercontent.com/solana-labs/token-list/main/assets/mainnet/Dypr2gWcVuqt3z6Uh31YD8Wm2V2ZCqWVBYEWhZNF9odk.png",
    "tags": ["social-token"]
  },
  {
    "chainId": 101,
    "address": "J3ts1ZEyQeUAbUyYHjZR6sE93YQTrfBzho8UKWnEa1j",
    "symbol": "ABION",
    "name": "aBion",
    "decimals": 5,
    "logoURI":
        "https://raw.githubusercontent.com/solana-labs/token-list/main/assets/mainnet/J3ts1ZEyQeUAbUyYHjZR6sE93YQTrfBzho8UKWnEa1j/logo.png",
    "tags": [],
    "extensions": {"website": "https://www.abion.org/"}
  },
  {
    "chainId": 101,
    "address": "CnGUfvi9FxiRPuaBXpYmaXEwBjj5X6kwNJB2Cba5TiQp",
    "symbol": "SOLUP",
    "name": "SOLUP",
    "decimals": 9,
    "logoURI":
        "https://raw.githubusercontent.com/solana-labs/token-list/main/assets/mainnet/CnGUfvi9FxiRPuaBXpYmaXEwBjj5X6kwNJB2Cba5TiQp/logo.png",
    "tags": ["SOLUP-TOKEN", "Sol-UP"],
    "extensions": {
      "website": "https://solup.xyz",
      "assetContract": "https://solscan.io/token/CnGUfvi9FxiRPuaBXpYmaXEwBjj5X6kwNJB2Cba5TiQp",
      "telegram": "https://t.me/solanavietnam"
    }
  },
  {
    "chainId": 101,
    "address": "95KN8q3qubEVjPf9trgyur2nHx8T5RCmztRbLuQ5E5i",
    "symbol": "SMRT",
    "name": "Solminter",
    "decimals": 0,
    "logoURI":
        "https://raw.githubusercontent.com/solana-labs/token-list/main/assets/mainnet/95KN8q3qubEVjPf9trgyur2nHx8T5RCmztRbLuQ5E5i/logo.png",
    "tags": ["utility-token"],
    "extensions": {
      "website": "https://solminter.com",
      "twitter": "https://twitter.com/solminter",
      "github": "https://github.com/solminter",
      "medium": "https://solminter.medium.com",
      "coingeckoId": "solminter"
    }
  },
  {
    "chainId": 101,
    "address": "2ZrwW5Ng1fbZKghWxnjyfTjYXLdSwJpU5EQrXus4ogsE",
    "symbol": "TIX",
    "name": "Tix Token",
    "decimals": 6,
    "logoURI":
        "https://raw.githubusercontent.com/solana-labs/token-list/main/assets/mainnet/2ZrwW5Ng1fbZKghWxnjyfTjYXLdSwJpU5EQrXus4ogsE/logo.png",
    "tags": [],
    "extensions": {"website": "https://tixtoken.io/", "twitter": "https://twitter.com/TixToken"}
  },
  {
    "chainId": 101,
    "address": "3xiDaQKLGrnWEVGpxFT5Y2DCBF1KoKdUnm9DmWdFnk45",
    "symbol": "PLGFT",
    "name": "Plongeurs de Fontaine Token",
    "decimals": 8,
    "logoURI":
        "https://raw.githubusercontent.com/solana-labs/token-list/main/assets/mainnet/3xiDaQKLGrnWEVGpxFT5Y2DCBF1KoKdUnm9DmWdFnk45/logo.png",
    "tags": ["esport"]
  },
  {
    "chainId": 101,
    "address": "CKtm7ZMYdKmFSCGukzKjhsp4JFTFGk9uEMGF7XYEFKgK",
    "symbol": "ALP",
    "name": "CoinAlpha",
    "decimals": 9,
    "logoURI":
        "https://raw.githubusercontent.com/solana-labs/token-list/main/assets/mainnet/CKtm7ZMYdKmFSCGukzKjhsp4JFTFGk9uEMGF7XYEFKgK/logo.png",
    "tags": ["utility-token"],
    "extensions": {"website": "https://coinalpha.app/"}
  },
  {
    "chainId": 101,
    "address": "Ce3PSQfkxT5ua4r2JqCoWYrMwKWC5hEzwsrT9Hb7mAz9",
    "symbol": "DATE",
    "name": "SolDate(DATE) Token",
    "decimals": 9,
    "logoURI":
        "https://raw.githubusercontent.com/solana-labs/token-list/main/assets/mainnet/Ce3PSQfkxT5ua4r2JqCoWYrMwKWC5hEzwsrT9Hb7mAz9/DATE.svg",
    "tags": ["social-token", "dating-token", "metaverse"],
    "extensions": {
      "website": "https://soldate.org/",
      "twitter": "https://twitter.com/SolDate_org",
      "medium": "https://soldate.medium.com",
      "discord": "https://discord.gg/soldate",
      "telegram": "https://t.me/soldate_org"
    }
  },
  {
    "chainId": 101,
    "address": "SWANaZUGxF82KyVsbxeeNsMaVECtimze5VyCdywkvkH",
    "symbol": "SWAN",
    "name": "Swanlana",
    "decimals": 9,
    "logoURI": "https://raw.githubusercontent.com/SwanLana/logo/main/SWANLANA_PNG.png",
    "tags": [],
    "extensions": {"website": "https://www.swanlana.com"}
  },
  {
    "chainId": 101,
    "address": "G7uYedVqFy97mzjygebnmmaMUVxWHFhNZotY6Zzsprvf",
    "symbol": "CSTR",
    "name": "CoreStarter",
    "decimals": 9,
    "logoURI": "https://raw.githubusercontent.com/CoreStarter/token-logo/main/corestarter_logo.png",
    "tags": [],
    "extensions": {
      "website": "https://corestarter.com/",
      "twitter": "https://twitter.com/CoreStarter",
      "github": "https://github.com/CoreStarter/",
      "medium": "https://corestarter.medium.com",
      "telegram": "https://t.me/corestarter_chat",
      "linkedin": "https://www.linkedin.com/company/core-starter"
    }
  },
  {
    "chainId": 101,
    "address": "DNhZkUaxHXYvpxZ7LNnHtss8sQgdAfd1ZYS1fB7LKWUZ",
    "symbol": "apUSDT",
    "name": "Wrapped USDT (Allbridge from Polygon)",
    "decimals": 6,
    "logoURI":
        "https://raw.githubusercontent.com/solana-labs/token-list/main/assets/mainnet/BQcdHdAQW1hczDbBi9hiegXAR7A98Q9jx3X3iBBBDiq4/logo.png",
    "tags": ["stablecoin"],
    "extensions": {"coingeckoId": "tether"}
  },
  {
    "chainId": 101,
    "address": "eqKJTf1Do4MDPyKisMYqVaUFpkEFAs3riGF3ceDH2Ca",
    "symbol": "apUSDC",
    "name": "Wrapped USDC (Allbridge from Polygon)",
    "decimals": 6,
    "logoURI":
        "https://raw.githubusercontent.com/solana-labs/token-list/main/assets/mainnet/BXXkv6z8ykpG1yuvUDPgh732wzVHB69RnB9YgSYh3itW/logo.png",
    "tags": ["stablecoin"],
    "extensions": {"coingeckoId": "usd-coin"}
  },
  {
    "chainId": 101,
    "address": "De2bU64vsXKU9jq4bCjeDxNRGPn8nr3euaTK8jBYmD3J",
    "symbol": "renFIL",
    "name": "renFIL",
    "decimals": 9,
    "logoURI":
        "https://raw.githubusercontent.com/solana-labs/token-list/main/assets/mainnet/De2bU64vsXKU9jq4bCjeDxNRGPn8nr3euaTK8jBYmD3J/logo.png",
    "tags": [],
    "extensions": {"coingeckoId": "renfil", "website": "https://renproject.io/"}
  },
  {
    "chainId": 101,
    "address": "6STzg1taqgJsFY6Z4xAmQVSErZ6e6EsbsvkQ6YJ3sXmj",
    "symbol": "SONC",
    "name": "Sonic",
    "decimals": 6,
    "logoURI":
        "https://raw.githubusercontent.com/solana-labs/token-list/main/assets/mainnet/6STzg1taqgJsFY6Z4xAmQVSErZ6e6EsbsvkQ6YJ3sXmj/logo.png",
    "tags": [],
    "extensions": {
      "website": "https://www.sparkborsa.com/",
      "twitter": "https://twitter.com/JaySpark0x"
    }
  },
  {
    "chainId": 101,
    "address": "7j7H7sgsnNDeCngAPjpaCN4aaaru4HS7NAFYSEUyzJ3k",
    "symbol": "SOLR",
    "name": "SolRazr",
    "decimals": 6,
    "logoURI":
        "https://raw.githubusercontent.com/solana-labs/token-list/main/assets/mainnet/7j7H7sgsnNDeCngAPjpaCN4aaaru4HS7NAFYSEUyzJ3k/SOLR.png",
    "tags": [],
    "extensions": {
      "website": "https://solrazr.com/",
      "twitter": "https://twitter.com/Solrazr_App",
      "github": "https://github.com/solrazr-app/",
      "medium": "https://medium.com/@SolRazr_App",
      "discord": "https://discord.gg/HXa3qAYe",
      "telegram": "https://t.me/solrazr_app"
    }
  },
  {
    "chainId": 101,
    "address": "5xgRqfw4DqzjrriXEWduzo8iW8Uj1KzDsPt1pSLVQVJh",
    "symbol": "RNFTz",
    "name": "RNFTz",
    "decimals": 9,
    "logoURI":
        "https://raw.githubusercontent.com/solana-labs/token-list/main/assets/mainnet/5xgRqfw4DqzjrriXEWduzo8iW8Uj1KzDsPt1pSLVQVJh/logo.png",
    "tags": ["nft"],
    "extensions": {"website": "https://rnftz.com", "twitter": "https://twitter.com/RnftzS"}
  },
  {
    "chainId": 101,
    "address": "8kFRCmQTKzvtVTVEVizjP8x3WamJpuQdZaPSGeqRJJnW",
    "symbol": "SKEM-USDC",
    "name": "Raydium LP Token (SKEM-USDC)",
    "decimals": 6,
    "logoURI":
        "https://raw.githubusercontent.com/solana-labs/token-list/main/assets/mainnet/8kFRCmQTKzvtVTVEVizjP8x3WamJpuQdZaPSGeqRJJnW/logo.svg",
    "tags": ["lp-token"],
    "extensions": {"website": "https://raydium.io"}
  },
  {
    "chainId": 101,
    "address": "HKLBSZbkfeB8LoaLLrK7CDepPHLWQEoj1jbunT1T2wYg",
    "symbol": "SODA-USDC",
    "name": "Raydium LP Token (SODA-USDC)",
    "decimals": 6,
    "logoURI":
        "https://raw.githubusercontent.com/solana-labs/token-list/main/assets/mainnet/HKLBSZbkfeB8LoaLLrK7CDepPHLWQEoj1jbunT1T2wYg/logo.svg",
    "tags": ["lp-token"],
    "extensions": {"website": "https://raydium.io"}
  },
  {
    "chainId": 101,
    "address": "BK2YNwsExxnjSUgdAzdvLV2FrthcNGGWTxDBvfBULCjG",
    "symbol": "AUSS-USDC",
    "name": "Raydium LP Token (AUSS-USDC)",
    "decimals": 6,
    "logoURI":
        "https://raw.githubusercontent.com/solana-labs/token-list/main/assets/mainnet/BK2YNwsExxnjSUgdAzdvLV2FrthcNGGWTxDBvfBULCjG/logo.svg",
    "tags": ["lp-token"],
    "extensions": {"website": "https://raydium.io"}
  },
  {
    "chainId": 101,
    "address": "BTszujAA5kJJT7YCWVsAXwk4eJeuycithuTeAksQC1RC",
    "symbol": "KLB-USDC",
    "name": "Raydium LP Token (KLB-USDC)",
    "decimals": 6,
    "logoURI":
        "https://raw.githubusercontent.com/solana-labs/token-list/main/assets/mainnet/BTszujAA5kJJT7YCWVsAXwk4eJeuycithuTeAksQC1RC/logo.svg",
    "tags": ["lp-token"],
    "extensions": {"website": "https://raydium.io"}
  },
  {
    "chainId": 101,
    "address": "DqRNwrvGUffB1j9tEYHcpw1DLMoc2QfwZ25nkBHkvRmr",
    "symbol": "SUPL",
    "name": "Suplar",
    "decimals": 9,
    "logoURI":
        "https://raw.githubusercontent.com/solana-labs/token-list/main/assets/mainnet/DqRNwrvGUffB1j9tEYHcpw1DLMoc2QfwZ25nkBHkvRmr/token.png",
    "tags": [],
    "extensions": {
      "website": "https://suplar.com",
      "telegram": "https://t.me/suplar",
      "twitter": "https://twitter.com/suplarcom"
    }
  },
  {
    "chainId": 101,
    "address": "4KVuGB1iNhYqR99Hykv1ZLdHvx41zpBqqPFtHucYpQja",
    "symbol": "XEN",
    "name": "Xenren",
    "decimals": 9,
    "logoURI":
        "https://raw.githubusercontent.com/solana-labs/token-list/main/assets/mainnet/4KVuGB1iNhYqR99Hykv1ZLdHvx41zpBqqPFtHucYpQja/logo.png",
    "tags": [],
    "extensions": {"website": "https://xenren.co"}
  },
  {
    "chainId": 101,
    "address": "7b9rgZhiZHieCoPwxWd7ihbjtQ7Ljjy4McxvcA2TTgcK",
    "symbol": "PERA",
    "name": "Prithera token",
    "decimals": 9,
    "logoURI":
        "https://raw.githubusercontent.com/solana-labs/token-list/main/assets/mainnet/7b9rgZhiZHieCoPwxWd7ihbjtQ7Ljjy4McxvcA2TTgcK/logo.png",
    "tags": [],
    "extensions": {}
  },
  {
    "chainId": 101,
    "address": "8SvvzDMu5jqcBhfdYZM1zDjDG5YGYrsNmGsPzTm4bFYU",
    "symbol": "QIA",
    "name": "Qia Coin",
    "decimals": 9,
    "logoURI":
        "https://raw.githubusercontent.com/solana-labs/token-list/main/assets/mainnet/8SvvzDMu5jqcBhfdYZM1zDjDG5YGYrsNmGsPzTm4bFYU/logo.png",
    "tags": [],
    "extensions": {
      "address": "3yN3xNcXxbhkZYC6MXak1f7Ff29BZdGyc4GUQ1jbyt27",
      "symbol": "NOVA",
      "name": "Nova frolic Sol Token",
      "decimals": 9,
      "logoURI": "https://cdn.jsdelivr.net/gh/sahityakumarsuman/frolic-token/nova_token.png",
      "tags": ["lp-token"],
      "extensions": {"website": "https://www.frolic.live/"}
    }
  },
  {
    "chainId": 101,
    "address": "3BUWWi7hb5dpnNdvi7s3hpLuDtzqEga6c2UT6c1tqKKP",
    "symbol": "COD",
    "name": "CODEMY",
    "decimals": 8,
    "logoURI": "http://codemyedu.com/resources/img/logo.png",
    "tags": ["CODEMY", "COD"],
    "extensions": {"website": "http://codemyedu.com"}
  },
  {
    "chainId": 101,
    "address": "HGy1LwAfsmC61hvAtadW7FaPTzMG8iJQEJBVqJTjgd7u",
    "symbol": "NTE",
    "name": "Nocte",
    "decimals": 6,
    "logoURI":
        "https://raw.githubusercontent.com/solana-labs/token-list/main/assets/mainnet/HGy1LwAfsmC61hvAtadW7FaPTzMG8iJQEJBVqJTjgd7u/logo.png",
    "tags": [],
    "extensions": {"website": "https://nocte.app/"}
  },
  {
    "chainId": 101,
    "address": "H6nF5DxF9ERkNrfs2QgMbDvVAH7YmzHM2Q1ysL7Qpgt",
    "symbol": "FE",
    "name": "FUTURE ECOSYSTEM",
    "decimals": 8,
    "logoURI": "https://raw.githubusercontent.com/h1rdr3v2/logo/main/felogo.jpeg",
    "tags": ["utility-token"],
    "extensions": {}
  },
  {
    "chainId": 101,
    "address": "AdARF36hBezSbqn7JAkGJtgGppMYdjtBjjXwRwBEp7JT",
    "symbol": "CAEN",
    "name": "Camel Aggregate Ecological Network",
    "decimals": 9,
    "logoURI":
        "https://raw.githubusercontent.com/solanasail/token-list/main/assets/mainnet/AdARF36hBezSbqn7JAkGJtgGppMYdjtBjjXwRwBEp7JT/logo.png",
    "tags": ["utility-token"],
    "extensions": {"website": "https://caen.io"}
  },
  {
    "chainId": 101,
    "address": "25Vu6457o2gdZRGVVt5K8NbAvaP3esYaQNHbNDitVtw1",
    "symbol": "XVC",
    "name": "Xverse Token",
    "decimals": 9,
    "logoURI":
        "https://raw.githubusercontent.com/solana-labs/token-list/main/assets/mainnet/25Vu6457o2gdZRGVVt5K8NbAvaP3esYaQNHbNDitVtw1/logo.png",
    "tags": [],
    "extensions": {"website": "https://xverse.ai/"}
  },
  {
    "chainId": 101,
    "address": "5CZn24oQp8rZgdJvw3Ud8Mi5yTKBccMi1efogxxqBuK8",
    "symbol": "CUTIE",
    "name": "Cutie Patootie",
    "decimals": 9,
    "logoURI":
        "https://raw.githubusercontent.com/solana-labs/token-list/main/assets/mainnet/5CZn24oQp8rZgdJvw3Ud8Mi5yTKBccMi1efogxxqBuK8/logo.png",
    "tags": ["MEME"],
    "extensions": {
      "website": "https://www.cutiepatootie.tech/",
      "twitter": "https://twitter.com/CutiePatotieSLN/",
      "discord": "https://discord.gg/2d3FvQUR",
      "github": "https://github.com/Cutie-Patootie-Token",
      "telegram": "https://t.me/joinchat/XFk1Boii0GxiNDc0"
    }
  },
  {
    "chainId": 101,
    "address": "Hp5CJjw9YxJeo8mAgkyUomzKGPUxEwyo6gGt6hj56aTw",
    "symbol": "SDM",
    "name": "Seldom",
    "decimals": 6,
    "logoURI":
        "https://raw.githubusercontent.com/solana-labs/token-list/main/assets/mainnet/Hp5CJjw9YxJeo8mAgkyUomzKGPUxEwyo6gGt6hj56aTw/logo.png",
    "tags": [""]
  },
  {
    "chainId": 101,
    "address": "CLLoeCMyKGH9yd6EVBUWFAbAfwq5VBFq4zidxZWKRaho",
    "symbol": "AUTM",
    "name": "Autumn",
    "decimals": 6,
    "logoURI":
        "https://raw.githubusercontent.com/solana-labs/token-list/main/assets/mainnet/CLLoeCMyKGH9yd6EVBUWFAbAfwq5VBFq4zidxZWKRaho/logo.png",
    "tags": ["social-token"]
  },
  {
    "chainId": 101,
    "address": "GZreQfnp3B1bmBZfxzJgShWbJgt6nyp13iyeHBB6Xh1n",
    "symbol": "LETTA",
    "name": "Soletta",
    "decimals": 9,
    "logoURI":
        "https://raw.githubusercontent.com/solana-labs/token-list/main/assets/mainnet/7dHbWXmci3dT8UFYWYZweBLXgycu7Y3iL6trKn1Y7ARj/logo.png",
    "tags": []
  },
  {
    "chainId": 101,
    "address": "5U9QqCPhqXAJcEv9uyzFJd5zhN93vuPk1aNNkXnUfPnt",
    "symbol": "SPWN",
    "name": "Bitspawn Token",
    "decimals": 9,
    "logoURI":
        "https://raw.githubusercontent.com/solana-labs/token-list/main/assets/mainnet/5U9QqCPhqXAJcEv9uyzFJd5zhN93vuPk1aNNkXnUfPnt/logo.png",
    "tags": ["utility-token"],
    "extensions": {
      "website": "https://bitspawn.io",
      "twitter": "https://twitter.com/bitspawngg",
      "telegram": "https://t.me/bitspawnprotocol",
      "discord": "https://discord.gg/EAtfCq9",
      "medium": "https://bitspawnprotocol.medium.com",
      "coingeckoId": "bitspawn"
    }
  },
  {
    "chainId": 101,
    "address": "51LAPRbcEvheteGQjSgAFV6rrEvjL4P2igvzPH8bu88",
    "symbol": "SNS",
    "name": "SynesisOne",
    "decimals": 3,
    "logoURI": "https://raw.githubusercontent.com/Synesis-One/spl-token/main/icon.png",
    "tags": ["utility-token"],
    "extensions": {
      "website": "https://www.synesis.one/",
      "twitter": "https://twitter.com/synesis_one"
    }
  },
  {
    "chainId": 101,
    "address": "6Wcs5FH471q1gqJHyRygm7DpNiHP1oYCKHX5zPEBD8ZZ",
    "symbol": "MILS",
    "name": "MillionSols",
    "decimals": 9,
    "logoURI": "https://arweave.net/uDmRPKqd7O9rXkv9y6cdc2sdCbVab5cgA62PWQYUYwI",
    "tags": [],
    "extensions": {
      "website": "https://millionsols.com",
      "twitter": "https://twitter.com/MillionSols"
    }
  },
  {
    "chainId": 101,
    "address": "GthwuoDnGTRgnvaZWixuqU5X3Nt18s9AzqNbGPxTonfK",
    "symbol": "JMKA",
    "name": "Jacob Makarsky Social Token",
    "decimals": 0,
    "logoURI":
        "https://raw.githubusercontent.com/solana-labs/token-list/main/assets/mainnet/GthwuoDnGTRgnvaZWixuqU5X3Nt18s9AzqNbGPxTonfK/logo.png",
    "tags": ["social-token", "jamaka"],
    "extensions": {"website": "https://www.makarsky.dev/"}
  },
  {
    "chainId": 101,
    "address": "EaD8CViuq8RXPqAhZsxZudTj6fFMy6ktgHD42J34P6PD",
    "symbol": "KISM",
    "name": "KISAMA",
    "decimals": 9,
    "logoURI":
        "https://raw.githubusercontent.com/Kisamacrypto/SPL-Logo/main/kisama-crypto-coin-520x520_edit.png",
    "tags": ["social-token", "kisama", "Trading"],
    "extensions": {"website": "http://kisamacrypto.com", "discord": "https://discord.gg/6xNDyc9"}
  },
  {
    "chainId": 101,
    "address": "6w5GEARUppTyeQee2grCUYjXi933Yswz5ZjYKt5nicY2",
    "symbol": "SOTY",
    "name": "Sol Infinity",
    "decimals": 9,
    "logoURI": "https://cdn.jsdelivr.net/gh/kpvy2002/solinfinity/SOLINFINITY%20LOGO.png",
    "tags": ["utility-token"],
    "extensions": {
      "twitter": "https://twitter.com/Solanainfinity",
      "discord": "http://discord.gg/z9st3dHRPf",
      "telegram": "http://t.me/Solinfinity_official"
    }
  },
  {
    "chainId": 101,
    "address": "5y1YcGVPFy8bEiCJi79kegF9igahmvDe5UrqswFvnpMJ",
    "symbol": "DSOL",
    "name": "DecentSol",
    "decimals": 4,
    "logoURI":
        "https://gateway.pinata.cloud/ipfs/QmfV1LNrqefadJQ7PzMvrTnio9GzsFLcbwRXAgVQad3ykt/logo.png",
    "tags": ["utility-token"],
    "extensions": {
      "website": "https://home.decentsol/",
      "twitter": "https://twitter.com/decentsol",
      "medium": "https://decentsol.medium.com",
      "discord": "https://discord.gg/mkH52yU9xQ"
    }
  },
  {
    "chainId": 101,
    "address": "6foyeENL9GhqZEqPeaRK9YtP8HnFfej1JBwdn5rcsPDi",
    "symbol": "iM",
    "name": "iMentusCoin",
    "decimals": 0,
    "logoURI": "https://imentus.com/wp-content/uploads/2020/10/black_imentus_logo.png",
    "tags": ["dev-token"],
    "extensions": {"website": "https://www.imentus.com"}
  },
  {
    "chainId": 101,
    "address": "5oVNBeEEQvYi1cX3ir8Dx5n1P7pdxydbGF2X4TxVusJm",
    "symbol": "SOCN",
    "name": "Socean",
    "decimals": 9,
    "logoURI":
        "https://raw.githubusercontent.com/solana-labs/token-list/main/assets/mainnet/5oVNBeEEQvYi1cX3ir8Dx5n1P7pdxydbGF2X4TxVusJm/logo.png",
    "tags": ["stake-pool"],
    "extensions": {
      "discord": "https://discord.gg/k8ZcW27bq9/",
      "medium": "https://medium.com/@soceanfinance/",
      "twitter": "https://twitter.com/soceanfinance/",
      "website": "https://socean.fi/"
    }
  },
  {
    "chainId": 103,
    "address": "FsrinjAhYaBKQieHhaJNGnepMS3RFHZJVjb1i26JhMdp",
    "symbol": "sBucks",
    "name": "SolBucks",
    "decimals": 6,
    "logoURI":
        "https://raw.githubusercontent.com/solana-labs/token-list/main/assets/mainnet/FxjbQMfvQYMtZZK7WGEJwWfsDcdMuuaee8uPxDFFShWh/logo.png",
    "tags": ["utility-token"]
  },
  {
    "chainId": 101,
    "address": "GHhDU9Y7HM37v6cQyaie1A3aZdfpCDp6ScJ5zZn2c3uk",
    "symbol": "SOL-pSOL",
    "name": "Mercurial LP Token (SOL-pSOL)",
    "decimals": 6,
    "logoURI":
        "https://raw.githubusercontent.com/solana-labs/token-list/main/assets/mainnet/GHhDU9Y7HM37v6cQyaie1A3aZdfpCDp6ScJ5zZn2c3uk/logo.svg",
    "tags": ["lp-token"],
    "extensions": {"website": "https://www.mercurial.finance/"}
  },
  {
    "chainId": 101,
    "address": "C64WgwmfCyuFeV1k8MP1gRMP6NPA1ve7QLivvCrVaJn",
    "symbol": "KRI",
    "name": "Kauri Token",
    "decimals": 9,
    "logoURI": "https://cdn.jsdelivr.net/gh/Osawejustice/Kauri-Token/Kauri_logo32x32.png",
    "tags": ["utility-token"],
    "extensions": {
      "website": "https://www.museinc.studio",
      "PlayStore": "https://play.google.com/store/apps/details?id=com.mimshachstudios.muse",
      "twitter": "https://twitter.com/_museinc",
      "Instagram": "https://www.instagram.com/_museinc/",
      "Telegram": "https://t.me/kauritoken",
      "Discord": "https://discord.gg/jeN7dhes9V"
    }
  },
  {
    "chainId": 101,
    "address": "H2EJUxt2KSPk7BWGZRfLMqh56wCmWygDJVTvjTJFHeym",
    "symbol": "ROLL",
    "name": "Let'sroll DAO",
    "decimals": 9,
    "logoURI":
        "https://raw.githubusercontent.com/solana-labs/token-list/main/assets/mainnet/H2EJUxt2KSPk7BWGZRfLMqh56wCmWygDJVTvjTJFHeym/logo.png",
    "tags": [],
    "extensions": {"website": "ipfs://letsroll.dao"}
  },
  {
    "chainId": 101,
    "address": "6SuBPLC3vMTgfET5uoEhNoi5voYeBujVm7LS9kM3KX9s",
    "symbol": "FINN",
    "name": "FINNGRAM TOKEN",
    "decimals": 9,
    "logoURI":
        "https://raw.githubusercontent.com/solana-labs/token-list/main/assets/mainnet/6SuBPLC3vMTgfET5uoEhNoi5voYeBujVm7LS9kM3KX9s/logo.png",
    "tags": ["utility-token"],
    "extensions": {"website": "https://www.finngram.com"}
  },
  {
    "chainId": 101,
    "address": "BZrca9YNDtnshtsiD9GTvbMAXzZrSE6drxqNfxp5mpdc",
    "symbol": "KAKI",
    "name": "KAKI Token",
    "decimals": 0,
    "logoURI":
        "https://raw.githubusercontent.com/solana-labs/token-list/main/assets/mainnet/BZrca9YNDtnshtsiD9GTvbMAXzZrSE6drxqNfxp5mpdc/logo.svg",
    "tags": ["dev-token"],
    "extensions": {"website": "https://shunkakinoki.com"}
  },
  {
    "chainId": 101,
    "address": "6PwnEP2o5AnM29GDs2EiwfkQNuMoPiWokrLufSkJcVJR",
    "symbol": "Hose",
    "name": "Hose Token",
    "decimals": 19,
    "logoURI":
        "https://raw.githubusercontent.com/solana-labs/token-list/main/assets/mainnet/6PwnEP2o5AnM29GDs2EiwfkQNuMoPiWokrLufSkJcVJR/logo.png",
    "tags": ["utility-token"],
    "extensions": {"website": "http://hose-coin.com"}
  },
  {
    "chainId": 101,
    "address": "4QV4wzDdy7S1EV6y2r9DkmaDsHeoKz6HUvFLVtAsu6dV",
    "symbol": "AGTE",
    "name": "Agronomist coin",
    "decimals": 9,
    "logoURI":
        "https://raw.githubusercontent.com/solana-labs/token-list/main/assets/mainnet/4QV4wzDdy7S1EV6y2r9DkmaDsHeoKz6HUvFLVtAsu6dV/logo.png",
    "tags": ["utility-token"],
    "extensions": {
      "website": "https://agronomist.tech",
      "twitter": "https://twitter.com/AgronomistTech",
      "discord": "https://discord.gg/tR45QftB6K",
      "serumV3Usdc": "Ci3wLTY3X9iuMxDGErSNwfWKcrhwPMugk8yWTGBvEzF",
      "medium": "https://medium.com/@agronomist.tech",
      "coingeckoId": "agronomist"
    }
  },
  {
    "chainId": 101,
    "address": "5KB7WK1sB7WpoFXAiKoyhWCh44jHfTMtXDuvaSRQ4TR1",
    "symbol": "GIG",
    "name": "DecentGig Governance Token",
    "decimals": 6,
    "logoURI":
        "https://raw.githubusercontent.com/solana-labs/token-list/main/assets/mainnet/5KB7WK1sB7WpoFXAiKoyhWCh44jHfTMtXDuvaSRQ4TR1/logo.png",
    "tags": ["utility-token"],
    "extensions": {
      "website": "https://github.com/solauto/decent-gig",
      "discord": "https://discord.gg/wKZhV5NtGA"
    }
  },
  {
    "chainId": 101,
    "address": "CJR5HtmXzpCD8Ro28zyZyLjz1wtrCsu7bEwC4f8ZjRCD",
    "symbol": "GEKZ",
    "name": "Gekz Arena",
    "decimals": 9,
    "logoURI":
        "https://raw.githubusercontent.com/solana-labs/token-list/main/assets/mainnet/CJR5HtmXzpCD8Ro28zyZyLjz1wtrCsu7bEwC4f8ZjRCD/logo.png",
    "tags": [],
    "extensions": {
      "website": "https://www.gekzarena.com/",
      "twitter": "https://twitter.com/gekzarena",
      "discord": "https://discord.gg/Mh29ZdQCGC"
    }
  },
  {
    "chainId": 101,
    "address": "84QX2yE96Qmb984wGUcHLPT54a5bwjqo8zokCWPWez6d",
    "symbol": "INNO",
    "name": "INNOVATEK",
    "decimals": 18,
    "logoURI":
        "https://raw.githubusercontent.com/solana-labs/token-list/assets/mainnet/84QX2yE96Qmb984wGUcHLPT54a5bwjqo8zokCWPWez6d/logo.png",
    "tags": [],
    "extensions": {"website": "https://www.innovatek.us"}
  },
  {
    "chainId": 101,
    "address": "9JTriKH36nk7kQvK5V5TiVnuGQTqAJHRkX4kunGvZXfP",
    "symbol": "WHISP",
    "name": "Whispell",
    "decimals": 9,
    "logoURI":
        "https://raw.githubusercontent.com/solana-labs/token-list/main/assets/mainnet/9JTriKH36nk7kQvK5V5TiVnuGQTqAJHRkX4kunGvZXfP/logo.png",
    "tags": [],
    "extensions": {"website": "https://www.linkedin.com/in/williamwhispell/"}
  },
  {
    "chainId": 101,
    "address": "E28mvmaJa9LHLpJWiWsLd4eERL7w9j6uGAUwBWpH5UFd",
    "symbol": "SBULL",
    "name": "SolBull",
    "decimals": 9,
    "logoURI": "https://cdn.jsdelivr.net/gh/kasshen/SolBull/SolBull_Logo.png",
    "tags": ["meme", "bullish"]
  },
  {
    "chainId": 101,
    "address": "6JxHWpKwZjcnxjE9DZtaCEaoVNgpJzuBmrGQ6hmJ7DuM",
    "symbol": "PEPE",
    "name": "PEPE Coin",
    "decimals": 6,
    "logoURI": "https://cdn.jsdelivr.net/gh/matthew-github-123/pepetoken/frog.png",
    "tags": ["SPL token"],
    "extensions": {"twitter": "https://twitter.com/Pepe_Solana_SPL"}
  },
  {
    "chainId": 101,
    "address": "72FzkmpjqXQunY1UvrYDYhCj3mtPYExbWq7wFBSuxmHA",
    "symbol": "BOIT",
    "name": "BOIT Token",
    "decimals": 9,
    "logoURI":
        "https://raw.githubusercontent.com/solana-labs/token-list/main/assets/mainnet/72FzkmpjqXQunY1UvrYDYhCj3mtPYExbWq7wFBSuxmHA/logo.png",
    "tags": [],
    "extensions": {"website": "https://boit.club"}
  },
  {
    "chainId": 101,
    "address": "4MawquNMLDQsyNmQwdwqa34YtWFiqSezNgFEbUvZgskM",
    "symbol": "USBL",
    "name": "Balanced Dollar",
    "decimals": 9,
    "logoURI":
        "https://raw.githubusercontent.com/solana-labs/token-list/main/assets/mainnet/4MawquNMLDQsyNmQwdwqa34YtWFiqSezNgFEbUvZgskM/logo.png",
    "tags": [],
    "extensions": {"website": "https://softbalanced.com"}
  },
  {
    "chainId": 101,
    "address": "FTD9EisrsMt5TW5wSTMqyXLh2o7xTb6KNuTiXgHhw8Q8",
    "symbol": "PLAY",
    "name": "POLYPLAY",
    "decimals": 9,
    "logoURI":
        "https://raw.githubusercontent.com/solana-labs/token-list/main/assets/assets/FTD9EisrsMt5TW5wSTMqyXLh2o7xTb6KNuTiXgHhw8Q8/logo.png",
    "tags": [],
    "extensions": {
      "website": "https://polyplay.net/",
      "coingeckoId": "polyplay",
      "twitter": "https://twitter.com/polyplaycoin",
      "discord": "https://discord.gg/TAgndUz2Fc"
    }
  },
  {
    "chainId": 101,
    "address": "CH74tuRLTYcxG7qNJCsV9rghfLXJCQJbsu7i52a8F1Gn",
    "symbol": "SOLX",
    "name": "Soldex",
    "decimals": 9,
    "logoURI":
        "https://raw.githubusercontent.com/solana-labs/token-list/main/assets/assets/CH74tuRLTYcxG7qNJCsV9rghfLXJCQJbsu7i52a8F1Gn/logo.png",
    "tags": [],
    "extensions": {
      "website": "https://soldex.ai/",
      "medium": "https://soldex.medium.com/",
      "twitter": "https://twitter.com/soldexai",
      "linkedin": "https://www.linkedin.com/company/soldex"
    }
  },
  {
    "chainId": 101,
    "address": "J5gLhk6mmQ4PSoir1Ufh8JY2ytEHA93YupzYiTFVCgcL",
    "symbol": "FAROUT",
    "name": "Far-Out Token",
    "decimals": 9,
    "logoURI":
        "https://raw.githubusercontent.com/solana-labs/token-list/main/assets/assets/J5gLhk6mmQ4PSoir1Ufh8JY2ytEHA93YupzYiTFVCgcL/logo.png",
    "tags": [],
    "extensions": {
      "website": "https://gitlab.com/far-out/far-out-token",
      "telegram": "https://t.me/farouttoken"
    }
  },
  {
    "chainId": 101,
    "address": "Amig8TisuLpzun8XyGfC5HJHHGUQEscjLgoTWsCCKihg",
    "symbol": "tuUSDC",
    "name": "tuUSDC",
    "decimals": 6,
    "logoURI": "https://raw.githubusercontent.com/sol-farm/token-logos/main/tuUSDC.png",
    "tags": ["solfarm", "lending", "collateral tokens"],
    "extensions": {
      "website": "https://solfarm.io",
      "twitter": "https://twitter.com/Solfarmio",
      "waterfallbot": "https://bit.ly/TULIPwaterfall"
    }
  },
  {
    "chainId": 101,
    "address": "Am2kxXzFH84biqbswGWq2zieWqsX2ANnFDyiZr9Fh7zc",
    "symbol": "tuTULIP",
    "name": "tuTULIP",
    "decimals": 6,
    "logoURI": "https://raw.githubusercontent.com/sol-farm/token-logos/main/tuTULIP.png",
    "tags": ["solfarm", "lending", "collateral tokens"],
    "extensions": {
      "website": "https://solfarm.io",
      "twitter": "https://twitter.com/Solfarmio",
      "waterfallbot": "https://bit.ly/TULIPwaterfall"
    }
  },
  {
    "chainId": 101,
    "address": "H4Q3hDbuMUw8Bu72Ph8oV2xMQ7BFNbekpfQZKS2xF7jW",
    "symbol": "tuSOL",
    "name": "tuSOL",
    "decimals": 9,
    "logoURI": "https://raw.githubusercontent.com/sol-farm/token-logos/main/tuSOL.png",
    "tags": ["solfarm", "lending", "collateral tokens"],
    "extensions": {
      "website": "https://solfarm.io",
      "twitter": "https://twitter.com/Solfarmio",
      "waterfallbot": "https://bit.ly/TULIPwaterfall"
    }
  },
  {
    "chainId": 101,
    "address": "2yQJdxJy4tGeeXK2u8Lwdy9oY6Ks5shVH9gYtRH9zdDw",
    "symbol": "tuSNY",
    "name": "tuSNY",
    "decimals": 6,
    "logoURI": "https://raw.githubusercontent.com/sol-farm/token-logos/main/tuSNY.png",
    "tags": ["solfarm", "lending", "collateral tokens"],
    "extensions": {
      "website": "https://solfarm.io",
      "twitter": "https://twitter.com/Solfarmio",
      "waterfallbot": "https://bit.ly/TULIPwaterfall"
    }
  },
  {
    "chainId": 101,
    "address": "GtFtWCcLYtWQT8NLRwEfUqc9sgVnq4SbuSnMCpwcutNk",
    "symbol": "tuSLRS",
    "name": "tuSLRS",
    "decimals": 6,
    "logoURI": "https://raw.githubusercontent.com/sol-farm/token-logos/main/tuSLRS.png",
    "tags": ["solfarm", "lending", "collateral tokens"],
    "extensions": {
      "website": "https://solfarm.io",
      "twitter": "https://twitter.com/Solfarmio",
      "waterfallbot": "https://bit.ly/TULIPwaterfall"
    }
  },
  {
    "chainId": 101,
    "address": "8Lg7TowFuMQoGiTsLE6qV9x3czRgDmVy8f8Vv8KS4uW",
    "symbol": "tuRAY",
    "name": "tuRAY",
    "decimals": 6,
    "logoURI": "https://raw.githubusercontent.com/sol-farm/token-logos/main/tuRAY.png",
    "tags": ["solfarm", "lending", "collateral tokens"],
    "extensions": {
      "website": "https://solfarm.io",
      "twitter": "https://twitter.com/Solfarmio",
      "waterfallbot": "https://bit.ly/TULIPwaterfall"
    }
  },
  {
    "chainId": 101,
    "address": "658FZo9B4HgKxsKsM7cUHN7jfNFgC7YftusWWYWc4piD",
    "symbol": "tuPOLIS",
    "name": "tuPOLIS",
    "decimals": 8,
    "logoURI": "https://raw.githubusercontent.com/sol-farm/token-logos/main/tuPOLIS.png",
    "tags": ["solfarm", "lending", "collateral tokens"],
    "extensions": {
      "website": "https://solfarm.io",
      "twitter": "https://twitter.com/Solfarmio",
      "waterfallbot": "https://bit.ly/TULIPwaterfall"
    }
  },
  {
    "chainId": 101,
    "address": "6fGTc455JK3bsiSrvyLkEymQasPDXdrw2jJR16UkPnT5",
    "symbol": "tuMEDIA",
    "name": "tuMEDIA",
    "decimals": 6,
    "logoURI": "https://raw.githubusercontent.com/sol-farm/token-logos/main/tuMEDIA.png",
    "tags": ["solfarm", "lending", "collateral tokens"],
    "extensions": {
      "website": "https://solfarm.io",
      "twitter": "https://twitter.com/Solfarmio",
      "waterfallbot": "https://bit.ly/TULIPwaterfall"
    }
  },
  {
    "chainId": 101,
    "address": "DRu91PV94sb6kX6HwMGnGM8TuHrjycS4FmJNRWEgyw6n",
    "symbol": "tuLIKE",
    "name": "tuLIKE",
    "decimals": 9,
    "logoURI": "https://raw.githubusercontent.com/sol-farm/token-logos/main/tuLIKE.png",
    "tags": ["solfarm", "lending", "collateral tokens"],
    "extensions": {
      "website": "https://solfarm.io",
      "twitter": "https://twitter.com/Solfarmio",
      "waterfallbot": "https://bit.ly/TULIPwaterfall"
    }
  },
  {
    "chainId": 101,
    "address": "C1gwRSpKFu4Vjrg9MhNfRjg65SV4CNLsb3C6d7kWFEyV",
    "symbol": "tuETH",
    "name": "tuETH",
    "decimals": 6,
    "logoURI": "https://raw.githubusercontent.com/sol-farm/token-logos/main/tuETH.png",
    "tags": ["solfarm", "lending", "collateral tokens"],
    "extensions": {
      "website": "https://solfarm.io",
      "twitter": "https://twitter.com/Solfarmio",
      "waterfallbot": "https://bit.ly/TULIPwaterfall"
    }
  },
  {
    "chainId": 101,
    "address": "8cm7UrBiDQ4C1ntQSCZfHSWKUizdW31ddTQGNY6Lym3B",
    "symbol": "tuCOPE",
    "name": "tuCOPE",
    "decimals": 6,
    "logoURI": "https://raw.githubusercontent.com/sol-farm/token-logos/main/tuCOPE.png",
    "tags": ["solfarm", "lending", "collateral tokens"],
    "extensions": {
      "website": "https://solfarm.io",
      "twitter": "https://twitter.com/Solfarmio",
      "waterfallbot": "https://bit.ly/TULIPwaterfall"
    }
  },
  {
    "chainId": 101,
    "address": "9eGNc4BZCAgpTSEjbu7ACCLjpnZh1WSdts3y4nMik4e7",
    "symbol": "tuATLAS",
    "name": "tuATLAS",
    "decimals": 8,
    "logoURI": "https://raw.githubusercontent.com/sol-farm/token-logos/main/tuATLAS.png",
    "tags": ["solfarm", "lending", "collateral tokens"],
    "extensions": {
      "website": "https://solfarm.io",
      "twitter": "https://twitter.com/Solfarmio",
      "waterfallbot": "https://bit.ly/TULIPwaterfall"
    }
  },
  {
    "chainId": 101,
    "address": "FJtaAZd6tXNCFGTq7ifRHt9AWoVdads6gWNc4SXCPw1k",
    "symbol": "ALEPH",
    "name": "tuALEPH",
    "decimals": 6,
    "logoURI": "https://raw.githubusercontent.com/sol-farm/token-logos/main/tuALEPH.png",
    "tags": ["solfarm", "lending", "collateral tokens"],
    "extensions": {
      "website": "https://solfarm.io",
      "twitter": "https://twitter.com/Solfarmio",
      "waterfallbot": "https://bit.ly/TULIPwaterfall"
    }
  },
  {
    "chainId": 101,
    "address": "a11bdAAuV8iB2fu7X6AxAvDTo1QZ8FXB3kk5eecdasp",
    "symbol": "ABR",
    "name": "Allbridge",
    "decimals": 9,
    "logoURI": "https://raw.githubusercontent.com/allbridge-io/media/main/token.svg",
    "tags": [],
    "extensions": {
      "website": "https://allbridge.io/",
      "coingeckoId": "allbridge",
      "telegram": "https://t.me/allbridge_announcements",
      "medium": "https://allbridge.medium.com/",
      "twitter": "https://twitter.com/Allbridge_io"
    }
  },
  {
    "chainId": 101,
    "address": "6nuaX3ogrr2CaoAPjtaKHAoBNWok32BMcRozuf32s2QF",
    "symbol": "abBUSD",
    "name": "Wrapped BUSD (Allbridge from BSC)",
    "decimals": 9,
    "logoURI":
        "https://raw.githubusercontent.com/solana-labs/token-list/main/assets/mainnet/AJ1W9A9N9dEMdVyoDiam2rV44gnBm2csrPDP7xqcapgX/logo.png",
    "tags": ["stablecoin"],
    "extensions": {"coingeckoId": "binance-usd"}
  },
  {
    "chainId": 101,
    "address": "AaAEw2VCw1XzgvKB8Rj2DyK2ZVau9fbt2bE8hZFWsMyE",
    "symbol": "aeWETH",
    "name": "Wrapped ETH (Allbridge from Ethereum)",
    "decimals": 9,
    "logoURI":
        "https://raw.githubusercontent.com/solana-labs/token-list/main/assets/mainnet/FeGn77dhg1KXRRFeSwwMiykZnZPw5JXW6naf2aQgZDQf/logo.png",
    "tags": ["stablecoin"],
    "extensions": {"coingeckoId": "weth"}
  },
  {
    "chainId": 101,
    "address": "Bn113WT6rbdgwrm12UJtnmNqGqZjY4it2WoUQuQopFVn",
    "symbol": "aeUSDT",
    "name": "Wrapped USDT (Allbridge from Ethereum)",
    "decimals": 9,
    "logoURI":
        "https://raw.githubusercontent.com/solana-labs/token-list/main/assets/mainnet/Es9vMFrzaCERmJfrF4H2FYD4KCoNkY11McCe8BenwNYB/logo.svg",
    "tags": ["stablecoin"],
    "extensions": {"coingeckoId": "tether"}
  },
  {
    "chainId": 101,
    "address": "DdFPRnccQqLD4zCHrBqdY95D6hvw6PLWp9DEXj1fLCL9",
    "symbol": "aeUSDC",
    "name": "Wrapped USDC (Allbridge from Ethereum)",
    "decimals": 9,
    "logoURI":
        "https://raw.githubusercontent.com/solana-labs/token-list/main/assets/mainnet/EPjFWdd5AufqSSqeM2qN1xzybapC8G4wEGGkZwyTDt1v/logo.png",
    "tags": ["stablecoin"],
    "extensions": {"coingeckoId": "usd-coin"}
  },
  {
    "chainId": 101,
    "address": "9w6LpS7RU1DKftiwH3NgShtXbkMM1ke9iNU4g3MBXSUs",
    "symbol": "aeDAI",
    "name": "Wrapped DAI (Allbridge from Ethereum)",
    "decimals": 9,
    "logoURI":
        "https://raw.githubusercontent.com/solana-labs/token-list/main/assets/mainnet/FYpdBuyAHSbdaAyD1sKkxyLWbAP8uUW9h6uvdhK74ij1/logo.png",
    "tags": ["stablecoin"],
    "extensions": {"coingeckoId": "multi-collateral-dai"}
  },
  {
    "chainId": 101,
    "address": "EwxNF8g9UfmsJVcZFTpL9Hx5MCkoQFoJi6XNWzKf1j8e",
    "symbol": "acUSD",
    "name": "Wrapped CUSD (Allbridge from Celo)",
    "decimals": 9,
    "logoURI": "https://s2.coinmarketcap.com/static/img/coins/64x64/7236.png",
    "tags": ["stablecoin"],
    "extensions": {"coingeckoId": "celo-dollar"}
  },
  {
    "chainId": 101,
    "address": "5h6ssFpeDeRbzsEHDbTQNH7nVGgsKrZydxdSTnLm6QdV",
    "symbol": "cSOL",
    "name": "Solend SOL",
    "logoURI":
        "https://raw.githubusercontent.com/solana-labs/token-list/main/assets/mainnet/5h6ssFpeDeRbzsEHDbTQNH7nVGgsKrZydxdSTnLm6QdV/logo.png",
    "decimals": 9,
    "tags": ["solend", "lending", "collateral tokens"],
    "extensions": {"website": "https://solend.fi"}
  },
  {
    "chainId": 101,
    "address": "993dVFL2uXWYeoXuEBFXR4BijeXdTv4s6BzsCjJZuwqk",
    "symbol": "cUSDC",
    "name": "Solend USDC",
    "logoURI":
        "https://raw.githubusercontent.com/solana-labs/token-list/main/assets/mainnet/993dVFL2uXWYeoXuEBFXR4BijeXdTv4s6BzsCjJZuwqk/logo.png",
    "decimals": 6,
    "tags": ["solend", "lending", "collateral tokens"],
    "extensions": {"website": "https://solend.fi"}
  },
  {
    "chainId": 101,
    "address": "AppJPZka33cu4DyUenFe9Dc1ZmZ3oQju6mBn9k37bNAa",
    "symbol": "cETH",
    "name": "Solend ETH",
    "logoURI":
        "https://raw.githubusercontent.com/solana-labs/token-list/main/assets/mainnet/AppJPZka33cu4DyUenFe9Dc1ZmZ3oQju6mBn9k37bNAa/logo.png",
    "decimals": 6,
    "tags": ["solend", "lending", "collateral tokens"],
    "extensions": {"website": "https://solend.fi"}
  },
  {
    "chainId": 101,
    "address": "Gqu3TFmJXfnfSX84kqbZ5u9JjSBVoesaHjfTsaPjRSnZ",
    "symbol": "cBTC",
    "name": "Solend BTC",
    "logoURI":
        "https://raw.githubusercontent.com/solana-labs/token-list/main/assets/mainnet/Gqu3TFmJXfnfSX84kqbZ5u9JjSBVoesaHjfTsaPjRSnZ/logo.png",
    "decimals": 6,
    "tags": ["solend", "lending", "collateral tokens"],
    "extensions": {"website": "https://solend.fi"}
  },
  {
    "chainId": 101,
    "address": "4CxGuD2NMr6zM8f18gr6kRhgd748pnmkAhkY1YJtkup1",
    "symbol": "cSRM",
    "name": "Solend SRM",
    "logoURI":
        "https://raw.githubusercontent.com/solana-labs/token-list/main/assets/mainnet/4CxGuD2NMr6zM8f18gr6kRhgd748pnmkAhkY1YJtkup1/logo.png",
    "decimals": 6,
    "tags": ["solend", "lending", "collateral tokens"],
    "extensions": {"website": "https://solend.fi"}
  },
  {
    "chainId": 101,
    "address": "BTsbZDV7aCMRJ3VNy9ygV4Q2UeEo9GpR8D6VvmMZzNr8",
    "symbol": "cUSDT",
    "name": "Solend USDT",
    "logoURI":
        "https://raw.githubusercontent.com/solana-labs/token-list/main/assets/mainnet/BTsbZDV7aCMRJ3VNy9ygV4Q2UeEo9GpR8D6VvmMZzNr8/logo.png",
    "decimals": 6,
    "tags": ["solend", "lending", "collateral tokens"],
    "extensions": {"website": "https://solend.fi"}
  },
  {
    "chainId": 101,
    "address": "A38TjtcYrfutXT6nfRxhqwoGiXyzwJsGPmekoZYYmfgP",
    "symbol": "cFTT",
    "name": "Solend FTT",
    "logoURI":
        "https://raw.githubusercontent.com/solana-labs/token-list/main/assets/mainnet/A38TjtcYrfutXT6nfRxhqwoGiXyzwJsGPmekoZYYmfgP/logo.png",
    "decimals": 6,
    "tags": ["solend", "lending", "collateral tokens"],
    "extensions": {"website": "https://solend.fi"}
  },
  {
    "chainId": 101,
    "address": "2d95ZC8L5XP6xCnaKx8D5U5eX6rKbboBBAwuBLxaFmmJ",
    "symbol": "cRAY",
    "name": "Solend RAY",
    "logoURI":
        "https://raw.githubusercontent.com/solana-labs/token-list/main/assets/mainnet/2d95ZC8L5XP6xCnaKx8D5U5eX6rKbboBBAwuBLxaFmmJ/logo.png",
    "decimals": 6,
    "tags": ["solend", "lending", "collateral tokens"],
    "extensions": {"website": "https://solend.fi"}
  },
  {
    "chainId": 101,
    "address": "BsWLxf6hRJnyytKR52kKBiz7qU7BB3SH77mrBxNnYU1G",
    "symbol": "cMER",
    "name": "Solend MER",
    "logoURI":
        "https://raw.githubusercontent.com/solana-labs/token-list/main/assets/mainnet/BsWLxf6hRJnyytKR52kKBiz7qU7BB3SH77mrBxNnYU1G/logo.png",
    "decimals": 6,
    "tags": ["solend", "lending", "collateral tokens"],
    "extensions": {"website": "https://solend.fi"}
  },
  {
    "chainId": 101,
    "address": "5PHgMyZpEUCTeXQdb2ARm2KMZNu4rxzLXuhKwXtr8Xzc",
    "symbol": "STVA-USDC",
    "name": "Raydium LP Token (STVA-USDC)",
    "decimals": 6,
    "logoURI":
        "https://raw.githubusercontent.com/solana-labs/token-list/main/assets/mainnet/5PHgMyZpEUCTeXQdb2ARm2KMZNu4rxzLXuhKwXtr8Xzc/logo.svg",
    "tags": ["lp-token"],
    "extensions": {"website": "https://raydium.io"}
  },
  {
    "chainId": 101,
    "address": "HZRCwxP2Vq9PCpPXooayhJ2bxTpo5xfpQrwB1svh332p",
    "symbol": "wLDO",
    "name": "Wormhole-wrapped Lido DAO Token",
    "decimals": 8,
    "logoURI":
        "https://raw.githubusercontent.com/solana-labs/token-list/main/assets/mainnet/HZRCwxP2Vq9PCpPXooayhJ2bxTpo5xfpQrwB1svh332p/logo.png",
    "tags": [],
    "extensions": {"website": "https://lido.fi/", "twitter": "https://twitter.com/LidoFinance/"}
  },
  {
    "chainId": 101,
    "address": "ADcrbtXkfpos5Z989zAr1KbjG4mXanwJYboaXKS749sm",
    "symbol": "ReeFi",
    "name": "Reedify Finance",
    "logoURI":
        "https://raw.githubusercontent.com/solana-labs/token-list/main/assets/mainnet/ADcrbtXkfpos5Z989zAr1KbjG4mXanwJYboaXKS749sm/logo.png",
    "decimals": 9,
    "tags": ["DeFi"],
    "extensions": {
      "website": "https://reedify.finance/",
      "twitter": "https://twitter.com/ReedifyFinance",
      "telegram": "https://t.me/ReedifyFinance",
      "medium": "https://reedify.medium.com",
      "discord": "https://discord.gg/f3VXDfwKNb"
    }
  },
  {
    "chainId": 101,
    "address": "48cR9mPuj33XowR4BX5nWtn6zqNP2rWjEAKURb6AcvkC",
    "symbol": "VLT",
    "name": "Vault Coin",
    "decimals": 9,
    "logoURI":
        "https://raw.githubusercontent.com/solana-labs/token-list/main/assets/assets/48cR9mPuj33XowR4BX5nWtn6zqNP2rWjEAKURb6AcvkC/logo.png",
    "tags": [],
    "extensions": {"website": "https://vaultnft.org/"}
  },
  {
    "chainId": 101,
    "address": "AKAwZaP91svXuYTe2gD5JVmUZteDFrT4G92rMtrF1Wb4",
    "symbol": "WTTE",
    "name": "WATTTON Exchange",
    "decimals": 8,
    "logoURI":
        "https://raw.githubusercontent.com/solana-labs/token-list/main/assets/mainnet/AKAwZaP91svXuYTe2gD5JVmUZteDFrT4G92rMtrF1Wb4/logo.png",
    "tags": ["WATTTON", "WATTTON Exchange", "WATTTON Exchange Token"],
    "extensions": {"website": "https://wattton.org"}
  },
  {
    "chainId": 101,
    "address": "6GF5Gjptix8yCJeVjp6e8uYNAP5Y2Gnb1CqZ9ADEaLdu",
    "symbol": "TOPS",
    "name": "TOPSOL",
    "decimals": 9,
    "logoURI":
        "https://raw.githubusercontent.com/solana-labs/token-list/main/assets/mainnet/6GF5Gjptix8yCJeVjp6e8uYNAP5Y2Gnb1CqZ9ADEaLdu/logo.png",
    "tags": ["utility-token", "commodity-token"],
    "extensions": {"website": "https://topsol.finance"}
  },
  {
    "chainId": 101,
    "address": "Fh3As4AU6bSsj5HcFHFD1LigeXWdFCJicnaQ64h7RFn5",
    "symbol": "IPC",
    "name": "Imperial Coin",
    "decimals": 9,
    "logoURI":
        "https://raw.githubusercontent.com/solana-labs/token-list/main/assets/mainnet/Fh3As4AU6bSsj5HcFHFD1LigeXWdFCJicnaQ64h7RFn5/logo.png",
    "tags": [],
    "extensions": {
      "telegram": "https://t.me/imperialcoinOfficial",
      "twitter": "https://twitter.com/ImperialCoin_"
    }
  },
  {
    "chainId": 101,
    "address": "FG7x94jPcVbtt4pLXWhyr6sU3iWim8JJ2y215X5yowN5",
    "symbol": "FIS",
    "name": "StaFi Token",
    "decimals": 9,
    "logoURI":
        "https://raw.githubusercontent.com/solana-labs/token-list/main/assets/mainnet/FG7x94jPcVbtt4pLXWhyr6sU3iWim8JJ2y215X5yowN5/logo.png",
    "tags": ["utility-token"],
    "extensions": {
      "website": "https://stafi.io",
      "twitter": "https://twitter.com/StaFi_Protocol",
      "telegram": "https://t.me/stafi_protocol",
      "medium": "https://stafi-protocol.medium.com",
      "discord": "https://discord.com/invite/jB77etn"
    }
  },
  {
    "chainId": 101,
    "address": "7hUdUTkJLwdcmt3jSEeqx4ep91sm1XwBxMDaJae6bD5D",
    "symbol": "rSOL",
    "name": "StaFi rSOL",
    "decimals": 9,
    "logoURI":
        "https://raw.githubusercontent.com/solana-labs/token-list/main/assets/mainnet/7hUdUTkJLwdcmt3jSEeqx4ep91sm1XwBxMDaJae6bD5D/logo.png",
    "tags": ["utility-token"],
    "extensions": {
      "website": "https://stafi.io",
      "twitter": "https://twitter.com/StaFi_Protocol",
      "telegram": "https://t.me/stafi_protocol",
      "medium": "https://stafi-protocol.medium.com",
      "discord": "https://discord.com/invite/jB77etn"
    }
  },
  {
    "chainId": 101,
    "address": "CPXDs2uhNwDKAt9V3vXvtspv9U7rsQ2fVr1qAUDmuCaq",
    "symbol": "CPX",
    "name": "Circlepod Protocol Token",
    "decimals": 6,
    "logoURI":
        "https://raw.githubusercontent.com/solana-labs/token-list/main/assets/mainnet/CPXDs2uhNwDKAt9V3vXvtspv9U7rsQ2fVr1qAUDmuCaq/logo.png",
    "tags": [],
    "extensions": {
      "website": "https://www.circlepod.app/",
      "twitter": "https://twitter.com/circlepodP",
      "discord": "https://discord.gg/4rTM9tRV8s"
    }
  },
  {
    "chainId": 101,
    "address": "GzN5Y1KoP6Yo6KYVYg7JfJ7Urs6oCrtLByHLeZ1ELAnx",
    "symbol": "ODC",
    "name": "OneDay Coin",
    "decimals": 9,
    "logoURI":
        "https://raw.githubusercontent.com/solana-labs/token-list/main/assets/assets/GzN5Y1KoP6Yo6KYVYg7JfJ7Urs6oCrtLByHLeZ1ELAnx/logo.png",
    "tags": [],
    "extensions": {
      "website": "https://www.odccoin.com/",
      "whitepaper":
          "https://fbcfc5cd-4898-40bf-9870-db311c0095f0.filesusr.com/ugd/0a74e1_154571838e94457692909858d58f1f99.pdf"
    }
  },
  {
    "chainId": 101,
    "address": "6E8tJq85M64wqerfwBN6iYQGJPVcUFzgc8wKqc3tcKeD",
    "symbol": "YAT-PIR",
    "name": "Yet Another Token PIRIT",
    "decimals": 6,
    "logoURI":
        "https://raw.githubusercontent.com/solana-labs/token-list/main/assets/mainnet/6E8tJq85M64wqerfwBN6iYQGJPVcUFzgc8wKqc3tcKeD/logo.png",
    "tags": [],
    "extensions": {"website": "http://n1pool.com/"}
  },
  {
    "chainId": 103,
    "address": "6E8tJq85M64wqerfwBN6iYQGJPVcUFzgc8wKqc3tcKeD",
    "symbol": "YAT-PIR",
    "name": "Yet Another Token PIRIT",
    "decimals": 6,
    "logoURI":
        "https://raw.githubusercontent.com/solana-labs/token-list/main/assets/mainnet/6E8tJq85M64wqerfwBN6iYQGJPVcUFzgc8wKqc3tcKeD/logo.png",
    "tags": [],
    "extensions": {"website": "http://n1pool.com/"}
  },
  {
    "chainId": 101,
    "address": "7duMWSNdYMof6WKZHs5X1wdmmxUa6cDGqqKShhMSGkgg",
    "symbol": "YAT-LAZ",
    "name": "Yet Another Token LAZURIT",
    "decimals": 6,
    "logoURI":
        "https://raw.githubusercontent.com/solana-labs/token-list/main/assets/mainnet/7duMWSNdYMof6WKZHs5X1wdmmxUa6cDGqqKShhMSGkgg/logo.png",
    "tags": [],
    "extensions": {"website": "http://n1pool.com/"}
  },
  {
    "chainId": 103,
    "address": "7duMWSNdYMof6WKZHs5X1wdmmxUa6cDGqqKShhMSGkgg",
    "symbol": "YAT-LAZ",
    "name": "Yet Another Token LAZURIT",
    "decimals": 6,
    "logoURI":
        "https://raw.githubusercontent.com/solana-labs/token-list/main/assets/mainnet/7duMWSNdYMof6WKZHs5X1wdmmxUa6cDGqqKShhMSGkgg/logo.png",
    "tags": [],
    "extensions": {"website": "http://n1pool.com/"}
  },
  {
    "chainId": 101,
    "address": "59XzU2M7YckoiNw7wUq54eeeg6Kw8gL5554eg2nToat",
    "symbol": "LDHTOIXG",
    "name": "LDHTOIXGCOIN",
    "decimals": 9,
    "logoURI":
        "https://raw.githubusercontent.com/solana-labs/token-list/main/assets/mainnet/59XzU2M7YckoiNw7wUq54eeeg6Kw8gL5554eg2nToat/logo.png",
    "tags": [],
    "extensions": {"website": "http://google.com/"}
  },
  {
    "chainId": 101,
    "address": "FU93FVMNiphc8Jdh2jPHHQvZpwvL4obCELPBhkMnJLxh",
    "symbol": "RZZ",
    "name": "Razzmena compnay Token",
    "decimals": 6,
    "logoURI":
        "https://raw.githubusercontent.com/solana-labs/token-list/main/assets/mainnet/FU93FVMNiphc8Jdh2jPHHQvZpwvL4obCELPBhkMnJLxh/logo.png",
    "tags": ["lp-token"],
    "extensions": {"website": "https://razzmena.com"}
  },
  {
    "chainId": 101,
    "address": "6xtyNYX6Rf4Kp3629X11m1jqUmkV89mf9xQakUtUQfHq",
    "symbol": "CHIH",
    "name": "CHIHUAHUA",
    "decimals": 9,
    "logoURI": "https://raw.githubusercontent.com/ChihuahuaSol/Chihuahua/main/chihuahua-token.png",
    "tags": ["NFT"],
    "extensions": {
      "website": "https://chihuahuasol.com/",
      "twitter": "https://twitter.com/ChihuahuaSol",
      "discord": "https://discord.gg/cQMHepBqmc"
    }
  },
  {
    "chainId": 101,
    "address": "9xkb4MSeD2WkJuio3EdGhEjNP5MuAp56scwKpiDNLtHc",
    "symbol": "JACKIE",
    "name": "Jackie Chan Fan Token",
    "decimals": 4,
    "logoURI":
        "https://raw.githubusercontent.com/solana-labs/token-list/main/assets/mainnet/9xkb4MSeD2WkJuio3EdGhEjNP5MuAp56scwKpiDNLtHc/logo.png",
    "tags": ["community-token"],
    "extensions": {
      "website": "https://jackietoken.tk/",
      "coinalpha": "9xkb4MSeD2WkJuio3EdGhEjNP5MuAp56scwKpiDNLtHc",
      "twitter": "https://twitter.com/jackie_token/",
      "facebook": "https://www.facebook.com/groups/jackiechanfanclubgroup",
      "telegram": "https://t.me/jackietoken"
    }
  },
  {
    "chainId": 101,
    "address": "8oMHsGMaeLLC77DdFYzernNS39oDT7cJ7Gq5o9ThcaFM",
    "symbol": "PLUS",
    "name": "PlusPlus",
    "decimals": 9,
    "logoURI":
        "https://raw.githubusercontent.com/solana-labs/token-list/main/assets/mainnet/8oMHsGMaeLLC77DdFYzernNS39oDT7cJ7Gq5o9ThcaFM/logo.png",
    "tags": ["utility-token"],
    "extensions": {"website": "https://plusplus.is/"}
  },
  {
    "chainId": 101,
    "address": "DQP2edsDc4bApMaQ4pRim6AE18yCjHpohFLhnWbxc4um",
    "symbol": "wDAY",
    "name": "ChronoLogic DAY (Wormhole)",
    "decimals": 8,
    "logoURI":
        "https://raw.githubusercontent.com/solana-labs/token-list/main/assets/mainnet/DQP2edsDc4bApMaQ4pRim6AE18yCjHpohFLhnWbxc4um/logo.png",
    "tags": ["ethereum", "wrapped", "wormhole"],
    "extensions": {
      "coingeckoId": "chronologic",
      "website": "https://chronologic.network/",
      "telegram": "https://t.me/chronologicnetwork",
      "medium": "https://blog.chronologic.network/",
      "twitter": "https://twitter.com/ChronoLogicETH",
      "youtube": "http://www.youtube.com/c/ChronoLogic"
    }
  },
  {
    "chainId": 101,
    "address": "FAmdutSS9sTVoqTbw2JYrcns58ZfEozrgevgeZuZiyML",
    "symbol": "SOL-USDC",
    "name": "HydraSwap LP Token (SOL-USDC)",
    "decimals": 6,
    "logoURI":
        "https://raw.githubusercontent.com/solana-labs/token-list/main/assets/mainnet/FAmdutSS9sTVoqTbw2JYrcns58ZfEozrgevgeZuZiyML/logo.png",
    "tags": ["lp-token"],
    "extensions": {
      "website": "https://www.hydraswap.io",
      "twitter": "https://twitter.com/HydraSwap_io"
    }
  },
  {
    "chainId": 101,
    "address": "5vVrn1ioAjAeCNSYhwA19CnPTSmcDuMPnB2wUFQ5hkeg",
    "symbol": "BTC-USDC",
    "name": "HydraSwap LP Token (BTC-USDC)",
    "decimals": 6,
    "logoURI":
        "https://raw.githubusercontent.com/solana-labs/token-list/main/assets/mainnet/5vVrn1ioAjAeCNSYhwA19CnPTSmcDuMPnB2wUFQ5hkeg/logo.png",
    "tags": ["lp-token"],
    "extensions": {
      "website": "https://www.hydraswap.io",
      "twitter": "https://twitter.com/HydraSwap_io"
    }
  },
  {
    "chainId": 101,
    "address": "HRhugQTKnX5TK6dQUygwUr7rgCZmzJjk4CiAxZV3eaTk",
    "symbol": "ETH-USDC",
    "name": "HydraSwap LP Token (ETH-USDC)",
    "decimals": 6,
    "logoURI":
        "https://raw.githubusercontent.com/solana-labs/token-list/main/assets/mainnet/HRhugQTKnX5TK6dQUygwUr7rgCZmzJjk4CiAxZV3eaTk/logo.png",
    "tags": ["lp-token"],
    "extensions": {
      "website": "https://www.hydraswap.io",
      "twitter": "https://twitter.com/HydraSwap_io"
    }
  },
  {
    "chainId": 101,
    "address": "UgMdvGuY2HNMmCJQdY6aGty1yDxHBxm9Q9KJVefVjwJ",
    "symbol": "W technology",
    "name": "W",
    "decimals": 2,
    "logoURI":
        "https://raw.githubusercontent.com/WBORSA/token-list/main/assets/mainnet/UgMdvGuY2HNMmCJQdY6aGty1yDxHBxm9Q9KJVefVjwJ/W%20Coin.png",
    "tags": [],
    "extensions": {"website": "https://app.w.systems/"}
  },
  {
    "chainId": 101,
    "address": "gxBfxxAwzHZvtyDhq8Rcs4at4cLwbemqvZnZguujKLw",
    "symbol": "DOGE.sol",
    "name": "DOGESOL",
    "decimals": 9,
    "logoURI":
        "https://raw.githubusercontent.com/Maxtho8/token-list/main/assets/mainnet/gxBfxxAwzHZvtyDhq8Rcs4at4cLwbemqvZnZguujKLw.png",
    "tags": [],
    "extensions": {}
  },
  {
    "chainId": 101,
    "address": "8EUyHq7ZVg7t9oFwYWtkiH1ybg5eXjKCGn7oc8FRXwDT",
    "symbol": "FLC",
    "name": "Feliz Coin",
    "decimals": 9,
    "logoURI":
        "https://raw.githubusercontent.com/solana-labs/token-list/main/assets/mainnet/8EUyHq7ZVg7t9oFwYWtkiH1ybg5eXjKCGn7oc8FRXwDT/logo.png",
    "tags": [],
    "extensions": {"website": "https://www.felizcoin.org/"}
  },
  {
    "chainId": 101,
    "address": "7R7rZ7SsLDXkYAfJyRCBScLuZwizeMWaTWrwFhSZU2Jq",
    "symbol": "WET",
    "name": "Weble Ecosystem Token",
    "decimals": 9,
    "logoURI":
        "https://raw.githubusercontent.com/solana-labs/token-list/main/assets/mainnet/7R7rZ7SsLDXkYAfJyRCBScLuZwizeMWaTWrwFhSZU2Jq/logo.png",
    "tags": [],
    "extensions": {"website": "https://wet.weble.ch/"}
  },
  {
    "chainId": 101,
    "address": "BFsCwfk8VsEbSfLkkgmoKsAPk2N6FMJjeTsuxfGa9VEf",
    "symbol": "aeFTT",
    "name": "Wrapped FTT (Allbridge from Ethereum)",
    "decimals": 9,
    "logoURI":
        "https://raw.githubusercontent.com/solana-labs/token-list/main/assets/mainnet/AGFEad2et2ZJif9jaGpdMixQqvW5i81aBdvKe7PHNfz3/logo.png",
    "tags": [],
    "extensions": {"coingeckoId": "ftx-token"}
  },
  {
    "chainId": 101,
    "address": "ALQ9KMWjFmxVbew3vMkJj3ypbAKuorSgGst6svCHEe2z",
    "symbol": "MDF",
    "name": "MatrixETF DAO Finance",
    "decimals": 6,
    "logoURI":
        "https://raw.githubusercontent.com/solana-labs/token-list/main/assets/mainnet/ALQ9KMWjFmxVbew3vMkJj3ypbAKuorSgGst6svCHEe2z/logo.png",
    "tags": ["utility-token"],
    "extensions": {
      "website": "https://www.matrixetf.finance/",
      "telegram": "https://t.me/MatrixETF",
      "twitter": "https://twitter.com/MatrixETF",
      "coingeckoId": "matrixetf"
    }
  },
  {
    "chainId": 101,
    "address": "EfdM1aiUaoXHu3TdVAGYiyHKcvkZURjmxsfXWLa5LyTc",
    "symbol": "BRANE",
    "name": "Brane",
    "decimals": 8,
    "logoURI": "https://raw.githubusercontent.com/elonsuk/BRANE-Token/master/Logo.png",
    "tags": ["BRANE", "BRANE-Token"]
  },
  {
    "chainId": 101,
    "address": "5tN42n9vMi6ubp67Uy4NnmM5DMZYN8aS8GeB3bEDHr6E",
    "symbol": "WAG",
    "name": "Waggle Network",
    "decimals": 9,
    "logoURI":
        "https://raw.githubusercontent.com/solana-labs/token-list/main/assets/mainnet/5tN42n9vMi6ubp67Uy4NnmM5DMZYN8aS8GeB3bEDHr6E/logo.png",
    "tags": [],
    "extensions": {
      "website": "https://waggle.network/",
      "twitter": "https://twitter.com/wagglenetwork",
      "telegram": "https://t.me/waggle_network",
      "medium": "https://medium.com/@wagglenetwork"
    }
  },
  {
    "chainId": 101,
    "address": "DxWXDwbqNyXs4ABCRWAJU2Xi4xpYJLp3UxRhsu1jU6gs",
    "symbol": "LMS",
    "name": "LMS Stars",
    "decimals": 9,
    "logoURI":
        "https://raw.githubusercontent.com/solana-labs/token-list/main/assets/assets/DxWXDwbqNyXs4ABCRWAJU2Xi4xpYJLp3UxRhsu1jU6gs/logo.png",
    "tags": ["LMS"],
    "extensions": {"website": "https://www.letmespeak.pro/"}
  },
  {
    "chainId": 101,
    "address": "uNrix3Q5g51MCEUrYBUEBDdQ96RQDQspQJJnnQ4T3Vc",
    "symbol": "SBNK",
    "name": "Solbank",
    "decimals": 6,
    "logoURI":
        "https://raw.githubusercontent.com/solana-labs/token-list/main/assets/mainnet/uNrix3Q5g51MCEUrYBUEBDdQ96RQDQspQJJnnQ4T3Vc/logo.png",
    "tags": [],
    "extensions": {
      "website": "http://solbank.app/",
      "coingeckoId": "solblank",
      "twitter": "https://twitter.com/solbankapp"
    }
  },
  {
    "chainId": 101,
    "address": "2KccNRqHQdnQ9WS8vLSo8uwVPpW7dojmMmZuDpwi6mKd",
    "symbol": "WESH",
    "name": "WeShare",
    "decimals": 8,
    "logoURI":
        "https://raw.githubusercontent.com/solana-labs/token-list/main/assets/mainnet/2KccNRqHQdnQ9WS8vLSo8uwVPpW7dojmMmZuDpwi6mKd/logo.png",
    "tags": ["tokenized-stock", "weshare", "social-token"],
    "extensions": {"website": "https://www.we-share.online/"}
  },
  {
    "chainId": 101,
    "address": "EHrY9aueq55y7pWTcFJhCryNwJtAN14spL5UiG938RnV",
    "symbol": "KLAYG",
    "name": "Klay Games",
    "decimals": 8,
    "logoURI": "https://raw.githubusercontent.com/KLAYGAMES/KlayGames/main/KlayLogo_64.png",
    "tags": ["game"],
    "extensions": {"website": "https://klaygames.io/"}
  },
  {
    "chainId": 101,
    "address": "NJdK95TPKguYLUzhNPEumEbwC7cjciEQUzG4UrvhcJv",
    "symbol": "AINU",
    "name": "AvatarInu",
    "decimals": 8,
    "logoURI":
        "https://raw.githubusercontent.com/solana-labs/token-list/main/assets/mainnet/NJdK95TPKguYLUzhNPEumEbwC7cjciEQUzG4UrvhcJv/logo.png",
    "tags": ["nft", "gaming"],
    "extensions": {"website": "https://avatarinu.com/"}
  },
  {
    "chainId": 101,
    "address": "2AVXRChvUAnyP3W3Psg4ZTY2w7KYbPy3vZ6FpS5c8ya6",
    "symbol": "BLACK",
    "name": "Black Freelancer",
    "decimals": 9,
    "logoURI":
        "https://raw.githubusercontent.com/solana-labs/token-list/main/assets/mainnet/2AVXRChvUAnyP3W3Psg4ZTY2w7KYbPy3vZ6FpS5c8ya6/logo.png",
    "tags": ["utility-token"],
    "extensions": {
      "website": "https://www.blackfreelancer.com",
      "twitter": "https://www.twitter.com/blackfreelancr",
      "instagram": "https://www.instagram.com/blackfreelancer",
      "blog": "https://blog.blackfreelancer.com"
    }
  },
  {
    "chainId": 101,
    "address": "GiKE9s8TMYdkWE28CzPDSYn42RK4AHZSxg7cthg1ntcn",
    "symbol": "SLTM",
    "name": "Soltomm F-token",
    "decimals": 9,
    "logoURI":
        "https://raw.githubusercontent.com/solana-labs/token-list/main/assets/mainnet/GiKE9s8TMYdkWE28CzPDSYn42RK4AHZSxg7cthg1ntcn/logo.png",
    "tags": ["utility-token", "nft"],
    "extensions": {
      "website": "https://www.soltomm.com",
      "twitter": "https://www.twitter.com/soltomm",
      "telegram": "https://t.me/soltomm",
      "medium": "https://soltomm.medium.com"
    }
  },
  {
    "chainId": 101,
    "address": "8urbgQGLFvEScPKVbigbzcfU3BFHsZaVGZ7mhrMoaZcu",
    "symbol": "SWAB",
    "name": "Schwabendollar",
    "decimals": 2,
    "logoURI":
        "https://cdn.jsdelivr.net/gh/solana-labs/token-list@15773063f55394cf15353e7b4874c56dc66c97b6/assets/mainnet/8urbgQGLFvEScPKVbigbzcfU3BFHsZaVGZ7mhrMoaZcu/logo.svg",
    "tags": ["stablecoin"],
    "extensions": {
      "website": "https://schwabendollar.de/",
      "instagram": "https://www.instagram.com/schwabendollar",
      "twitter": "https://twitter.com/schwabendollar"
    }
  },
  {
    "chainId": 101,
    "address": "BDNA1bZDCQYerXgjF9dcqeNcqBYKWQQN3z9QXypvQ9uV",
    "symbol": "BDNA1",
    "name": "Gold SolBull DNA",
    "decimals": 9,
    "logoURI":
        "https://raw.githubusercontent.com/solana-labs/token-list/main/assets/mainnet/BDNA1bZDCQYerXgjF9dcqeNcqBYKWQQN3z9QXypvQ9uV/logo.png",
    "tags": ["utility-token"],
    "extensions": {
      "website": "https://solbulls.art",
      "twitter": "https://twitter.com/SolanaBullsNFT",
      "discord": "https://discord.gg/wbkXkWQeex",
      "medium": "https://medium.com/@SolBulls"
    }
  },
  {
    "chainId": 101,
    "address": "BDNA2oi3W3TpMfbPMRoEzM55WdSajtyWnADkhsCW9p5f",
    "symbol": "BDNA2",
    "name": "White SolBull DNA",
    "decimals": 9,
    "logoURI":
        "https://raw.githubusercontent.com/solana-labs/token-list/main/assets/mainnet/BDNA2oi3W3TpMfbPMRoEzM55WdSajtyWnADkhsCW9p5f/logo.png",
    "tags": ["utility-token"],
    "extensions": {
      "website": "https://solbulls.art",
      "twitter": "https://twitter.com/SolanaBullsNFT",
      "discord": "https://discord.gg/wbkXkWQeex",
      "medium": "https://medium.com/@SolBulls"
    }
  },
  {
    "chainId": 101,
    "address": "BDNA345whxSjPj1xBk7wobHfnv35qe7rJwX2zUnRMZMT",
    "symbol": "BDNA3",
    "name": "Grey SolBull DNA",
    "decimals": 9,
    "logoURI":
        "https://raw.githubusercontent.com/solana-labs/token-list/main/assets/mainnet/BDNA345whxSjPj1xBk7wobHfnv35qe7rJwX2zUnRMZMT/logo.png",
    "tags": ["utility-token"],
    "extensions": {
      "website": "https://solbulls.art",
      "twitter": "https://twitter.com/SolanaBullsNFT",
      "discord": "https://discord.gg/wbkXkWQeex",
      "medium": "https://medium.com/@SolBulls"
    }
  },
  {
    "chainId": 101,
    "address": "BDNA4xTPk6iVe2iuQe8931quH55XsZo3R97VwsgfUgK5",
    "symbol": "BDNA4",
    "name": "Brown SolBull DNA",
    "decimals": 9,
    "logoURI":
        "https://raw.githubusercontent.com/solana-labs/token-list/main/assets/mainnet/BDNA4xTPk6iVe2iuQe8931quH55XsZo3R97VwsgfUgK5/logo.png",
    "tags": ["utility-token"],
    "extensions": {
      "website": "https://solbulls.art",
      "twitter": "https://twitter.com/SolanaBullsNFT",
      "discord": "https://discord.gg/wbkXkWQeex",
      "medium": "https://medium.com/@SolBulls"
    }
  },
  {
    "chainId": 101,
    "address": "MNDEFzGvMt87ueuHvVU9VcTqsAP5b3fTGPsHuuPA5ey",
    "symbol": "MNDE",
    "name": "Marinade Governance (MNDE)",
    "decimals": 9,
    "logoURI":
        "https://raw.githubusercontent.com/solana-labs/token-list/main/assets/mainnet/MNDEFzGvMt87ueuHvVU9VcTqsAP5b3fTGPsHuuPA5ey/logo.png",
    "tags": [],
    "extensions": {
      "website": "https://marinade.finance",
      "twitter": "https://twitter.com/MarinadeFinance",
      "discord": "https://discord.gg/mGqZA5pjRN",
      "medium": "https://medium.com/marinade-finance",
      "github": "https://github.com/marinade-finance"
    }
  }
];
