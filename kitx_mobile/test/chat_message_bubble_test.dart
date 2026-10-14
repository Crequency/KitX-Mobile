import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:kitx_mobile/models/chat_message.dart';
import 'package:kitx_mobile/pages/controls/chat_message_bubble.dart';
import 'package:kitx_mobile/pages/sub_pages/device_chat_page.dart';

Future<void> pumpBubble(WidgetTester tester, {required bool isMine, String text = 'hello kitx'}) {
  return tester.pumpWidget(
    MaterialApp(
      home: Scaffold(
        body: ChatMessageBubble(
          message: ChatMessage(
            id: 'm1',
            text: text,
            isMine: isMine,
            createdAt: DateTime(2026, 10, 14, 10, 30),
          ),
        ),
      ),
    ),
  );
}

void main() {
  group('ChatMessageBubble', () {
    testWidgets('renders the message text', (WidgetTester tester) async {
      await pumpBubble(tester, isMine: true);

      expect(find.text('hello kitx'), findsOneWidget);
    });

    testWidgets('aligns own messages to the right', (WidgetTester tester) async {
      await pumpBubble(tester, isMine: true);

      final align = tester.widget<Align>(
        find.descendant(of: find.byType(ChatMessageBubble), matching: find.byType(Align)),
      );

      expect(align.alignment, Alignment.centerRight);
    });

    testWidgets('aligns peer messages to the left', (WidgetTester tester) async {
      await pumpBubble(tester, isMine: false);

      final align = tester.widget<Align>(
        find.descendant(of: find.byType(ChatMessageBubble), matching: find.byType(Align)),
      );

      expect(align.alignment, Alignment.centerLeft);
    });

    testWidgets('keeps long messages inside the bubble width limit', (WidgetTester tester) async {
      await pumpBubble(tester, isMine: true, text: 'x' * 500);

      expect(tester.takeException(), isNull);
    });
  });

  group('randomString', () {
    test('generates unique identifiers', () {
      final ids = List.generate(200, (_) => randomString());

      expect(ids.toSet().length, ids.length);
    });

    test('produces a non empty url safe value', () {
      final id = randomString();

      expect(id, isNotEmpty);
      expect(id, matches(RegExp(r'^[A-Za-z0-9_\-=]+$')));
    });
  });
}
