import 'package:flutter/material.dart';
import 'package:flutter_application_1/models.dart';
import 'package:provider/provider.dart';
import 'home_tab.dart';

void main() {
  runApp(ChangeNotifierProvider(
      create: (context) => FeedInfoModel([
            FeedInfo('1', Source('ip 1', Content('desc 1'))),
            FeedInfo('2', Source('ip 2', Content('desc 2'))),
            FeedInfo('3', Source('ip 3', Content('desc 3'))),
          ]),
      child: const BottomNavigationBarPageApp()));
}
