import 'package:get_it/get_it.dart';

final sl = GetIt.instance; // Service locator

void init() {
  // Di sini Anda dapat menambahkan dependency injection di masa depan.
  // Contoh:
  // sl.registerLazySingleton<SomeService>(() => SomeServiceImpl());
}
