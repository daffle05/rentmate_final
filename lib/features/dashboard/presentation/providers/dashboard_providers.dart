import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import '/presentation/providers/tenant_providers.dart';
import '/features/dashboard/data/data_sources/dashboard_data_source.dart';
import '/features/dashboard/data/data_sources/dashboard_data_source_impl.dart';
import '/features/dashboard/data/repositories/dashboard_repository.dart';
import '/features/dashboard/data/repositories/dashboard_repository_impl.dart';
import '../controllers/dashboard_controller.dart';
import '../state/dashboard_state.dart';


/// 1️⃣ Hive Boxes (use shared providers)
// `tenantBoxProvider` and `paymentBoxProvider` are provided from
// `lib/presentation/providers/tenant_providers.dart`.

/// 2️⃣ Data Source Provider
final dashboardDataSourceProvider = Provider<DashboardDataSource>((ref) {
  final tenantBox = ref.read(tenantBoxProvider);
  final paymentBox = ref.read(paymentBoxProvider);
  return DashboardDataSourceImpl(tenantBox: tenantBox, paymentBox: paymentBox);
});

/// 3️⃣ Repository Provider
final dashboardRepositoryProvider = Provider<DashboardRepository>((ref) {
  final dataSource = ref.read(dashboardDataSourceProvider);
  return DashboardRepositoryImpl(dataSource);
});

/// 4️⃣ Controller Provider
final dashboardControllerProvider =
    StateNotifierProvider<DashboardController, DashboardState>((ref) {
  final repository = ref.read(dashboardRepositoryProvider);
  return DashboardController(repository: repository);
});
