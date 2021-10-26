

import 'dart:convert';

import 'package:wallet/common/util/string/string_util.dart';


class AiJson {

  final dynamic data;
  AiJson(this.data);

  List<dynamic> getArray(String path){
    var ret = getObject(path);
    if(null == ret) return [];
    if(ret is List) return ret;
    return [];
  }

  Map<String, dynamic> getMap(String path){
    var ret = getObject(path);
    if(null == ret) return {};
    if(ret is Map) return ret as Map<String, dynamic>;
    if(ret is String){
      var m = jsonDecode(ret);
      if(m is Map){
        return m as Map<String, dynamic>;
      }
    }
    return {};
  }

  String getString(String path, {String defaultValue = ""}){
    var ret = getObject(path);
    if(null == ret) return defaultValue;
    return isStrNullOrEmpty(ret.toString()) ? defaultValue : ret.toString();
  }

  num getNum(String path, {num defaultValue = 0}){
    var ret = getObject(path);
    if(null == ret) return defaultValue;
    if(ret is num) return ret;
    if(ret is String) return num.tryParse(ret) ?? defaultValue;
    return defaultValue;
  }

  int getInt(String path, {int defaultValue = 0}){
    var ret = getObject(path);
    if(null == ret) return defaultValue;
    if(ret is int) return ret;
    if(ret is num) return ret.toInt();
    if(ret is String) return int.tryParse(ret) ?? defaultValue;
    return defaultValue;
  }

  double getDouble(String path, {double defaultValue = 0.0}){
    var ret = getObject(path);
    if(null == ret) return defaultValue;
    if(ret is double) return ret;
    if(ret is String) return double.tryParse(ret) ?? defaultValue;
    return defaultValue;
  }

  bool getBool(String path, {bool defaultValue = false}){
    var ret = getObject(path);
    if(null == ret) return defaultValue;
    if(ret is bool) return ret;
    return defaultValue;
  }


  dynamic getObject(String path){
    if(isStrNullOrEmpty(path)) return data;
    var curJson = data;
    var names = path.split("."); // 
    for(var name in names){
      if(isStrNullOrEmpty(name)) return null;
      if(null == curJson) return null;
      if(name.startsWith("[") && name.endsWith("]")){ // , eg: [1]
        var idxStr = name.substring(1, name.length -1);
        var idx = int.tryParse(idxStr);
        if(null == idx) throw Exception(", idx=[$idxStr]");
        if(idx < 0) throw Exception("0, idx=[$idxStr]");
        if(!(curJson is List)) return null; // ,,,null
        var list  = curJson;
        if(idx >= list.length) return null;
        // 
        curJson = list[idx];
      }else {
        // 
        if(!(curJson is Map<String, dynamic>)) return null; // map,map
        var map = curJson;
        // 
        curJson = map[name];
      }
    }
    return curJson;
  }

  dynamic operator[](AiJsonKey aiJsonKey){
    switch(aiJsonKey.returnType){
      case AiJsonReturnType.object:
        return getObject(aiJsonKey.key);
      case AiJsonReturnType.num:
        return getNum(aiJsonKey.key);
      case AiJsonReturnType.string:
        return getString(aiJsonKey.key);
      case AiJsonReturnType.double:
        return getDouble(aiJsonKey.key);
      case AiJsonReturnType.array:
        return getArray(aiJsonKey.key);
      case AiJsonReturnType.bool:
        return getBool(aiJsonKey.key);
      case AiJsonReturnType.map:
        return getMap(aiJsonKey.key);
    }
  }
}

class AiJsonKey {
 final String key; /// key
 final AiJsonReturnType returnType; /// 
 AiJsonKey({required this.key, this.returnType = AiJsonReturnType.string});

 factory AiJsonKey.string(String key){
   return AiJsonKey(key: key);
 }

 factory AiJsonKey.num(String key){
   return AiJsonKey(key: key, returnType: AiJsonReturnType.num);
 }

 factory AiJsonKey.object(String key){
   return AiJsonKey(key: key, returnType: AiJsonReturnType.object);
 }

 factory AiJsonKey.double(String key){
   return AiJsonKey(key: key, returnType: AiJsonReturnType.double);
 }
 factory AiJsonKey.bool(String key){
   return AiJsonKey(key: key, returnType: AiJsonReturnType.bool);
 }

 factory AiJsonKey.array(String key){
   return AiJsonKey(key: key, returnType: AiJsonReturnType.array);
 }

 factory AiJsonKey.map(String key){
   return AiJsonKey(key: key, returnType: AiJsonReturnType.map);
 }
}

enum AiJsonReturnType {
  object,
  string,
  num,
  double,
  bool,
  array,
  map,
}