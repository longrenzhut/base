class PostEntity {
  String imageWidth;
  String avatarUrl;
  String subject;
  String typeName;
  int displayorder;
  int type;
  String message;
  int posts;
  int tid;
  String imageHeight;
  int lauds;
  int uid;
  String createTime;
  String imageUrl;
  String nickname;
  String headimgurl;
  int views;

  PostEntity({this.imageWidth, this.avatarUrl, this.subject, this.typeName, this.displayorder, this.type, this.message, this.posts, this.tid, this.imageHeight, this.lauds, this.uid, this.createTime, this.imageUrl, this.nickname, this.headimgurl, this.views});

  PostEntity.fromJson(Map<String, dynamic> json) {
    imageWidth = json['imageWidth'].toString();
    avatarUrl = json['avatarUrl'];
    subject = json['subject'];
    typeName = json['typeName'];
    displayorder = json['displayorder'];
    type = json['type'];
    message = json['message'];
    posts = json['posts'];
    tid = json['tid'];
    imageHeight = json['imageHeight'].toString();
    lauds = json['lauds'];
    uid = json['uid'];
    createTime = json['createTime'];
    imageUrl = json['imageUrl'];
    nickname = json['nickname'];
    headimgurl = json['headimgurl'];
    views = json['views'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['imageWidth'] = this.imageWidth;
    data['avatarUrl'] = this.avatarUrl;
    data['subject'] = this.subject;
    data['typeName'] = this.typeName;
    data['displayorder'] = this.displayorder;
    data['type'] = this.type;
    data['message'] = this.message;
    data['posts'] = this.posts;
    data['tid'] = this.tid;
    data['imageHeight'] = this.imageHeight;
    data['lauds'] = this.lauds;
    data['uid'] = this.uid;
    data['createTime'] = this.createTime;
    data['imageUrl'] = this.imageUrl;
    data['nickname'] = this.nickname;
    data['headimgurl'] = this.headimgurl;
    data['views'] = this.views;
    return data;
  }
}
