class Noticia {
  final String titulo;
  final String descripcion;

  Noticia({required this.titulo, required this.descripcion});

  factory Noticia.fromJson(Map<String, dynamic> json) {
    return Noticia(
      titulo: json['title'] ?? 'Sin título',
      descripcion: json['body'] ?? 'Sin descripción',
    );
  }
}