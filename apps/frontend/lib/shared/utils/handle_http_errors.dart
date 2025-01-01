import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:frontend/shared/either.dart';
import 'package:frontend/shared/failure.dart';

typedef Runner<T> = Future<T> Function();

Future<Either<Failure, T>> handleDioErrors<T>(Runner<T> runner) async {
  try {
    final result = await runner();
    return Right(result);
  } on DioException catch (e, s) {
    if (kDebugMode) {
      debugPrint('$e\n$s');
    }

    final DioException(:type, :response) = e;
    return switch (type) {
      DioExceptionType.connectionTimeout => const Left(NetworkFailure()),
      DioExceptionType.sendTimeout => const Left(NetworkFailure()),
      DioExceptionType.receiveTimeout => const Left(NetworkFailure()),
      DioExceptionType.connectionError => const Left(NetworkFailure()),
      DioExceptionType.cancel => const Left(UserCancelledFailure()),
      DioExceptionType.badCertificate =>
      const Left(ServerFailure('Bad certificate')),
      DioExceptionType.unknown => const Left(UnknownFailure()),
      DioExceptionType.badResponse => _handleBadRequest(response!),
    };
  } catch (e, s) {
    if (kDebugMode) {
      debugPrint('$e\n$s');
    }

    return const Left(UnknownFailure());
  }
}

Either<Failure, T> _handleBadRequest<T>(Response response) {
  final Response(:statusCode, :data) = response;

  if (statusCode == 401) {
    return const Left(UnauthorizedFailure());
  }

  if (statusCode == 403) {
    return const Left(ForbiddenFailure());
  }

  if (data case {'message': final String message}) {
    return Left(BadRequestFailure(message));
  }

  return const Left(UnknownFailure());
}
