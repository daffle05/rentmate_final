import '../../data/models/payment_model.dart';

class PaymentState {
  final List<PaymentModel> payments;
  final bool isLoading;
  final String? errorMessage;

  const PaymentState({
    required this.payments,
    required this.isLoading,
    this.errorMessage,
  });

  factory PaymentState.initial() => const PaymentState(
    payments: [],
    isLoading: false,
    errorMessage: null,
  );

  PaymentState copyWith({
    List<PaymentModel>? payments,
    bool? isLoading,
    String? errorMessage,
  }) {
    return PaymentState(
      payments: payments ?? this.payments,
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage,
    );
  }
}
