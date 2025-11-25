import 'package:dartz/dartz.dart';
import '../models/tenant_model.dart';
import '/core/failures/failure.dart';

abstract class TenantRepository {
  Future<Either<Failure, void>> addTenant(TenantModel tenant);
  Future<Either<Failure, void>> updateTenant(TenantModel tenant);
  Future<Either<Failure, void>> deleteTenant(String tenantId);
  Future<Either<Failure, List<TenantModel>>> getAllTenants();
  Future<Either<Failure, TenantModel?>> getTenantById(String tenantId);
}
