import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:easy_refresh/easy_refresh.dart';
import 'package:flutter/widgets.dart';

class HertownRefreshHeader extends Header {
  final Key? key;

  const HertownRefreshHeader(
      {this.key, super.triggerOffset = 70, super.clamping = false});

  @override
  Widget build(BuildContext context, IndicatorState state) {
    return _HertownRefreshHeaderIndicator(state);
  }
}

class _HertownRefreshHeaderIndicator extends StatefulWidget {
  final IndicatorState state;

  const _HertownRefreshHeaderIndicator(this.state);

  @override
  State<_HertownRefreshHeaderIndicator> createState() =>
      _HertownRefreshHeaderIndicatorState();
}

class _HertownRefreshHeaderIndicatorState
    extends State<_HertownRefreshHeaderIndicator>
    with TickerProviderStateMixin<_HertownRefreshHeaderIndicator> {
  IndicatorMode get _refreshState => widget.state.mode;

  double get _pulledExtent => widget.state.offset;

  double get _indicatorExtent => widget.state.triggerOffset;

  bool get _noMore => widget.state.result == IndicatorResult.noMore;

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

  void _preloadLocalImage(BuildContext context, String imagePath) {
    final imageProvider = AssetImage(imagePath);
    precacheImage(imageProvider, context);
  }

  void _updateDragFrameIndex() {
    int dragFrames = _dragFrameImagePaths.length;
    int index = ((_pulledExtent - 20) / _indicatorExtent * dragFrames).toInt();
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
    List<String> pathes = (_dragFrameImagePaths + _refreshFrameImagePaths);

    for (int i = 0; i <= pathes.length - 1; i++) {
      _preloadLocalImage(context, pathes[i]);
    }

    if (_noMore) return Container();
    if (_refreshState == IndicatorMode.processed) {
      isBeginRefresh = true;
    } else if (_refreshState == IndicatorMode.done ||
        _refreshState == IndicatorMode.inactive) {
      isBeginRefresh = false;
    }
    _updateDragFrameIndex();
    return Stack(
      children: <Widget>[
        Container(
          height: _pulledExtent,
          alignment: Alignment.bottomCenter,
          child: Image.asset(
            (_refreshState == IndicatorMode.processed)
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
