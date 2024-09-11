// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

class ChatModel {
  final String chatID;
  final String peerID;
  final String toPathImage;
  final String toname;
  final String lasttime;
  final String lastmessage;
  final String type;

  ChatModel({
    required this.chatID,
    required this.peerID,
    required this.toPathImage,
    required this.toname,
    required this.lasttime,
    required this.lastmessage,
    required this.type,
  });

  ChatModel copyWith({
    String? chatID,
    String? peerID,
    String? toPathImage,
    String? toname,
    String? lasttime,
    String? lastmessage,
    String? type,
  }) {
    return ChatModel(
      chatID: chatID ?? this.chatID,
      peerID: peerID ?? this.peerID,
      toPathImage: toPathImage ?? this.toPathImage,
      toname: toname ?? this.toname,
      lasttime: lasttime ?? this.lasttime,
      lastmessage: lastmessage ?? this.lastmessage,
      type: type ?? this.type,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'chatID': chatID,
      'peerID': peerID,
      'toPathImage': toPathImage,
      'toname': toname,
      'lasttime': lasttime,
      'lastmessage': lastmessage,
      'type': type,
    };
  }

  factory ChatModel.fromMap(Map<String, dynamic> map) {
    return ChatModel(
      chatID: map['chatID'] as String,
      peerID: map['peerID'] as String,
      toPathImage: map['toPathImage'] as String,
      toname: map['toname'] as String,
      lasttime: map['lasttime'] as String,
      lastmessage: map['lastmessage'] as String,
      type: map['type'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  // factory ChatModel.fromJson(String source) =>
  //     ChatModel.fromMap(json.decode(source) as Map<String, dynamic>);
  factory ChatModel.fromJson(QueryDocumentSnapshot<Map<String, dynamic>> map) {
    return ChatModel(
      chatID: map['chatID'],
      peerID: map['peerID'],
      toPathImage: map['toPathImage'],
      toname: map['toname'],
      lasttime: map['lasttime'],
      lastmessage: map['lastmessage'],
      type: map['type'],
    );
  }
  @override
  String toString() {
    return 'ChatModel(chatID: $chatID, peerID: $peerID, toPathImage: $toPathImage, toname: $toname,lasttime: $lasttime,lastmessage: $lastmessage,type: $type)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is ChatModel &&
        other.chatID == chatID &&
        other.peerID == peerID &&
        other.toPathImage == toPathImage &&
        other.toname == toname &&
        other.lasttime == lasttime &&
        other.lastmessage == lastmessage &&
        other.type == type;
  }

  @override
  int get hashCode {
    return chatID.hashCode ^
        peerID.hashCode ^
        toPathImage.hashCode ^
        toname.hashCode ^
        lasttime.hashCode ^
        lastmessage.hashCode ^
        type.hashCode;
  }
}
