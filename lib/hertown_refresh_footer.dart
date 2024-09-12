import 'package:flutter/material.dart';
import 'package:easy_refresh/easy_refresh.dart';

class HertownRefreshFooter extends Footer {
  final Key? key;
  final String? noMoreText;

  const HertownRefreshFooter(
      {this.key,
      this.noMoreText,
      super.triggerOffset = 20,
      super.clamping = false});

  @override
  Widget build(BuildContext context, IndicatorState state) {
    return _HertownRefreshFooterIndicator(state: state, noMoreText: noMoreText);
  }
}

class _HertownRefreshFooterIndicator extends StatefulWidget {
  final String? noMoreText;
  final IndicatorState state;
  const _HertownRefreshFooterIndicator({
    required this.state,
    this.noMoreText,
  });

  @override
  _HertownRefreshFooterIndicatorState createState() {
    return _HertownRefreshFooterIndicatorState();
  }
}

class _HertownRefreshFooterIndicatorState
    extends State<_HertownRefreshFooterIndicator>
    with TickerProviderStateMixin<_HertownRefreshFooterIndicator> {
  IndicatorMode get _refreshState => widget.state.mode;

  bool get _noMore => widget.state.result == IndicatorResult.noMore;

  @override
  Widget build(BuildContext context) {
    if (_noMore) {
      return Container(
        alignment: Alignment.center,
        child: const Text('~ THE END ~'),
      );
    }

    if (_refreshState != IndicatorMode.processing) {
      return Container();
    }

    return Container(
      alignment: AlignmentDirectional.center,
      padding: const EdgeInsets.only(bottom: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            alignment: Alignment.topCenter,
            padding: const EdgeInsets.only(right: 10),
            child: const SizedBox(
                width: 16,
                height: 16,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  color: Color.fromRGBO(0, 0, 0, 0.3),
                )),
          ),
          const Text(
            '加载中',
            style: TextStyle(fontSize: 12, color: Color.fromRGBO(0, 0, 0, 0.3)),
          )
        ],
      ),
    );
  }
}
