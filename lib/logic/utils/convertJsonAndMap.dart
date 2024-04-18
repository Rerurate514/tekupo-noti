import 'dart:convert';

extension ConvertJsonFromMap on Map<String, bool>{
  String convertJsonFromMap(){
    const encoder = JsonEncoder();
    final json = encoder.convert(this);

    return json;
  }
}

extension ConvertMapFromJson on String{
  Map<String, bool> convertJsonFromMap(){
    const decoder = JsonDecoder();
    final map = decoder.convert(this);

    return map;
  }
}