import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:int_jumat/bloc/check_connectivity/cubit/check_connectivity_cubit.dart';
import 'package:int_jumat/screen/error_screen/error_screen.dart';
import 'package:int_jumat/screen/home/home_screen.dart';
import 'package:lottie/lottie.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 2), () {
      BlocProvider.of<CheckConnectivityCubit>(context).checkConnectivity();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: double.infinity,
        width: double.infinity,
        color: const Color(0xffF0EFF2),
        child: Column(
          children: [
            BlocListener<CheckConnectivityCubit, CheckConnectivityState>(
              listener: (context, state) {
                if (state is CheckConnectivitySuccess) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const MyHomePage(),
                    ),
                  );
                }
                if (state is CheckConnectivityFailure) {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const ErrorScreen(),
                    ),
                  );
                }
              },
              child: const SizedBox(),
            ),
            const Expanded(
              child: SizedBox(),
            ),
            SizedBox(
              height: 120,
              width: 120,
              child: Lottie.asset("assets/97952-loading-animation-blue.json"),
            ),
            const SizedBox(
              height: 50,
            )
          ],
        ),
      ),
    );
  }
}
