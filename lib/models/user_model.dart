// ignore_for_file: unnecessary_null_comparison, null_check_always_fails

import 'dart:convert';

class UserModel {
  late final String name;
  // final String surname;
  final String gender;
  final String phonenum;
  // final String housenumber;
  // final String street;
  // final String district;
  // final String subdistrict;
  final String province;
  final String introduce;
  // final String postcode;
  final String PathImage;
  late final String pushToken;
  UserModel({
    required this.name,
    // required this.surname,
    required this.gender,
    required this.phonenum,
    // required this.housenumber,
    // required this.street,
    // required this.district,
    // required this.subdistrict,
    required this.province,
    required this.introduce,
    // required this.postcode,
    required this.PathImage,
    required this.pushToken,
  });

  UserModel copyWith({
    String? name,
    // String? surname,
    String? gender,
    String? phonenum,
    // String? housenumber,
    // String? street,
    // String? district,
    // String? subdistrict,
    String? province,
    String? introduce,
    // String? postcode,
    String? PathImage,
    String? pushToken,
  }) {
    return UserModel(
      name: name ?? this.name,
      // surname: surname ?? this.surname,
      gender: gender ?? this.gender,
      phonenum: phonenum ?? this.phonenum,
      // housenumber: housenumber ?? this.housenumber,
      // street: street ?? this.street,
      // district: district ?? this.district,
      // subdistrict: subdistrict ?? this.subdistrict,
      province: province ?? this.province,
      // postcode: postcode ?? this.postcode,
      introduce: introduce ?? this.introduce,
      PathImage: PathImage ?? this.PathImage,
      pushToken: pushToken ?? this.pushToken,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      // 'surname': surname,
      'gender': gender,
      'phonenum': phonenum,
      // 'housenumber': housenumber,
      // 'street': street,
      // 'district': district,
      // 'subdistrict': subdistrict,
      'province': province,
      // 'postcode': postcode,
      'introduce': introduce,
      'PathImage': PathImage, 'pushToken': pushToken,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    if (map == null) return null!;

    return UserModel(
      name: map['name'],
      // surname: map['surname'],
      gender: map['gender'],
      phonenum: map['phonenum'],
      // housenumber: map['housenumber'],
      // street: map['street'],
      // district: map['district'],
      // subdistrict: map['subdistrict'],
      province: map['province'],
      // postcode: map['postcode'],
      introduce: map['introduce'],
      PathImage: map['PathImage'], pushToken: map['pushToken'],
    );
  }
  String toJson() => json.encode(toMap());

  factory UserModel.fromJson(String source) =>
      UserModel.fromMap(json.decode(source));

  @override
  String toString() =>
      'UserModel(name: $name, gender: $gender, phonenum: $phonenum,  province: $province, introduce: $introduce, PathImage: $PathImage,pushToken: $pushToken)';

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is UserModel &&
        o.name == name &&
        o.gender == gender &&
        o.phonenum == phonenum &&
        // o.district == district &&
        // o.subdistrict == subdistrict &&
        o.province == province &&
        o.introduce == introduce &&
        o.PathImage == PathImage &&
        o.pushToken == pushToken;
  }

  @override
  int get hashCode =>
      name.hashCode ^
      gender.hashCode ^
      phonenum.hashCode ^
      // district.hashCode ^
      // subdistrict.hashCode ^
      province.hashCode ^
      introduce.hashCode ^
      PathImage.hashCode ^
      pushToken.hashCode;
}
