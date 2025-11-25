import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '/shared/themes/theme.dart';
import '../providers/payment_providers.dart';
import '../../data/models/payment_model.dart';
import 'add_payment_screen.dart';

class PaymentHistoryScreen extends ConsumerWidget {
  final String tenantId;
  final String tenantName;

  const PaymentHistoryScreen({
    super.key,
    required this.tenantId,
    required this.tenantName,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final paymentState = ref.watch(paymentControllerProvider);
    final paymentController = ref.read(paymentControllerProvider.notifier);

    // Load payments initially
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (paymentState.payments.isEmpty && !paymentState.isLoading) {
        paymentController.loadPaymentsByTenant(tenantId);
      }
    });

    final tenantPayments = paymentState.payments
        .where((p) => p.tenantId == tenantId)
        .toList();

    return Scaffold(
      appBar: AppBar(
        title: Text('Payments for $tenantName'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: paymentState.isLoading
            ? const Center(child: CircularProgressIndicator())
            : tenantPayments.isEmpty
                ? const Center(child: Text('No payments recorded yet.'))
                : ListView.builder(
                    itemCount: tenantPayments.length,
                    itemBuilder: (context, index) {
                      final payment = tenantPayments[index];
                      return PaymentCard(
                        payment: payment,
                        onDelete: () => paymentController.deletePayment(
                          payment.id,
                          tenantId,
                        ),
                      );
                    },
                  ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppTheme.primaryColor,
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => AddPaymentScreen(tenantId: tenantId),
            ),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}

class PaymentCard extends StatelessWidget {
  final PaymentModel payment;
  final VoidCallback onDelete;

  const PaymentCard({
    super.key,
    required this.payment,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      child: ListTile(
        title: Text('Amount: ${payment.amount}'),
        subtitle: Text('Date: ${payment.date}'),
        trailing: IconButton(
          icon: const Icon(Icons.delete, color: Colors.red),
          onPressed: onDelete,
        ),
      ),
    );
  }
}
