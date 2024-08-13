import 'dart:async';

final class EventBusController {
  final StreamController _streamController = StreamController.broadcast();

  EventBusController._internal();

  static final EventBusController _singleton = EventBusController._internal();

  factory EventBusController() => _singleton;

  Stream<T> on<T>() => T == dynamic
      ? _streamController.stream as Stream<T>
      : _streamController.stream.where((event) => event is T).cast<T>();

  void emit<T>(T event) => _streamController.add(event);

  void destroy() => _streamController.close();
}
