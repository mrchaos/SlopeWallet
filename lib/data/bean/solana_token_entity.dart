import 'package:wallet/generated/json/base/json_convert_content.dart';
import 'package:wallet/generated/json/base/json_field.dart';

class SolanaTokenEntity with JsonConvert<SolanaTokenEntity> {
	late List<SolanaTokenTokens> tokens;
}


class SolanaTokenTokens with JsonConvert<SolanaTokenTokens> {
	late int chainId;
	late String address;
	late String symbol;
	late String name;
	late int decimals;
	String? logoURI;
	// late List<dynamic> tags;
	// late SolanaTokenTokensExtensions extensions;
	// late String waterfallbot;
}

class SolanaTokenTokensExtensions with JsonConvert<SolanaTokenTokensExtensions> {
	late String website;
	late String telegram;
	late String twitter;
	late String discord;
	late String instagram;
}
