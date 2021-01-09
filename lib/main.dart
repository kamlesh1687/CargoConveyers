import 'package:cargoconveyers/UI/Helpers/Theming.dart';
import 'package:cargoconveyers/businessLogics/viewModels/MarketViewModel.dart';

import 'package:flutter/material.dart';

import 'package:firebase_core/firebase_core.dart';

import 'package:load_toast/load_toast.dart';
import 'package:provider/provider.dart';
import 'package:timeago/timeago.dart';
import 'UI/screens/CommonScreen/HomePage/HomePage.dart';
import 'UI/screens/CommonScreen/auth_Screens/SplashScreen.dart';
import 'UI/screens/userScreens/BottomSheet/BottomSheet.dart';
import 'businessLogics/viewModels/ProfileViewMode.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // Create the initialization Future outside of `build`:

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => MarketViewModel(),
        ),
        ChangeNotifierProvider(
          create: (context) => ProfileViewModel(),
        ),
        ChangeNotifierProvider(
          create: (context) => BottomSheetPageBuilder(),
        ),
        ChangeNotifierProvider(
          create: (context) => ThemeProvider(),
        ),
        ChangeNotifierProvider(create: (context) => TabsIndexState())
      ],
      child: Builder(
        builder: (context) {
          Provider.of<ThemeProvider>(context, listen: false).loadColor();
          var _marketData =
              Provider.of<MarketViewModel>(context, listen: false);
          Provider.of<ProfileViewModel>(context, listen: false)
              .loadDataFromSf()
              .then((_user) {
            if (_user != null) {
              if (_user.isShipper) {
                _marketData.getMyLoads(_user.userId);
              } else {
                _marketData.getLoadsFromMarket();
              }
            }
          });
          return Consumer<ThemeProvider>(
            builder: (_, value, __) {
              return LoadToast(
                child: MaterialApp(
                    theme: ThemeData(
                        primaryColor: value.currentColor, fontFamily: 'Ubuntu'),
                    home: Splash()),
              );
            },
          );
        },
      ),
    );
  }
}
