import 'package:hive/hive.dart';
import 'tenant_data_source.dart';
import '../models/tenant_model.dart';

class TenantDataSourceImpl implements TenantDataSource {
  final Box<TenantModel> tenantBox;

  TenantDataSourceImpl(this.tenantBox);

  @override
  Future<void> addTenant(TenantModel tenant) async {
    await tenantBox.put(tenant.id, tenant);
  }

  @override
  Future<void> updateTenant(TenantModel tenant) async {
    await tenant.save();
  }

  @override
  Future<void> deleteTenant(String tenantId) async {
    await tenantBox.delete(tenantId);
  }

  @override
  Future<List<TenantModel>> getAllTenants() async {
    return tenantBox.values.toList();
  }

  @override
  Future<TenantModel?> getTenantById(String tenantId) async {
    return tenantBox.get(tenantId);
  }
}
