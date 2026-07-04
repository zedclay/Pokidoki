import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:pokidoki/app/routing/route_names.dart';
import 'package:pokidoki/features/onboarding/presentation/screens/onboarding_flow_screen.dart';
import 'package:pokidoki/features/splash/presentation/screens/splash_screen.dart';

import '../helpers/test_app.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('app opens on the splash route', (tester) async {
    await pumpPokidokiApp(tester);
    await tester.pump();

    expect(find.byType(SplashScreen), findsOneWidget);
    expect(find.byType(NavigationBar), findsNothing);
    expect(find.byType(BottomNavigationBar), findsNothing);
    expect(AppRoutes.splash, '/splash');

    await settleSplashBootstrap(tester);
    await tester.pumpAndSettle();

    expect(find.byType(OnboardingFlowScreen), findsOneWidget);
  });
}
