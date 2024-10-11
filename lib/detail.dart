import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/models.dart';
import 'package:provider/provider.dart';

class DetailPage extends StatefulWidget {
  final FeedInfo item;
  const DetailPage({super.key, required this.item});

  @override
  State<StatefulWidget> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  FeedInfo get info => widget.item;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('详情')
      ),
      body: Column(
        children: [
          IdText(id: info.id),
          IpText(ip: info.source?.ip ?? ""),
          DescText(id: info.id, desc: info.source?.content?.desc ?? ""),
          TextButton(
              onPressed: () {
                Provider.of<FeedInfoModel?>(context, listen: false)?.updateItem(
                    info.id, 'feed id: ${info.id} - detail upadte desc');
              },
              child: const Text('修改desc')),
        ],
      ),
    );
  }
}

class IdText extends StatelessWidget {
  final String id;
  const IdText({super.key, required this.id});
  @override
  Widget build(BuildContext context) {
    print('detail id rebuild');
    return Text(id);
  }
}

class IpText extends StatelessWidget {
  final String ip;
  const IpText({super.key, required this.ip});
  @override
  Widget build(BuildContext context) {
    print('detail ip rebuild');
    return Text(ip);
  }
}

class DescText extends StatelessWidget {
  final String id;
  final String desc;
  const DescText({super.key, required this.id, required this.desc});
  @override
  Widget build(BuildContext context) {
    print('detail desc rebuild');
    String desc = context.select<FeedInfoModel?, String>(
        (info) => info?.getItem(id)?.source?.content?.desc ?? "");
    return Text(desc);
  }
}

class ListItemWidget extends StatefulWidget {
  final FeedInfo item;
  const ListItemWidget({super.key, required this.item});
  @override
  State<StatefulWidget> createState() => _ListItemWidgetState();
}

class _ListItemWidgetState extends State<ListItemWidget> {
  FeedInfo get item => widget.item;


  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListIdText(id: item.id),
        ListIpText(ip: item.source?.ip ?? ""),
        ListDescText(id: item.id, desc: item.source?.content?.desc ?? ""),
        TextButton(
            onPressed: () {
              Provider.of<FeedInfoModel?>(context, listen: false)?.updateItem(
                  item.id, 'feed id: ${item.id} - list item upadte desc');
            },
            child: const Text('修改desc')),
        TextButton(
            onPressed: () {
              Navigator.push(
                  context,
                  CupertinoPageRoute(
                      builder: (context) => DetailPage(item: item)));
            },
            child: const Text('详情')),
        const Divider(color: Colors.red)
      ],
    );
  }
}

class ListIdText extends StatelessWidget {
  final String id;
  const ListIdText({super.key, required this.id});
  @override
  Widget build(BuildContext context) {
    print('list id rebuild');
    return Text(id);
  }
}

class ListIpText extends StatelessWidget {
  final String ip;
  const ListIpText({super.key, required this.ip});
  @override
  Widget build(BuildContext context) {
    print('list ip rebuild');
    return Text(ip);
  }
}

class ListDescText extends StatelessWidget {
  final String id;
  final String desc;
  const ListDescText({super.key, required this.id, required this.desc});
  @override
  Widget build(BuildContext context) {
    print('list desc rebuild');
    String desc = context.select<FeedInfoModel?, String>(
        (info) => info?.getItem(id)?.source?.content?.desc ?? "");
    return Text(desc);
  }
}
