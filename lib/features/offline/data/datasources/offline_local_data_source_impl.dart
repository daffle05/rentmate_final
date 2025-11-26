import 'package:hive/hive.dart';

import '../models/offline_tenant_model.dart';
import '../models/offline_payment_model.dart';
import '../models/dashboard_summary_model.dart';
import 'offline_local_data_source.dart';

class OfflineLocalDataSourceImpl implements OfflineLocalDataSource {
  final Box<OfflineTenantModel> tenantBox;
  final Box<OfflinePaymentModel> paymentBox;

  OfflineLocalDataSourceImpl({
    required this.tenantBox,
    required this.paymentBox,
  });

  @override
  Future<void> saveTenant(OfflineTenantModel tenant) async {
    await tenantBox.put(tenant.id, tenant);
  }

  @override
  Future<List<OfflineTenantModel>> getAllTenants() async {
    return tenantBox.values.toList();
  }

  @override
  Future<void> savePayment(OfflinePaymentModel payment) async {
    await paymentBox.put(payment.id, payment);
  }

  @override
  Future<List<OfflinePaymentModel>> getPaymentsForTenant(String tenantId) async {
    return paymentBox.values.where((p) => p.tenantId == tenantId).toList();
  }

  /// NEW — Dashboard summary computation
  @override
  Future<DashboardSummaryModel> getDashboardSummary() async {
    final tenants = tenantBox.values.toList();
    final payments = paymentBox.values.toList();

    final totalTenants = tenants.length;

    int paid = 0;
    int unpaid = 0;
    int overdue = 0;

    final now = DateTime.now();
    final currentMonth = now.month;
    final currentMonthStr = currentMonth.toString();

    for (final tenant in tenants) {
      final tenantPayments =
          payments.where((p) => p.tenantId == tenant.id).toList();

        final hasPaidThisMonth =
          tenantPayments.any((p) => p.month == currentMonthStr);

      if (hasPaidThisMonth) {
        paid++;
      } else {
        // `dueDate` is stored as an integer (millisecondsSinceEpoch)
        if (tenant.dueDate < now.millisecondsSinceEpoch) {
          overdue++;
        } else {
          unpaid++;
        }
      }
    }

    return DashboardSummaryModel(
      totalTenants: totalTenants,
      paidCount: paid,
      unpaidCount: unpaid,
      overdueCount: overdue,
    );
  }
}
