import '/features/dashboard/data/models/dashboard_summary_model.dart';
import '../../../tenant/data/models/tenant_model.dart';

abstract class DashboardDataSource {
  Future<DashboardSummaryModel> getDashboardSummary();

  /// Filter options: "all", "paid", "unpaid", "overdue"
  Future<List<TenantModel>> getFilteredTenants(String filter);
}
