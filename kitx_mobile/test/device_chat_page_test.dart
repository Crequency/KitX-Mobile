import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:kitx_mobile/pages/sub_pages/device_chat_page.dart';
import 'package:kitx_mobile/utils/translation/translation.dart';

Future<void> pumpChatPage(WidgetTester tester) async {
  await tester.pumpWidget(
    GetMaterialApp(
      translations: Translation(),
      locale: const Locale('zh', 'CN'),
      home: const DeviceChatPage(),
    ),
  );
  await tester.pumpAndSettle();
}

void main() {
  testWidgets('starts with the empty hint', (WidgetTester tester) async {
    await pumpChatPage(tester);

    expect(find.text('还没有消息'), findsOneWidget);
  });

  testWidgets('sends a message and renders it as a bubble', (WidgetTester tester) async {
    await pumpChatPage(tester);

    await tester.enterText(find.byType(TextField), 'hello kitx');
    await tester.tap(find.byIcon(Icons.send_rounded));
    await tester.pumpAndSettle();

    expect(find.text('hello kitx'), findsOneWidget);
    expect(find.text('还没有消息'), findsNothing);
  });

  testWidgets('clears the input after sending', (WidgetTester tester) async {
    await pumpChatPage(tester);

    await tester.enterText(find.byType(TextField), 'hello');
    await tester.tap(find.byIcon(Icons.send_rounded));
    await tester.pumpAndSettle();

    final field = tester.widget<TextField>(find.byType(TextField));

    expect(field.controller?.text, isEmpty);
  });

  testWidgets('ignores blank input', (WidgetTester tester) async {
    await pumpChatPage(tester);

    await tester.enterText(find.byType(TextField), '   ');
    await tester.tap(find.byIcon(Icons.send_rounded));
    await tester.pumpAndSettle();

    expect(find.text('还没有消息'), findsOneWidget);
  });

  testWidgets('keeps several messages in the order they were sent', (WidgetTester tester) async {
    await pumpChatPage(tester);

    for (final text in ['first', 'second']) {
      await tester.enterText(find.byType(TextField), text);
      await tester.tap(find.byIcon(Icons.send_rounded));
      await tester.pumpAndSettle();
    }

    expect(find.text('first'), findsOneWidget);
    expect(find.text('second'), findsOneWidget);
    expect(find.text('还没有消息'), findsNothing);
  });
}
