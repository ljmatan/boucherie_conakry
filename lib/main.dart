import 'logic/api/firebase/firebase.dart';
import 'logic/i18n/locale_controller.dart';
import 'logic/local_db/local_db.dart';
import 'logic/cache/prefs.dart';
import 'other/overscroll_removed.dart';
import 'ui/views/home/home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() async {
  SystemChrome.setSystemUIOverlayStyle(
    SystemUiOverlayStyle(
      systemNavigationBarColor: const Color(0xff2d2d2d),
      systemNavigationBarIconBrightness: Brightness.light,
      statusBarColor: const Color(0xff2d2d2d),
      statusBarBrightness: Brightness.light,
    ),
  );

  WidgetsFlutterBinding.ensureInitialized();

  await Prefs.init();

  await LocalDB.init();

  runApp(BoucherieConakry());
}

class BoucherieConakry extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _BoucherieConakryState();
  }
}

class _BoucherieConakryState extends State<BoucherieConakry> {
  @override
  void initState() {
    super.initState();
    LocaleController.init();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: const Color(0xff2d2d2d),
        accentColor: const Color(0xff69072a),
        appBarTheme: const AppBarTheme(
          elevation: 6,
          brightness: Brightness.dark,
          color: Color(0xff2d2d2d),
        ),
        textSelectionTheme: const TextSelectionThemeData(
          cursorColor: Color(0xff69072a),
        ),
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: Colors.white,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(6),
          ),
        ),
        snackBarTheme: const SnackBarThemeData(
          backgroundColor: Color(0xff2d2d2d),
        ),
      ),
      builder: (context, child) => ScrollConfiguration(
        behavior: OverscrollRemovedBehavior(),
        child: child,
      ),
      home: StreamBuilder(
        stream: LocaleController.stream,
        builder: (context, _) => HomePage(),
      ),
    );
  }

  @override
  void dispose() {
    LocaleController.dispose();
    super.dispose();
  }
}
