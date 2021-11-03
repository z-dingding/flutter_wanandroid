import 'package:flutter_wanandroid/generated/json/base/json_convert_content.dart';

///首页文章列表
class ArticlelistEntity with JsonConvert<ArticlelistEntity> {
	ArticlelistData? data;
	int? errorCode;
	String? errorMsg;
}

class ArticlelistData with JsonConvert<ArticlelistData> {
	int? curPage;
	List<ArticlelistDataDatas>? datas;
	int? offset;
	bool? over;
	int? pageCount;
	int? size;
	int? total;
}

class ArticlelistDataDatas with JsonConvert<ArticlelistDataDatas> {
	String? apkLink;
	int? audit;
	String? author;
	bool? canEdit;
	int? chapterId;
	String? chapterName;
	bool? collect;
	int? courseId;
	String? desc;
	String? descMd;
	String? envelopePic;
	bool? fresh;
	String? host;
	int? id;
	String? link;
	String? niceDate;
	String? niceShareDate;
	String? origin;
	String? prefix;
	String? projectLink;
	int? publishTime;
	int? realSuperChapterId;
	int? selfVisible;
	int? shareDate;
	String? shareUser;
	int? superChapterId;
	String? superChapterName;
	List<dynamic>? tags;
	String? title;
	int? type;
	int? userId;
	int? visible;
	int? zan;
}
