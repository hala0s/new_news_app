import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:ny_times1/bloc/theme_bloc.dart';
import 'package:ny_times1/screens/homepage.dart';
import 'package:ny_times1/screens/search_screen.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final prefs = await SharedPreferences.getInstance();
  final isDark = prefs.getBool('isDark') ?? false ;
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform );
  // FirebaseMessaging messaging = FirebaseMessaging.instance;


  FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    print('Got a message whilst in the foreground!');
    print('Message data: ${message.data}');

    if (message.notification != null) {
      print('Message also contained a notification: ${message.notification}');
    }

  });

  await Future.delayed(const Duration(seconds: 2));
  FlutterNativeSplash.remove();

  runApp( MyApp(isDark: isDark,));
}


class MyApp extends StatelessWidget  {
  final bool isDark ;
  const MyApp({Key? key, required this.isDark}) : super(key: key);  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        BlocProvider(
          create: (context) => ThemeBloc(),
        ),
      ],
      child: Consumer<ThemeBloc>(
        builder: (context, themeBloc, child) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Flutter Demo',
            theme: ThemeData.light(),
            darkTheme: ThemeData.dark(),
            themeMode: themeBloc.state ? ThemeMode.dark : ThemeMode.light,
            home: HomeScreen(),
          );
        },
      ),
    );
  }
}
