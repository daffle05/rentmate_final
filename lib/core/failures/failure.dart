// lib/core/error/failure.dart

/// Base class for all Failures
abstract class Failure {
  final String message;

  const Failure(this.message);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Failure &&
          runtimeType == other.runtimeType &&
          message == other.message;

  @override
  int get hashCode => message.hashCode;

  @override
  String toString() => '$runtimeType: $message';
}

/// Database-related failure (e.g., Hive read/write errors)
class DatabaseFailure extends Failure {
  const DatabaseFailure(String message) : super(message);
}

/// Failure when requested data is not found
class NotFoundFailure extends Failure {
  const NotFoundFailure(String message) : super(message);
}

/// Generic unexpected failure
class UnknownFailure extends Failure {
  const UnknownFailure(String message) : super(message);
}
