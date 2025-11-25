

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
}

/// For database errors (e.g., Hive read/write failure)
class DatabaseFailure extends Failure {
  const DatabaseFailure(String message) : super(message);
}

/// For when requested data does not exist
class NotFoundFailure extends Failure {
  const NotFoundFailure(String message) : super(message);
}

/// For anything unexpected
class UnknownFailure extends Failure {
  const UnknownFailure(String message) : super(message);
}
