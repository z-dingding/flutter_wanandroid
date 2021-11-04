

import 'package:flutter/cupertino.dart';

class NavigationListRoute extends StatefulWidget {
  const NavigationListRoute({Key? key}) : super(key: key);

  @override
  _NavigationListState createState() => _NavigationListState();
}

class _NavigationListState extends State<NavigationListRoute> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Text("我是导航"),
      ),
    );
  }
}
