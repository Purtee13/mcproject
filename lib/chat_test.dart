import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'chat_module/singleMessage.dart';

void main() {
  testWidgets('SingleMessage UI Test', (WidgetTester tester) async {
    // Build our widget and trigger a frame.
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: SingleMessage(
            message: 'Test Message',
            isMe: true,
            image: 'image_url',
            type: 'text',
            friendName: 'Friend',
            myName: 'Me',
            date: Timestamp.now(), // Provide a Timestamp instance here
          ),
        ),
      ),
    );

    // Verify that the text 'Test Message' is present.
    expect(find.text('Test Message'), findsOneWidget);

    // Verify that the 'Friend' text is present.
    //expect(find.text('Friend'), findsOneWidget);

    // Verify that the 'Me' text is present.
    expect(find.text('Me'), findsOneWidget);
  });
}
