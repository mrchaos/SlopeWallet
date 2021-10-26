import 'package:wallet/data/bean/solana_token_entity.dart';

solanaTokenEntityFromJson(SolanaTokenEntity data, Map<String, dynamic> json) {
	if (json['tokens'] != null) {
		data.tokens = (json['tokens'] as List).map((v) => SolanaTokenTokens().fromJson(v)).toList();
	}
	return data;
}

Map<String, dynamic> solanaTokenEntityToJson(SolanaTokenEntity entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	data['tokens'] =  entity.tokens.map((v) => v.toJson()).toList();
	return data;
}

solanaTokenTokensFromJson(SolanaTokenTokens data, Map<String, dynamic> json) {
	if (json['chainId'] != null) {
		data.chainId = json['chainId'] is String
				? int.tryParse(json['chainId'])
				: json['chainId'].toInt();
	}
	if (json['address'] != null) {
		data.address = json['address'].toString();
	}
	if (json['symbol'] != null) {
		data.symbol = json['symbol'].toString();
	}
	if (json['name'] != null) {
		data.name = json['name'].toString();
	}
	if (json['decimals'] != null) {
		data.decimals = json['decimals'] is String
				? int.tryParse(json['decimals'])
				: json['decimals'].toInt();
	}
	if (json['logoURI'] != null) {
		data.logoURI = json['logoURI'].toString();
	}
	return data;
}

Map<String, dynamic> solanaTokenTokensToJson(SolanaTokenTokens entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	data['chainId'] = entity.chainId;
	data['address'] = entity.address;
	data['symbol'] = entity.symbol;
	data['name'] = entity.name;
	data['decimals'] = entity.decimals;
	data['logoURI'] = entity.logoURI;
	return data;
}

solanaTokenTokensExtensionsFromJson(SolanaTokenTokensExtensions data, Map<String, dynamic> json) {
	if (json['website'] != null) {
		data.website = json['website'].toString();
	}
	if (json['telegram'] != null) {
		data.telegram = json['telegram'].toString();
	}
	if (json['twitter'] != null) {
		data.twitter = json['twitter'].toString();
	}
	if (json['discord'] != null) {
		data.discord = json['discord'].toString();
	}
	if (json['instagram'] != null) {
		data.instagram = json['instagram'].toString();
	}
	return data;
}

Map<String, dynamic> solanaTokenTokensExtensionsToJson(SolanaTokenTokensExtensions entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	data['website'] = entity.website;
	data['telegram'] = entity.telegram;
	data['twitter'] = entity.twitter;
	data['discord'] = entity.discord;
	data['instagram'] = entity.instagram;
	return data;
}