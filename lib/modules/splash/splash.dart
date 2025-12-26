import 'dart:async';

import 'package:flutter/material.dart';
import 'package:harambee_mobile_app/app_state/app_info_state/app_info_state.dart';
import 'package:harambee_mobile_app/core/components/circular_process_loader.dart';
import 'package:harambee_mobile_app/core/constants/app_constant.dart';
import 'package:harambee_mobile_app/modules/home/home.dart';
import 'package:provider/provider.dart';

class Splash extends StatefulWidget {
  const Splash({super.key});

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      Provider.of<AppInfoState>(context, listen: false).initiatizeAppInfo();
      Timer(const Duration(milliseconds: 100), () {
        _redictectToHomePage();
      });
    });
  }

  void _redictectToHomePage() {
    Timer(const Duration(milliseconds: 200), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => Home()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Theme.of(context).colorScheme.primary,
        child: const Center(
          child: CircularProcessLoader(
            color: AppConstant.defaultColor,
            size: 3,
          ),
        ),
      ),
    );
  }
}
