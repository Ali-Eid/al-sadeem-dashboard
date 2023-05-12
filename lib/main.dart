import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:sadeem/constants.dart';
import 'package:sadeem/controllers/MenuAppController.dart';
import 'package:sadeem/features/doctors/presentations/bloc/add_new_doctor/add_new_doctors_bloc.dart';
import 'package:sadeem/features/doctors/presentations/bloc/get_all_doctors/get_all_doctors_bloc.dart';

import 'screens/main/main_screen.dart';
import 'injection_container.dart' as di;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Admin Panel',
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: bgColor,
        // textTheme: GoogleFonts.poppinsTextTheme(Theme.of(context).textTheme)
        //     .apply(bodyColor: Colors.white),
        canvasColor: secondaryColor,
      ),
      home: MultiBlocProvider(
        providers: [
          // BlocProvider(
          //     create: (_) => di.sl<PostsBloc>()..add(GetAllPostsEvent())),
          // BlocProvider(create: (_) => di.sl<AddDeleteUpdatePostBloc>()),
          BlocProvider(
            create: (context) =>
                di.sl<GetAllDoctorsBloc>()..add(GetAllDoctors()),
          ),
          BlocProvider(
            create: (context) => di.sl<AddNewDoctorsBloc>(),
          )
        ],
        child: MultiProvider(
          providers: [
            ChangeNotifierProvider(
              create: (context) => MenuAppController(),
            ),
          ],
          child: const MainScreen(),
        ),
      ),
    );
  }
}
