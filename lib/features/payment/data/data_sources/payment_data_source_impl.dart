import 'package:hive/hive.dart';
import 'payment_data_source.dart';
import '../models/payment_model.dart';

class PaymentDataSourceImpl implements PaymentDataSource {
  final Box<PaymentModel> paymentBox;

  PaymentDataSourceImpl(this.paymentBox);

  @override
  Future<void> addPayment(PaymentModel payment) async {
    await paymentBox.put(payment.id, payment);
  }

  @override
  Future<void> updatePayment(PaymentModel payment) async {
    await payment.save();
  }

  @override
  Future<void> deletePayment(String paymentId) async {
    await paymentBox.delete(paymentId);
  }

  @override
  Future<List<PaymentModel>> getPaymentsByTenant(String tenantId) async {
    return paymentBox.values.where((p) => p.tenantId == tenantId).toList();
  }

  @override
  Future<PaymentModel?> getPaymentById(String paymentId) async {
    return paymentBox.get(paymentId);
  }

  @override
  Future<List<PaymentModel>> getAllPayments() async {
    return paymentBox.values.toList();
  }
}
