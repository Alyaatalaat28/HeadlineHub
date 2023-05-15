import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:window_manager/window_manager.dart';

import 'responsive_and_adaptive/desktop_layout.dart';
import 'responsive_and_adaptive/mobile_layout.dart';
import 'modules/news_app/news_app_layout/cubit/cubit.dart';
import 'modules/news_app/news_app_layout/news_layout.dart';
import 'modules/news_app/shared/bloc_observer.dart';
import 'modules/news_app/shared/cubit/cubit.dart';
import 'modules/news_app/shared/cubit/states.dart';
import 'modules/news_app/shared/network/local/cache_helper.dart';
import 'modules/news_app/shared/network/remote/dio_helper.dart';
import 'modules/news_app/shared/styles/theme.dart';

 void main() async {
  WidgetsFlutterBinding.ensureInitialized(); 
  //if(Platform.isWindows)
  await windowManager.ensureInitialized();
  WindowOptions windowOptions =const WindowOptions(
    minimumSize: Size(350.0, 650.0),
  );
   windowManager.waitUntilReadyToShow(windowOptions, () async {
    await windowManager.show();
    await windowManager.focus();
  });
  
  Bloc.observer = MyBlocObserver();
   DioHelper.init();
   await CacheHelper.init();
    bool? isDark = CacheHelper.getBoolean(key: 'isDark');

  runApp( MyApp(isDark:isDark,));
}

class MyApp extends StatelessWidget {
   final bool? isDark ;
   const MyApp({Key? key, this.isDark}) : super(key: key);

  

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (BuildContext context)=>NewsCubit()..getBusiness()..getsports()..getScience(),),
        BlocProvider(
            create: (BuildContext context) => AppCubit()..changeAppMode(
              fromShared: isDark,)),
       

      ],
      child: BlocConsumer<AppCubit,AppState>(
        listener:(context,state){
        },
        builder: (context , state){
          return  MaterialApp(
              debugShowCheckedModeBanner: false ,
              theme: lightTheme,
              darkTheme: darkTheme,
              themeMode: AppCubit.get(context).isDark? ThemeMode.dark : ThemeMode.light,
              

              home: Builder(builder: (context){
                 if(MediaQuery.of(context).size.width.toInt()<=560){
                  return MediaQuery(data: MediaQuery.of(context).copyWith(
                    textScaleFactor: 0.7,
                  ),
                  child: const MobileScreen());
                 }
                return MediaQuery(data: MediaQuery.of(context).copyWith(
                  textScaleFactor: 1.25
                ),
                child: const DesktopScreen());
              })


          );
        }
       ),
    );

  }
 }


