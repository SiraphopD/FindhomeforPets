// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class MatchModel {
  final String petname;
  final String Image;
  final String petID;
  final String status;
  MatchModel({
    required this.petname,
    required this.Image,
    required this.petID,
    required this.status,
  });

  MatchModel copyWith({
    String? petname,
    String? Image,
    String? petID,
    String? status,
  }) {
    return MatchModel(
      petname: petname ?? this.petname,
      Image: Image ?? this.Image,
      petID: petID ?? this.petID,
      status: status ?? this.status,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'petname': petname,
      'Image': Image,
      'petID': petID,
      'status': status,
    };
  }

  factory MatchModel.fromMap(Map<String, dynamic> map) {
    return MatchModel(
      petname: map['petname'] as String,
      Image: map['Image'] as String,
      petID: map['petID'] as String,
      status: map['status'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory MatchModel.fromJson(String source) =>
      MatchModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'PetModel( petname: $petname, Image: $Image,petID: $petID,status:$status)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is MatchModel &&
        other.petname == petname &&
        other.Image == Image &&
        other.petID == petID &&
        other.status == status;
  }

  @override
  int get hashCode {
    return petname.hashCode ^ Image.hashCode ^ petID.hashCode ^ status.hashCode;
  }
}
