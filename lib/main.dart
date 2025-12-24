import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wavenadmin/common/theme.dart';
import 'package:wavenadmin/common/util.dart';
import 'package:wavenadmin/persentation/cubit/auth_cubit.dart';
import 'package:wavenadmin/persentation/route/approuter.dart';
import 'injection.dart' as injection;

 
void main() {
  WidgetsFlutterBinding.ensureInitialized();
  injection.init(injection.locator);
  runApp(
   ProviderScope(
     child: MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => injection.locator<AuthCubit>()..checkToken(),)
      ],
      child: const MainApp(),
     ),
   )
  );
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    final authCubit = context.read<AuthCubit>();
     

    TextTheme textTheme = createTextTheme(context, "Roboto Flex", "Roboto Flex");

    MaterialTheme theme = MaterialTheme(textTheme);
    return  MaterialApp.router(
      theme: theme.dark(),
      routerConfig: injection.locator<Approuter>().myRouter(authCubit),
    );
  }
}
