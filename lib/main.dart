import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_flashcards/router/app_router.dart';
import 'package:flutter_flashcards/styles/themes.dart';

void main() {
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
  ));

  WidgetsFlutterBinding.ensureInitialized();
  runApp(FlashCardApp());
}

class FlashCardApp extends StatefulWidget {
  @override
  _FlashCardAppState createState() => _FlashCardAppState();
}

class _FlashCardAppState extends State<FlashCardApp> {
  final AppRouter _appRouter = AppRouter();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flashcards',
      theme: FlashCardTheme.standard,
      initialRoute: '/',
      onGenerateRoute: _appRouter.onGenerateRoute,
    );
  }

  @override
  void dispose() {
    _appRouter.dispose();
    super.dispose();
  }
}
