import 'package:flutter_application_1/Modelo/modelo_bloc.dart';

abstract class NoticiasState {}

class NoticiasInicial extends NoticiasState {}

class NoticiasCargando extends NoticiasState {}

class NoticiasCargadas extends NoticiasState {
  final List<Noticia> noticias;
  NoticiasCargadas(this.noticias);
}

class NoticiasError extends NoticiasState {
  final String mensaje;
  NoticiasError(this.mensaje);
}
