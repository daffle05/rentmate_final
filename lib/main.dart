import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rentmate_final/presentation/root_navigation_screen.dart';
import 'hive_adapters.dart';
import '/shared/themes/theme.dart';
import '/features/tenant/data/models/tenant_model.dart';
import '/features/payment/data/models/payment_model.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Hive
  await Hive.initFlutter();

  // Register all Hive adapters (Tenant + Payment)
  await registerHiveAdapters();

  // Open Hive boxes
  await Hive.openBox<TenantModel>('tenants');
  await Hive.openBox<PaymentModel>('payments');

  // Run the app with Riverpod ProviderScope
  runApp(
    const ProviderScope(
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'RentMate',
      theme: AppTheme.lightTheme,
      home: const RootNavigationScreen(),
    );
  }
}
