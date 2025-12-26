import 'package:flutter/material.dart';
import 'package:harambee_mobile_app/app_state/app_info_state/app_info_state.dart';
import 'package:provider/provider.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Home',
          style: TextStyle().copyWith(
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
        backgroundColor: Theme.of(context).colorScheme.primary,
      ),
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
    );
  }
}
