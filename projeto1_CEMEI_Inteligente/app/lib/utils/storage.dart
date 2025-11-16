import 'package:flutter_secure_storage/flutter_secure_storage.dart';

const _storage = FlutterSecureStorage();

Future<String?> get(String key) async => _storage.read(key: key);
void set(String key, String value) async =>
    _storage.write(key: key, value: value);

Future<void> remove(String key) async => _storage.delete(key: key);

// final GetStorage storage = GetStorage('Preferences');



// void _delete(String key) => storage.remove(key);

// set host(String? url) => _set('hostUrl', url);


// String? get apiBaseUrl => host == null ? null : '$host/api';

// String get apiVersion => 'v6';

// set apiToken(String? token) =>
//     token == null ? _delete('apiToken') : _set('apiToken', token);

// set audioToken(String? token) =>
//     token == null ? _delete('audioToken') : _set('audioToken', token);

// set transcoding(bool t) => _set('transcoding', t);

// String? get apiToken => _get<String>('apiToken');

// String? get audioToken => _get<String>('audioToken');

// bool get transcoding => _get<bool>('transcoding') ?? false;

// set userEmail(String? email) => _set('email', email);

// String? get userEmail => _get<String>('email');

// set repeatMode(AudioServiceRepeatMode mode) => _set('repeatMode', mode.name);

// AudioServiceRepeatMode get repeatMode {
//   String name = _get('repeatMode') ?? AudioServiceRepeatMode.none.name;

//   return AudioServiceRepeatMode.values.firstWhere(
//     (e) => e.toString().split('.').last == name,
//     orElse: () => AudioServiceRepeatMode.none,
//   );
// }

// set volume(double volume) => _set('volume', volume);

// double get volume => _get<double>('volume') ?? 0.7;
