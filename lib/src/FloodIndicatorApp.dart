// Packages
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

// Screens
import 'screens/MainScreen.dart';

// Scoped Model - Main Model
import 'scoped-model/MainModel.dart';

class FloodIndicatorApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final model = MainModel();
    return ScopedModel<MainModel>(
      model: model,
      child: _buildMaterialApp(model),
    );
  }

  MaterialApp _buildMaterialApp(MainModel model) {
    return MaterialApp(
      title: 'Flood Indicator',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Colors.pinkAccent
      ),
      routes: {
        '/': (context) => MainScreen(model: model),
        // TODO - Details Screen
        // '/details': (context) => DetailsScreen(model)
      },
    );
  }
}