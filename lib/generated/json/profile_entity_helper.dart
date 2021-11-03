import 'package:flutter_wanandroid/models/profile_entity.dart';
import 'package:flutter_wanandroid/models/cacheconfig_entity.dart';
import 'package:flutter_wanandroid/models/user_entity.dart';

profileEntityFromJson(ProfileEntity data, Map<String, dynamic> json) {
	if (json['user'] != null) {
		data.user = UserData().fromJson(json['user']);
	}
	if (json['cookies'] != null) {
		data.cookies = json['cookies'].toString();
	}
	if (json['theme'] != null) {
		data.theme = json['theme'] is String
				? int.tryParse(json['theme'])
				: json['theme'].toInt();
	}
	if (json['cache'] != null) {
		data.cache = CacheconfigEntity().fromJson(json['cache']);
	}
	if (json['lastLogin'] != null) {
		data.lastLogin = json['lastLogin'].toString();
	}
	if (json['locale'] != null) {
		data.locale = json['locale'].toString();
	}
	return data;
}

Map<String, dynamic> profileEntityToJson(ProfileEntity entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	data['user'] = entity.user?.toJson();
	data['cookies'] = entity.cookies;
	data['theme'] = entity.theme;
	data['cache'] = entity.cache?.toJson();
	data['lastLogin'] = entity.lastLogin;
	data['locale'] = entity.locale;
	return data;
}