import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:harambee_mobile_app/app_state/app_info_state/app_info_state.dart';
import 'package:provider/provider.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.light,
        statusBarBrightness: Brightness.dark,
      ),
      child: Scaffold(
        appBar: AppBar(title: const Text('Home')),
        body: Consumer<AppInfoState>(
          builder: (context, appInfoState, child) {
            if (appInfoState.loading) {
              return const Center(child: CircularProgressIndicator());
            }
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('App Name: ${appInfoState.appName}'),
                  Text('Package Name: ${appInfoState.packageName}'),
                  Text('Version: ${appInfoState.version}'),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
