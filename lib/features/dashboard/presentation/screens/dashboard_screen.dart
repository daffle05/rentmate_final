import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/models/dashboard_summary_model.dart';
import '../providers/dashboard_providers.dart';
import '../../../tenant/data/models/tenant_model.dart';

class DashboardScreen extends ConsumerStatefulWidget {
  const DashboardScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends ConsumerState<DashboardScreen> {
  String selectedFilter = "all";

  @override
  void initState() {
    super.initState();
    // Load initial data
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(dashboardControllerProvider.notifier).loadDashboard();
      ref.read(dashboardControllerProvider.notifier).loadFilteredTenants(selectedFilter);
    });
  }

  void _onFilterSelected(String filter) {
    setState(() {
      selectedFilter = filter;
    });
    ref.read(dashboardControllerProvider.notifier).loadFilteredTenants(filter);
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(dashboardControllerProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Dashboard Overview'),
      ),
      body: state.isLoading
          ? const Center(child: CircularProgressIndicator())
          : state.errorMessage != null
              ? Center(child: Text(state.errorMessage!))
              : SingleChildScrollView(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildSummaryCards(state.summary),
                      const SizedBox(height: 20),
                      _buildFilterChips(),
                      const SizedBox(height: 20),
                      _buildTenantList(state.filteredTenants),
                    ],
                  ),
                ),
    );
  }

  Widget _buildSummaryCards(DashboardSummaryModel? summary) {
    if (summary == null) {
      return const SizedBox.shrink();
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _buildSummaryCard('Total Tenants', summary.totalTenants, AppColors.primary),
        _buildSummaryCard('Paid', summary.totalPaid, AppColors.success),
        _buildSummaryCard('Unpaid', summary.totalUnpaid, AppColors.warning),
        _buildSummaryCard('Overdue', summary.totalOverdue, AppColors.error),
      ],
    );
  }

  Widget _buildSummaryCard(String title, int value, Color color) {
    return Expanded(
      child: Card(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
          child: Column(
            children: [
              Text(title, style: AppTextStyles.subtitle),
              const SizedBox(height: 8),
              Text(
                value.toString(),
                style: AppTextStyles.headline,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFilterChips() {
    final filters = ['all', 'paid', 'unpaid', 'overdue'];

    return Wrap(
      spacing: 8,
      children: filters.map((filter) {
        final isSelected = selectedFilter == filter;
        return ChoiceChip(
          label: Text(filter.toUpperCase()),
          selected: isSelected,
          onSelected: (_) => _onFilterSelected(filter),
          selectedColor: AppColors.primary,
          backgroundColor: AppColors.background,
          labelStyle: isSelected
              ? AppTextStyles.chipSelected
              : AppTextStyles.chipUnselected,
        );
      }).toList(),
    );
  }

  Widget _buildTenantList(List<TenantModel> tenants) {
    if (tenants.isEmpty) {
      return const Center(child: Text('No tenants found.'));
    }

    return ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: tenants.length,
      separatorBuilder: (_, __) => const SizedBox(height: 8),
      itemBuilder: (context, index) {
        final tenant = tenants[index];
        return Card(
          child: ListTile(
            title: Text(tenant.name),
            subtitle: Text('Room: ${tenant.roomNumber} | Rent: ${tenant.rentAmount}'),
            trailing: const Icon(Icons.chevron_right),
            onTap: () {
              // Navigate to tenant payment record screen
              // For now, show a placeholder snackbar
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Open payment record for ${tenant.name}')),
              );
            },
          ),
        );
      },
    );
  }
}

class AppColors {
  static const Color background = Color(0xFFF5F5F5);
  static const Color primary = Color(0xFF1E88E5);
  static const Color success = Color(0xFF4CAF50);
  static const Color error = Color(0xFFF44336);
  static const Color warning = Color(0xFFFFC107);
}



class AppTextStyles {
  static var chipUnselected;
  
  static var chipSelected;
  
  static var subtitle;
  
  static var headline;
}
