class UserData {
  bool? status;
  String? message;
  User? user;
  String? token;
  Bookcount? bookcount;

  UserData({this.status, this.message, this.user, this.bookcount});

  UserData.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['user'] != null) {
      user = User.fromJson(json['user']);
    } else {
      user = null;
    }
    token = json['token'];
    bookcount = json['bookcount'] != null
        ? Bookcount.fromJson(json['bookcount'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['message'] = message;
    if (user != null) {
      data['user'] = user!.toJson();
    }

    data['token'] = token;

    if (bookcount != null) {
      data['bookcount'] = bookcount!.toJson();
    }
    return data;
  }
}

class User {
  int? id;
  String? name;
  String? email;
  String? mobile;
  String? userImage;
  String? emailVerifiedAt;
  String? userRole;
  String? status;
  String? userId;
  String? membershipPlan;
  String? membershipDate;
  String? ip;
  String? deviceType;
  String? createdAt;
  String? updatedAt;
  String? appUpdateOnOff;
  String? notificationOnOff;
  String? mode;
  String? countryCode;

  User(
      {this.id,
      this.name,
      this.email,
      this.mobile,
      this.userImage,
      this.emailVerifiedAt,
      this.userRole,
      this.status,
      this.userId,
      this.membershipPlan,
      this.membershipDate,
      this.ip,
      this.deviceType,
      this.createdAt,
      this.updatedAt,
      this.appUpdateOnOff,
      this.notificationOnOff,
      this.mode,this.countryCode});

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    mobile = json['mobile'];
    userImage = json['user_image'];
    emailVerifiedAt = json['email_verified_at'];
    userRole = json['user_role'];
    status = json['status'];
    userId = json['user_id'];
    membershipPlan = json['membership_plan'];
    membershipDate = json['membership_date'];
    ip = json['ip'];
    deviceType = json['device_type'];
    countryCode = json['country_code'].toString();
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    notificationOnOff = json['notification_on_off'];
    appUpdateOnOff = json['app_update_on_off'];
    mode = json['mode'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['email'] = email;
    data['mobile'] = mobile;
    data['user_image'] = userImage;
    data['email_verified_at'] = emailVerifiedAt;
    data['user_role'] = userRole;
    data['status'] = status;
    data['user_id'] = userId;
    data['membership_plan'] = membershipPlan;
    data['membership_date'] = membershipDate;
    data['ip'] = ip;
    data['country_code'] = countryCode;
    data['device_type'] = deviceType;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['notification_on_off'] = notificationOnOff;
    data['app_update_on_off'] = appUpdateOnOff;
    data['mode'] = mode;
    return data;
  }
}

class Bookcount {
  int? myCollection;
  int? completedbook;
  int? ongoing;

  Bookcount({this.myCollection, this.completedbook, this.ongoing});

  Bookcount.fromJson(Map<String, dynamic> json) {
    myCollection = json['my_collection'];
    completedbook = json['completedbook'];
    ongoing = json['ongoing'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['my_collection'] = myCollection;
    data['completedbook'] = completedbook;
    data['ongoing'] = ongoing;
    return data;
  }
}
