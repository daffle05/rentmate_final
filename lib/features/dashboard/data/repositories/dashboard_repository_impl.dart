import 'package:dartz/dartz.dart';
import '/core/failures/failure.dart';
import '../models/dashboard_summary_model.dart';
import '/features/tenant/data/models/tenant_model.dart';
import '../data_sources/dashboard_data_source.dart';
import 'dashboard_repository.dart';

/// Concrete Repository Implementation
class DashboardRepositoryImpl implements DashboardRepository {
  final DashboardDataSource dataSource;

  DashboardRepositoryImpl(this.dataSource);

  @override
  Future<Either<Failure, DashboardSummaryModel>> getDashboardSummary() async {
    try {
      final summary = await dataSource.getDashboardSummary();
      return Right(summary);
    } catch (e) {
      return Left(UnknownFailure('Failed to fetch dashboard summary: $e'));
    }
  }

  @override
  Future<Either<Failure, List<TenantModel>>> getFilteredTenants(String filter) async {
    try {
      final tenants = await dataSource.getFilteredTenants(filter);
      return Right(tenants);
    } catch (e) {
      return Left(UnknownFailure('Failed to fetch filtered tenants: $e'));
    }
  }
}
