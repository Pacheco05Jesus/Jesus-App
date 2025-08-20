
import 'package:flutter/material.dart';
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
