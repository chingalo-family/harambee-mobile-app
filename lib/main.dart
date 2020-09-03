import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:harambee_mobile_app/app-state/page_state.dart';
import 'package:harambee_mobile_app/modules/splash.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Harambee App',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
          textTheme: GoogleFonts.robotoTextTheme(
            Theme.of(context).textTheme,
          ),
        ),
        home: MultiProvider(
          providers: [
            ChangeNotifierProvider(
              create: (_) => PageState(),
            )
          ],
          child: Splash(),
        ));
  }
}
