import 'package:hive/hive.dart';
import 'features/tenant/data/models/tenant_model.dart';
import 'features/payment/data/models/payment_model.dart';

Future<void> registerHiveAdapters() async {
  if (!Hive.isAdapterRegistered(0)) {
    Hive.registerAdapter(TenantModelAdapter());
  }
  if (!Hive.isAdapterRegistered(1)) {
    Hive.registerAdapter(PaymentModelAdapter());
  }
}
