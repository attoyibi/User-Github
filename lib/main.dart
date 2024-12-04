import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'features/home/presentation/home_screen.dart';
import 'features/profile/presentation/profile_screen.dart'; // Sesuaikan import dengan path project Anda
import 'features/user_detail/presentation/user_detail_screen.dart'; // Sesuaikan import dengan path project Anda
// import 'features/favorite/presentation/favorite_screen.dart'; // Sesuaikan import dengan path project Anda
import 'injection_container.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  init(); // Initialize dependency injection
  runApp(ModularApp(
    module: AppModule(),
    child: MyApp(), // Add the main app widget here
  ));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'GitHub User App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      routeInformationParser: Modular.routeInformationParser,
      routerDelegate: Modular.routerDelegate,
    );
  }
}

class AppModule extends Module {
  @override
  List<ModularRoute> get routes => [
        ChildRoute('/', child: (_, __) => HomeScreen()), // Home route
        // Uncomment the following lines if you have these screens
        ChildRoute('/detail/:username',
            child: (_, args) =>
                UserDetailScreen(username: args.params['username'])),
        ChildRoute('/profile',
            child: (_, __) => ProfileScreen()), // Route for Profile
      ];
}
