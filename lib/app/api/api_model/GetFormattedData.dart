class GetFormatedData {
  bool? status;
  String? message;
  Data? data;

  GetFormatedData({this.status, this.message, this.data});

  GetFormatedData.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  int? id;
  String? userId;
  String? textColor;
  String? backGroundColor;
  String? selectFontSize;
  String? setFontStyle;
  String? setImage;
  String? setTextAlign;
  String? setFontFamily;
  String? isDarkmode;
  String? createdAt;
  String? updatedAt;

  Data(
      {this.id,
        this.userId,
        this.textColor,
        this.backGroundColor,
        this.selectFontSize,
        this.setFontStyle,
        this.setImage,
        this.setTextAlign,
        this.setFontFamily,
        this.isDarkmode,
        this.createdAt,
        this.updatedAt});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    textColor = json['textColor'];
    backGroundColor = json['backGroundColor'];
    selectFontSize = json['selectFontSize'];
    setFontStyle = json['setFontStyle'];
    setImage = json['setImage'];
    setTextAlign = json['setTextAlign'];
    setFontFamily = json['setFontFamily'];
    isDarkmode = json['isDarkmode'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_id'] = this.userId;
    data['textColor'] = this.textColor;
    data['backGroundColor'] = this.backGroundColor;
    data['selectFontSize'] = this.selectFontSize;
    data['setFontStyle'] = this.setFontStyle;
    data['setImage'] = this.setImage;
    data['setTextAlign'] = this.setTextAlign;
    data['setFontFamily'] = this.setFontFamily;
    data['isDarkmode'] = this.isDarkmode;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
