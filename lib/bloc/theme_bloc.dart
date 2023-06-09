import 'package:bloc/bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

enum ThemeEvent { toggle }

class ThemeBloc extends Bloc<ThemeEvent, bool> {
  ThemeBloc() : super(false) {
    on<ThemeEvent>((event, emit) async {
      if (event == ThemeEvent.toggle) {
        final prefs = await SharedPreferences.getInstance();
        final isDark = !state;
        await prefs.setBool('isDark', isDark);
        emit(isDark);
      }
    });
  }
    Future<bool> loadTheme() async {
      final prefs = await SharedPreferences.getInstance();
      final isDark = prefs.getBool('isDark') ?? false;
      add(ThemeEvent.toggle);
      return isDark;
    }
  }


