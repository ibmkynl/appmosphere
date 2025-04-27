import 'package:hive/hive.dart';

class HiveService {
  Future<void> put<T>(String boxName, String key, T value) async {
    final box = await Hive.openBox<T>(boxName);
    await box.put(key, value);
    await box.close();
  }

  Future<T?> get<T>(String boxName, String key) async {
    final box = await Hive.openBox<T>(boxName);
    final value = box.get(key);
    await box.close();
    return value;
  }

  Future<void> clear(String boxName) async {
    final box = await Hive.openBox(boxName);
    await box.clear();
    await box.close();
  }

  Future<void> delete(String boxName, String key) async {
    final box = await Hive.openBox(boxName);
    await box.delete(key);
    await box.close();
  }
}
