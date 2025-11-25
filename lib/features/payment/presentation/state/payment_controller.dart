import 'package:flutter_riverpod/legacy.dart';
import '../../data/models/payment_model.dart';
import '../../data/repositories/payment_repository.dart';
import 'payment_state.dart';

class PaymentController extends StateNotifier<PaymentState> {
  final PaymentRepository repository;

  PaymentController(this.repository) : super(PaymentState.initial());

  Future<void> loadPaymentsByTenant(String tenantId) async {
    state = state.copyWith(isLoading: true);
    final result = await repository.getPaymentsByTenant(tenantId);
    result.fold(
      (failure) {
        state = state.copyWith (
          isLoading: false,
          errorMessage: failure.message,
        );
      },
      (payments) {
        state = state.copyWith(
          payments: payments,
          isLoading: false,
          errorMessage: null,
        );
      },
    );
  }

  Future<void> addPayment(PaymentModel payment) async {
    final result = await repository.addPayment(payment);
    result.fold(
      (failure) {
        state = state.copyWith(errorMessage: failure.message);
      },
      (_) {
        // Reload payments after adding
        loadPaymentsByTenant(payment.tenantId);
      },
    );
  }

  Future<void> updatePayment(PaymentModel payment) async {
    final result = await repository.updatePayment(payment);
    result.fold(
      (failure) {
        state = state.copyWith(errorMessage: failure.message);
      },
      (_) {
        // Reload payments after updating
        loadPaymentsByTenant(payment.tenantId);
      },
    );
  }

  Future<void> deletePayment(String paymentId, String tenantId) async {
    final result = await repository.deletePayment(paymentId);
    result.fold(
      (failure) {
        state = state.copyWith(errorMessage: failure.message);
      },
      (_) {
        // Reload payments after deleting
        loadPaymentsByTenant(tenantId);
      },
    );
  }
}
