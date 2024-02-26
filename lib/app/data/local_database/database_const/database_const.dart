class DatabaseConst {
  static const databaseName = "user.db";
  static const  tableName = "userData";
  static const version = 10;
  static const columnPrimaryKey = "primary_key";
  static const columnId = "id";
  static const columnName = "name";
  static const columnMembershipPlan = "membership_plan";
  static const columnMembershipDate = "membership_date";
  static const columnMembershipExpireDate = "membership_expire_date";

  static const columnEmail = "email";
  static const columnMobile = "mobile";
  static const columnUserImage = "user_image";
  static const columnEmailVerifyAt = "email_verified_at";
  static const columnUserRole = "user_role";
  static const columnStatus = "status";
  static const columnUserId = "user_id";

  static const columnIp = "ip";
  static const columnDeviceType = "device_type";
  static const columnCreatedAt = "created_at";
  static const columnUpdatedAt = "updated_at";
  static const columnToken = "token";
  static const columnMyCollection = "my_collection";
  static const columnCompleteBook = "completedbook";
  static const columnOnGoing = "ongoing";
  static const columnAppUpdateOnOff = "app_update_on_off";
  static const columnNotificationOnOff = "notification_on_off";
  static const columnMode="mode";
  static const columnCountryCode="country_code";

  static const idType = "INTEGER PRIMARY KEY AUTOINCREMENT"; //AUTOINCREMENT OPTIONAL
  static const textType = "TEXT";

  static const tableNameUserLogin = "userLogin";

  static var columIsLogIn='is_login';


}

class UserLocalData {
  String? columnId;
  String? columnName;


  String? columnMembershipPlan;
  String? columnMembershipDate;
  String? columnMembershipExpireDate;
  String? columnEmail;
  String? columnMobile;
  String? columnUserImage;
  String? columnEmailVerifyAt;
  String? columnUserRole;
  String? columnStatus;
  String? columnUserId;

  String? columnIp;
  String? columnDeviceType;
  String? columnCreatedAt;
  String? columnUpdatedAt;
  String? columnToken;
  String? columnMyCollection;
  String? columnCompleteBook;
  String? columnOnGoing;
  String? columnAppUpdateOnOff;
  String? columnNotificationOnOff;
  String? columnMode;
  String? columnCountryCode;

  UserLocalData({
    this.columnId,
    this.columnName,
    this.columnEmail,
    this.columnMobile,
    this.columnUserImage,
    this.columnEmailVerifyAt,
    this.columnUserRole,
    this.columnStatus,
    this.columnUserId,
    this.columnMembershipPlan,
    this.columnMembershipDate,
    this.columnIp,
    this.columnDeviceType,
    this.columnCreatedAt,
    this.columnUpdatedAt,
    this.columnToken,
    this.columnMyCollection,
    this.columnCompleteBook,
    this.columnOnGoing,
    this.columnNotificationOnOff,
    this.columnAppUpdateOnOff,
    this.columnMode,
    this.columnCountryCode
  });

  Map<String, dynamic> toMap() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data[DatabaseConst.columnId] = columnId;
    data[DatabaseConst.columnName] = columnName;
    data[DatabaseConst.columnMembershipPlan] = columnMembershipPlan;
    data[DatabaseConst.columnMembershipDate] = columnMembershipDate;
    data[DatabaseConst.columnMembershipExpireDate] = columnMembershipExpireDate;
    data[DatabaseConst.columnEmail] = columnEmail;
    data[DatabaseConst.columnMobile] = columnMobile;
    data[DatabaseConst.columnUserImage] = columnUserImage;
    data[DatabaseConst.columnEmailVerifyAt] = columnEmailVerifyAt;
    data[DatabaseConst.columnUserRole] = columnUserRole;
    data[DatabaseConst.columnStatus] = columnStatus;
    data[DatabaseConst.columnUserId] = columnUserId;
    data[DatabaseConst.columnMembershipPlan] = columnMembershipPlan;
    data[DatabaseConst.columnMembershipDate] = columnMembershipDate;
    data[DatabaseConst.columnMembershipExpireDate] = columnMembershipExpireDate;
    data[DatabaseConst.columnIp] = columnIp;
    data[DatabaseConst.columnDeviceType] = columnDeviceType;
    data[DatabaseConst.columnCreatedAt] = columnCreatedAt;
    data[DatabaseConst.columnUpdatedAt] = columnUpdatedAt;
    data[DatabaseConst.columnToken] = columnToken;
    data[DatabaseConst.columnMyCollection] = columnMyCollection;
    data[DatabaseConst.columnCompleteBook] = columnCompleteBook;
    data[DatabaseConst.columnOnGoing] = columnOnGoing;
    data[DatabaseConst.columnAppUpdateOnOff] =columnAppUpdateOnOff;
    data[DatabaseConst.columnNotificationOnOff] = columnNotificationOnOff;
    data[DatabaseConst.columnMode] = columnMode;
    data[DatabaseConst.columnCountryCode] = columnCountryCode;
    return data;
  }

}
