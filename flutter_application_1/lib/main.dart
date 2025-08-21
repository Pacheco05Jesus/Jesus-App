import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'cubit/clima_cubit.dart';
import 'bloc/noticias_bloc.dart';
import 'vista_principal.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => ClimaCubit()),
        BlocProvider(create: (_) => NoticiasBloc()),
      ],
      child: MaterialApp(
        title: 'Cubit + Bloc',
        home: VistaPrincipal(),
      ),
    );
  }
}