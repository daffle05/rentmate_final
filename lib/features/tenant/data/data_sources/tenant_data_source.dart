import '../models/tenant_model.dart';

abstract class TenantDataSource {
  Future<void> addTenant(TenantModel tenant);
  Future<void> updateTenant(TenantModel tenant);
  Future<void> deleteTenant(String tenantId);
  Future<List<TenantModel>> getAllTenants();
  Future<TenantModel?> getTenantById(String tenantId);
}
