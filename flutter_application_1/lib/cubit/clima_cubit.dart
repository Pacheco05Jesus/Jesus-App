import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_application_1/Modelo/modelo_cubit.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

part 'clima_state.dart';


class ClimaCubit extends Cubit<ClimaState> {
  ClimaCubit() : super(Initial());

  Future<void> cargarClima(String ciudad) async {
    try {
      emit(Loading());

      final url = Uri.parse('https://raw.githubusercontent.com/Pacheco05Jesus/Jesus-App/refs/heads/main/flutter_application_1/lib/json/clima.json');


      final response = await http.get(url);

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final clima = Clima.fromJson(data);
        emit(Loaded(clima, ciudad));
      } else {
        emit(Error('Error al cargar datos: ${response.statusCode}'));
      }
    } catch (e) {
      emit(Error('Error: $e'));
    }
  }
}
