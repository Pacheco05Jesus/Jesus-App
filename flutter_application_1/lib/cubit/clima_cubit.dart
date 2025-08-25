import 'package:flutter_application_1/Data/servicio_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'dart:async';

part 'clima_state.dart';

class ClimaCubit extends Cubit<ClimaState> {
  final APIServicio api;

  ClimaCubit(this.api) : super(Initial());

  Future<void> loadPosts() async {
    try {
      emit(Loading());

      final response = await api.fetchData("posts");
      final posts = response.map((post) => post).toList();
      emit(Loaded(posts));
    } catch (e) {
      emit(Error("Error: $e"));
    }
  }
}
