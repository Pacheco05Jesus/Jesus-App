import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'cubit/clima_cubit.dart';
import 'cubit/clima_state.dart';
import 'bloc/noticias_bloc.dart';
import 'bloc/noticias_event.dart';
import 'bloc/noticias_state.dart';

class VistaPrincipal extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: Text("Clima + Noticias"),
        centerTitle: true,
        backgroundColor: Colors.blueAccent,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            BlocBuilder<ClimaCubit, ClimaEstado>(
              builder: (context, estado) {
                if (estado is ClimaInicial) {
                  return ElevatedButton.icon(
                    onPressed: () =>
                        context.read<ClimaCubit>().cargarClima("Bogotá"),
                    icon: Icon(Icons.cloud),
                    label: Text("Cargar Clima"),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blueAccent,
                      foregroundColor: Colors.white,
                      padding:
                          EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                    ),
                  );
                } else if (estado is ClimaCargando) {
                  return CircularProgressIndicator();
                } else if (estado is ClimaCargado) {
                  return Card(
                    elevation: 4,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12)),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        children: [
                          Text("🌤 ${estado.descripcion}",
                              style: TextStyle(
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.blueAccent)),
                          SizedBox(height: 8),
                          Text("Temperatura: ${estado.temperatura}°C",
                              style: TextStyle(fontSize: 18)),
                        ],
                      ),
                    ),
                  );
                } else if (estado is ClimaError) {
                  return Text("Error: ${estado.mensaje}",
                      style: TextStyle(color: Colors.red));
                }
                return Container();
              },
            ),

            SizedBox(height: 24),

            Divider(thickness: 1.5),

            SizedBox(height: 8),

            Expanded(
              child: BlocBuilder<NoticiasBloc, NoticiasEstado>(
                builder: (context, estado) {
                  if (estado is NoticiasInicial) {
                    return Center(
                      child: ElevatedButton.icon(
                        onPressed: () => context
                            .read<NoticiasBloc>()
                            .add(CargarNoticias()),
                        icon: Icon(Icons.article),
                        label: Text("Cargar Noticias"),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.indigo,
                          foregroundColor: Colors.white,
                          padding: EdgeInsets.symmetric(
                              horizontal: 20, vertical: 12),
                        ),
                      ),
                    );
                  } else if (estado is NoticiasCargando) {
                    return Center(child: CircularProgressIndicator());
                  } else if (estado is NoticiasCargadas) {
                    return ListView.builder(
                      itemCount: estado.noticias.length,
                      itemBuilder: (context, i) {
                        final n = estado.noticias[i];
                        return Card(
                          elevation: 3,
                          margin: EdgeInsets.symmetric(vertical: 8),
                          child: ListTile(
                            leading: Icon(Icons.article_outlined,
                                color: Colors.indigo),
                            title: Text(n.titulo,
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16)),
                            subtitle: Text(n.descripcion),
                          ),
                        );
                      },
                    );
                  } else if (estado is NoticiasError) {
                    return Center(
                        child: Text("Error: ${estado.mensaje}",
                            style: TextStyle(color: Colors.red)));
                  }
                  return Container();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
