import 'package:flutter_bloc/flutter_bloc.dart';
import 'clima_state.dart';
import 'dart:async';

class ClimaCubit extends Cubit<ClimaEstado> {
  ClimaCubit() : super(ClimaInicial());

  Future<void> cargarClima(String ciudad) async {
    emit(ClimaCargando());
    await Future.delayed(Duration(seconds: 2)); 

    
    emit(ClimaCargado(temperatura: 22, descripcion: "Soleado en $ciudad"));
  }
}
