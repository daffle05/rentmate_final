import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/legacy.dart';
import '../../data/models/dashboard_summary_model.dart';
import '../../data/repositories/dashboard_repository.dart';
import '../../../tenant/data/models/tenant_model.dart';
import '/core/failures/failure.dart';
import '../state/dashboard_state.dart';

class DashboardController extends StateNotifier<DashboardState> {
  final DashboardRepository repository;

  DashboardController({required this.repository})
      : super(DashboardState.initial()); // Pass initial state

  /// Load dashboard summary
  Future<void> loadDashboard() async {
    state = state.copyWith(isLoading: true, errorMessage: null);

    final Either<Failure, DashboardSummaryModel> summaryResult =
        await repository.getDashboardSummary();

    summaryResult.fold(
      (failure) => state = state.copyWith(
        isLoading: false,
        errorMessage: failure.message, // no need for ??
      ),
      (summary) => state = state.copyWith(
        summary: summary,
        isLoading: false,
        errorMessage: null,
      ),
    );
  }

  /// Load tenants filtered by some criteria
  Future<void> loadFilteredTenants(String filter) async {
    state = state.copyWith(isLoading: true, errorMessage: null);

    final Either<Failure, List<TenantModel>> tenantsResult =
        await repository.getFilteredTenants(filter);

    tenantsResult.fold(
      (failure) => state = state.copyWith(
        isLoading: false,
        errorMessage: failure.message, // no need for ??
      ),
      (tenants) => state = state.copyWith(
        filteredTenants: tenants,
        isLoading: false,
        errorMessage: null,
      ),
    );
  }
}
