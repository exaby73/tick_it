sealed class Either<L, R> {
  const Either();

  bool get isRight {
    return switch (this) {
      Right() => true,
      Left() => false,
    };
  }

  bool get isLeft => !isRight;

  R get rightOrThrow {
    return switch (this) {
      Right(value: final value) => value,
      Left() => throw StateError('Either is not Right'),
    };
  }

  L get leftOrThrow {
    return switch (this) {
      Left(value: final value) => value,
      Right() => throw StateError('Either is not Left'),
    };
  }

  Either<L, R2> map<R2>(R2 Function(R r) f) {
    return switch (this) {
      Right(value: final value) => Right(f(value)),
      Left(value: final value) => Left(value),
    };
  }
}

class Left<L, R> extends Either<L, R> {
  final L value;

  const Left(this.value);
}

class Right<L, R> extends Either<L, R> {
  final R value;

  const Right(this.value);
}
