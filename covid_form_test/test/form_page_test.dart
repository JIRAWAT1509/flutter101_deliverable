import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:covid_form/main.dart';
import 'package:covid_form/viewmodels/form_viewmodel.dart';

void main() {
  group('FormPage Widget Tests', () {
    testWidgets('Find form elements', (WidgetTester tester) async {
      await tester.pumpWidget(
        MultiProvider(
          providers: [ChangeNotifierProvider(create: (_) => FormViewModel())],
          child: const MyApp(),
        ),
      );

      expect(find.byKey(Key('form-page-tag')), findsOneWidget);
      expect(find.byKey(Key('firstname-tag')), findsOneWidget);
      expect(find.byKey(Key('lastname-tag')), findsOneWidget);
      expect(find.byKey(Key('nickname-tag')), findsOneWidget);
      expect(find.byKey(Key('age-tag')), findsOneWidget);
      expect(find.byKey(Key('male-tag')), findsOneWidget);
      expect(find.byKey(Key('female-tag')), findsOneWidget);
      expect(find.byKey(Key('syntom-one-tag')), findsOneWidget);
      expect(find.byKey(Key('syntom-two-tag')), findsOneWidget);
      expect(find.byKey(Key('syntom-three-tag')), findsOneWidget);
      expect(find.byKey(Key('syntom-four-tag')), findsOneWidget);
      expect(find.byKey(Key('save-button-tag')), findsOneWidget);
    });

    testWidgets('Fill form and submit', (WidgetTester tester) async {
      await tester.pumpWidget(
        MultiProvider(
          providers: [ChangeNotifierProvider(create: (_) => FormViewModel())],
          child: const MyApp(),
        ),
      );

      await tester.enterText(find.byKey(Key('firstname-tag')), 'ปอนด์');
      await tester.enterText(find.byKey(Key('lastname-tag')), 'สุดหล่อ');
      await tester.enterText(find.byKey(Key('nickname-tag')), 'เทพค้างคาว');
      await tester.enterText(find.byKey(Key('age-tag')), '21');
      await tester.tap(find.byKey(Key('male-tag')));
      await tester.tap(find.byKey(Key('syntom-one-tag')));
      await tester.tap(find.byKey(Key('syntom-two-tag')));
      await tester.pump();

      await tester.tap(find.byKey(Key('save-button-tag')));
      await tester.pump();
    });
  });
}
