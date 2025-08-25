import 'package:flutter_bloc/flutter_bloc.dart';
import 'noticias_event.dart';
import 'noticias_state.dart';
import 'dart:async';

class NoticiasBloc extends Bloc<NoticiasEvent, NoticiasEstado> {
  NoticiasBloc() : super(NoticiasInicial()) {
    on<CargarNoticias>((event, emit) async {
      emit(NoticiasCargando());
      await Future.delayed(Duration(seconds: 2));

      final noticias = List.generate(
        5,
        (i) => Noticia("Noticia #$i", "Descripción de la noticia $i"),
      );

      emit(NoticiasCargadas(noticias));
    });
  }
}
