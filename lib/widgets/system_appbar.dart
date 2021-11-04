import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_wanandroid/utils/toast.dart';

class SystemAppBar extends StatefulWidget {
  //当前页面的索引
  int pageIndex;
  //标题集合
  List<String> titles;
  //父widget回调方法
  final ValueChanged<int> onChanged;


  SystemAppBar(this.pageIndex,this.titles, this.onChanged, {Key? key}) : super(key: key);

  @override
  _SystemAppBarState createState() => _SystemAppBarState();
}

class _SystemAppBarState extends State<SystemAppBar> {

  @override
  Widget build(BuildContext context) {
    return Row(
      children: widget.titles
          .asMap()
          .keys
          .map((index) => Expanded(
              flex: 1,
              child: Center(
                child: GestureDetector(
                  child: Text(
                    widget.titles[index],
                    style: TextStyle(
                        color: widget.pageIndex == index ? Colors.white : Colors.grey,
                       fontSize: widget.pageIndex  == index ? 25 : 20,),
                  ),
                  onTap: () {
                    _itemClick(index);
                  },
                ),
              )))
          .toList(),
    );
  }

  void _itemClick(int index) {
    widget.onChanged(index);
  }
}
