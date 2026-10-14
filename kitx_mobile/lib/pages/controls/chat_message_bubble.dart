import 'package:flutter/material.dart';
import 'package:kitx_mobile/models/chat_message.dart';

/// A single chat bubble, aligned according to the message author.
class ChatMessageBubble extends StatelessWidget {
  /// Constructor
  const ChatMessageBubble({required this.message, super.key});

  /// The message to render.
  final ChatMessage message;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    final bubbleColor = message.isMine ? colorScheme.primaryContainer : colorScheme.surfaceContainerHighest;
    final contentColor = message.isMine ? colorScheme.onPrimaryContainer : colorScheme.onSurfaceVariant;

    return Align(
      alignment: message.isMine ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        constraints: BoxConstraints(maxWidth: MediaQuery.of(context).size.width * 0.75),
        margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
        decoration: BoxDecoration(
          color: bubbleColor,
          borderRadius: BorderRadius.only(
            topLeft: const Radius.circular(16),
            topRight: const Radius.circular(16),
            bottomLeft: Radius.circular(message.isMine ? 16 : 4),
            bottomRight: Radius.circular(message.isMine ? 4 : 16),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              message.text,
              style: TextStyle(color: contentColor, fontSize: 16),
            ),
            const SizedBox(height: 4),
            Text(
              TimeOfDay.fromDateTime(message.createdAt).format(context),
              style: TextStyle(color: contentColor.withValues(alpha: 0.6), fontSize: 11),
            ),
          ],
        ),
      ),
    );
  }
}
