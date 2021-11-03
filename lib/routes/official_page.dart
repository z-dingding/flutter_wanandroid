

import 'package:flutter/cupertino.dart';
import 'package:flutter_wanandroid/110n/gmlocalization.dart';

class OfficialRoute extends StatefulWidget {
  const OfficialRoute({Key? key}) : super(key: key);

  @override
  _OfficialRouteState createState() => _OfficialRouteState();
}

class _OfficialRouteState extends State<OfficialRoute> with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    GmLocalization gm = GmLocalization.of(context);
    return Container(
      child: Center(
        child: Text(gm.official),
      ),
    );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive =>  true; ///保持当前页面状态
}
