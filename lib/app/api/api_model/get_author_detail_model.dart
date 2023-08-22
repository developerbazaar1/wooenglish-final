class GetAuthorDetailsModel {
  bool? status;
  String? message;
  Author? author;
  int? noOfFollowers;
  int? isFollow;
  int? noOfAuthorBooks;
  List<AuthorBooks>? authorBooks;
  List<AuthorBooksReviews>? authorBooksReviews;
  List<String>? favorite;

  GetAuthorDetailsModel(
      {this.status,
      this.message,
      this.author,
      this.noOfFollowers,
      this.isFollow,
      this.noOfAuthorBooks,
      this.authorBooks,
      this.authorBooksReviews,
      this.favorite});

  GetAuthorDetailsModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    author = json['author'] != null ? Author.fromJson(json['author']) : null;
    noOfFollowers = json['no_of_followers'];
    isFollow = json["is_follow"];
    noOfAuthorBooks = json['no_of_authorbooks'];
    if (json['authorbooks'] != null) {
      authorBooks = <AuthorBooks>[];
      json['authorbooks'].forEach((v) {
        authorBooks!.add(AuthorBooks.fromJson(v));
      });
    }
    if (json['favorite'] != null) {
      favorite = json['favorite'].cast<String>();
    }
    if (json['authorbooksreviews'] != null) {
      authorBooksReviews = <AuthorBooksReviews>[];
      json['authorbooksreviews'].forEach((v) {
        authorBooksReviews!.add(AuthorBooksReviews.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['message'] = message;
    data['favorite'] = favorite;
    if (author != null) {
      data['author'] = author!.toJson();
    }
    data['no_of_followers'] = noOfFollowers;
    data['is_follow'] = isFollow;
    data['no_of_authorbooks'] = noOfAuthorBooks;
    if (authorBooks != null) {
      data['authorbooks'] = authorBooks!.map((v) => v.toJson()).toList();
    }
    if (authorBooksReviews != null) {
      data['authorbooksreviews'] =
          authorBooksReviews!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Author {
  int? id;
  String? name;
  String? authorImage;
  String? status;
  String? createdAt;
  String? updatedAt;

  Author(
      {this.id,
      this.name,
      this.authorImage,
      this.status,
      this.createdAt,
      this.updatedAt});

  Author.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    authorImage = json['author_image'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['author_image'] = authorImage;
    data['status'] = status;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}

class AuthorBooks {
  int? id;
  String? title;
  String? category;
  String? englishAccent;
  String? homeCategory;
  String? authorName;
  String? totalWords;
  String? genre;
  String? totalTime;
  String? level;
  String? status;
  String? englishFluency;
  String? showbookto;
  String? bookThumbnail;
  String? bookDescription;
  String? videoTitle;
  String? audioTitle;
  String? video;
  String? audio;
  String? createdAt;
  String? updatedAt;
  String? views;
  String? isAudio;
  String? rating;

  AuthorBooks(
      {this.id,
      this.title,
      this.category,
      this.englishAccent,
      this.homeCategory,
      this.authorName,
      this.totalWords,
      this.genre,
      this.totalTime,
      this.level,
      this.status,
      this.englishFluency,
      this.showbookto,
      this.bookThumbnail,
      this.bookDescription,
      this.videoTitle,
      this.audioTitle,
      this.video,
      this.audio,
      this.createdAt,
      this.updatedAt,
      this.views,
      this.isAudio,
      this.rating});

  AuthorBooks.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    category = json['category'];
    englishAccent = json['english_accent'];
    homeCategory = json['home_category'];
    authorName = json['author_name'];
    totalWords = json['total_words'];
    genre = json['genre'];
    totalTime = json['total_time'];
    level = json['level'];
    status = json['status'];
    englishFluency = json['english_fluency'];
    showbookto = json['showbookto'];
    bookThumbnail = json['book_thumbnail'];
    bookDescription = json['book_description'];
    videoTitle = json['video_title'];
    audioTitle = json['audio_title'];
    video = json['video'];
    audio = json['audio'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    views = json['views'];
    isAudio = json['is_audio'];
    rating = json['rating'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['title'] = title;
    data['category'] = category;
    data['english_accent'] = englishAccent;
    data['home_category'] = homeCategory;
    data['author_name'] = authorName;
    data['total_words'] = totalWords;
    data['genre'] = genre;
    data['total_time'] = totalTime;
    data['level'] = level;
    data['status'] = status;
    data['english_fluency'] = englishFluency;
    data['showbookto'] = showbookto;
    data['book_thumbnail'] = bookThumbnail;
    data['book_description'] = bookDescription;
    data['video_title'] = videoTitle;
    data['audio_title'] = audioTitle;
    data['video'] = video;
    data['audio'] = audio;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['views'] = views;
    data['is_audio'] = isAudio;
    data['rating'] = rating;
    return data;
  }
}

class AuthorBooksReviews {
  int? id;
  String? name;
  String? review;
  String? rating;
  String? bookId;
  String? userId;
  String? reply;
  String? createdAt;
  String? updatedAt;
  UserDetails? userdetails;

  AuthorBooksReviews(
      {this.id,
      this.name,
      this.review,
      this.rating,
      this.bookId,
      this.userId,
      this.reply,
      this.createdAt,
      this.updatedAt,
      this.userdetails});

  AuthorBooksReviews.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    review = json['review'];
    rating = json['rating'];
    bookId = json['book_id'];
    userId = json['user_id'];
    reply = json['reply'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    userdetails = json['userdetails'] != null
        ? UserDetails.fromJson(json['userdetails'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['review'] = review;
    data['rating'] = rating;
    data['book_id'] = bookId;
    data['user_id'] = userId;
    data['reply'] = reply;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    if (userdetails != null) {
      data['userdetails'] = userdetails!.toJson();
    }
    return data;
  }
}

class UserDetails {
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

  UserDetails(
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
      this.updatedAt});

  UserDetails.fromJson(Map<String, dynamic> json) {
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
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
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
    data['device_type'] = deviceType;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}
