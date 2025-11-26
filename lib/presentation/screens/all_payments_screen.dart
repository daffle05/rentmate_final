import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '/features/payment/presentation/providers/payment_providers.dart';
import '/presentation/providers/tenant_providers.dart';

class AllPaymentsScreen extends ConsumerWidget {
  const AllPaymentsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final paymentState = ref.watch(paymentControllerProvider);
    final tenantState = ref.watch(tenantControllerProvider);

    // Load data initially
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (paymentState.payments.isEmpty && !paymentState.isLoading) {
        ref.read(paymentControllerProvider.notifier).loadAllPayments();
      }
      if (tenantState.tenants.isEmpty && !tenantState.isLoading) {
        ref.read(tenantControllerProvider.notifier).loadTenants();
      }
    });

    // Create a map of tenantId -> tenantName for easy lookup
    final tenantMap = <String, String>{};
    for (var tenant in tenantState.tenants) {
      tenantMap[tenant.id] = tenant.name;
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('All Payments'),
      ),
      body: paymentState.isLoading
          ? const Center(child: CircularProgressIndicator())
          : paymentState.payments.isEmpty
              ? const Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.payment_outlined, size: 64, color: Colors.grey),
                      SizedBox(height: 16),
                      Text('No payments recorded yet.'),
                    ],
                  ),
                )
              : ListView.builder(
                  padding: const EdgeInsets.all(12.0),
                  itemCount: paymentState.payments.length,
                  itemBuilder: (context, index) {
                    final payment = paymentState.payments[index];
                    final tenantName = tenantMap[payment.tenantId] ?? 'Unknown Tenant';

                    return Card(
                      margin: const EdgeInsets.symmetric(vertical: 8.0),
                      child: ListTile(
                        leading: const Icon(Icons.receipt),
                        title: Text('$tenantName - ₱${payment.amount}'),
                        subtitle: Text(
                          'Time: ${payment.month} | Date: ${payment.date.toString().split(' ')[0]}',
                        ),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            // Toggle paid/unpaid
                            IconButton(
                              tooltip: payment.isPaid ? 'Mark as unpaid' : 'Mark as paid',
                              icon: Icon(
                                payment.isPaid ? Icons.undo : Icons.check_circle,
                                color: payment.isPaid ? Colors.orange : Colors.green,
                              ),
                              onPressed: () async {
                                final controller = ref.read(paymentControllerProvider.notifier);
                                payment.isPaid = !payment.isPaid;
                                await controller.updatePayment(payment);
                                // refresh full list after toggle
                                await ref.read(paymentControllerProvider.notifier).loadAllPayments();
                              },
                            ),
                            // Delete payment
                            IconButton(
                              tooltip: 'Delete payment',
                              icon: const Icon(Icons.delete, color: Colors.redAccent),
                              onPressed: () async {
                                final confirm = await showDialog<bool>(
                                  context: context,
                                  builder: (ctx) => AlertDialog(
                                    title: const Text('Delete payment'),
                                    content: const Text('Are you sure you want to delete this payment?'),
                                    actions: [
                                      TextButton(
                                        onPressed: () => Navigator.of(ctx).pop(false),
                                        child: const Text('Cancel'),
                                      ),
                                      TextButton(
                                        onPressed: () => Navigator.of(ctx).pop(true),
                                        child: const Text('Delete'),
                                      ),
                                    ],
                                  ),
                                );

                                if (confirm == true) {
                                  final controller = ref.read(paymentControllerProvider.notifier);
                                  await controller.deletePayment(payment.id, payment.tenantId);
                                  // refresh full list after deletion
                                  await ref.read(paymentControllerProvider.notifier).loadAllPayments();
                                }
                              },
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
    );
  }
}
