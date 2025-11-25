import '../models/payment_model.dart';

abstract class PaymentDataSource {
  Future<void> addPayment(PaymentModel payment);
  Future<void> updatePayment(PaymentModel payment);
  Future<void> deletePayment(String paymentId);
  Future<List<PaymentModel>> getPaymentsByTenant(String tenantId);
  Future<PaymentModel?> getPaymentById(String paymentId);
}

// Concrete implementation
class PaymentDataSourceImpl implements PaymentDataSource {
  @override
  Future<void> addPayment(PaymentModel payment) async {
    // implement logic, e.g., Hive box or API
  }

  @override
  Future<void> updatePayment(PaymentModel payment) async {
    // implement logic
  }

  @override
  Future<void> deletePayment(String paymentId) async {
    // implement logic
  }

  @override
  Future<List<PaymentModel>> getPaymentsByTenant(String tenantId) async {
    return []; // implement logic
  }

  @override
  Future<PaymentModel?> getPaymentById(String paymentId) async {
    return null; // implement logic
  }
}
