abstract interface class ILocalStorage<T> {
  Future<void> initialize();
  void delete({required String key});
  Map<String, dynamic> getMap({required String key});
  List<T> getList({required String key});
  void saveList({required String key, required List<T> data});
  void saveMap({required String key, required Map<String, dynamic> data});
}
