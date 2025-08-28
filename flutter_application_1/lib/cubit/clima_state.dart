part of 'clima_cubit.dart';

abstract class ClimaState {}

class Initial extends ClimaState {}

class Loading extends ClimaState {}

class Loaded extends ClimaState {
  final Clima clima;
  final String ciudad;
  Loaded(this.clima, this.ciudad);

}

class Error extends ClimaState {
  final String mensaje;
  Error(this.mensaje);
}
