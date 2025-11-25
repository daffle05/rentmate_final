// lib/core/database/hive_adapters.dart

import 'package:hive/hive.dart';

import '../../features/tenant/data/models/tenant_model.dart';
import '../../features/payment/data/models/payment_model.dart';
// Add more model imports here as new features are introduced.

/// Centralized Hive typeId definitions.
/// Each model must have a UNIQUE typeId.
class HiveTypeIds {
  static const int tenant = 0;
  static const int payment = 1;

  // Add future IDs here:
  // static const int dashboard = 2;
}

Future<void> registerHiveAdapters() async {
  // Register TenantModel
  if (!Hive.isAdapterRegistered(HiveTypeIds.tenant)) {
    Hive.registerAdapter(TenantModelAdapter());
  }

  // Register PaymentModel
  if (!Hive.isAdapterRegistered(HiveTypeIds.payment)) {
    Hive.registerAdapter(PaymentModelAdapter());
  }

  // Register future models here:
  // if (!Hive.isAdapterRegistered(HiveTypeIds.dashboard)) {
  //   Hive.registerAdapter(DashboardModelAdapter());
  // }
}
