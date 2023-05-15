import 'package:flutter/material.dart';


import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:web/modules/news_app/news_app_layout/cubit/states.dart';

import '../../business/business_screen.dart';
import '../../science/science_screen.dart';
import '../../shared/network/remote/dio_helper.dart';
import '../../sports/sports_screen.dart';



class NewsCubit extends Cubit<NewsState> {
  NewsCubit() : super(NewsInitialState());

  static NewsCubit get(context) => BlocProvider.of(context);
  int currentIndex = 0;
  List<BottomNavigationBarItem> bottomItems = [
    const BottomNavigationBarItem(
      icon: Icon(
      Icons.business,
    ),
      label: 'Business',
    ),
    const BottomNavigationBarItem(
      icon: Icon(
        Icons.sports,
      ),
      label: 'Sports',
    ),
    const BottomNavigationBarItem(
      icon: Icon(
        Icons.science,
      ),
      label: 'Science',
    ),

  ];
  void changeBottomNav(int index){
    currentIndex=index;
    emit(NewsBottomNaveState());
  }
  List<Widget> screens =[
      BusinessScreen(),
      SportsScreen(),
      ScienceScreen(),
  ];
  List<dynamic> business =[];
  List<dynamic> sports=[];
  List<dynamic> science=[];
  int selectBusinessItem =0;
  bool isDesktop =false;

  void getBusiness(){
    emit(NewsGetBusinessLoadingState());
    DioHelper.getData(url:'v2/top-headlines' , query: {
      'country': 'eg',
      'category': 'business',
      'apiKey': 'ce3bd33275b44866ae895b0838532800',
    }
    ).then((value) {
         business = value?.data['articles'];
         print(business[0]['title']);
      emit(NewsGetBusinessSuccessState());
    }).catchError((error){
      print(error.toString());
      emit(NewsGetBusinessErrorState(error.toString()));
    });
  }

void selectBusinessItemMethod(int index){
  selectBusinessItem=index;
  emit(SelectBusinessItemState());
}

void setDesktop(bool value){
  isDesktop=value;
  emit(SelectBusinessItemState());
}


  void getsports(){
    emit(NewsGetSportsLoadingState());
    DioHelper.getData(url:'v2/top-headlines' , query: {
      'country': 'eg',
      'category': 'sports',
      'apiKey': 'ce3bd33275b44866ae895b0838532800',
    }
    ).then((value) {
      sports = value?.data['articles'];
      print(sports[0]['title']);
      emit(NewsGetSportsSuccessState());
    }).catchError((error){
      print(error.toString());
      emit(NewsGetSportsErrorState(error.toString()));
    });
  }
  void getScience(){
    emit(NewsGetScienceLoadingState());
    DioHelper.getData(url:'v2/top-headlines' , query: {
      'country': 'eg',
      'category': 'science',
      'apiKey': 'ce3bd33275b44866ae895b0838532800',
    }
    ).then((value) {
      science = value?.data['articles'];
      print(science[0]['title']);
      emit(NewsGetScienceSuccessState());
    }).catchError((error){
      print(error.toString());
      emit(NewsGetScienceErrorState(error.toString()));
    });
  }
  List<dynamic>search=[];
  void getSearch(String value){
    emit(NewsGetSearchLoadingState());

    DioHelper.getData(url:'v2/everything' , query: {
      'q': value,
      'apiKey': 'ce3bd33275b44866ae895b0838532800',
    }
    ).then((value) {
      search = value?.data['article'];
      emit(NewsGetSearchSuccessState());
    }).catchError((error){
      print(error.toString());
      emit(NewsGetSearchErrorState(error.toString()));
    });
  }
}

