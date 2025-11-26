import 'package:dartz/dartz.dart';
import 'payment_repository.dart';
import '../data_sources/payment_data_source.dart';
import '../models/payment_model.dart';
import '../../../../core/failures/failure.dart';

class PaymentRepositoryImpl implements PaymentRepository {
  final PaymentDataSource dataSource;

  PaymentRepositoryImpl(this.dataSource);

  @override
  Future<Either<Failure, void>> addPayment(PaymentModel payment) async {
    try {
      await dataSource.addPayment(payment);
      return const Right(null);
    } catch (e) {
      return Left(UnknownFailure('Failed to add payment: $e'));
    }
  }

  @override
  Future<Either<Failure, void>> updatePayment(PaymentModel payment) async {
    try {
      await dataSource.updatePayment(payment);
      return const Right(null);
    } catch (e) {
      return Left(UnknownFailure('Failed to update payment: $e'));
    }
  }

  @override
  Future<Either<Failure, void>> deletePayment(String paymentId) async {
    try {
      await dataSource.deletePayment(paymentId);
      return const Right(null);
    } catch (e) {
      return Left(UnknownFailure('Failed to delete payment: $e'));
    }
  }

  @override
  Future<Either<Failure, List<PaymentModel>>> getPaymentsByTenant(String tenantId) async {
    try {
      final list = await dataSource.getPaymentsByTenant(tenantId);
      return Right(list);
    } catch (e) {
      return Left(UnknownFailure('Failed to fetch payments: $e'));
    }
  }

  @override
  Future<Either<Failure, PaymentModel?>> getPaymentById(String paymentId) async {
    try {
      final payment = await dataSource.getPaymentById(paymentId);
      return Right(payment);
    } catch (e) {
      return Left(UnknownFailure('Failed to fetch payment: $e'));
    }
  }

  @override
  Future<Either<Failure, List<PaymentModel>>> getAllPayments() async {
    try {
      final list = await dataSource.getAllPayments();
      return Right(list);
    } catch (e) {
      return Left(UnknownFailure('Failed to fetch all payments: $e'));
    }
  }
}
