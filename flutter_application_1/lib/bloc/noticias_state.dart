
abstract class NoticiasEstado {}

class NoticiasInicial extends NoticiasEstado {}
class NoticiasCargando extends NoticiasEstado {}
class NoticiasCargadas extends NoticiasEstado {
  final List<Noticia> noticias;
  NoticiasCargadas(this.noticias);
}
class NoticiasError extends NoticiasEstado {
  final String mensaje;
  NoticiasError(this.mensaje);
}

class Noticia {
  final String titulo;
  final String descripcion;
  Noticia(this.titulo, this.descripcion);
}