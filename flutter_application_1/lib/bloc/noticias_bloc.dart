import 'dart:convert';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_application_1/Modelo/modelo_bloc.dart';
import 'noticias_event.dart';
import 'noticias_state.dart';

class NoticiasBloc extends Bloc<NoticiasEvent, NoticiasState> {
  NoticiasBloc() : super(NoticiasInicial()) {
    on<CargarNoticias>((event, emit) async {
      emit(NoticiasCargando());

      try {
        final url = Uri.parse('https://jsonplaceholder.typicode.com/posts');
        final response = await http.get(url);

        if (response.statusCode == 200) {
          final List jsonData = json.decode(response.body);
          final noticias = jsonData
              .take(10)
              .map((e) => Noticia.fromJson(e))
              .toList();

          emit(NoticiasCargadas(noticias));
        } else {
          emit(NoticiasError('Error: código ${response.statusCode}'));
        }
      } catch (e) {
        emit(NoticiasError('Error al cargar noticias: $e'));
      }
    });
  }
}
