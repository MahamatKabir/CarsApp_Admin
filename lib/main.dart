import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:gracery_admin/controllers/MenuController.dart';
import 'package:gracery_admin/screens/main_screen.dart';
import 'package:provider/provider.dart';
import 'consts/theme_data.dart';
import 'inner_screens/add_prod.dart';
import 'providers/dark_theme_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      options: const FirebaseOptions(
          apiKey: "AIzaSyDxUEEYqnwni5LV-CoC11sUM97s2FFUHM0",
          authDomain: "gracery-app.firebaseapp.com",
          projectId: "gracery-app",
          storageBucket: "gracery-app.appspot.com",
          messagingSenderId: "515831734983",
          appId: "1:515831734983:web:dd3fafad03818328f554e2",
          measurementId: "G-1WR8XNYQMC"));
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  DarkThemeProvider themeChangeProvider = DarkThemeProvider();

  void getCurrentAppTheme() async {
    themeChangeProvider.setDarkTheme =
        await themeChangeProvider.darkThemePreference.getTheme();
  }

  @override
  void initState() {
    getCurrentAppTheme();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => SideMenuController(),
        ),
        ChangeNotifierProvider(
          create: (_) {
            return themeChangeProvider;
          },
        ),
      ],
      child: Consumer<DarkThemeProvider>(
        builder: (context, themeProvider, child) {
          return MaterialApp(
              debugShowCheckedModeBanner: false,
              title: 'Grocery',
              theme: Styles.themeData(themeProvider.getDarkTheme, context),
              home: const MainScreen(),
              routes: {
                UploadProductForm.routeName: (context) =>
                    const UploadProductForm(),
              });
        },
      ),
    );
  }
}
