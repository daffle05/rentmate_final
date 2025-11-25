import 'package:hive/hive.dart';
import '/features/dashboard/data/models/dashboard_summary_model.dart';
import '../../../tenant/data/models/tenant_model.dart';
import '../../../payment/data/models/payment_model.dart';
import '/core/failures/failure.dart';
import 'dashboard_data_source.dart';

class DashboardDataSourceImpl implements DashboardDataSource {
  final Box<TenantModel> tenantBox;
  final Box<PaymentModel> paymentBox;

  DashboardDataSourceImpl({
    required this.tenantBox,
    required this.paymentBox,
  });

  @override
  Future<DashboardSummaryModel> getDashboardSummary() async {
    try {
      final tenants = tenantBox.values.toList();
      final payments = paymentBox.values.toList();

      final totalTenants = tenants.length;
      final totalPaid = payments.where((p) => p.isPaid).length;
      final totalUnpaid = payments.where((p) => !p.isPaid).length;

      final now = DateTime.now();
      final totalOverdue = payments
          .where((p) => !p.isPaid && p.dueDate.isBefore(now))
          .length;

      return DashboardSummaryModel(
        totalTenants: totalTenants,
        totalPaid: totalPaid,
        totalUnpaid: totalUnpaid,
        totalOverdue: totalOverdue,
      );
    } catch (e) {
      throw Failure(e.toString());
    }
  }

  @override
  Future<List<TenantModel>> getFilteredTenants(String filter) async {
    try {
      final tenants = tenantBox.values.toList();
      final payments = paymentBox.values.toList();

      switch (filter) {
        case "paid":
          return tenants.where((t) =>
              payments.any((p) => p.tenantId == t.id && p.isPaid)).toList();

        case "unpaid":
          return tenants.where((t) =>
              payments.any((p) => p.tenantId == t.id && !p.isPaid)).toList();

        case "overdue":
          final now = DateTime.now();
          return tenants.where((t) => payments.any((p) =>
              p.tenantId == t.id &&
              !p.isPaid &&
              p.dueDate.isBefore(now))).toList();

        default:
          return tenants;
      }
    } catch (e) {
      throw Failure(e.toString());
    }
  }
}
