// lib/main.dart
import 'package:dwarka_app/features/auth/signin_screen.dart';
import 'package:dwarka_app/features/auth/signup_screen.dart';
import 'package:dwarka_app/features/tabs/bottom_navbar.dart';
import 'package:dwarka_app/providers/cart_provider.dart';

import 'features/theme/theme.dart';
import 'features/theme/theme_provider.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'screens/splash_screen.dart';


void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => CartProvider()),

        ChangeNotifierProvider(create: (_) => ThemeProvider()),

      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});


  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    return MaterialApp(
      title: 'Dwarka Opticals',
      debugShowCheckedModeBanner: false,
      theme: lightTheme,
      darkTheme: darkTheme,
      themeMode: themeProvider.themeMode,
      initialRoute: '/',
      routes: {
        '/': (context) => const SplashScreen(),
        '/signin': (context) => const SigninScreen(),
        '/signup': (context) => const SignupScreen(),
        '/home': (context) => const BottomNavbar(),
      },


    );

  }
}
