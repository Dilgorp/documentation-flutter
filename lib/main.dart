import 'package:documentation/bindings/schema_screen_bindings.dart';
import 'package:documentation/screens/schema_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';

Future main() async {
  await dotenv.load(fileName: '.env');

  runApp(const DocumentationApp());
}

class DocumentationApp extends StatelessWidget {
  const DocumentationApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: '${dotenv.env['title']}',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      initialRoute: Routes.home.path,
      getPages: [
        GetPage(
          name: Routes.home.path,
          page: () => const SchemaScreen(),
          binding: SchemaScreenBinding(),
        ),
      ],
    );
  }
}

enum Routes{
  home('/');

  const Routes(this.path);
  final String path;
}
