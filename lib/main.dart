import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rentmate_final/presentation/tenant/screens/tenant_list_screen.dart';
import 'hive_adapters.dart';
import '/shared/themes/theme.dart';
import '/features/tenant/data/models/tenant_model.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Hive.initFlutter();
  await registerHiveAdapters(); // Make sure your Hive adapters are registered
  await Hive.openBox<TenantModel>('tenants');

  runApp(
    const ProviderScope(
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'RentMate',
      theme: AppTheme.lightTheme,
      home: const TenantListScreen(),
    );
  }
}
