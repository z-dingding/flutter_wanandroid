import 'package:flutter_wanandroid/models/cacheconfig_entity.dart';

cacheconfigEntityFromJson(CacheconfigEntity data, Map<String, dynamic> json) {
	if (json['enable'] != null) {
		data.enable = json['enable'];
	}
	if (json['maxAge'] != null) {
		data.maxAge = json['maxAge'] is String
				? int.tryParse(json['maxAge'])
				: json['maxAge'].toInt();
	}
	if (json['maxCount'] != null) {
		data.maxCount = json['maxCount'] is String
				? int.tryParse(json['maxCount'])
				: json['maxCount'].toInt();
	}
	return data;
}

Map<String, dynamic> cacheconfigEntityToJson(CacheconfigEntity entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	data['enable'] = entity.enable;
	data['maxAge'] = entity.maxAge;
	data['maxCount'] = entity.maxCount;
	return data;
}