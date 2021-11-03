
import 'package:flutter/cupertino.dart';
import 'package:flutter_wanandroid/110n/gmlocalization.dart';

class SystemRoute extends StatefulWidget {
  const SystemRoute({Key? key}) : super(key: key);

  @override
  _SystemRouteState createState() => _SystemRouteState();
}

class _SystemRouteState extends State<SystemRoute> with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    GmLocalization gm = GmLocalization.of(context);
    return Container(
      child: Center(
        child: Text(gm.system),
      ),
    );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive =>  true; ///保持当前页面状态
}
