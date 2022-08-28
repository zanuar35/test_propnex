import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:http/http.dart' as http;
import 'package:int_jumat/core/app_url.dart';
import 'package:int_jumat/model/detail.dart';

part 'detail_state.dart';

class DetailCubit extends Cubit<DetailState> {
  DetailCubit() : super(DetailInitial());
  String baseUrl = AppUrl.baseUrl;
  String apiKey = AppUrl.apiKey;

  void getDetail(int id) async {
    emit(DetailLoading());
    var response = await http.get(
      Uri.parse("$baseUrl/movie/$id?api_key=$apiKey"),
      headers: {
        'Accept': 'application/json',
      },
    );
    if (response.statusCode == 200) {
      final Map<String, dynamic> parsed = json.decode(response.body);
      DetailModel detailModel = DetailModel.fromJson(parsed);
      emit(DetailSuccess(detailModel));
    } else {
      emit(DetailError());
    }
  }
}
