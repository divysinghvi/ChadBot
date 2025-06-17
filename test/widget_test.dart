// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:chad_bot/main.dart'; // Ensure this path is correct
import 'package:flutter_gemini_bot/flutter_gemini_bot.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  // Helper function to mock rootBundle.loadString
  void mockAssetBundleLoadString(String path, String response, {bool shouldThrow = false}) {
    ServicesBinding.instance.defaultBinaryMessenger.setMockMessageHandler('flutter/assets', (ByteData? message) async {
      final String incomingPath = utf8.decode(message!.buffer.asUint8List());
      if (incomingPath == path) {
        if (shouldThrow) {
          throw Exception('Mocked error: Failed to load asset');
        }
        return ByteData.view(utf8.encoder.convert(response).buffer);
      }
      return null;
    });
  }

  // Clear mocks after each test
  tearDown(() {
    ServicesBinding.instance.defaultBinaryMessenger.setMockMessageHandler('flutter/assets', null);
  });

  testWidgets('Test Loading State - CircularProgressIndicator is displayed', (WidgetTester tester) async {
    // Mock a delayed response for config.json
    ServicesBinding.instance.defaultBinaryMessenger.setMockMessageHandler('flutter/assets', (ByteData? message) async {
      final String path = utf8.decode(message!.buffer.asUint8List());
      if (path == 'assets/config.json') {
        // Delay the response
        await Future.delayed(const Duration(milliseconds: 100));
        return ByteData.view(utf8.encoder.convert('{"apiKey": "test_api_key"}').buffer);
      }
      return null;
    });

    await tester.pumpWidget(MyApp());

    // Initially, should show loading indicator
    expect(find.byType(CircularProgressIndicator), findsOneWidget);

    // Wait for the future to complete
    await tester.pumpAndSettle();

    // After loading, FlutterGeminiChat should be present
    expect(find.byType(FlutterGeminiChat), findsOneWidget);
  });

  testWidgets('Test Error State - API Key Loading Fails (Exception)', (WidgetTester tester) async {
    // Mock rootBundle.loadString to throw an exception for config.json
    mockAssetBundleLoadString('assets/config.json', '', shouldThrow: true);

    await tester.pumpWidget(MyApp());
    await tester.pumpAndSettle(); // Wait for async operations to complete

    // Verify that an error message is displayed
    expect(find.textContaining('Failed to load API key'), findsOneWidget);
    expect(find.byType(FlutterGeminiChat), findsNothing);
  });

  testWidgets('Test Error State - API Key Loading Fails (Malformed JSON)', (WidgetTester tester) async {
    // Mock rootBundle.loadString to return malformed JSON
    mockAssetBundleLoadString('assets/config.json', '{"apiKey": }'); // Malformed JSON

    await tester.pumpWidget(MyApp());
    await tester.pumpAndSettle(); // Wait for async operations to complete

    // Verify that an error message is displayed (error message might vary based on JSON parsing)
    expect(find.textContaining('Failed to load API key'), findsOneWidget);
    expect(find.byType(FlutterGeminiChat), findsNothing);
  });


  testWidgets('Test Successful State - API Key Loaded and FlutterGeminiChat is displayed', (WidgetTester tester) async {
    // Mock rootBundle.loadString to return a valid API key
    mockAssetBundleLoadString('assets/config.json', '{"apiKey": "test_api_key"}');

    await tester.pumpWidget(MyApp());
    await tester.pumpAndSettle(); // Wait for async operations to complete

    // Verify that FlutterGeminiChat widget is displayed
    expect(find.byType(FlutterGeminiChat), findsOneWidget);

    // Verify that the AppBar title is correct
    expect(find.text('UrbanBuy ChadBot'), findsOneWidget);

    // Verify no error message is shown
    expect(find.textContaining('Failed to load API key'), findsNothing);
    expect(find.text('API Key not found.'), findsNothing);
  });
}
