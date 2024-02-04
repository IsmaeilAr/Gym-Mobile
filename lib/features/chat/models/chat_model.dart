// class ChatModel {
//   final int chatParticipantId;
//   final String name;
//   final double rate;
//   final String content;
//   final String chatMessageCreatedAt;
// // todo backend: add user image
//   ChatModel({
//     required this.chatParticipantId,
//     required this.name,
//     required this.rate,
//     required this.content,
//     required this.chatMessageCreatedAt,
//   });
//
//   factory ChatModel.fromJson(Map<String, dynamic> json) {
//     final sid2 = json['sid2'];
//     final latestMessage = sid2['latestMessage'];
//
//     return ChatModel(
//       chatParticipantId: sid2['id'],
//       name: sid2['name'],
//       rate: sid2['rate'],
//       content: latestMessage['content'],
//       chatMessageCreatedAt: latestMessage['created_at'].currentFormatted(),
//     );
//   }
// }


import 'package:gym/features/profile/models/user_model.dart';
import 'package:gym/utils/extensions/time_formatter.dart';

class ChatModel {
  final UserModel sid2;
  final LatestMessage latestMessage;

  ChatModel({
    required this.sid2,
    required this.latestMessage,
  });

  factory ChatModel.fromJson(Map<String, dynamic> json) {
    return ChatModel(
      sid2: UserModel.fromJson(json['sid2']),
      latestMessage: LatestMessage.fromJson(json['latestMessage']),
    );
  }
}


class LatestMessage {
  final int id;
  final String content;
  final int senderId;
  final int receiverId;
  final String createdAt;

  LatestMessage({
    required this.id,
    required this.content,
    required this.senderId,
    required this.receiverId,
    required this.createdAt,
  });

  factory LatestMessage.fromJson(Map<String, dynamic> json) {
    return LatestMessage(
      id: json['id'],
      content: json['content'],
      senderId: json['sender_id'],
      receiverId: json['receiver_id'],
      createdAt: DateTime.parse(json['created_at']).currentFormatted(),
    );
  }
}
