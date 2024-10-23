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

  final EasyRefreshController _controller = EasyRefreshController(
      controlFinishLoad: true, controlFinishRefresh: true);

/*
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
            child: BaseRefreshView(
      key: globalKeyRefresh,
      data: items,
      onRefresh: () async {
        await Future.delayed(const Duration(seconds: 1));
        setState(() {
          items = List.generate(2, (i) => i + 1);
        });
        // _controller.finishRefresh();
        // _controller.resetFooter();
        globalKeyRefresh.currentState?.onLoadSuccess(false, items, true);
      },
      onLoad: () async {
        await Future.delayed(const Duration(seconds: 1));
        setState(() {
          items.addAll(List.generate(2, (i) => items.length + i + 1));
        });
        globalKeyRefresh.currentState
            ?.onLoadSuccess(true, items, items.length < 4);
        // _controller.finishLoad(items.length >= 4
        //     ? IndicatorResult.noMore
        //     : IndicatorResult.success);
      },
      headerView: Text('Header View'),
      footerView: Text('Footer View'),
      itemBuilder: (context, index) {
        return SizedBox(height: 50, child: Text('Item $index'));
      },
      separatorBuilder: (context, index) {
        return const SizedBox.shrink();
      },
      // controller: _controller,
    )));
  }
}

*/

  Drawer _drawer() {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          const DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.blue,
            ),
            child: Text(
              '抽屉头部',
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
              ),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.home),
            title: const Text('主页'),
            onTap: () {
              // 处理主页的点击事件
              Navigator.pop(context); // 关闭抽屉
            },
          ),
          ListTile(
            leading: const Icon(Icons.settings),
            title: const Text('设置'),
            onTap: () {
              // 处理设置的点击事件
              Navigator.pop(context); // 关闭抽屉
            },
          ),
          ListTile(
            leading: const Icon(Icons.info),
            title: const Text('关于'),
            onTap: () {
              // 处理关于的点击事件
              Navigator.pop(context); // 关闭抽屉
            },
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: 
      AppBar(
        title: const Text('我的Title'),
        leading: Builder(
          builder: (BuildContext context) {
            return IconButton(
              icon: const Icon(Icons.arrow_back), // 自定义图标
              onPressed: () {
                Scaffold.of(context).openDrawer(); // 打开 Drawer
              },
            );
          },
        ),
      ),
      backgroundColor: Colors.green,
      drawer: _drawer(),
      body: EasyRefresh(
          controller: _controller,
          onRefresh: () async {
            await Future.delayed(const Duration(seconds: 1));
            setState(() {
              items = List.generate(20, (i) => i + 1);
            });
            _controller.finishRefresh();
            _controller.resetFooter();
          },
          onLoad: () async {
            await Future.delayed(const Duration(seconds: 1));
            setState(() {
              items.addAll(List.generate(10, (i) => items.length + i + 1));
            });
            _controller.finishLoad(items.length >= 300
                ? IndicatorResult.noMore
                : IndicatorResult.success);
          },
          header: const HertownRefreshHeader(),
          footer:
              const HertownRefreshFooter(position: IndicatorPosition.locator),
          child: CustomScrollView(
            scrollDirection: Axis.vertical,
            slivers: [
              const HeaderLocator.sliver(),
              SliverAppBar(
                expandedHeight: 200.0,
                floating: false,
                pinned: false, // 关键属性，设为 true 后，AppBar 会吸顶
                flexibleSpace: FlexibleSpaceBar(
                  title: const Text('吸顶标题'),
                  background: Image.network(
                    'https://s.momocdn.com/s1/u/gfcidciib/kit_2.png',
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              SliverList(
                delegate: SliverChildBuilderDelegate(
                  (context, index) {
                    return Container(
                        color: Colors.yellow,
                        height: 50,
                        child: Text('Item $index'));
                  },
                  childCount: items.length,
                ),
              ),
              const FooterLocator.sliver(),
            ],
          )),
    );
  }
}
