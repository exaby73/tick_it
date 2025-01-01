sealed class Failure {
  const Failure();

  String get messageOrDefault {
    return switch (this) {
      UnauthorizedFailure() => 'Unauthorized',
      ForbiddenFailure() => 'Forbidden',
      BadRequestFailure(message: final message) => message,
      UserCancelledFailure() => 'Cancelled by user',
      NetworkFailure() => 'No internet connection',
      ServerFailure(message: final message) => message,
      UnknownFailure() => 'Something went wrong',
    };
  }

  factory Failure.fromJson(Map<String, dynamic> json) {
    return switch (json['type'] as String) {
      'UnauthorizedFailure' => const UnauthorizedFailure(),
      'ForbiddenFailure' => const ForbiddenFailure(),
      'BadRequestFailure' => BadRequestFailure(json['message'] as String),
      'UserCancelledFailure' => const UserCancelledFailure(),
      'NetworkFailure' => const NetworkFailure(),
      'ServerFailure' => ServerFailure(json['message'] as String),
      'UnknownFailure' => const UnknownFailure(),
      _ => throw Exception('Unknown failure type: ${json['type']}'),
    };
  }

  Map<String, dynamic> toJson() {
    return {
      'type': switch (this) {
        UnauthorizedFailure() => 'UnauthorizedFailure',
        ForbiddenFailure() => 'ForbiddenFailure',
        BadRequestFailure() => 'BadRequestFailure',
        UserCancelledFailure() => 'UserCancelledFailure',
        NetworkFailure() => 'NetworkFailure',
        ServerFailure() => 'ServerFailure',
        UnknownFailure() => 'UnknownFailure',
      },
      'message': messageOrDefault,
    };
  }
}

class UnauthorizedFailure extends Failure {
  const UnauthorizedFailure();
}

class ForbiddenFailure extends Failure {
  const ForbiddenFailure();
}

class BadRequestFailure extends Failure {
  final String message;

  const BadRequestFailure(this.message);
}

class UserCancelledFailure extends Failure {
  const UserCancelledFailure();
}

class NetworkFailure extends Failure {
  const NetworkFailure();
}

class ServerFailure extends Failure {
  final String message;

  const ServerFailure([this.message = 'Something went wrong']);
}

class UnknownFailure extends Failure {
  const UnknownFailure();
}
