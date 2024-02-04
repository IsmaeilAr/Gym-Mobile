class ChatMessage {
  final int id;
  final int senderId;
  final int receiverId;
  final String content;
  final bool isSender;
  final String createdAt;

  ChatMessage({
    required this.id,
    required this.senderId,
    required this.receiverId,
    required this.content,
    required this.isSender,
    required this.createdAt,
  });

  factory ChatMessage.fromJson(Map<String, dynamic> json) {
    return ChatMessage(
      id: json['id'] ?? 0,
      senderId: json['sender_id'] ?? 0,
      receiverId: json['receiver_id'] ?? 0,
      content: json['content'] ?? '',
      isSender: json['is_sender'] ?? false,
      createdAt: json['created_at'] ?? '',
    );
  }
}
