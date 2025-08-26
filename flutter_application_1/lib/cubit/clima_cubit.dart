import 'package:flutter_bloc/flutter_bloc.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

part 'clima_state.dart';

class Clima {
  final String descripcion;
  final double temperatura;

  Clima({required this.descripcion, required this.temperatura});

  factory Clima.fromJson(Map<String, dynamic> json) {
    return Clima(
      descripcion: json['weather'][0]['description'],
      temperatura: (json['main']['temp'] as num).toDouble(),
    );
  }
}

class ClimaCubit extends Cubit<ClimaState> {
  final String apiKey = '439d4b804bc8187953eb36d2a8c26a02'; 

  ClimaCubit() : super(Initial());

  Future<void> cargarClima(String ciudad) async {
    try {
      emit(Loading());

      final url = Uri.parse('https://www.metaweather.com/api/location/368148/');


      final response = await http.get(url);

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final clima = Clima.fromJson(data);
        emit(Loaded(clima));
      } else {
        emit(Error('Error al cargar datos: ${response.statusCode}'));
      }
    } catch (e) {
      emit(Error('Error: $e'));
    }
  }
}
