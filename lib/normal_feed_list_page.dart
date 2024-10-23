import 'dart:math';
import 'package:easy_refresh/easy_refresh.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_application_1/hertown_refresh_footer.dart';
import 'package:flutter_application_1/hertown_refresh_header.dart';
import 'package:flutter_application_1/profile_page.dart';
import 'package:visibility_detector/visibility_detector.dart';

class VisibleItem {
  VisibilityInfo info;
  int index;
  VisibleItem(this.info, this.index);
}

class NormalFeedListPage extends StatefulWidget {
  const NormalFeedListPage({super.key});

  @override
  State<StatefulWidget> createState() => _NormalFeedListPageState();
}

class _NormalFeedListPageState extends State<NormalFeedListPage> {
  List<String> longTexts = [
    '「每周创作者」是对在话题内发布优质内容的姐妹的奖励。根据用户在该话题内发布的内容数量、内容质量、内容与话题匹配度等因素，进行评选。每周一上午10:00进行更新。',
    '以前看延禧攻略，嗑糖啥的。现在看延禧攻略，到了她入宫开始，就感觉她这破班真是上得累死。就像是公司最牛的销售经理，深受器重，是厉害的，但陪吃陪喝，揣测老板心思，每天推陈出新……班味儿特别浓！',
    '「每周创作者」会获得专属头衔和个人主页的特殊标识，持续时间为1周。',
    'Xtraordinary Girls 简称XG， 于2022年3月18日正式出道。成员包括JURIN、CHISA、HINATA、HARVEY、JURIA、MAYA、COCONA。字母“X”，象征其音乐和风格的不可预测性，同时代表女性所特有的X染色体。希望更多ALPHAZ加入话题，一起分享我们爱的小狼们~',
    'Hertown 会根据每个话题的活跃程度、内容之类等因素，判断该话题是否开放「每周创作者」。',
    '1、未成年相关 色情低俗内容：恋童、未成年结婚生子、涉及未成年人性侵害或展示未成年性暗示、性行为等内容 不良行为: 未成年恋爱、抽烟、喝酒、驾驶机动车、出入娱乐场所（网吧、游戏厅、足疗保健场所、ktv 等法律不允许未成年人进入的营业性娱乐场所）等不良行为，以及涉未成年校园/家庭/社会暴力的内容 危险行为：包括但不限于未成年野泳、驾驶大型摩托车、玩火、野外探险、极限运动等 利用未成年博眼球内容：在公共场合卖惨求关注、扮丑、喊麦、乞讨卖艺等 危害未成年身心健康的内容 教唆未成年人违法犯罪的行为 以各种名义对未成年人进行网络欺诈 雇佣童工，残害、虐待、体罚、恶意整蛊未成年人 推销可能危害未成年人身心健康的相关物品 恶意编辑或蓄意传播恐怖、惊悚、色情的内容供未成年人观看 披露未成年人个人隐私信息或有损未成年人人格尊严的内容 诱导未成年人无底线追星、自残、恋爱、弃学、校园霸凌、网暴等 2、违背公序良俗 畸形婚恋观：宣扬非正常交友、不健康婚恋、传播或开展情感操控课程 拜金主义：炫富行为，歪曲的利益观、金钱观，追崇奢靡腐朽的不良生活观念 其他违反公序良俗、传播社会不文明现象或展现社会不良风气的内容： · 展示丧葬过程、场景；利用逝者炒作、卖惨；虐待动 物内容；邪典漫画/动漫等 · 损坏公共设施、扰乱公共秩序的行为，如：随地吐 痰、闯红灯逆行等 3、饭圈极端行为 煽动粉丝群体的敌视情绪：造谣、歪曲事实、职业攻击某特定明星或群体 制造对立骂战：互撕、拉踩、引战等，包括但不限于以挑拨或反串黑的形式制造对立骂战的行为，鼓吹人肉搜索行为 诱导粉丝应援集资：未经明星经纪公司（工作室）授权或认证的粉丝团、后援会，通过网络组织开展应援、打榜等线上线下明星粉丝活动 流量造假：通过刷帖控评、评论注水进行流量造假，雇佣网络水军等',
    '「看见」女性真实多样的生活「包容」多元观点，一起理性探讨「尊重」每位女性的隐私和表达的权利「连接」更多同频姐妹',
    '拿到书，我比较好奇作者的经历，她是谁？为什么是她写这本书？拿到书，我比较好奇作者的经历，她是谁？',
  ];

  List<int> _items = List.generate(10, (i) => i + 1);

  final EasyRefreshController _refreshController = EasyRefreshController(
      controlFinishLoad: true, controlFinishRefresh: true);

  final ScrollController _scrollController = ScrollController();

  List<VisibleItem> visibleItems = [];

  @override
  void initState() {
    _scrollController.addListener(_observScroll);
    super.initState();
  }

  @override
  void dispose() {
    _scrollController.removeListener(_observScroll);
    _scrollController.dispose();
    super.dispose();
  }

  void _observScroll() {
    ScrollDirection direction = _scrollController.position.userScrollDirection;
    if (direction == ScrollDirection.forward) {
    } else if (direction == ScrollDirection.reverse) {}
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.green,
        body: EasyRefresh(
          controller: _refreshController,
          onRefresh: () async {
            await Future.delayed(const Duration(seconds: 1));
            setState(() {
              _items = List.generate(10, (i) => i + 1);
            });
            _refreshController.finishRefresh();
            _refreshController.resetFooter();
          },
          onLoad: () async {
            await Future.delayed(const Duration(seconds: 1));
            setState(() {
              _items.addAll(List.generate(10, (i) => _items.length + i + 1));
            });
            _refreshController.finishLoad(_items.length >= 300
                ? IndicatorResult.noMore
                : IndicatorResult.success);
          },
          header: const HertownRefreshHeader(),
          footer:
              const HertownRefreshFooter(position: IndicatorPosition.locator),
          child: NotificationListener<ScrollNotification>(
              onNotification: (notification) {
                if (notification is ScrollStartNotification) {
                } else if (notification is ScrollUpdateNotification) {
                } else if (notification is ScrollEndNotification) {}
                return true;
              },
              child: CustomScrollView(
                scrollDirection: Axis.vertical,
                controller: _scrollController,
                slivers: [
                  const HeaderLocator.sliver(),
                  SliverList(
                    delegate: SliverChildBuilderDelegate(
                      (context, index) {
                        return VisibilityDetector(
                            key: Key('$index'),
                            onVisibilityChanged: (info) {
                              if (info.visibleFraction > 0) {
                                if (!visibleItems
                                    .any((item) => item.index == index)) {
                                  visibleItems.add(VisibleItem(info, index));
                                }
                              } else {
                                visibleItems
                                    .removeWhere((item) => item.index == index);
                              }
                            },
                            child: ListItemWidget(
                                index: index,
                                content: longTexts[
                                    Random().nextInt(longTexts.length)]));
                      },
                      childCount: _items.length,
                    ),
                  ),
                  const FooterLocator.sliver(),
                ],
              )),
        ));
  }
}

class ListItemWidget extends StatefulWidget {
  final int index;
  final String content;
  const ListItemWidget({super.key, required this.index, required this.content});

  @override
  State<StatefulWidget> createState() => _ListItemWidgetState();
}

class _ListItemWidgetState extends State<ListItemWidget> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: () {
          Navigator.of(context).push(MaterialPageRoute<void>(
            builder: (BuildContext context) => const UserProfilePage(),
          ));
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Item ${widget.index}'),
            Text(widget.content),
            const Divider(color: Colors.red)
          ],
        ));
  }
}
