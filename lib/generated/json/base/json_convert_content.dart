// ignore_for_file: non_constant_identifier_names
// ignore_for_file: camel_case_types
// ignore_for_file: prefer_single_quotes

// This file is automatically generated. DO NOT EDIT, all your changes would be lost.
import 'package:wallet/data/bean/solana_token_entity.dart';
import 'package:wallet/generated/json/solana_token_entity_helper.dart';

class JsonConvert<T> {
	T fromJson(Map<String, dynamic> json) {
		return _getFromJson<T>(runtimeType, this, json);
	}

  Map<String, dynamic> toJson() {
		return _getToJson<T>(runtimeType, this);
  }

  static _getFromJson<T>(Type type, data, json) {
		switch (type) {
			case SolanaTokenEntity:
				return solanaTokenEntityFromJson(data as SolanaTokenEntity, json) as T;
			case SolanaTokenTokens:
				return solanaTokenTokensFromJson(data as SolanaTokenTokens, json) as T;
			case SolanaTokenTokensExtensions:
				return solanaTokenTokensExtensionsFromJson(data as SolanaTokenTokensExtensions, json) as T;    }
		return data as T;
	}

  static _getToJson<T>(Type type, data) {
		switch (type) {
			case SolanaTokenEntity:
				return solanaTokenEntityToJson(data as SolanaTokenEntity);
			case SolanaTokenTokens:
				return solanaTokenTokensToJson(data as SolanaTokenTokens);
			case SolanaTokenTokensExtensions:
				return solanaTokenTokensExtensionsToJson(data as SolanaTokenTokensExtensions);
			}
			return data as T;
		}
  //Go back to a single instance by type
	static _fromJsonSingle<M>( json) {
		String type = M.toString();
		if(type == (SolanaTokenEntity).toString()){
			return SolanaTokenEntity().fromJson(json);
		}
		if(type == (SolanaTokenTokens).toString()){
			return SolanaTokenTokens().fromJson(json);
		}
		if(type == (SolanaTokenTokensExtensions).toString()){
			return SolanaTokenTokensExtensions().fromJson(json);
		}

		return null;
	}

  //list is returned by type
	static M _getListChildType<M>(List data) {
		if(<SolanaTokenEntity>[] is M){
			return data.map<SolanaTokenEntity>((e) => SolanaTokenEntity().fromJson(e)).toList() as M;
		}
		if(<SolanaTokenTokens>[] is M){
			return data.map<SolanaTokenTokens>((e) => SolanaTokenTokens().fromJson(e)).toList() as M;
		}
		if(<SolanaTokenTokensExtensions>[] is M){
			return data.map<SolanaTokenTokensExtensions>((e) => SolanaTokenTokensExtensions().fromJson(e)).toList() as M;
		}

		throw Exception("not found");
	}

  static M fromJsonAsT<M>(json) {
		if (json is List) {
			return _getListChildType<M>(json);
		} else {
			return _fromJsonSingle<M>(json) as M;
		}
	}
}