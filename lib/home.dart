import 'package:flutter/material.dart';
import 'package:flutter_application_1/detail.dart';
import 'package:flutter_application_1/models.dart';
import 'package:provider/provider.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    FeedInfoModel infoModel = context.read();
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        actions: [
          TextButton(
              onPressed: () {
                Provider.of<FeedInfoModel>(context, listen: false).updateItem("1", "notify 自定义 desc");
              },
              child: const Text('修改数据'))
        ],
      ),

      body: CustomScrollView(
        scrollDirection: Axis.vertical,
        slivers: [
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                return ListItemWidget(item: infoModel.items[index]);
              },
              childCount: infoModel.items.length,
            ),
          ),
        ],
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
