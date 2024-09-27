import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';

class TopicContentCreatorDesc extends StatelessWidget {
  const TopicContentCreatorDesc({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        const _TopicItem(),
        const SizedBox(height: 20,),
        const _TopicItem(),
        Html(
          data: """
        <p class="title">1.什么是「每周创作者」？</p>
        <p class="content">「每周创作者」是对在话题内发布优质内容的姐妹的奖励。根据用户在该话题内发布的<span>内容数量、内容质量、内容与话题匹配度<span>等因素，进行评选。每周一上午10:00进行更新。</p>
        <p class="title">2.为什么有的话题没有「每周创作者」？</p>
        <p class="content">Hertown 会根据每个话题的活跃程度、内容之类等因素，判断该话题是否开放「每周创作者」。</p>
        <p class="title">3.「每周创作者」的权益有哪些？</p>
        <p class="content">「每周创作者」会获得<span>专属头衔和个人主页的特殊标识</span>，持续时间为1周。</p>
        """,
          style: {
            'p.title': Style(
                textAlign: TextAlign.start,
                color: const Color.fromRGBO(0, 0, 0, 1),
                fontWeight: FontWeight.w600,
                fontSize: FontSize(17)),
            "p.content": Style(
                lineHeight: const LineHeight(2),
                textAlign: TextAlign.start,
                color: const Color.fromRGBO(0, 0, 0, 0.6),
                fontWeight: FontWeight.w400,
                fontSize: FontSize(15)),
            "span": Style(
                lineHeight: const LineHeight(2),
                textAlign: TextAlign.start,
                color: const Color.fromRGBO(175, 130, 234, 1),
                fontWeight: FontWeight.w500,
                fontSize: FontSize(15)),
          },
        ),
        Image.network(
            "https://s.momocdn.com/s1/u/hfjcfahga/topic_content_creator_id1.png",
            width: 330,
            height: 200),
        Image.network(
            "https://s.momocdn.com/s1/u/hfjcfahga/topic_content_creator_id2.png",
            width: 330,
            height: 200),
      ],
    );
  }
}

class _TopicItem extends StatelessWidget {
  const _TopicItem();

  @override
  Widget build(BuildContext context) {
    return Row(children: [
      Stack(
        children: [
          Container(
            width: 100,
            height: 100,
            color: Colors.red,
          ),
          Positioned(
              left: 50,
              top: 50,
              child: Container(
                width: 50,
                height: 50,
                color: Colors.green,
              ))
        ],
      ),
      const SizedBox(width: 12,),
      const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [Text("我的美食日常"), SizedBox(height: 8), Text("每周创作者 称号")],
      )
    ]);
  }
}
