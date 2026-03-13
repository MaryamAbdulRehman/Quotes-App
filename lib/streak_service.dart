import 'package:shared_preferences/shared_preferences.dart';

class StreakService {

  static Future<int> updateStreak() async {

    final prefs = await SharedPreferences.getInstance();

    int streak = prefs.getInt("streak") ?? 0;

    streak++;

    await prefs.setInt("streak", streak);

    return streak;
  }

  static Future<int> getStreak() async {

    final prefs = await SharedPreferences.getInstance();

    return prefs.getInt("streak") ?? 0;
  }
}