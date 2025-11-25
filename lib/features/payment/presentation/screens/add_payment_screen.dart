import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '/shared/themes/theme.dart';
import '../providers/payment_providers.dart';
import '../../data/models/payment_model.dart';

class AddPaymentScreen extends ConsumerStatefulWidget {
  final String tenantId;

  const AddPaymentScreen({
    super.key,
    required this.tenantId,
  });

  @override
  ConsumerState<AddPaymentScreen> createState() => _AddPaymentScreenState();
}

class _AddPaymentScreenState extends ConsumerState<AddPaymentScreen> {
  final amountController = TextEditingController();
  final dateController = TextEditingController();
  final descriptionController = TextEditingController();
  DateTime? selectedDate;
  String? selectedMonth;

  @override
  void dispose() {
    amountController.dispose();
    dateController.dispose();
    descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Payment'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              TextField(
                controller: amountController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: 'Amount',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: dateController,
                readOnly: true,
                decoration: const InputDecoration(
                  labelText: 'Date',
                  border: OutlineInputBorder(),
                ),
                onTap: () async {
                  final picked = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(2020),
                    lastDate: DateTime(2101),
                  );
                  if (picked != null) {
                    selectedDate = picked;
                    dateController.text = picked.toString().split(' ')[0];
                  }
                },
              ),
              const SizedBox(height: 16),
              TextField(
                controller: TextEditingController(
                  text: selectedMonth ?? '',
                ),
                readOnly: true,
                decoration: const InputDecoration(
                  labelText: 'Month (YYYY-MM)',
                  border: OutlineInputBorder(),
                ),
                onTap: () async {
                  final picked = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(2020),
                    lastDate: DateTime(2101),
                  );
                  if (picked != null) {
                    final month = '${picked.year}-${picked.month.toString().padLeft(2, '0')}';
                    setState(() {
                      selectedMonth = month;
                    });
                  }
                },
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppTheme.primaryColor,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 32,
                    vertical: 12,
                  ),
                ),
                onPressed: () async {
                  if (amountController.text.isEmpty ||
                      selectedDate == null ||
                      selectedMonth == null) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Please fill in all required fields.'),
                      ),
                    );
                    return;
                  }

                  final payment = PaymentModel(
                    id: DateTime.now().millisecondsSinceEpoch.toString(),
                    tenantId: widget.tenantId,
                    amount: double.parse(amountController.text),
                    date: selectedDate!,
                    month: selectedMonth!,
                  );

                  final paymentController =
                      ref.read(paymentControllerProvider.notifier);
                  final navigator = Navigator.of(context);
                  await paymentController.addPayment(payment);

                  if (!mounted) return;
                  navigator.pop();
                },
                child: const Text('Add Payment'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
