library result;

import 'package:flutter/widgets.dart';

typedef SuccessHandler<T, R> = R Function(T value);
typedef ErrorHandler<R> = R Function(Exception exception);

@immutable
class Result<T> {

  const Result.success(this.value) : exception = null;

  const Result.error(this.exception) : value = null;

  final T? value;

  final Exception? exception;
}

extension ResultExtensions <T> on Result<T> {

  bool get isError => exception != null;

  bool get isSuccessful => value != null;

  Result<T> onSuccess(SuccessHandler<T, void> handle) {
    var val = value;
    if (val != null) {
      handle(val);
    }
    return this;
  }

  Result<T> onError(ErrorHandler<void> handle) {
    var ex = exception;
    if (ex != null) {
      handle(ex);
    }
    return this;
  }
  
  R reduce<R>({
    required SuccessHandler<T, R> onSuccess,
    required ErrorHandler<R> onError
  }) {
    var val = value;
    var ex = exception;
    if (val != null) {
      return onSuccess(val);
    } else {
      return onError(ex!);
    }
  }

  /// Transform the result into another result type.
  Result<R> map<R>(R Function(T value) transform) {
    var val = value;
    if (val != null) {
      return Result.success(transform(val));
    } else {
      return Result.error(exception!);
    }
  }
}