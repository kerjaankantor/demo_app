import 'dart:convert';
import 'package:meta/meta.dart';

class SettingFav {
  final String hiddenVal;

  SettingFav({@required this.hiddenVal});

  factory SettingFav.fromNeoJson(Map<String, dynamic> json) {
    final hiddenVal = json['hiddenVal'] as String;
    return SettingFav(hiddenVal: hiddenVal);
  }

  factory SettingFav.fromJson(Map<String, dynamic> json) {
    return SettingFav(hiddenVal: json['hiddenVal']);
  }

  Map<String, dynamic> toJson() {
    return {'hiddenVal': hiddenVal};
  }

  @override
  String toString() {
    return jsonEncode(toJson());
  }
}
