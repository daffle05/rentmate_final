import 'package:flutter/material.dart';
import '/features/tenant/data/models/tenant_model.dart';
import '/features/payment/presentation/screens/payment_history_screen.dart';
import '../../../shared/themes/theme.dart';

class TenantCard extends StatelessWidget {
  final TenantModel tenant;
  final VoidCallback onDelete;

  const TenantCard({super.key, required this.tenant, required this.onDelete});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Text(
          tenant.name,
          style: AppTheme.lightTextTheme.titleLarge,
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Room: ${tenant.roomNumber}', style: AppTheme.lightTextTheme.bodyMedium),
            Text('Rent: ₱${tenant.rentAmount.toStringAsFixed(2)}', style: AppTheme.lightTextTheme.bodyMedium),
            Text('Due Date: ${tenant.dueDate.toLocal().toString().split(' ')[0]}', style: AppTheme.lightTextTheme.bodyMedium),
          ],
        ),
        trailing: SizedBox(
          width: 96,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              IconButton(
                icon: const Icon(Icons.payment, color: Colors.green),
                tooltip: 'Payments',
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => PaymentHistoryScreen(
                        tenantId: tenant.id,
                        tenantName: tenant.name,
                      ),
                    ),
                  );
                },
              ),
              IconButton(
                icon: const Icon(Icons.delete, color: Colors.red),
                onPressed: onDelete,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
