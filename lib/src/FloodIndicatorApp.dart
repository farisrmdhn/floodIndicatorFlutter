// Packages
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

// Screens
import 'screens/LoginScreen.dart';
import 'screens/MainScreen.dart';
import 'screens/DetailsScreen.dart';
import 'screens/EditProfileScreen.dart';

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
      // ignore: missing_return
      onGenerateRoute: (RouteSettings settings) {
        // Ignore Problem, Returnnya di Switch
        final arguments = settings.arguments;

        switch (settings.name) {
          case '/':
            return SlideRightRoute(widget:LoginScreen());
            break;
          case '/main':
            return SlideRightRoute(widget:MainScreen(model: model));
            break;
          case '/details':
            return SlideRightRoute(widget:DetailsScreen(model: model, id: arguments));
            break;
          case '/editProfile':
            return SlideRightRoute(widget:EditProfileScreen(model: model));
            break;
        }

      }
    );
  }
}

class SlideRightRoute extends PageRouteBuilder {
  final Widget widget;
  SlideRightRoute({this.widget})
      : super(
    pageBuilder: (BuildContext context, Animation<double> animation,
        Animation<double> secondaryAnimation) {
      return widget;
    },
    transitionsBuilder: (BuildContext context,
        Animation<double> animation,
        Animation<double> secondaryAnimation,
        Widget child) {
      return new SlideTransition(
        position: new Tween<Offset>(
          begin: const Offset(1.0, 0.0),
          end: Offset.zero,
        ).animate(animation),
        child: child,
      );
    },
  );
}