import 'package:flutter_wanandroid/generated/json/base/json_convert_content.dart';

class CacheconfigEntity with JsonConvert<CacheconfigEntity> {
	late bool enable;
	late int maxAge;
	late int maxCount;
}
