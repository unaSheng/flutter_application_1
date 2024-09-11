import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';

/*
class KeyframeAnimationHeader extends StatefulWidget {
  final double extent; // 下拉的高度
  final double triggerDistance; // 触发刷新的距离

  const KeyframeAnimationHeader(
      {super.key, this.extent = 70.0, this.triggerDistance = 70.0});

  @override
  _KeyframeAnimationHeaderState createState() =>
      _KeyframeAnimationHeaderState();
}

class _KeyframeAnimationHeaderState extends State<KeyframeAnimationHeader>
    with TickerProviderStateMixin {
  AnimationController? _animationController;
  Animation<double>? _animation;

  @override
  void initState() {
    super.initState();
    _animationController =
        AnimationController(vsync: this, duration: const Duration(seconds: 2));
    _animation = Tween(begin: 0.0, end: 1.0).animate(_animationController!)
      ..addListener(() {
        setState(() {});
      });
  }

  @override
  void dispose() {
    _animationController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CustomHeader(
      extent: widget.extent,
      triggerDistance: widget.triggerDistance,
      headerBuilder: (context, mode, offset) {
        if (mode == RefreshMode.armed) {
          _animationController?.forward(from: 0.0);
        } else if (mode == RefreshMode.inactive || mode == RefreshMode.done) {
          _animationController?.reset();
        }
        return Container(
          height: widget.extent,
          color: Colors.blue,
          child: const Center(
            child: Text(
              'Pull down to refresh',
              style: TextStyle(
                color: Colors.white,
                fontSize: 16.0,
              ),
            ),
          ),
        );
      },
    );
  }
}
*/
class CustomListPage extends StatefulWidget {
  const CustomListPage({super.key});

  @override
  State<StatefulWidget> createState() => _CustomListPage();
}

class _CustomListPage extends State<CustomListPage>
    with SingleTickerProviderStateMixin {
  // final ScrollController _scrollController = ScrollController();
  // late AnimationController _animationController;

  // @override
  // void initState() {
  //   super.initState();
  //   _scrollController.addListener(_scrollListener);
  //   _animationController = AnimationController(vsync: this);
  // }

  // @override
  // void dispose() {
  //   _scrollController.removeListener(_scrollListener);
  //   _scrollController.dispose();
  //   _animationController.dispose();
  //   super.dispose();
  // }

  // void _scrollListener() {
  //   double offset = _scrollController.offset;
  //   _animationController.value = (offset % 100) / 100;
  // }

  List<int> items = List.generate(20, (i) => i + 1);

  @override
  Widget build(BuildContext context) {
    return EasyRefresh(
      header: PhoenixHeader(),
      onLoad: () async {
        // 模拟网络请求加载更多数据
        await Future.delayed(const Duration(seconds: 2));
        setState(() {
          items.addAll(List.generate(10, (i) => items.length + i + 1));
        });
      },
      onRefresh: () async {},
      footer: ClassicalFooter(),
      child: ListView.builder(
        physics: const AlwaysScrollableScrollPhysics(),
        itemBuilder: (context, index) => ListTile(title: Text('Item $index')),
        itemCount: items.length,
      ),
    );
  }
}
