import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:harambee_mobile_app/app_state/app_info_state/app_info_state.dart';
import 'package:harambee_mobile_app/core/constants/app_constant.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [ChangeNotifierProvider(create: (_) => AppInfoState())],
      child: MaterialApp(
        title: 'Harambee Mobile App',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(
            seedColor: AppConstant.defaultColor,
          ),
          useMaterial3: true,
        ),
        home: Container(),
      ),
    );
  }
}
