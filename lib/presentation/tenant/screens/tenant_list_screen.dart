import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../shared/themes/theme.dart';
import '/presentation/providers/tenant_providers.dart'; // <-- import the provider
import 'add_tenant_screen.dart';
import '../widgets/tenant_card.dart';

class TenantListScreen extends ConsumerWidget {
  const TenantListScreen({super.key}); // <-- use super.key

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tenantState = ref.watch(tenantControllerProvider);
    final tenantController = ref.read(tenantControllerProvider.notifier);

    // Load tenants initially
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (tenantState.tenants.isEmpty && !tenantState.isLoading) {
        tenantController.loadTenants();
      }
    });

    return Scaffold(
      appBar: AppBar(
        title: const Text('Tenant List'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: tenantState.isLoading
            ? const Center(child: CircularProgressIndicator())
            : tenantState.tenants.isEmpty
                ? const Center(child: Text('No tenants added yet.'))
                : ListView.builder(
                    itemCount: tenantState.tenants.length,
                    itemBuilder: (context, index) {
                      final tenant = tenantState.tenants[index];
                      return TenantCard(
                        tenant: tenant,
                        onDelete: () => tenantController.deleteTenant(tenant.id),
                      );
                    },
                  ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppTheme.primaryColor,
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const AddTenantScreen()),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
