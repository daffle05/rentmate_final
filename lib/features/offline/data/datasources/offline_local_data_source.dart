import '../models/offline_tenant_model.dart';
import '../models/offline_payment_model.dart';
import '../models/dashboard_summary_model.dart';

abstract class OfflineLocalDataSource {
  // TENANTS
  Future<void> saveTenant(OfflineTenantModel tenant);
  Future<List<OfflineTenantModel>> getAllTenants();

  // PAYMENTS
  Future<void> savePayment(OfflinePaymentModel payment);
  Future<List<OfflinePaymentModel>> getPaymentsForTenant(String tenantId);

  // NEW — Dashboard Summary
  Future<DashboardSummaryModel> getDashboardSummary();
}
