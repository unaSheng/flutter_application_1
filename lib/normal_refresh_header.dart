import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';

class FrameAnimationHeader extends MaterialHeader {
  List<String> dragFrameImagePaths() {
    List<String> paths = [];
    for (int i = 0; i <= 27; i++) {
      paths.add('assets/images/refresh_header/drag/refresh_header_idle_$i.png');
    }
    return paths;
  }

  List<String> refreshFrameImagePaths() {
    List<String> paths = [];
    for (int i = 0; i <= 27; i++) {
      paths.add(
          'assets/images/refresh_header/refresh/refresh_header_loading_$i.png');
    }
    return paths;
  }

  FrameAnimationHeader()
      : super(
          // triggerDistance: 70.0,
          // float: true,
          // enableInfiniteRefresh: false,
          enableHapticFeedback: true,
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
    return FrameAnimationWidget(
      mode: refreshState,
      dragFrameImagePaths: dragFrameImagePaths(),
      refreshFrameImagePaths: refreshFrameImagePaths(),
      pulledExtent: pulledExtent,
      durationMilliseconds: 1000,
    );
  }
}

class FrameAnimationWidget extends StatefulWidget {
  final RefreshMode mode;
  final List<String> dragFrameImagePaths;
  final List<String> refreshFrameImagePaths;
  final double pulledExtent;
  final int durationMilliseconds;

  const FrameAnimationWidget({
    super.key,
    required this.mode,
    required this.dragFrameImagePaths,
    required this.refreshFrameImagePaths,
    required this.pulledExtent,
    required this.durationMilliseconds,
  });

  @override
  // ignore: library_private_types_in_public_api
  _FrameAnimationWidgetState createState() => _FrameAnimationWidgetState();
}

class _FrameAnimationWidgetState extends State<FrameAnimationWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<int> _frameAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: widget.durationMilliseconds),
    );
    _frameAnimation =
        IntTween(begin: 0, end: widget.dragFrameImagePaths.length - 1)
            .animate(_animationController)
          ..addListener(() {
            setState(() {});
          });
  }

  @override
  void didUpdateWidget(FrameAnimationWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.mode != oldWidget.mode) {
      if (widget.mode == RefreshMode.armed ||
          widget.mode == RefreshMode.refresh ||
          widget.mode == RefreshMode.drag) {
        _animationController.repeat();
      } else {
        _animationController.reset();
      }
    }
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    int frameIndex = _frameAnimation.value;
    return Container(
      height: widget.pulledExtent,
      alignment: Alignment.center,
      child: Image.asset(
        widget.mode == RefreshMode.drag
            ? widget.dragFrameImagePaths[frameIndex]
            : widget.refreshFrameImagePaths[frameIndex],
        fit: BoxFit.cover,
      ),
    );
  }
}
