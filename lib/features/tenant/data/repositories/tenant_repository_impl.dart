import 'package:dartz/dartz.dart';
import 'tenant_repository.dart';
import '../data_sources/tenant_data_source.dart';
import '../models/tenant_model.dart';
import '/core/failures/failure.dart';

class TenantRepositoryImpl implements TenantRepository {
  final TenantDataSource dataSource;

  TenantRepositoryImpl(this.dataSource);

  @override
  Future<Either<Failure, void>> addTenant(TenantModel tenant) async {
    try {
      await dataSource.addTenant(tenant);
      return const Right(null);
    } catch (e) {
      return Left(Failure('Failed to add tenant: $e'));
    }
  }

  @override
  Future<Either<Failure, void>> updateTenant(TenantModel tenant) async {
    try {
      await dataSource.updateTenant(tenant);
      return const Right(null);
    } catch (e) {
      return Left(Failure('Failed to update tenant: $e'));
    }
  }

  @override
  Future<Either<Failure, void>> deleteTenant(String tenantId) async {
    try {
      await dataSource.deleteTenant(tenantId);
      return const Right(null);
    } catch (e) {
      return Left(Failure('Failed to delete tenant: $e'));
    }
  }

  @override
  Future<Either<Failure, List<TenantModel>>> getAllTenants() async {
    try {
      final tenants = await dataSource.getAllTenants();
      return Right(tenants);
    } catch (e) {
      return Left(Failure('Failed to fetch tenants: $e'));
    }
  }

  @override
  Future<Either<Failure, TenantModel?>> getTenantById(String tenantId) async {
    try {
      final tenant = await dataSource.getTenantById(tenantId);
      return Right(tenant);
    } catch (e) {
      return Left(Failure('Failed to fetch tenant: $e'));
    }
  }
}
