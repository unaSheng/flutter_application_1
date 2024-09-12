import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';

class HertownRefreshHeader extends Header {
  /// Key
  final Key? key;

  final LinkHeaderNotifier linkNotifier = LinkHeaderNotifier();

  HertownRefreshHeader({
    this.key,
    super.enableHapticFeedback,
  }) : super(
          extent: 80.0,
          triggerDistance: 80.0,
          float: false,
          enableInfiniteRefresh: false,
          completeDuration: const Duration(seconds: 1),
        );

  @override
  Widget contentBuilder(
      BuildContext context,
      RefreshMode refreshState,
      double pulledExtent,
      double refreshTriggerPullDistance,
      double refreshIndicatorExtent,
      AxisDirection axisDirection,
      bool float,
      Duration? completeDuration,
      bool enableInfiniteRefresh,
      bool success,
      bool noMore) {
    // 不能为水平方向以及反向
    assert(axisDirection == AxisDirection.down,
        'Widget can only be vertical and cannot be reversed');
    linkNotifier.contentBuilder(
        context,
        refreshState,
        pulledExtent,
        refreshTriggerPullDistance,
        refreshIndicatorExtent,
        axisDirection,
        float,
        completeDuration,
        enableInfiniteRefresh,
        success,
        noMore);
    return HertownRefreshHeaderWidget(
      key: key,
      linkNotifier: linkNotifier,
    );
  }
}

class HertownRefreshHeaderWidget extends StatefulWidget {
  final LinkHeaderNotifier linkNotifier;

  const HertownRefreshHeaderWidget({
    super.key,
    required this.linkNotifier,
  });

  @override
  HertownRefreshHeaderWidgetState createState() {
    return HertownRefreshHeaderWidgetState();
  }
}

class HertownRefreshHeaderWidgetState
    extends State<HertownRefreshHeaderWidget> {
  RefreshMode get _refreshState => widget.linkNotifier.refreshState;

  double get _pulledExtent => widget.linkNotifier.pulledExtent;

  double get _indicatorExtent => widget.linkNotifier.refreshIndicatorExtent;

  bool get _noMore => widget.linkNotifier.noMore;

  late List<String> _dragFrameImagePaths;
  late List<String> _refreshFrameImagePaths;

  int _dragFrameIndex = 0;
  int _refreshFrameIndex = 0;

  Timer? _refreshAnimationTimer;

  bool _isBeginRefresh = false;

  set isBeginRefresh(bool value) {
    if (_isBeginRefresh != value) {
      _isBeginRefresh = value;
      if (_isBeginRefresh) {
        startRefreshAnimation();
      } else {
        if (_refreshAnimationTimer != null) {
          _refreshAnimationTimer!.cancel();
        }
      }
    }
  }

  @override
  void initState() {
    super.initState();
    List<String> dragPaths = [];
    for (int i = 0; i <= 27; i++) {
      dragPaths
          .add('assets/images/refresh_header/drag/refresh_header_idle_$i.png');
    }
    _dragFrameImagePaths = dragPaths;

    List<String> refreshPaths = [];
    for (int i = 0; i <= 47; i++) {
      refreshPaths.add(
          'assets/images/refresh_header/refresh/refresh_header_loading_$i.png');
    }
    _refreshFrameImagePaths = refreshPaths;
  }

  void _updateDragFrameIndex() {
    int dragFrames = _dragFrameImagePaths.length;
    int index = (_pulledExtent / _indicatorExtent * dragFrames).toInt();
    _dragFrameIndex = min(dragFrames - 1, max(0, index));
  }

  @override
  void dispose() {
    if (_refreshAnimationTimer != null && _refreshAnimationTimer!.isActive) {
      _refreshAnimationTimer!.cancel();
    }
    super.dispose();
  }

  void startRefreshAnimation() {
    _refreshAnimationTimer = Timer(const Duration(milliseconds: 10), () {
      setState(() {
        _refreshFrameIndex =
            (_refreshFrameIndex += 1) % _refreshFrameImagePaths.length;
        startRefreshAnimation();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_noMore) return Container();
    if (_refreshState == RefreshMode.refreshed) {
      isBeginRefresh = true;
    } else if (_refreshState == RefreshMode.done ||
        _refreshState == RefreshMode.inactive) {
      isBeginRefresh = false;
    }
    _updateDragFrameIndex();
    return Stack(
      children: <Widget>[
        Container(
          height: _pulledExtent,
          alignment: Alignment.bottomCenter,
          child: Image.asset(
            (_refreshState == RefreshMode.refreshed)
                ? _refreshFrameImagePaths[_refreshFrameIndex]
                : _dragFrameImagePaths[_dragFrameIndex],
            fit: BoxFit.cover,
            height: 60,
          ),
        ),
      ],
    );
  }
}
