import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';

class HertownRefreshFooter extends Footer {
  final Key? key;

  final String? noMoreText;

  final LinkFooterNotifier linkNotifier = LinkFooterNotifier();

  HertownRefreshFooter({
    this.key,
    this.noMoreText,
    completeDuration = const Duration(seconds: 1),
    super.enableHapticFeedback,
    super.enableInfiniteLoad,
    super.overScroll,
  }) : super(
          float: true,
          extent: 52.0,
          triggerDistance: 52.0,
          completeDuration: completeDuration == null
              ? const Duration(
                  milliseconds: 300,
                )
              : completeDuration +
                  const Duration(
                    milliseconds: 300,
                  ),
        );

  @override
  Widget contentBuilder(
      BuildContext context,
      LoadMode loadState,
      double pulledExtent,
      double loadTriggerPullDistance,
      double loadIndicatorExtent,
      AxisDirection axisDirection,
      bool float,
      Duration? completeDuration,
      bool enableInfiniteLoad,
      bool success,
      bool noMore) {
    // 不能为水平方向以及反向
    assert(axisDirection == AxisDirection.down,
        'Widget can only be vertical and cannot be reversed');
    linkNotifier.contentBuilder(
        context,
        loadState,
        pulledExtent,
        loadTriggerPullDistance,
        loadIndicatorExtent,
        axisDirection,
        float,
        completeDuration,
        enableInfiniteLoad,
        success,
        noMore);
    return HertownRefreshFooterWidget(
      key: key,
      noMoreText: noMoreText,
      linkNotifier: linkNotifier,
    );
  }
}

class HertownRefreshFooterWidget extends StatefulWidget {
  final String? noMoreText;
  final LinkFooterNotifier linkNotifier;

  const HertownRefreshFooterWidget({
    super.key,
    this.noMoreText,
    required this.linkNotifier,
  });

  @override
  HertownRefreshFooterWidgetState createState() {
    return HertownRefreshFooterWidgetState();
  }
}

class HertownRefreshFooterWidgetState extends State<HertownRefreshFooterWidget>
    with SingleTickerProviderStateMixin {
  LoadMode get _refreshState => widget.linkNotifier.loadState;

  double get _pulledExtent => widget.linkNotifier.pulledExtent;

  double get _riggerPullDistance => widget.linkNotifier.loadTriggerPullDistance;

  bool get _noMore => widget.linkNotifier.noMore;

  AnimationController? _controller;
  Animation<Color?>? _colorAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 3),
      vsync: this, // 使用 SingleTickerProviderStateMixin 来提供 vsync
    );

    _colorAnimation = ColorTween(
      begin: const Color.fromRGBO(0, 0, 0, 0.3),
      end: const Color.fromRGBO(0, 0, 0, 0.3),
    ).animate(_controller!)
      ..addListener(() {
        setState(() {});
      })
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          _controller!.reverse();
        } else if (status == AnimationStatus.dismissed) {
          _controller!.forward();
        }
      });

    _controller!.forward();
  }

  @override
  void dispose() {
    _controller!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (_noMore) {
      return Container(
        alignment: Alignment.center,
        child: const Text('~ THE END ~'),
      );
    }
    // 计算进度值
    double indicatorValue = _pulledExtent / _riggerPullDistance;
    indicatorValue = indicatorValue < 1.0 ? indicatorValue : 1.0;
    return Stack(
      children: <Widget>[
        Positioned(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                alignment: Alignment.topCenter,
                child: RefreshProgressIndicator(
                  value: _refreshState == LoadMode.armed ||
                          _refreshState == LoadMode.load ||
                          _refreshState == LoadMode.loaded ||
                          _refreshState == LoadMode.done
                      ? null
                      : indicatorValue,
                  elevation: 0,
                  valueColor: _colorAnimation,
                  indicatorPadding: const EdgeInsets.all(12),
                ),
              ),
              const Text(
                '加载中',
                style: TextStyle(
                    fontSize: 12, color: Color.fromRGBO(0, 0, 0, 0.3)),
              )
            ],
          ),
        ),
      ],
    );
  }
}
