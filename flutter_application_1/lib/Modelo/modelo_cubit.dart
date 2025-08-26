class Clima {
  final String ciudad;
  final String descripcion;
  final double temperatura;

  Clima({
    required this.ciudad,
    required this.descripcion,
    required this.temperatura,
  });

  factory Clima.fromJson(Map<String, dynamic> json) {
    return Clima(
      ciudad: json['name'] ?? 'Ciudad desconocida',
      descripcion: json['weather'][0]['description'] ?? 'Sin descripción',
      temperatura: (json['main']['temp'] as num).toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'ciudad': ciudad,
      'descripcion': descripcion,
      'temperatura': temperatura,
    };
  }
}
