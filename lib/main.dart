import 'package:dwarka_app/providers/cart_provider.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'features/auth/landing_screen.dart';
import 'features/auth/signin_screen.dart';
import 'features/auth/signup_screen.dart';
import 'features/auth/otp_verification_screen.dart';
import 'features/tabs/bottom_navbar.dart';
import 'features/tabs/home_tab/all_category_list.dart';
import 'features/tabs/home_tab/category_details.dart';
import 'features/tabs/home_tab/product_screen.dart';
import 'features/tabs/cart_tab/cart_screen.dart';
import 'features/tabs/profile_tab/prescription_screen.dart';
import 'features/tabs/profile_tab/profile_screen.dart';
import 'screens/splash_screen.dart';
import 'features/theme/theme_provider.dart';
import 'features/tabs/profile_tab/orders_screen.dart';
import 'features/tabs/profile_tab/wishlist_screen.dart';
import 'features/tabs/profile_tab/addresses_screen.dart';
import 'features/tabs/profile_tab/add_address_screen.dart';
import 'features/tabs/profile_tab/help_screen.dart';
import 'features/tabs/profile_tab/about_screen.dart';
import 'features/tabs/profile_tab/contact_screen.dart';
import 'features/tabs/profile_tab/privacy_screen.dart';
import 'features/tabs/profile_tab/terms_screen.dart';
import 'features/theme/theme.dart'; // Import your custom themes

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
    // Watch for theme changes
    final themeProvider = Provider.of<ThemeProvider>(context);

    return MaterialApp.router(
      title: 'Dwarka Eyewear',
      routerConfig: _router,
      // Use your custom themes
      theme: lightTheme,
      darkTheme: darkTheme,
      themeMode: themeProvider.themeMode, // This makes it responsive to theme changes
      debugShowCheckedModeBanner: false,
    );
  }
}

// Define router outside of build method as a constant or final variable
final GoRouter _router = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      name: 'splash',
      builder: (context, state) => const SplashScreen(),
    ),
    GoRoute(
      path: '/landing',
      name: 'landing',
      builder: (context, state) => const LandingScreen(),
    ),
    GoRoute(
      path: '/signin',
      name: 'signin',
      builder: (context, state) => const SigninScreen(),
    ),
    GoRoute(
      path: '/signup',
      name: 'signup',
      builder: (context, state) => const SignupScreen(),
    ),
    GoRoute(
      path: '/otp-verification',
      name: 'otp-verification',
      builder: (context, state) {
        final phoneNumber = state.uri.queryParameters['phoneNumber'] ?? '';
        return OTPVerificationScreen(phoneNumber: phoneNumber);
      },
    ),
    GoRoute(
      path: '/categories',
      name: 'categories',
      builder: (context, state) => const AllCategoryList(),
    ),
    GoRoute(
      path: '/home',
      name: 'home',
      builder: (context, state) => const BottomNavbar(),
    ),
    GoRoute(
      path: '/cart',
      name: 'cart',
      builder: (context, state) => const CartScreen(),
    ),
    // Category routes
    GoRoute(
      path: '/category/:categoryName',
      name: 'category',
      builder: (context, state) {
        final categoryName = state.pathParameters['categoryName'] ?? '';
        return CategoryDetails(
          categoryName: categoryName,
          itemCount: 11,
        );
      },
    ),
    // Product route
    GoRoute(
      path: '/product/:productId',
      name: 'product',
      builder: (context, state) {
        final productId = state.pathParameters['productId'] ?? '';
        return ProductScreen(productId: productId);
      },
    ),
    // Profile routes
    GoRoute(
      path: '/profile',
      name: 'profile',
      builder: (context, state) => const ProfileScreen(),
      routes: [
        GoRoute(
          path: 'orders',
          name: 'orders',
          builder: (context, state) => const OrdersScreen(),
        ),
        GoRoute(
          path: 'wishlist',
          name: 'wishlist',
          builder: (context, state) => const WishlistScreen(),
        ),
        GoRoute(
          path: 'addresses',
          name: 'addresses',
          builder: (context, state) => const AddressesScreen(),
        ),
        GoRoute(
          path: 'add-address',
          name: 'add-address',
          builder: (context, state) => const AddAddressScreen(),
        ),
        GoRoute(
          path: 'prescription',
          name: 'prescription',
          builder: (context, state) => const PrescriptionScreen(),
        ),
        GoRoute(
          path: 'help',
          name: 'help',
          builder: (context, state) => const HelpScreen(),
        ),
        GoRoute(
          path: 'about',
          name: 'about',
          builder: (context, state) => const AboutScreen(),
        ),
        GoRoute(
          path: 'contact',
          name: 'contact',
          builder: (context, state) => const ContactScreen(),
        ),
        GoRoute(
          path: 'privacy',
          name: 'privacy',
          builder: (context, state) => const PrivacyScreen(),
        ),
        GoRoute(
          path: 'terms',
          name: 'terms',
          builder: (context, state) => const TermsScreen(),
        ),
      ],
    ),
  ],
  initialLocation: '/',
  errorBuilder: (context, state) => Scaffold(
    body: Center(
      child: Text('Page not found: ${state.error}'),
    ),
  ),
);