import 'package:extended_text/extended_text.dart';
import 'package:flutter/material.dart';

class MySpecialTextSpanBuilder extends SpecialTextSpanBuilder {
  @override
  TextSpan build(String data,
      {TextStyle? textStyle, SpecialTextGestureTapCallback? onTap}) {
    if (data.length > 20) {
      String start = data.substring(0, 10);
      String end = data.substring(data.length - 10);
      return TextSpan(
        style: textStyle,
        children: <TextSpan>[
          TextSpan(text: start),
          const TextSpan(text: '...'),
          TextSpan(text: end),
        ],
      );
    }
    return TextSpan(text: data, style: textStyle);
  }

  @override
  SpecialText? createSpecialText(String flag,
      {TextStyle? textStyle,
      SpecialTextGestureTapCallback? onTap,
      int? index}) {
    // 这里可以添加更多的自定义文本处理逻辑
    return null;
  }
}

class UserInfo extends StatelessWidget {
  const UserInfo({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                    child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const Text(
                      '把大象装进冰箱把大象装进冰箱把大象装进冰箱把大象',
                      style: TextStyle(
                          fontSize: 18.0, fontWeight: FontWeight.bold),
                      maxLines: 10,
                    ),
                    Visibility(
                      visible: true,
                      replacement: Container(
                        height: 0,
                      ),
                      child: const Text('IP属地：北京'),
                    ),
                    const Visibility(
                        visible: true,
                        child: Text(
                            '@带脑子出门 带快乐回家瞎玩瞎看 探索思辨的大活人Indoor Plants & Sustaninable Living',
                            style: TextStyle(color: Colors.grey))),
                    Visibility(
                        visible: true,
                        child: Column(
                          children: [
                            ExtendedText(
                              '是一段非常长的文本这是一段非常长的文本这是一段非常长的文本，我们希望它在中间部分缩略显示，例如“开始。',
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              specialTextSpanBuilder:
                                  MySpecialTextSpanBuilder(),
                              softWrap: false,
                            ),
                          ],
                        ))
                  ],
                )),
                const CircleAvatar(
                  radius: 40.0,
                  backgroundImage: NetworkImage(
                      'https://herland.momocdn.com/avatar/F4/68/F4689AEC-C969-43CA-8EF8-6AF842A15DD520230828_M.jpg'),
                ),
              ],
            ),
            Row(
              children: [
                const Column(
                  children: [Text('121'), Text('关注')],
                ),
                const VerticalDivider(
                  color: Colors.black,
                  width: 5,
                ),
                Container(
                  width: 1,
                  height: 20,
                  color: Colors.grey,
                ),
                const VerticalDivider(
                  color: Colors.black,
                  width: 5,
                ),
                const Column(
                  children: [Text('121'), Text('粉丝')],
                ),
                const Spacer(),
                TextButton(onPressed: () {}, child: const Text('关注')),
              ],
            ),
            Visibility(
                visible: true,
                child: Column(
                  children: [
                    Row(
                      children: [
                        Container(
                          width: 24,
                          height: 24,
                          color: Colors.red,
                        ),
                        const Text('面包不肉松：'),
                        const Spacer(),
                        Row(
                          children: [
                            Container(
                              width: 16,
                              height: 16,
                              color: Colors.black,
                            ),
                            const Text('邀请人推荐')
                          ],
                        )
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Wrap(
                          spacing: 8.0, // 横向间隔
                          runSpacing: 4.0, // 纵向间隔
                          children: <Widget>[
                            Container(
                                decoration: const BoxDecoration(
                                    color: Colors.amber,
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10))),
                                child: const Padding(
                                  padding: EdgeInsets.fromLTRB(12, 10, 12, 10),
                                  child: Text('通过超100家咖啡厅'),
                                )),
                            Container(
                                decoration: const BoxDecoration(
                                    color: Colors.amber,
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10))),
                                child: const Padding(
                                  padding: EdgeInsets.fromLTRB(12, 10, 12, 10),
                                  child: Text('处女座Buff抵消'),
                                )),
                            Container(
                                decoration: const BoxDecoration(
                                    color: Colors.amber,
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10))),
                                child: const Padding(
                                  padding: EdgeInsets.fromLTRB(12, 10, 12, 10),
                                  child: Text('神经INF'),
                                )),
                            Container(
                                decoration: const BoxDecoration(
                                    color: Colors.amber,
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10))),
                                child: const Padding(
                                  padding: EdgeInsets.fromLTRB(12, 10, 12, 10),
                                  child: Text('物理学博士'),
                                )),
                            Container(
                                decoration: const BoxDecoration(
                                    color: Colors.amber,
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10))),
                                child: const Padding(
                                  padding: EdgeInsets.fromLTRB(12, 10, 12, 10),
                                  child: Text('Helloooo!'),
                                )),
                          ],
                        ),
                      ],
                    )
                  ],
                )),
            // const Spacer()
          ],
        ));
  }
}
