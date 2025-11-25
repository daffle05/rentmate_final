import 'package:flutter_riverpod/legacy.dart';
import '/features/tenant/data/models/tenant_model.dart';
import '/features/tenant/data/repositories/tenant_repository.dart';
import '/presentation/state/tenant_state.dart';

class TenantController extends StateNotifier<TenantState> {
  final TenantRepository repository;

  TenantController(this.repository) : super(TenantState.initial());

  Future<void> loadTenants() async {
    state = state.copyWith(isLoading: true);

    final result = await repository.getAllTenants();

    result.fold(
      (failure) => state = state.copyWith(
        isLoading: false,
        errorMessage: failure.message,
      ),
      (list) => state = state.copyWith(
        isLoading: false,
        tenants: list,
        errorMessage: null,
      ),
    );
  }

  Future<void> addTenant(TenantModel tenant) async {
    state = state.copyWith(isLoading: true);

    final result = await repository.addTenant(tenant);

    result.fold(
      (failure) {
        state = state.copyWith(
          isLoading: false,
          errorMessage: failure.message,
        );
      },
      (_) async => await loadTenants(),
    );
  }

  Future<void> updateTenant(TenantModel tenant) async {
    state = state.copyWith(isLoading: true);

    final result = await repository.updateTenant(tenant);

    result.fold(
      (failure) {
        state = state.copyWith(
          isLoading: false,
          errorMessage: failure.message,
        );
      },
      (_) async => await loadTenants(),
    );
  }

  Future<void> deleteTenant(String tenantId) async {
    state = state.copyWith(isLoading: true);

    final result = await repository.deleteTenant(tenantId);

    result.fold(
      (failure) {
        state = state.copyWith(
          isLoading: false,
          errorMessage: failure.message,
        );
      },
      (_) async => await loadTenants(),
    );
  }
}
