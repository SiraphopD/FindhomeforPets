// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class PetModel {
  final String pettype;
  final String petname;
  final String petgender;
  final String petcolor;
  final String breed;
  final String more_info;
  final String PathImage;
  final String uid;
  final String age;
  final String vaccine;
  final String petID;
  final String province;
  PetModel({
    required this.pettype,
    required this.petname,
    required this.petgender,
    required this.petcolor,
    required this.breed,
    required this.more_info,
    required this.PathImage,
    required this.uid,
    required this.age,
    required this.vaccine,
    required this.petID,
    required this.province,
  });

  PetModel copyWith({
    String? pettype,
    String? petname,
    String? petgender,
    String? petcolor,
    String? breed,
    String? more_info,
    String? PathImage,
    String? uid,
    String? age,
    String? vaccine,
    String? petID,
    String? province,
  }) {
    return PetModel(
      pettype: pettype ?? this.pettype,
      petname: petname ?? this.petname,
      petgender: petgender ?? this.petgender,
      petcolor: petcolor ?? this.petcolor,
      breed: breed ?? this.breed,
      more_info: more_info ?? this.more_info,
      PathImage: PathImage ?? this.PathImage,
      uid: uid ?? this.uid,
      age: age ?? this.age,
      vaccine: vaccine ?? this.vaccine,
      petID: petID ?? this.petID,
      province: province ?? this.province,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'pettype': pettype,
      'petname': petname,
      'petgender': petgender,
      'petcolor': petcolor,
      'breed': breed,
      'more_info': more_info,
      'PathImage': PathImage,
      'uid': uid,
      'age': age,
      'vaccine': vaccine,
      'petID': petID,
      'province': province,
    };
  }

  factory PetModel.fromMap(Map<String, dynamic> map) {
    return PetModel(
      pettype: map['pettype'] as String,
      petname: map['petname'] as String,
      petgender: map['petgender'] as String,
      petcolor: map['petcolor'] as String,
      breed: map['breed'] as String,
      more_info: map['more_info'] as String,
      PathImage: map['PathImage'] as String,
      uid: map['uid'] as String,
      age: map['age'] as String,
      vaccine: map['vaccine'] as String,
      petID: map['petID'] as String,
      province: map['province'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory PetModel.fromJson(String source) =>
      PetModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'PetModel(pettype: $pettype, petname: $petname, petgender: $petgender, petcolor: $petcolor, breed: $breed, more_info: $more_info, PathImage: $PathImage,uid: $uid,age: $age,vaccine: $vaccine,petID: $petID,province: $province)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is PetModel &&
        other.pettype == pettype &&
        other.petname == petname &&
        other.petgender == petgender &&
        other.petcolor == petcolor &&
        other.breed == breed &&
        other.more_info == more_info &&
        other.PathImage == PathImage &&
        other.uid == uid &&
        other.age == age &&
        other.vaccine == vaccine &&
        other.petID == petID &&
        other.province == province;
  }

  @override
  int get hashCode {
    return pettype.hashCode ^
        petname.hashCode ^
        petgender.hashCode ^
        petcolor.hashCode ^
        breed.hashCode ^
        more_info.hashCode ^
        PathImage.hashCode ^
        uid.hashCode ^
        age.hashCode ^
        vaccine.hashCode ^
        petID.hashCode ^
        province.hashCode;
  }
}
