/// Base class for all Failures
class Failure {
  final String message;

  const Failure(this.message);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Failure && other.message == message;

  @override
  int get hashCode => message.hashCode;
}

/// Database-related failure (e.g., Hive read/write errors)
class DatabaseFailure extends Failure {
  const DatabaseFailure(super.message);
}

/// Failure when requested data is not found
class NotFoundFailure extends Failure {
  const NotFoundFailure(super.message);
}

/// Generic unexpected failure
class UnknownFailure extends Failure {
  const UnknownFailure(super.message);
}
