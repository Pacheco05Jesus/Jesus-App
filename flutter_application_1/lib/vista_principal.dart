import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'cubit/clima_cubit.dart';
import 'bloc/noticias_bloc.dart';
import 'bloc/noticias_event.dart';
import 'bloc/noticias_state.dart';

class VistaPrincipal extends StatelessWidget {
  
  Future<void> cargarClimaConDelay(BuildContext context) async {
    await Future.delayed(Duration(seconds: 1));
    context.read<ClimaCubit>().cargarClima("Bogota");
  }

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
            
            FutureBuilder(
              future: cargarClimaConDelay(context),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                }

                return BlocBuilder<ClimaCubit, ClimaState>(
                  builder: (context, estado) {
                    return Column(
                      children: [
                        ElevatedButton.icon(
                          onPressed: () => context.read<ClimaCubit>().cargarClima("Bogota"),
                          icon: Icon(Icons.cloud),
                          label: Text("Cargar Clima"),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.blueAccent,
                            foregroundColor: Colors.white,
                            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                          ),
                        ),
                        SizedBox(height: 16),
                        if (estado is Loading)
                          CircularProgressIndicator()
                        else if (estado is Loaded)
                          Card(
                            elevation: 4,
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                            child: Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Column(
                                children: [
                                  Text("Ciudad: ${estado.ciudad}"),
                                  Text(
                                    "🌤 ${estado.clima.descripcion}",
                                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.blueAccent),
                                  ),
                                  SizedBox(height: 8),
                                  Text(
                                    "Temperatura: ${estado.clima.temperatura}°C",
                                    style: TextStyle(fontSize: 18),
                                  ),
                                ],
                              ),
                            ),
                          )
                        else if (estado is Error)
                          Text(
                            "Error: ${estado.mensaje}",
                            style: TextStyle(color: Colors.red),
                          ),
                      ],
                    );
                  },
                );
              },
            ),

            SizedBox(height: 32),

            Divider(thickness: 1.5),

            SizedBox(height: 16),

            Expanded(
              child: BlocBuilder<NoticiasBloc, NoticiasState>(
                builder: (context, estado) {
                  if (estado is NoticiasInicial) {
                    return Center(
                      child: ElevatedButton.icon(
                        onPressed: () => context.read<NoticiasBloc>().add(CargarNoticias()),
                        icon: Icon(Icons.article),
                        label: Text("Cargar Noticias"),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.indigo,
                          foregroundColor: Colors.white,
                          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                        ),
                      ),
                    );
                  } else if (estado is NoticiasCargando) {
                    return Center(child: CircularProgressIndicator());
                  } else if (estado is NoticiasCargadas) {
                    return Column(
                      children: [
                        Expanded(
                          child: ListView.builder(
                            itemCount: estado.noticias.length,
                            itemBuilder: (context, i) {
                              final n = estado.noticias[i];
                              return Card(
                                elevation: 3,
                                margin: EdgeInsets.symmetric(vertical: 8),
                                child: ListTile(
                                  leading: Icon(Icons.article_outlined, color: Colors.indigo),
                                  title: Text(n.titulo, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                                  subtitle: Text(n.descripcion),
                                ),
                              );
                            },
                          ),
                        ),
                        SizedBox(height: 12),
                        ElevatedButton.icon(
                          onPressed: () => context.read<NoticiasBloc>().add(CargarNoticias()),
                          icon: Icon(Icons.refresh),
                          label: Text("Recargar Noticias"),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.indigo,
                            foregroundColor: Colors.white,
                            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                          ),
                        ),
                      ],
                    );
                  } else if (estado is NoticiasError) {
                    return Center(
                        child: Text("Error: ${estado.mensaje}", style: TextStyle(color: Colors.red)));
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
