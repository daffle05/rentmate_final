import 'package:dartz/dartz.dart';

import '../../../../../core/failures/failure.dart';
import '../models/dashboard_summary_model.dart';
import '../../../tenant/data/models/tenant_model.dart';

abstract class DashboardRepository {
  Future<Either<Failure, DashboardSummaryModel>> getDashboardSummary();

  Future<Either<Failure, List<TenantModel>>> getFilteredTenants(
    String filter,
  );
}
