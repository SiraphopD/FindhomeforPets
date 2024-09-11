// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class AdopterModel {
  final String petname;
  final String Image;

  AdopterModel({
    required this.petname,
    required this.Image,
  });

  AdopterModel copyWith({
    String? petname,
    String? Image,
  }) {
    return AdopterModel(
      petname: petname ?? this.petname,
      Image: Image ?? this.Image,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'petname': petname,
      'Image': Image,
    };
  }

  factory AdopterModel.fromMap(Map<String, dynamic> map) {
    return AdopterModel(
      petname: map['petname'] as String,
      Image: map['Image'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory AdopterModel.fromJson(String source) =>
      AdopterModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'PetModel( petname: $petname, Image: $Image,)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is AdopterModel &&
        other.petname == petname &&
        other.Image == Image;
  }

  @override
  int get hashCode {
    return petname.hashCode ^ Image.hashCode;
  }
}
