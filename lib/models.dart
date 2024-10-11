import 'package:flutter/material.dart';

class Profile {
  String nick;
  String avatar;

  Profile(this.nick, this.avatar);

  factory Profile.fromJson(dynamic json) {
    return Profile(json['nick'] as String, json['avatar'] as String);
  }
}

class User {
  String userId;
  Profile profile;

  User(this.userId, this.profile);

  factory User.fromJson(dynamic json) {
    return User(json['userId'] as String, Profile.fromJson(json['profile']));
  }
}

class FeedInfo {
  String id;
  Source? source;

  FeedInfo(this.id, this.source);
}

class Source {
  String? ip;
  Content? content;

  Source(this.ip, this.content);
}

class Content {
  String? desc;

  Content(this.desc);
}

class FeedInfoModel extends ChangeNotifier {
  List<FeedInfo> items;

  FeedInfoModel(this.items);

  FeedInfo? getItem(String id) {
    for (var item in items) {
      if (item.id == id) {
        return item;
      }
    }
    return null;
  }

  void updateItem(String id, String desc) {
    for (var item in items) {
      if (item.id == id) {
        item.source?.content?.desc = desc;
        notifyListeners();
        break;
      }
    }
  }
}
