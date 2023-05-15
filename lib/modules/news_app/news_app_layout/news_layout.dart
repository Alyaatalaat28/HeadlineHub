import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../search/search_screen.dart';
import '../shared/components/components.dart';
import '../shared/cubit/cubit.dart';
import 'cubit/cubit.dart';
import 'cubit/states.dart';


class NewsLayout extends StatelessWidget {
  const NewsLayout({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsCubit,NewsState>(
      listener: (BuildContext context, state) {},
      builder: (BuildContext context, Object? state) {
        var cubit = NewsCubit.get(context);
        return  Scaffold(
          appBar: AppBar(
            title: const Text(
              'News App',
            ),
            actions: [
              IconButton(
                  onPressed: (){
                    navigateTo(context, SearchScreen());
                  },
                  icon: Icon(
                    Icons.search,
                  ),
              ),
              IconButton(
                onPressed: (){
                  AppCubit.get(context).changeAppMode();
                },
                icon: Icon(
                  Icons.brightness_4_outlined,
                ),
              ),
            ],
          ),

          body: cubit.screens[cubit.currentIndex],
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: cubit.currentIndex,
            onTap: (index){
              cubit.changeBottomNav(index);
            },
            items: cubit.bottomItems ,
          ),
        );
      },

    );
  }
}
