import '../../../tenant/data/models/tenant_model.dart';
import '../../data/models/dashboard_summary_model.dart';

class DashboardState {
  final bool isLoading;
  final DashboardSummaryModel? summary;
  final List<TenantModel> filteredTenants;
  final String? errorMessage;

  DashboardState({
    required this.isLoading,
    required this.filteredTenants,
    this.summary,
    this.errorMessage,
  });

  factory DashboardState.initial() {
    return DashboardState(
      isLoading: false,
      filteredTenants: [],
      summary: null,
      errorMessage: null,
    );
  }

  DashboardState copyWith({
    bool? isLoading,
    DashboardSummaryModel? summary,
    List<TenantModel>? filteredTenants,
    String? errorMessage,
  }) {
    return DashboardState(
      isLoading: isLoading ?? this.isLoading,
      summary: summary ?? this.summary,
      filteredTenants: filteredTenants ?? this.filteredTenants,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}
