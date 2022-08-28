import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:int_jumat/core/app_url.dart';
import 'package:int_jumat/model/now_playing.dart';
import 'package:http/http.dart' as http;

part 'now_playing_state.dart';

class NowPlayingCubit extends Cubit<NowPlayingState> {
  NowPlayingCubit() : super(NowPlayingInitial());

  String baseUrl = AppUrl.baseUrl;
  String apiKey = AppUrl.apiKey;

  void getNowPlaying() async {
    emit(NowPlayingLoading());
    var response = await http.get(
      Uri.parse("$baseUrl/movie/now_playing?api_key=$apiKey"),
      headers: {
        'Accept': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> parsed = json.decode(response.body);
      NowPlayingModel nowPlayingModel = NowPlayingModel.fromJson(parsed);
      emit(NowPlayingSuccess(nowPlayingModel.results));
    } else {
      emit(NowPlayingFailed());
    }
  }
}
