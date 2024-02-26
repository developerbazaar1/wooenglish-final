class GetCommentModal {
  bool? status;
  String? message;
  List<Data>? data;

  GetCommentModal({this.status, this.message, this.data});

  GetCommentModal.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  int? id;
  String? userId;
  String? quizResId;
  String? comment;
  String? createdAt;
  String? updatedAt;
  Userdetails? userdetails;

  Data(
      {this.id,
        this.userId,
        this.quizResId,
        this.comment,
        this.createdAt,
        this.updatedAt,
        this.userdetails});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    quizResId = json['quiz_res_id'];
    comment = json['comment'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    userdetails = json['userdetails'] != null
        ? new Userdetails.fromJson(json['userdetails'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_id'] = this.userId;
    data['quiz_res_id'] = this.quizResId;
    data['comment'] = this.comment;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    if (this.userdetails != null) {
      data['userdetails'] = this.userdetails!.toJson();
    }
    return data;
  }
}

class Userdetails {
  int? id;
  String? name;
  String? email;
  String? mobile;
  String? userImage;
  Null? emailVerifiedAt;
  String? userRole;
  String? status;
  String? userId;
  String? membershipPlan;
  String? membershipDate;
  String? membershipExpireDate;
  String? ip;
  String? deviceType;
  String? notificationOnOff;
  String? appUpdateOnOff;
  String? mode;
  String? fcmid;
  String? provider;
  String? countryCode;
  String? createdAt;
  String? updatedAt;

  Userdetails(
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
        this.membershipExpireDate,
        this.ip,
        this.deviceType,
        this.notificationOnOff,
        this.appUpdateOnOff,
        this.mode,
        this.fcmid,
        this.provider,
        this.countryCode,
        this.createdAt,
        this.updatedAt});

  Userdetails.fromJson(Map<String, dynamic> json) {
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
    membershipExpireDate = json['membership_expire_date'];
    ip = json['ip'];
    deviceType = json['device_type'];
    notificationOnOff = json['notification_on_off'];
    appUpdateOnOff = json['app_update_on_off'];
    mode = json['mode'];
    fcmid = json['fcmid'];
    provider = json['provider'];
    countryCode = json['country_code'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['email'] = this.email;
    data['mobile'] = this.mobile;
    data['user_image'] = this.userImage;
    data['email_verified_at'] = this.emailVerifiedAt;
    data['user_role'] = this.userRole;
    data['status'] = this.status;
    data['user_id'] = this.userId;
    data['membership_plan'] = this.membershipPlan;
    data['membership_date'] = this.membershipDate;
    data['membership_expire_date'] = this.membershipExpireDate;
    data['ip'] = this.ip;
    data['device_type'] = this.deviceType;
    data['notification_on_off'] = this.notificationOnOff;
    data['app_update_on_off'] = this.appUpdateOnOff;
    data['mode'] = this.mode;
    data['fcmid'] = this.fcmid;
    data['provider'] = this.provider;
    data['country_code'] = this.countryCode;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
