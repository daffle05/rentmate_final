import 'package:hive/hive.dart';
import '../../../tenant/data/models/tenant_model.dart';
import '../../../payment/data/models/payment_model.dart';
import '../models/dashboard_summary_model.dart';
import 'dashboard_data_source.dart';

/// Concrete Data Source Implementation
class DashboardDataSourceImpl implements DashboardDataSource {
  final Box<TenantModel> tenantBox;
  final Box<PaymentModel> paymentBox;

  DashboardDataSourceImpl({
    required this.tenantBox,
    required this.paymentBox,
  });

  @override
  Future<DashboardSummaryModel> getDashboardSummary() async {
    final tenants = tenantBox.values.toList();
    final payments = paymentBox.values.toList();

    return DashboardSummaryModel(
      totalTenants: tenants.length,
      totalPaid: payments.where((p) => p.isPaid).length,
      totalUnpaid: payments.where((p) => !p.isPaid).length,
      totalOverdue:
          payments.where((p) => !p.isPaid && p.dueDate.isBefore(DateTime.now())).length,
    );
  }

  @override
  Future<List<TenantModel>> getFilteredTenants(String filter) async {
    final tenants = tenantBox.values.toList();
    final payments = paymentBox.values.toList();

    switch (filter) {
      case 'paid':
        return tenants.where((t) => payments.any((p) => p.tenantId == t.id && p.isPaid)).toList();
      case 'unpaid':
        return tenants.where((t) => payments.any((p) => p.tenantId == t.id && !p.isPaid)).toList();
      case 'overdue':
        final now = DateTime.now();
        return tenants
            .where((t) => payments.any((p) => p.tenantId == t.id && !p.isPaid && p.dueDate.isBefore(now)))
            .toList();
      default:
        return tenants;
    }
  }
}
