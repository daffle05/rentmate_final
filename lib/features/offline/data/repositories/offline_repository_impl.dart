import 'package:dartz/dartz.dart';

import '../../../../core/failures/failure.dart';
import '../datasources/offline_local_data_source.dart';
import '../models/offline_tenant_model.dart';
import '../models/offline_payment_model.dart';
import '../models/dashboard_summary_model.dart';
import 'offline_repository.dart';

class OfflineRepositoryImpl implements OfflineRepository {
  final OfflineLocalDataSource dataSource;

  OfflineRepositoryImpl({required this.dataSource});

  @override
  Future<Either<Failure, void>> saveTenant(OfflineTenantModel tenant) async {
    try {
      await dataSource.saveTenant(tenant);
      return const Right(null);
    } catch (e) {
      return Left(UnknownFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<OfflineTenantModel>>> getAllTenants() async {
    try {
      final tenants = await dataSource.getAllTenants();
      return Right(tenants);
    } catch (e) {
      return Left(UnknownFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> savePayment(OfflinePaymentModel payment) async {
    try {
      await dataSource.savePayment(payment);
      return const Right(null);
    } catch (e) {
      return Left(UnknownFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<OfflinePaymentModel>>> getPaymentsForTenant(String tenantId) async {
    try {
      final payments = await dataSource.getPaymentsForTenant(tenantId);
      return Right(payments);
    } catch (e) {
      return Left(UnknownFailure(e.toString()));
    }
  }

  /// NEW — Dashboard summary
  @override
  Future<Either<Failure, DashboardSummaryModel>> getDashboardSummary() async {
    try {
      final summary = await dataSource.getDashboardSummary();
      return Right(summary);
    } catch (e) {
      return Left(UnknownFailure(e.toString()));
    }
  }
}
