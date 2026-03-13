import 'package:flutter/material.dart';
import 'quoteHomeScreen.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/data/latest_all.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

// Notification plugin
final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
FlutterLocalNotificationsPlugin();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Timezone initialize karna zaruri hai
  tz.initializeTimeZones();

  // Android initialization settings
  const AndroidInitializationSettings androidInitializationSettings =
  AndroidInitializationSettings('@mipmap/ic_launcher');

  // IOS initialization settings (agar future me add karni ho)
  const DarwinInitializationSettings iosInitializationSettings =
  DarwinInitializationSettings();

  // InitializationSettings updated for Flutter v14+
  final InitializationSettings initializationSettings = InitializationSettings(
    android: androidInitializationSettings,
    iOS: iosInitializationSettings,
  );

  // Plugin initialize
  await flutterLocalNotificationsPlugin.initialize(
    settings: initializationSettings, // ✅ named argument use karna hai
  );

  // Schedule daily 8 AM notification
  scheduleDailyQuoteNotification();

  runApp(QuoteApp()); // Run main app
}

// Daily 8 AM notification
void scheduleDailyQuoteNotification() async {
  await flutterLocalNotificationsPlugin.zonedSchedule(
    id: 0,
    title: 'Daily Quote',
    body: 'Check out your motivational quote for today!',
    scheduledDate: _nextInstanceOf8AM(),
    notificationDetails: const NotificationDetails(
      android: AndroidNotificationDetails(
        'daily_quote_channel',
        'Daily Quote',
        channelDescription: 'Daily motivational quotes',
        importance: Importance.high,
        priority: Priority.high,
      ),
    ),
    androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
    matchDateTimeComponents: DateTimeComponents.time,
  );
}

// 8 AM ka schedule calculate karna
tz.TZDateTime _nextInstanceOf8AM() {
  final tz.TZDateTime now = tz.TZDateTime.now(tz.local);
  tz.TZDateTime scheduledDate =
  tz.TZDateTime(tz.local, now.year, now.month, now.day, 8);
  if (scheduledDate.isBefore(now)) {
    scheduledDate = scheduledDate.add(const Duration(days: 1));
  }
  return scheduledDate;
}

// --------------------- QuoteApp class ---------------------
class QuoteApp extends StatefulWidget {
  @override
  State<QuoteApp> createState() => _QuoteAppState();
}

class _QuoteAppState extends State<QuoteApp> {
  bool isDark = false;

  void toggleTheme() {
    setState(() {
      isDark = !isDark;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Quote Generator",
      theme: ThemeData(
        brightness: Brightness.light,
        primaryColor: Color(0xff16A34A),
        scaffoldBackgroundColor: Color(0xffF6FFF8),
        appBarTheme: AppBarTheme(
          backgroundColor: Color(0xff16A34A),
          centerTitle: true,
          elevation: 0,
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: Color(0xffF97316),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(14),
            ),
          ),
        ),
      ),
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        primaryColor: Color(0xff16A34A),
        scaffoldBackgroundColor: Color(0xff1E1E1E),
        appBarTheme: AppBarTheme(
          backgroundColor: Color(0xff14532D),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: Color(0xffEA580C),
          ),
        ),
      ),
      themeMode: isDark ? ThemeMode.dark : ThemeMode.light,
      home: QuoteHomeScreen(
        toggleTheme: toggleTheme,
        isDark: isDark,
      ),
    );
  }
}