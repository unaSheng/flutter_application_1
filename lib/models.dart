
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