// ignore_for_file: prefer_const_constructors

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';


import 'package:zero/controllers/wallet_controller.dart';
import 'package:zero/firebase_options.dart';

import 'package:zero/model/favourite_list_models.dart';
import 'package:zero/model/favourite_page_model.dart';
import 'package:zero/model/itemmodel.dart';

import 'package:zero/pages/Screen/onBoardingScreen.dart';
import 'package:zero/pages/Profile/pointSystem.dart';
import 'package:zero/pages/repository/authentication_repository/authentication_repository.dart';

import 'package:zero/services/notification_service.dart';

import 'package:zero/styles/color.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await NotificationService().initNotification();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  
  

  @override
  Widget build(BuildContext context) {
     //Get.put(AuthenticationRepository());
    Get.put(WalletController());
    return MultiProvider(
      providers: [
        Provider(create: (context) => FavoriteListModel()),
        ChangeNotifierProxyProvider<FavoriteListModel, FavoritePageModel>(
          create: (context) => FavoritePageModel(),
          update: (context, favoritelist, favoritepage) {
            if (favoritepage == null)
              throw ArgumentError.notNull('favoritepage');
            favoritepage.favoritelist = favoritelist;
            return favoritepage;
          },
        ),
        ChangeNotifierProvider(
          create: (context) => ItemModel(),
        ),
        ChangeNotifierProvider(
          create: (context) => PointSystem(), // Add the PointSystem provider here
        ),
        
      ],
      child: GetMaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          scaffoldBackgroundColor: background,
          fontFamily: 'FjallaOne',
          useMaterial3: true,
        ),
        home: OnBoardingScreen(), // Set Screen widget as the home screen
      ),
    );
  }
}
