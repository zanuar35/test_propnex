import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:int_jumat/core/app_url.dart';
import 'package:http/http.dart' as http;
import 'package:int_jumat/model/populer.dart';

part 'populer_state.dart';

class PopulerCubit extends Cubit<PopulerState> {
  PopulerCubit() : super(PopulerInitial());

  String baseUrl = AppUrl.baseUrl;
  String apiKey = AppUrl.apiKey;

  void getPopuler() async {
    emit(PopulerLoading());
    var response = await http.get(
      Uri.parse("$baseUrl/movie/popular?api_key=$apiKey"),
      headers: {
        'Accept': 'application/json',
      },
    );
    if (response.statusCode == 200) {
      final Map<String, dynamic> parsed = json.decode(response.body);
      PopulerModel populerModel = PopulerModel.fromJson(parsed);
      emit(PopulerSuccess(populerModel.results));
    } else {
      emit(PopulerFailed());
    }
  }
}
