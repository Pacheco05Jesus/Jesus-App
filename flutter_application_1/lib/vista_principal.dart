import 'package:flutter/material.dart';


class VistaPrincipal extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Clima + Noticias")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
          
            BlocBuilder<ClimaCubit, ClimaEstado>(
              builder: (context, estado) {
                if (estado is ClimaInicial) {
                  return ElevatedButton(
                    onPressed: () =>
                        context.read<ClimaCubit>().cargarClima("Bogotá"),
                    child: Text("Cargar Clima"),
                  );
                } else if (estado is ClimaCargando) {
                  return CircularProgressIndicator();
                } else if (estado is ClimaCargado) {
                  return Column(
                    children: [
                      Text("🌤 ${estado.descripcion}",
                          style: TextStyle(fontSize: 20)),
                      Text("Temperatura: ${estado.temperatura}°C"),
                    ],
                  );
                } else if (estado is ClimaError) {
                  return Text("Error: ${estado.mensaje}");
                }
                return Container();
              },
            ),

            Divider(),

          
            Expanded(
              child: BlocBuilder<NoticiasBloc, NoticiasEstado>(
                builder: (context, estado) {
                  if (estado is NoticiasInicial) {
                    return Center(
                      child: ElevatedButton(
                        onPressed: () => context
                            .read<NoticiasBloc>()
                            .add(CargarNoticias()),
                        child: Text("Cargar Noticias"),
                      ),
                    );
                  } else if (estado is NoticiasCargando) {
                    return Center(child: CircularProgressIndicator());
                  } else if (estado is NoticiasCargadas) {
                    return ListView.builder(
                      itemCount: estado.noticias.length,
                      itemBuilder: (context, i) {
                        final n = estado.noticias[i];
                        return ListTile(
                          title: Text(n.titulo),
                          subtitle: Text(n.descripcion),
                        );
                      },
                    );
                  } else if (estado is NoticiasError) {
                    return Center(child: Text("Error: ${estado.mensaje}"));
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
