import 'package:flutter/material.dart';

/// 显示错误界面
class CommonError extends StatelessWidget {
  /// 具体的错误码
  final String errorMsg;

  /// 可点击的回调函数
  final Function? action;

  final String? actionBtnText;

  final bool showRetryBtn;

  final Color backgroundColor;

  final bool isDark;

  final double bottomMargin;

  /// 默认构造函数
  const CommonError(
      {super.key,
      required this.errorMsg,
      this.action,
      this.actionBtnText,
      this.showRetryBtn = false,
      this.backgroundColor = Colors.transparent,
      this.isDark = false,
      this.bottomMargin = 260.0});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      body: Container(
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            // Image.asset(
            //   'assets/images/ic_list_empty_new.webp',
            //   width: 150,
            //   height: 150,
            //   fit: BoxFit.cover,
            // ),
            const SizedBox(height: 16),
            Text(
              errorMsg,
              style: TextStyle(
                fontSize: 13.0,
                fontWeight: FontWeight.w500,
                color: isDark ? Colors.white : Colors.black,
              ),
            ),
            const SizedBox(height: 20),
            Visibility(
              visible: showRetryBtn,
              child: TextButton(
                style: ButtonStyle(
                  shape: WidgetStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0), // 设置边框颜色和宽度
                    ),
                  ),
                  backgroundColor: WidgetStateProperty.resolveWith((states) {
                    if (states.contains(WidgetState.pressed)) {
                      return Colors.red.withAlpha(50);
                    }
                    return Colors.red;
                  }),
                  padding: WidgetStateProperty.all(
                    const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                  ),
                ),
                onPressed: () {
                  if (action != null) {
                    action!();
                  }
                },
                child: Text(actionBtnText ?? '重新加载',
                    style: const TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.w600,
                      color: Colors.black,
                    )),
              ),
            ),
            SizedBox(height: bottomMargin), // 负值会使其向上移动
          ],
        ),
      ),
    );
  }
}
