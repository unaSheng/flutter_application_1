import 'package:flutter/material.dart';
import 'package:flutter_application_1/hertown_refresh_footer.dart';
import 'package:flutter_application_1/hertown_refresh_header.dart';
import 'package:easy_refresh/easy_refresh.dart';

class CustomListPage extends StatefulWidget {
  const CustomListPage({super.key});

  @override
  State<StatefulWidget> createState() => _CustomListPage();
}

class _CustomListPage extends State<CustomListPage>
    with SingleTickerProviderStateMixin {
  List<int> items = List.generate(20, (i) => i + 1);

  @override
  Widget build(BuildContext context) {
    return EasyRefresh(
      header: const HertownRefreshHeader(),
      onLoad: () async {
        // 模拟网络请求加载更多数据
        await Future.delayed(const Duration(seconds: 2));
        setState(() {
          items.addAll(List.generate(10, (i) => items.length + i + 1));
        });
      },
      onRefresh: () async {},
      footer: const HertownRefreshFooter(),
      child: ListView.builder(
        physics: const AlwaysScrollableScrollPhysics(),
        itemBuilder: (context, index) => ListTile(title: Text('Item $index')),
        itemCount: items.length,
      ),
    );
  }
}
