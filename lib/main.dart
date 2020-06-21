import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';

import 'core/deeplink/deeplink_parser.dart';
import 'core/deeplink/deeplink_provider.dart';
import 'core/firebase_service.dart';
import 'core/provider/account_provider.dart';
import 'generated/l10n.dart';
import 'page/friend/friend_page.dart';
import 'page/login/login_page.dart';
import 'page/profile/profile_page.dart';
import 'page/turnip/prediction/turnip_prediction_page.dart';
import 'page/turnip/turnip_page.dart';

void main() => runApp(AcnhApp());

class AcnhApp extends StatelessWidget {
  final _navigatorKey = GlobalKey<NavigatorState>();
  final _routeMapping = {
    TurnipHomePage.routeName: TurnipHomePage(),
    ProfilePage.routeName: ProfilePage(),
    TurnipPredictionPage.routeName: TurnipPredictionPage(),
    FriendPage.routeName: FriendPage(),
  };

  @override
  Widget build(BuildContext context) {
    FirebaseService.instance.setup();

    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AccountProvider()),
        if (!kIsWeb)
          Provider(
            create: (context) => DeeplinkProvider(_navigatorKey)..initUniLink(),
            dispose: (context, provider) => provider.dispose(),
            // no other page will use DeeplinkProvider,
            // need set lazy to false to make sure it will init
            lazy: false,
          )
      ],
      child: MaterialApp(
        localizationsDelegates: [
          S.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate
        ],
        navigatorKey: _navigatorKey,
        supportedLocales: S.delegate.supportedLocales,
        title: 'Animal crossing',
        // TODO: Move theme to separate file
        theme: ThemeData(
          cardTheme: CardTheme(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          buttonColor: Color.fromARGB(255, 102, 184, 136),
          primarySwatch: Colors.green,
          primaryColorDark: Color.fromARGB(255, 0, 125, 117),
          backgroundColor: Color.fromARGB(255, 240, 255, 245),
          primaryTextTheme: TextTheme(
            subtitle2: TextStyle(
              color: Color.fromARGB(255, 0, 125, 117),
              fontWeight: FontWeight.bold,
            ),
          ),
          visualDensity: VisualDensity.adaptivePlatformDensity,
          inputDecorationTheme: InputDecorationTheme(
            filled: true,
            fillColor: Color.fromARGB(255, 248, 244, 199),
            border: OutlineInputBorder(
              borderSide: const BorderSide(
                color: Color.fromARGB(255, 255, 235, 84),
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: const BorderSide(
                color: Color.fromARGB(255, 255, 235, 84),
              ),
            ),
          ),
        ),
        onGenerateRoute: _generateRoute,
        onGenerateInitialRoutes: _generateInitialRoute,
      ),
    );
  }

  List<Route<dynamic>> _generateInitialRoute(String initialRouteName) {
    final defaultRouteSetting = RouteSettings(name: initialRouteName);
    if (kIsWeb) {
      var uri = Uri.parse(initialRouteName);
      var routeSetting = parseDeeplink(uri) ?? defaultRouteSetting;
      return [_generateRoute(routeSetting)];
    } else {
      return [_generateRoute(defaultRouteSetting)];
    }
  }

  MaterialPageRoute _generateRoute(RouteSettings settings) {
    return MaterialPageRoute(
      maintainState: false,
      builder: (context) {
        final accountProvider = context.watch<AccountProvider>();
        if (accountProvider.isLoading) {
          return SplashScreen();
        }

        if (accountProvider.currentUser == null) {
          return LoginPage();
        }

        return _routeMapping[settings?.name] ?? TurnipHomePage();
      },
      settings: settings,
    );
  }
}

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      color: theme.backgroundColor,
      child: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
