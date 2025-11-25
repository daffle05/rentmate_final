import 'package:dartz/dartz.dart';
import '../../../../core/failures/failure.dart';
import '../models/payment_model.dart';

abstract class PaymentRepository {
  Future<Either<Failure, void>> addPayment(PaymentModel payment);
  Future<Either<Failure, void>> updatePayment(PaymentModel payment);
  Future<Either<Failure, void>> deletePayment(String paymentId);
  Future<Either<Failure, List<PaymentModel>>> getPaymentsByTenant(String tenantId);
  Future<Either<Failure, PaymentModel?>> getPaymentById(String paymentId);
}
