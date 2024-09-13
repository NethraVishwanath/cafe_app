import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:provider/provider.dart';
import 'package:cafe_project/screens/home/widget/cart_item_provider.dart';
import 'package:cafe_project/screens/home/widget/favouriteprovider.dart';
import 'package:cafe_project/screens/home/widget/favouriteprovider2.dart';
import 'package:cafe_project/screens/home/widget/favouritesprovider3.dart';
import 'app.dart';
import 'data/repositories.authentication/authentication_repository.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  ).then((FirebaseApp value) => Get.put(AuthenticationRepository()));

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => CartItemProvider()),
        // ... other providers ...

        ChangeNotifierProvider(create: (context) => FavoritesProvider()),
        ChangeNotifierProvider(create: (context) => FavoritesProvider2()),
        ChangeNotifierProvider(create: (context) => FavoritesProvider3()),
      ],
      child: GetMaterialApp(
        debugShowCheckedModeBanner: false,
        home: const MyApp(),
      ),
    ),
  );
}
