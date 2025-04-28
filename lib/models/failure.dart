import 'package:freezed_annotation/freezed_annotation.dart';

part 'failure.freezed.dart';

@freezed
class Failure with _$Failure {
  const factory Failure.server({
    required String message,
  }) = ServerFailure;

  const factory Failure.network() = NetworkFailure;

  const factory Failure.auth({
    required String message,
  }) = AuthFailure;

  const factory Failure.unexpected() = UnexpectedFailure;
}