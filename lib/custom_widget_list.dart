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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green,
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
          footer: const HertownRefreshFooter(position: IndicatorPosition.locator),
          child: CustomScrollView(
            scrollDirection: Axis.vertical,
            slivers: [
              const HeaderLocator.sliver(),
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
