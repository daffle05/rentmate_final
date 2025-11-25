import '/features/tenant/data/models/tenant_model.dart';

class TenantState {
  final List<TenantModel> tenants;
  final bool isLoading;
  final String? errorMessage;

  const TenantState({
    required this.tenants,
    required this.isLoading,
    this.errorMessage,
  });

  factory TenantState.initial() => const TenantState(
        tenants: [],
        isLoading: false,
        errorMessage: null,
      );

  TenantState copyWith({
    List<TenantModel>? tenants,
    bool? isLoading,
    String? errorMessage,
  }) {
    return TenantState(
      tenants: tenants ?? this.tenants,
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage,
    );
  }
}
