import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:int_jumat/bloc/check_connectivity/cubit/check_connectivity_cubit.dart';
import 'package:int_jumat/core/app_color.dart';
import 'package:int_jumat/core/app_text_style.dart';
import 'package:int_jumat/screen/home/home_screen.dart';

class ErrorScreen extends StatefulWidget {
  const ErrorScreen({Key? key}) : super(key: key);

  @override
  State<ErrorScreen> createState() => _ErrorScreenState();
}

class _ErrorScreenState extends State<ErrorScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      children: [
        const Expanded(child: SizedBox()),
        Image.asset("assets/no_internet.png"),
        const SizedBox(
          height: 50,
        ),
        const Text("Cek Koneksi Anda", style: AppTextStyle.body24),
        const SizedBox(
          height: 20,
        ),
        const Text(
          "Silahkan perbarui koneksi anda dan coba lagi",
          style: AppTextStyle.body14,
        ),
        const SizedBox(
          height: 100,
        ),
        ElevatedButton(
            onPressed: () {
              BlocProvider.of<CheckConnectivityCubit>(context)
                  .checkConnectivity();
            },
            style: ElevatedButton.styleFrom(
                primary: AppColor.yellowBtn,
                fixedSize: Size(MediaQuery.of(context).size.width - 40, 50)),
            child: BlocBuilder<CheckConnectivityCubit, CheckConnectivityState>(
              builder: (context, state) {
                if (state is CheckConnectivityLoading) {
                  return const Text("Loading...", style: AppTextStyle.body16);
                }
                return const Text("Coba Lagi", style: AppTextStyle.body16);
              },
            )),
        BlocListener<CheckConnectivityCubit, CheckConnectivityState>(
          listener: (context, state) {
            if (state is CheckConnectivityFailure) {
              const snackBar = SnackBar(
                duration: Duration(seconds: 1),
                content: Text('Coba Lagi..'),
              );

              ScaffoldMessenger.of(context).showSnackBar(snackBar);
            }
            if (state is CheckConnectivitySuccess) {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const MyHomePage()));
            }
          },
          child: Container(),
        ),
        const SizedBox(
          height: 150,
        ),
      ],
    ));
  }
}
