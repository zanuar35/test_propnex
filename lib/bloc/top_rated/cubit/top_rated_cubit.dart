import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:http/http.dart' as http;
import 'package:int_jumat/core/app_url.dart';
import 'package:int_jumat/model/top_rated.dart';

part 'top_rated_state.dart';

class TopRatedCubit extends Cubit<TopRatedState> {
  TopRatedCubit() : super(TopRatedInitial());

  String baseUrl = AppUrl.baseUrl;
  String apiKey = AppUrl.apiKey;

  void getTopRated() async {
    emit(TopRatedLoading());
    var response = await http.get(
      Uri.parse("$baseUrl/movie/300/recommendations?api_key=$apiKey"),
      headers: {
        'Accept': 'application/json',
      },
    );
    if (response.statusCode == 200) {
      final Map<String, dynamic> parsed = json.decode(response.body);
     
      TopRatedModel topRatedModel = TopRatedModel.fromJson(parsed);
      emit(TopRatedSuccess(topRatedModel.results));
    } else {
      emit(TopRatedFailed());
    }
  }
}
