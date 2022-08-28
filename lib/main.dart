import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:int_jumat/bloc/check_connectivity/cubit/check_connectivity_cubit.dart';
import 'package:int_jumat/bloc/detail/cubit/detail_cubit.dart';
import 'package:int_jumat/bloc/now_playing/cubit/now_playing_cubit.dart';
import 'package:int_jumat/bloc/populer/cubit/populer_cubit.dart';
import 'package:int_jumat/bloc/top_rated/cubit/top_rated_cubit.dart';
import 'package:int_jumat/screen/splash_screen/splash_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => NowPlayingCubit(),
        ),
        BlocProvider(
          create: (context) => PopulerCubit(),
        ),
        BlocProvider(
          create: (context) => CheckConnectivityCubit(),
        ),
        BlocProvider(
          create: (context) => TopRatedCubit(),
        ),
        BlocProvider(
          create: (context) => DetailCubit(),
        )
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const SplashScreen(),
      ),
    );
  }
}
