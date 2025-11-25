import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:hive/hive.dart';
import '/features/tenant/data/models/tenant_model.dart';
import '/features/tenant/data/data_sources/tenant_data_source.dart';
import '/features/tenant/data/data_sources/tenant_data_source_impl.dart';
import '/features/tenant/data/repositories/tenant_repository.dart';
import '/features/tenant/data/repositories/tenant_repository_impl.dart';
import '../state/tenant_controller.dart';
import '../state/tenant_state.dart';


// =========================
//   HIVE BOX PROVIDER
// =========================
final tenantBoxProvider = Provider<Box<TenantModel>>((ref) {
  return Hive.box<TenantModel>('tenants');
});

// =========================
//   DATA SOURCE PROVIDER
// =========================
final tenantDataSourceProvider = Provider<TenantDataSource>((ref) {
  final box = ref.watch(tenantBoxProvider);
  return TenantDataSourceImpl(box);
});

// =========================
//   REPOSITORY PROVIDER
// =========================
final tenantRepositoryProvider = Provider<TenantRepository>((ref) {
  final dataSource = ref.watch(tenantDataSourceProvider);
  return TenantRepositoryImpl(dataSource);
});

// =========================
//   CONTROLLER PROVIDER
// =========================
final tenantControllerProvider =
    StateNotifierProvider<TenantController, TenantState>((ref) {
  final repository = ref.watch(tenantRepositoryProvider);
  return TenantController(repository);
});

