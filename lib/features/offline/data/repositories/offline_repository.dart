import 'package:dartz/dartz.dart';

import '../../../../core/failures/failure.dart';
import '../models/offline_tenant_model.dart';
import '../models/offline_payment_model.dart';
import '../models/dashboard_summary_model.dart';

abstract class OfflineRepository {
  Future<Either<Failure, void>> saveTenant(OfflineTenantModel tenant);
  Future<Either<Failure, List<OfflineTenantModel>>> getAllTenants();

  Future<Either<Failure, void>> savePayment(OfflinePaymentModel payment);
  Future<Either<Failure, List<OfflinePaymentModel>>> getPaymentsForTenant(String tenantId);

  /// NEW
  Future<Either<Failure, DashboardSummaryModel>> getDashboardSummary();
}
