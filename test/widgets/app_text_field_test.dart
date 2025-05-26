import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:tourist_app/widgets/app_text_field.dart';

void main() {
  group('AppTextField Widget Tests', () {
    late TextEditingController controller;

    setUp(() {
      controller = TextEditingController();
    });

    tearDown(() {
      controller.dispose();
    });

    testWidgets('should display label and hint correctly', (WidgetTester tester) async {
      const testLabel = 'Email';
      const testHint = 'Enter your email';

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: AppTextField(
              controller: controller,
              label: testLabel,
              hint: testHint,
            ),
          ),
        ),
      );

      expect(find.text(testLabel), findsOneWidget);

      final textField = tester.widget<TextField>(find.byType(TextField));
      expect(textField.decoration?.hintText, equals(testHint));
    });

    testWidgets('should handle text input correctly', (WidgetTester tester) async {
      const inputText = 'test@example.com';

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: AppTextField(
              controller: controller,
              label: 'Email',
            ),
          ),
        ),
      );

      await tester.enterText(find.byType(TextFormField), inputText);
      expect(controller.text, equals(inputText));
    });

    testWidgets('should show/hide password when obscureText is true', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: AppTextField(
              controller: controller,
              label: 'Password',
              obscureText: true,
            ),
          ),
        ),
      );

      final textField = tester.widget<TextField>(find.byType(TextField));
      expect(textField.obscureText, isTrue);

      expect(find.byIcon(Icons.visibility), findsOneWidget);

      await tester.tap(find.byIcon(Icons.visibility));
      await tester.pump();

      final updatedTextField = tester.widget<TextField>(find.byType(TextField));
      expect(updatedTextField.obscureText, isFalse);
      expect(find.byIcon(Icons.visibility_off), findsOneWidget);
    });

    testWidgets('should call validator function', (WidgetTester tester) async {
      bool validatorCalled = false;
      String? validatorResult;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Form(
              child: AppTextField(
                controller: controller,
                label: 'Email',
                validator: (value) {
                  validatorCalled = true;
                  if (value == null || value.isEmpty) {
                    validatorResult = 'Field is required';
                    return validatorResult;
                  }
                  return null;
                },
              ),
            ),
          ),
        ),
      );

      final formState = tester.state<FormState>(find.byType(Form));
      formState.validate();

      expect(validatorCalled, isTrue);
      expect(validatorResult, equals('Field is required'));
    });

    testWidgets('should be disabled when enabled is false', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: AppTextField(
              controller: controller,
              label: 'Email',
              enabled: false,
            ),
          ),
        ),
      );

      final textField = tester.widget<TextField>(find.byType(TextField));
      expect(textField.enabled, isFalse);
    });

    testWidgets('should call onChanged callback', (WidgetTester tester) async {
      String? changedValue;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: AppTextField(
              controller: controller,
              label: 'Email',
              onChanged: (value) {
                changedValue = value;
              },
            ),
          ),
        ),
      );

      const inputText = 'test input';
      await tester.enterText(find.byType(TextFormField), inputText);

      expect(changedValue, equals(inputText));
    });

    testWidgets('should display prefix and suffix widgets', (WidgetTester tester) async {
      const prefixIcon = Icon(Icons.email);
      const suffixIcon = Icon(Icons.clear);

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: AppTextField(
              controller: controller,
              label: 'Email',
              prefix: prefixIcon,
              suffix: suffixIcon,
            ),
          ),
        ),
      );

      expect(find.byIcon(Icons.email), findsOneWidget);
      expect(find.byIcon(Icons.clear), findsOneWidget);
    });
  });
}