import '../models/payment_model.dart';

abstract class PaymentDataSource {
  Future<void> addPayment(PaymentModel payment);
  Future<void> updatePayment(PaymentModel payment);
  Future<void> deletePayment(String paymentId);
  Future<List<PaymentModel>> getPaymentsByTenant(String tenantId);
  Future<PaymentModel?> getPaymentById(String paymentId);
}
