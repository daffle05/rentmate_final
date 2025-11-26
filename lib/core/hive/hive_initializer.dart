import 'package:hive_flutter/hive_flutter.dart';

import '../../features/offline/data/models/offline_tenant_model.dart';
import '../../features/offline/data/models/offline_payment_model.dart';

Future<void> registerHiveAdapters() async {
  if (!Hive.isAdapterRegistered(10)) {
    Hive.registerAdapter(OfflineTenantModelAdapter());
  }
  if (!Hive.isAdapterRegistered(11)) {
    Hive.registerAdapter(OfflinePaymentModelAdapter());
  }

  await Hive.openBox<OfflineTenantModel>('offline_tenants');
  await Hive.openBox<OfflinePaymentModel>('offline_payments');
}
