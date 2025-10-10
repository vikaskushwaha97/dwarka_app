import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

// Define your themes
class AppThemes {
  static final ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    primarySwatch: Colors.blue,
    // Add other light theme properties
  );

  static final ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    primarySwatch: Colors.blue,
    // Add other dark theme properties
  );
}

// Events
abstract class ThemeEvent {}

class ThemeLoad extends ThemeEvent {}

class ThemeChanged extends ThemeEvent {
  final ThemeMode themeMode;
  ThemeChanged(this.themeMode);
}

class ThemeToggle extends ThemeEvent {}

// States
abstract class ThemeState {
  final ThemeMode themeMode;
  final ThemeData lightTheme;
  final ThemeData darkTheme;

  const ThemeState({
    required this.themeMode,
    required this.lightTheme,
    required this.darkTheme,
  });
}

class ThemeInitial extends ThemeState {
  ThemeInitial() : super(
    themeMode: ThemeMode.system,
    lightTheme: AppThemes.lightTheme,
    darkTheme: AppThemes.darkTheme,
  );
}

class ThemeLoaded extends ThemeState {
  const ThemeLoaded({
    required ThemeMode themeMode,
    required ThemeData lightTheme,
    required ThemeData darkTheme,
  }) : super(
    themeMode: themeMode,
    lightTheme: lightTheme,
    darkTheme: darkTheme,
  );
}

// BLoC
class ThemeBloc extends Bloc<ThemeEvent, ThemeState> {
  final SharedPreferences sharedPreferences;

  ThemeBloc({required this.sharedPreferences}) : super(ThemeInitial()) {
    on<ThemeLoad>(_onThemeLoad);
    on<ThemeChanged>(_onThemeChanged);
    on<ThemeToggle>(_onThemeToggle);
  }

  Future<void> _onThemeLoad(ThemeLoad event, Emitter<ThemeState> emit) async {
    final savedTheme = sharedPreferences.getString('themeMode') ?? 'system';

    final themeMode = ThemeMode.values.firstWhere(
          (e) => e.toString() == 'ThemeMode.$savedTheme',
      orElse: () => ThemeMode.system,
    );

    emit(ThemeLoaded(
      themeMode: themeMode,
      lightTheme: AppThemes.lightTheme,
      darkTheme: AppThemes.darkTheme,
    ));
  }

  Future<void> _onThemeChanged(ThemeChanged event, Emitter<ThemeState> emit) async {
    await sharedPreferences.setString(
        'themeMode',
        event.themeMode.toString().split('.').last
    );

    emit(ThemeLoaded(
      themeMode: event.themeMode,
      lightTheme: state.lightTheme,
      darkTheme: state.darkTheme,
    ));
  }

  void _onThemeToggle(ThemeToggle event, Emitter<ThemeState> emit) {
    final newThemeMode = state.themeMode == ThemeMode.light
        ? ThemeMode.dark
        : ThemeMode.light;

    add(ThemeChanged(newThemeMode));
  }
}