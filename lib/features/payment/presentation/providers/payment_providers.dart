import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:hive/hive.dart';
import '../../data/models/payment_model.dart';
import '../../data/repositories/payment_repository_impl.dart';
import '../../data/data_sources/payment_data_source_impl.dart';
import '../state/payment_state.dart';
import '../state/payment_controller.dart';

// Providers for data layer
final paymentDataSourceProvider = Provider((ref) {
  final paymentBox = Hive.box<PaymentModel>('payments');
  return PaymentDataSourceImpl(paymentBox);
});

final paymentRepositoryProvider = Provider((ref) {
  final dataSource = ref.watch(paymentDataSourceProvider);
  return PaymentRepositoryImpl(dataSource);
});

// State management provider
final paymentControllerProvider =
    StateNotifierProvider<PaymentController, PaymentState>((ref) {
  final repository = ref.watch(paymentRepositoryProvider);
  return PaymentController(repository);
});
