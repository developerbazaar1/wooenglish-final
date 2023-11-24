class GetDashBoardBooksModel {
  bool? status;
  String? message;
  Books? book;
  List<Books>? books;
  List<Pages>? pages;
  Pages? page;
  List<Books>? quiz;
  List<Authors>? authors;
  List<String>? favorite;
  List<Filters>? genre;
  List<Filters>? level;
  List<Filters>? language;
  List<Filters>? length;
  List<Filters>? englishAccent;
  List<Filters>? category;
  List<Reviews>? reviews;
  List<Notification>? notification;
  List<Chapters>? chapters;
  int? isQuiz;
  int? reviewCount;
  int? isFavorite;
  int? favoriteCount;
  int? chapterCount;
  int? isBookmark;
  String? adminReply;
  List<String>? bookmark;

  GetDashBoardBooksModel(
      {this.status,
      this.message,
      this.book,
      this.books,
      this.authors,
      this.favorite,
      this.reviews,
      this.notification,
      this.quiz,
      this.reviewCount,
      this.chapters,
      this.isFavorite,
      this.isQuiz,
      this.favoriteCount,
      this.chapterCount,
      this.englishAccent,
      this.level,
      this.category,
      this.page,
      this.isBookmark,
      this.genre,
      this.adminReply,
      this.bookmark,
      this.language,
      this.length,this.pages});

  GetDashBoardBooksModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    reviewCount = json['rev_count'];
    isBookmark = json['isBookmark'];
    isFavorite = json['isFavorite'];
    favoriteCount = json['Favorite_count'];
    adminReply = json['admin_reply'];
    isQuiz = json['isQuiz'];
    chapterCount = json['Chapter_count'];
    page = json['page'] != null ? Pages.fromJson(json['page']) : null;
    if (json['book'] != null) {
      book = json['book'] != null ? Books.fromJson(json['book']) : null;
    }
    if (json['notification'] != null) {
      notification = <Notification>[];
      json['notification'].forEach((v) {
        notification!.add(Notification.fromJson(v));
      });
    }
    if (json['quiz'] != null) {
      quiz = <Books>[];
      json['quiz'].forEach((v) {
        quiz!.add(Books.fromJson(v));
      });
    }if (json['pages'] != null) {
      pages = <Pages>[];
      json['pages'].forEach((v) {
        pages!.add(Pages.fromJson(v));
      });
    }

    if (json['chapters'] != null) {
      chapters = <Chapters>[];
      json['chapters'].forEach((v) {
        chapters!.add(Chapters.fromJson(v));
      });
    }
    if (json['books'] != null) {
      books = <Books>[];
      json['books'].forEach((v) {
        books!.add(Books.fromJson(v));
      });
    }
    if (json['authors'] != null) {
      authors = <Authors>[];
      json['authors'].forEach((v) {
        authors!.add(Authors.fromJson(v));
      });
    }
    if (json['reviews'] != null) {
      reviews = <Reviews>[];
      json['reviews'].forEach((v) {
        reviews!.add(Reviews.fromJson(v));
      });
    }
    if (json['favorite'] != null) {
      favorite = json['favorite'].cast<String>();
    }
    if (json['Bookmark'] != null) {
      bookmark = json['Bookmark'].cast<String>();
    }

    if (json['genre'] != null) {
      genre = <Filters>[];
      json['genre'].forEach((v) {
        genre!.add(Filters.fromJson(v));
      });
    }
    if (json['language'] != null) {
      language = <Filters>[];
      json['language'].forEach((v) {
        language!.add(Filters.fromJson(v));
      });
    }
    if (json['length'] != null) {
      length = <Filters>[];
      json['length'].forEach((v) {
        length!.add(Filters.fromJson(v));
      });
    }
    if (json['level'] != null) {
      level = <Filters>[];
      json['level'].forEach((v) {
        level!.add(Filters.fromJson(v));
      });
    }

    if (json['englishaccent'] != null) {
      englishAccent = <Filters>[];
      json['englishaccent'].forEach((v) {
        englishAccent!.add(Filters.fromJson(v));
      });
    }

    if (json['category'] != null) {
      category = <Filters>[];
      json['category'].forEach((v) {
        category!.add(Filters.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['message'] = message;
    data['rev_count'] = reviewCount;
    data['isBookmark'] = isBookmark;
    data['admin_reply'] = adminReply;
    data['isFavorite'] = isFavorite;
    data['isQuiz'] = isQuiz;
    data['Favorite_count'] = favoriteCount;
    data['Chapter_count'] = chapterCount;
    if (page != null) {
      data['page'] = page!.toJson();
    }
    if (books != null) {
      data['books'] = books!.map((v) => v.toJson()).toList();
    }
    if (reviews != null) {
      data['reviews'] = reviews!.map((v) => v.toJson()).toList();
    }
    if (notification != null) {
      data['notification'] = notification!.map((v) => v.toJson()).toList();
    }
    if (chapters != null) {
      data['chapters'] = chapters!.map((v) => v.toJson()).toList();
    }
    if (quiz != null) {
      data['quiz'] = quiz!.map((v) => v.toJson()).toList();
    }  if (pages != null) {
      data['pages'] = pages!.map((v) => v.toJson()).toList();
    }
    if (genre != null) {
      data['genre'] = genre!.map((v) => v.toJson()).toList();
    }
    if (length != null) {
      data['length'] = length!.map((v) => v.toJson()).toList();
    } if (language != null) {
      data['language'] = language!.map((v) => v.toJson()).toList();
    }
    if (level != null) {
      data['level'] = level!.map((v) => v.toJson()).toList();
    }
    if (category != null) {
      data['category'] = category!.map((v) => v.toJson()).toList();
    }
    if (englishAccent != null) {
      data['englishaccent'] = englishAccent!.map((v) => v.toJson()).toList();
    }
    if (authors != null) {
      data['authors'] = authors!.map((v) => v.toJson()).toList();
    }
    data['favorite'] = favorite;
    return data;
  }
}

class Books {
  int? id;
  String? title;
  String? bookId;
  String? question;
  String? chapterName;
  String? answer;
  String? adminReply;
  String? category;
  String? englishAccent;
  String? homeCategory;
  String? chapter;
  String? chapterId;
  String? percentage;
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
  String? isAudio;
  String? rating;
  String? views;
  Bookdetails? bookdetails;
  Userdetails? userdetails;

  Books(
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
      this.chapter,
      this.chapterName,
      this.chapterId,
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
      this.isAudio,
      this.rating,
      this.views,
      this.bookId,
      this.percentage,
      this.question,
      this.userdetails,
      this.adminReply,
      this.answer});

  Books.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    question = json['question'];
    answer = json['answer'];
    bookId = json["book_id"];
    adminReply = json["admin_reply"];
    chapterName = json["chapter_name"];
    title = json['title'];
    category = json['category'];
    chapterId = json['chapter_id'];
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
    isAudio = json['is_audio'].toString();
    rating = json['rating'].toString();
    views = json['views'].toString();
    chapter = json["chapter"];
    percentage = json["percentage"];
    bookdetails = json['bookdetails'] != null
        ? Bookdetails.fromJson(json['bookdetails'])
        : null;
    userdetails = json['userdetails'] != null
        ? Userdetails.fromJson(json['userdetails'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['title'] = title;
    data['question'] = question;
    data['answer'] = answer;
    data['category'] = category;
    data['english_accent'] = englishAccent;
    data['home_category'] = homeCategory;
    data['author_name'] = authorName;
    data['total_words'] = totalWords;
    data['genre'] = genre;
    data['book_id'] = bookId;
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
    data['is_audio'] = isAudio;
    data['rating'] = rating;
    data['views'] = views;
    data['chapter'] = chapter;
    data["percentage"] = percentage;
    if (bookdetails != null) {
      data['bookdetails'] = bookdetails!.toJson();
    }
    return data;
  }
}

class Authors {
  int? id;
  String? name;
  String? authorImage;
  String? status;
  String? createdAt;
  String? updatedAt;

  Authors(
      {this.id,
      this.name,
      this.authorImage,
      this.status,
      this.createdAt,
      this.updatedAt});

  Authors.fromJson(Map<String, dynamic> json) {
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

class Bookdetails {
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

  Bookdetails(
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

  Bookdetails.fromJson(Map<String, dynamic> json) {
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
    views = json['views'].toString();
    isAudio = json['is_audio'].toString();
    rating = json['rating'].toString();
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

class Filters {
  int? id;
  String? name;
  String? status;
  String? createdAt;
  String? updatedAt;

  Filters({this.id, this.name, this.createdAt, this.updatedAt});

  Filters.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['status'] = status;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}

class Reviews {
  int? id;
  String? name;
  String? review;
  String? rating;
  String? bookId;
  String? userId;
  String? reply;
  String? createdAt;
  String? updatedAt;
  Bookdetails? bookdetails;
  Userdetails? userdetails;

  Reviews(
      {this.id,
      this.name,
      this.review,
      this.rating,
      this.bookId,
      this.userId,
      this.reply,
      this.createdAt,
      this.updatedAt,
      this.bookdetails,
      this.userdetails});

  Reviews.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    review = json['review'];
    rating = json['rating'].toString();
    bookId = json['book_id'];
    userId = json['user_id'];
    reply = json['reply'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    bookdetails = json['bookdetails'] != null
        ? Bookdetails.fromJson(json['bookdetails'])
        : null;
    userdetails = json['userdetails'] != null
        ? Userdetails.fromJson(json['userdetails'])
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
    if (bookdetails != null) {
      data['bookdetails'] = bookdetails!.toJson();
    }
    if (userdetails != null) {
      data['userdetails'] = userdetails!.toJson();
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
      this.ip,
      this.deviceType,
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

class Notification {
  int? id;
  String? notificationName;
  String? notificationDescription;
  String? createdAt;
  String? updatedAt;

  Notification(
      {this.id,
      this.notificationName,
      this.notificationDescription,
      this.createdAt,
      this.updatedAt});

  Notification.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    notificationName = json['notification_name'];
    notificationDescription = json['notification_description'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['notification_name'] = notificationName;
    data['notification_description'] = notificationDescription;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}

class Chapters {
  int? id;
  String? bookId;
  String? chapterNo;
  String? chapterName;
  String? chapterDescription;
  String? audioTitle;
  String? audio;
  String? createdAt;
  String? updatedAt;

  Chapters(
      {this.id,
      this.bookId,
      this.chapterNo,
      this.chapterName,
      this.chapterDescription,
      this.audioTitle,
      this.audio,
      this.createdAt,
      this.updatedAt});

  Chapters.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    bookId = json['book_id'];
    chapterNo = json['chapter_no'];
    chapterName = json['chapter_name'];
    chapterDescription = json['chapter_description'];
    audioTitle = json['audio_title'];
    audio = json['audio'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['book_id'] = bookId;
    data['chapter_no'] = chapterNo;
    data['chapter_name'] = chapterName;
    data['chapter_description'] = chapterDescription;
    data['audio_title'] = audioTitle;
    data['audio'] = audio;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}

class Pages {
  int? id;
  String? pageName;
  String? pageDescription;
  String? image;
  String? createdAt;
  String? updatedAt;

  Pages(
      {this.id,
      this.pageName,
      this.pageDescription,
      this.createdAt,
      this.updatedAt,this.image});

  Pages.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    pageName = json['page_name'];
    image = json['image'];
    pageDescription = json['page_description'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['page_name'] = pageName;
    data['page_description'] = pageDescription;
    data['image'] = image;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}
