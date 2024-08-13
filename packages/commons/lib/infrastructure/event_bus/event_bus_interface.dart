abstract interface class IVentBus {
  Stream<T> on<T>();
  void emit<T>(T event);
  destroy();
}
