import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:to_do_flutter_app/screens/tabs_screen.dart';
import 'package:to_do_flutter_app/utils/app_router.dart';
import 'package:to_do_flutter_app/utils/app_theme.dart';

import 'blocs/bloc_exports.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final storage = await HydratedStorage.build(
    storageDirectory: await getApplicationDocumentsDirectory(),
  );

  HydratedBlocOverrides.runZoned(
    () => runApp(MyApp(
      appRouter: AppRouter(),
    )),
    storage: storage,
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key, required this.appRouter}) : super(key: key);

  final AppRouter appRouter;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => TasksBloc(),
          ),
          BlocProvider(
            create: (context) => SwitchBloc(),
          ),
          BlocProvider(
            create: (context) => ColorBloc(
              switchBloc: BlocProvider.of<SwitchBloc>(context),
              colorInitial: Theme.of(context).primaryColor,
            ),
          ),
        ],
        child: BlocBuilder<SwitchBloc, SwitchState>(
          builder: (context, state) {

            return BlocBuilder<ColorBloc, ColorState>(
              builder: (context, colorState) {

              ThemeData? theme = state.switchValue
                      ? AppThemes.appThemeData[AppTheme.darkTheme]
                      : AppThemes.appThemeData[AppTheme.lightTheme];

                if(!colorState.isDefaultColor) {

                  Color orginalColor = colorState.appColor.computeLuminance() >= 0.5 ? Colors.black : Colors.white;
                  Color textColor = orginalColor;

                  if(textColor == Colors.black && state.switchValue) {
                    textColor = Colors.white;
                  } else if (textColor == Colors.white && !state.switchValue) {
                    textColor = Colors.black;
                  }
                  
                  theme = theme?.copyWith(
                    primaryColor: colorState.appColor,
                    bottomNavigationBarTheme: theme.bottomNavigationBarTheme.copyWith(
                      selectedItemColor: colorState.appColor
                    ),
                    floatingActionButtonTheme: theme.floatingActionButtonTheme.copyWith(
                      backgroundColor: colorState.appColor
                    ),
                    checkboxTheme: theme.checkboxTheme.copyWith(
                      fillColor: MaterialStateProperty.all(colorState.appColor)
                    ),
                    appBarTheme: theme.appBarTheme.copyWith(
                      color: colorState.appColor
                    ),
                    elevatedButtonTheme: ElevatedButtonThemeData(
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(colorState.appColor) 
                      )
                    ),
                    textButtonTheme: TextButtonThemeData(
                      style: ButtonStyle(
                        splashFactory: InkRipple.splashFactory,
                        overlayColor: MaterialStateProperty.resolveWith<Color>((Set<MaterialState> states) {
                          if (states.contains(MaterialState.pressed)) {
                            return colorState.appColor.withOpacity(0.5);
                          }
                          return Colors.transparent;
                        }),
                      )
                    ),
                    textSelectionTheme: TextSelectionThemeData(
                      cursorColor: colorState.appColor,
                      selectionHandleColor: colorState.appColor,
                    ),
                    textTheme: TextTheme(
                      bodyText1: TextStyle(color: textColor),
                      bodyText2: TextStyle(color: textColor),
                      subtitle1: TextStyle(color: textColor),
                      headline5: TextStyle(color: orginalColor),
                    )
                    
                  );
                
                }

              return MaterialApp(
                title: 'Flutter ToDo App',
                theme: theme,
                home: const TabsScreen(),
                onGenerateRoute: appRouter.onGenerateRoute,
                debugShowCheckedModeBanner: false,
              );
            });
          }));
  }
}
