import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:kitx_mobile/pages/controls/group_divider.dart';

void main() {
  testWidgets('GroupDivider renders a divider', (WidgetTester tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          body: GroupDivider(duration: 0),
        ),
      ),
    );

    expect(find.byType(GroupDivider), findsOneWidget);
    expect(find.byType(Divider), findsOneWidget);
  });

  testWidgets('GroupDivider lays out without overflow', (WidgetTester tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          body: SingleChildScrollView(
            child: GroupDivider(duration: 0, height: 10, width: 10),
          ),
        ),
      ),
    );

    await tester.pumpAndSettle();

    expect(tester.takeException(), isNull);
  });
}
