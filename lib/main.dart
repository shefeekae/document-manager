import 'package:document_manager_app/model/file_model.dart';
import 'package:document_manager_app/provider/file_list_provider.dart';
import 'package:document_manager_app/provider/file_picker_provider.dart';
import 'package:document_manager_app/provider/toggle_view_provider.dart';
import 'package:document_manager_app/provider/validation.dart';
import 'package:document_manager_app/routes/route_generator.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  //intialize Hive
  await Hive.initFlutter();

  //register hive adapter
  Hive.registerAdapter(FileModelAdapter());

  //Open the hive box
  await Hive.openBox<FileModel>('fileBox');

  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(
      create: (context) => Validate(),
    ),
    ChangeNotifierProvider(
      create: (context) => FileProvider(),
    ),
    ChangeNotifierProvider(
      create: (context) => FilePickerProvider(),
    ),
    ChangeNotifierProvider(
      create: (context) => ToggleViewProvider(),
    ),
  ], child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/',
      onGenerateRoute: RouteGenerator.generateRoute,
    );
  }
}
