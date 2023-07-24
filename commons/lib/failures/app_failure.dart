class AppFailure implements Exception {
  AppFailure(this.errorMessage);

  final String errorMessage;
}
