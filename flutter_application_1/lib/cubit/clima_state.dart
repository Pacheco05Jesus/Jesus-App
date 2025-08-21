
abstract class ClimaEstado {}

class ClimaInicial extends ClimaEstado {}
class ClimaCargando extends ClimaEstado {}
class ClimaCargado extends ClimaEstado {
  final int temperatura;
  final String descripcion;
  ClimaCargado({required this.temperatura, required this.descripcion});
}
class ClimaError extends ClimaEstado {
  final String mensaje;
  ClimaError(this.mensaje);
}