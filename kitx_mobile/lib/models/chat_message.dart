/// A single text message shown on the device chat page.
class ChatMessage {
  /// Constructor
  const ChatMessage({
    required this.id,
    required this.text,
    required this.isMine,
    required this.createdAt,
  });

  /// Unique identifier of this message.
  final String id;

  /// Text body of this message.
  final String text;

  /// Whether the local device sent this message.
  final bool isMine;

  /// Creation time of this message.
  final DateTime createdAt;
}
