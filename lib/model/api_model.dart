import 'dart:convert';

List<ApiModel> apiModelFromMap(String str) =>
    List<ApiModel>.from(json.decode(str).map((x) => ApiModel.fromMap(x)));

String apiModelToMap(List<ApiModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toMap())));

class ApiModel {
  ApiModel({
    this.charId,
    this.name,
    this.birthday,
    this.occupation,
    this.img,
    this.status,
    this.nickname,
    this.appearance,
    this.portrayed,
    this.category,
    this.betterCallSaulAppearance,
  });

  final int? charId;
  final String? name;
  final Birthday? birthday;
  final List<String?>? occupation;
  final String? img;
  final Status? status;
  final String? nickname;
  final List<int?>? appearance;
  final String? portrayed;
  final Category? category;
  final List<int?>? betterCallSaulAppearance;

  factory ApiModel.fromMap(Map<String, dynamic> json) => ApiModel(
        charId: json["char_id"],
        name: json["name"],
        birthday: birthdayValues.map[json["birthday"]],
        occupation: List<String>.from(json["occupation"].map((x) => x)),
        img: json["img"],
        status: statusValues.map[json["status"]],
        nickname: json["nickname"],
        appearance: List<int>.from(json["appearance"].map((x) => x)),
        portrayed: json["portrayed"],
        category: categoryValues.map[json["category"]],
        betterCallSaulAppearance:
            List<int>.from(json["better_call_saul_appearance"].map((x) => x)),
      );

  Map<String, dynamic> toMap() => {
        "char_id": charId,
        "name": name,
        "birthday": birthdayValues.reverse![birthday],
        "occupation": List<dynamic>.from(occupation!.map((x) => x)),
        "img": img,
        "status": statusValues.reverse![status],
        "nickname": nickname,
        "appearance": List<dynamic>.from(appearance!.map((x) => x)),
        "portrayed": portrayed,
        "category": categoryValues.reverse![category],
        "better_call_saul_appearance":
            List<dynamic>.from(betterCallSaulAppearance!.map((x) => x)),
      };
}

enum Birthday {
  THE_09071958,
  THE_09241984,
  THE_08111970,
  THE_07081993,
  UNKNOWN
}

final birthdayValues = EnumValues({
  "07-08-1993": Birthday.THE_07081993,
  "08-11-1970": Birthday.THE_08111970,
  "09-07-1958": Birthday.THE_09071958,
  "09-24-1984": Birthday.THE_09241984,
  "Unknown": Birthday.UNKNOWN
});

enum Category { BREAKING_BAD, BREAKING_BAD_BETTER_CALL_SAUL, BETTER_CALL_SAUL }

final categoryValues = EnumValues({
  "Better Call Saul": Category.BETTER_CALL_SAUL,
  "Breaking Bad": Category.BREAKING_BAD,
  "Breaking Bad, Better Call Saul": Category.BREAKING_BAD_BETTER_CALL_SAUL
});

enum Status { PRESUMED_DEAD, ALIVE, DECEASED, UNKNOWN }

final statusValues = EnumValues({
  "Alive": Status.ALIVE,
  "Deceased": Status.DECEASED,
  "Presumed dead": Status.PRESUMED_DEAD,
  "Unknown": Status.UNKNOWN
});

class EnumValues<T> {
  Map<String, T> map;
  Map<T, String>? reverseMap;

  EnumValues(this.map);

  Map<T, String>? get reverse {
    if (reverseMap == null) {
      reverseMap = map.map((k, v) => new MapEntry(v, k));
    }
    return reverseMap;
  }
}
