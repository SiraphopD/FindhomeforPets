// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class RequestModel {
  final String Image;
  final String name;
  final String petImage;
  final String petID;
  final String petname;
  final String requestID;
  final String adopterID;

  RequestModel({
    required this.Image,
    required this.name,
    required this.petImage,
    required this.petID,
    required this.petname,
    required this.requestID,
    required this.adopterID,
  });

  RequestModel copyWith({
    String? Image,
    String? name,
    String? petImage,
    String? petID,
    String? petname,
    String? requestID,
    String? adopterID,
  }) {
    return RequestModel(
      Image: Image ?? this.Image,
      name: name ?? this.name,
      petImage: petImage ?? this.petImage,
      petID: petID ?? this.petID,
      petname: petname ?? this.petname,
      requestID: requestID ?? this.requestID,
      adopterID: adopterID ?? this.adopterID,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'chatID': Image,
      'peerID': name,
      'petImage': petImage,
      'petID': petID,
      'toname': petname,
      'requestID': requestID,
      'adopterID': adopterID,
    };
  }

  factory RequestModel.fromMap(Map<String, dynamic> map) {
    return RequestModel(
      Image: map['Image'] as String,
      name: map['name'] as String,
      petImage: map['petImage'] as String,
      petID: map['petID'] as String,
      petname: map['petname'] as String,
      requestID: map['requestID'] as String,
      adopterID: map['adopterID'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory RequestModel.fromJson(String source) =>
      RequestModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'RequestModel(Image: $Image, name: $name, petImage: $petImage, petname: $petname, requestID: $requestID, adopterID: $adopterID, petID: $petID)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is RequestModel &&
        other.Image == Image &&
        other.name == name &&
        other.petImage == petImage &&
        other.petID == petID &&
        other.petname == petname &&
        other.requestID == requestID &&
        other.adopterID == adopterID;
  }

  @override
  int get hashCode {
    return Image.hashCode ^
        name.hashCode ^
        petImage.hashCode ^
        petID.hashCode ^
        petname.hashCode ^
        requestID.hashCode ^
        adopterID.hashCode;
  }
}
