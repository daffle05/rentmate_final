import 'package:hive/hive.dart';
import '/features/tenant/data/models/tenant_model.dart';

Future<void> registerHiveAdapters() async {
  if (!Hive.isAdapterRegistered(0)) {
    Hive.registerAdapter(TenantModelAdapter());
  }
}
