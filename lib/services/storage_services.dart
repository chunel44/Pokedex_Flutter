import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class StorageServices {
  late final FlutterSecureStorage storage;

  StorageServices() {
    storage = const FlutterSecureStorage();
  }

  Future<String>? getUser() async {
    return await storage.read(key: 'user') ?? '';
  }

  Future<String>? getPage() async {
    return await storage.read(key: 'initScreen') ?? '0';
  }

  Future<void> setPage() async {
    await storage.write(key: 'initScreen', value: '1');
  }

  Future<void> setUser(String name) async {
    await storage.write(key: 'user', value: name);
  }
}
