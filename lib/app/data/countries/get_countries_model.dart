class GetCountriesModel {
  List<Country>? country;

  GetCountriesModel({this.country});

  GetCountriesModel.fromJson(Map<String, dynamic> json) {
    if (json['country'] != null) {
      country = <Country>[];
      json['country'].forEach((v) {
        country!.add( Country.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  <String, dynamic>{};
    if (country != null) {
      data['country'] = country!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Country {
  Flags? flags;
  Name? name;
  Idd? idd;

  Country({this.flags, this.name, this.idd});

  Country.fromJson(Map<String, dynamic> json) {
    flags = json['flags'] != null ?  Flags.fromJson(json['flags']) : null;
    name = json['name'] != null ?  Name.fromJson(json['name']) : null;
    idd = json['idd'] != null ?  Idd.fromJson(json['idd']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  <String, dynamic>{};
    if (flags != null) {
      data['flags'] = flags!.toJson();
    }
    if (name != null) {
      data['name'] = name!.toJson();
    }
    if (idd != null) {
      data['idd'] = idd!.toJson();
    }
    return data;
  }
}

class Flags {
  String? png;
  String? svg;
  String? alt;

  Flags({this.png, this.svg, this.alt});

  Flags.fromJson(Map<String, dynamic> json) {
    png = json['png'];
    svg = json['svg'];
    alt = json['alt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  <String, dynamic>{};
    data['png'] = png;
    data['svg'] = svg;
    data['alt'] = alt;
    return data;
  }
}

class Name {
  String? common;
  String? official;
  NativeName? nativeName;

  Name({this.common, this.official, this.nativeName});

  Name.fromJson(Map<String, dynamic> json) {
    common = json['common'];
    official = json['official'];
    nativeName = json['nativeName'] != null
        ?  NativeName.fromJson(json['nativeName'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  <String, dynamic>{};
    data['common'] = common;
    data['official'] = official;
    if (nativeName != null) {
      data['nativeName'] = nativeName!.toJson();
    }
    return data;
  }
}

class NativeName {
  Ara? ara;

  NativeName({this.ara});

  NativeName.fromJson(Map<String, dynamic> json) {
    ara = json['ara'] != null ?  Ara.fromJson(json['ara']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  <String, dynamic>{};
    if (ara != null) {
      data['ara'] = ara!.toJson();
    }
    return data;
  }
}

class Ara {
  String? official;
  String? common;

  Ara({this.official, this.common});

  Ara.fromJson(Map<String, dynamic> json) {
    official = json['official'];
    common = json['common'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  <String, dynamic>{};
    data['official'] = official;
    data['common'] = common;
    return data;
  }
}

class Idd {
  String? root;
  List<String>? suffixes;

  Idd({this.root, this.suffixes});

  Idd.fromJson(Map<String, dynamic> json) {
    root = json['root'];
    suffixes = json['suffixes'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  <String, dynamic>{};
    data['root'] = root;
    data['suffixes'] = suffixes;
    return data;
  }
}