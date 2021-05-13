import 'package:bloc/bloc.dart';
import 'package:egyptnews/modules/business/business.dart';
import 'package:egyptnews/modules/science/science.dart';
import 'package:egyptnews/modules/settings_screen/settings_screen.dart';
import 'package:egyptnews/modules/sports/sports.dart';
import 'package:egyptnews/network/local/cache_helper.dart';
import 'package:egyptnews/network/remote/dio.dart';
import 'package:egyptnews/shared/cubit/appstates.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AppCubit extends Cubit<AppStates>{
  AppCubit() : super(AppInitialState());

  static AppCubit get(context) =>BlocProvider.of(context);

  int currentIndex=0;
  List<Widget> screens = [
    BusinessScreen(),
    SportsScreen(),
    ScienceScreen(),
  ];

  List<BottomNavigationBarItem> bottomNavItems =
  [
    BottomNavigationBarItem(icon: Icon(Icons.business) , label:'Business'),
    BottomNavigationBarItem(icon: Icon(Icons.sports) , label:'Sports'),
    BottomNavigationBarItem(icon: Icon(Icons.science) , label:'Science'),
  ];
 void changeNavBarIndex(int index){
   currentIndex = index;
   if(index == 1 ) {
     getSportsArticles();
   }else if(index ==2 ){
     getScienceArticles();
   }
   emit(AppNavBarState());
 }

  List<dynamic> businessArticles = [];
  List<dynamic> sportsArticles = [];
  List<dynamic> scienceArticles = [];
  List<dynamic> searchArticles = [];

 void getBusinessArticles(){
   emit(AppBusinessLoadingState());
   if (businessArticles.length == 0){
     DioHelper.getData(url:'v2/top-headlines',
       query:
       {
         'country':'eg',
         'category':'business',
         'apiKey':'0a40587a9b78488c897a9218c7726fc6',
       },
     ).then((value) {
       businessArticles = value.data['articles'];
       print(value.data['articles'][0]['title']);
       emit(AppGetBusinessArticlesSuccessState());
     }).catchError((error){
       print(error.toString());
       emit(AppGetBusinessArticlesErrorState(error.toString()));
     });
   }else {
     emit(AppGetBusinessArticlesSuccessState());
   }

 }
 //https://newsapi.org/v2/top-headlines?country=br&category=business&apiKey=0a40587a9b78488c897a9218c7726fc6
  //https://newsapi.org/v2/top-headlines?country=eg&category=business&apiKey=0a40587a9b78488c897a9218c7726fc6

  void getSportsArticles(){
    emit(AppSportsLoadingState());
    if (sportsArticles.length == 0){
      DioHelper.getData(url:'v2/top-headlines',
        query:
        {
          'country':'eg',
          'category':'sports',
          'apiKey':'0a40587a9b78488c897a9218c7726fc6',
        },
      ).then((value) {
        sportsArticles = value.data['articles'];
        print(value.data['articles'][0]['title']);
        emit(AppGetSportsArticlesSuccessState());
      }).catchError((error){
        print(error.toString());
        emit(AppGetSportsArticlesErrorState(error.toString()));
      });
    }else {
      emit(AppGetSportsArticlesSuccessState());
    }

  }

  void getScienceArticles(){
    emit(AppScienceLoadingState());
    if(scienceArticles.length ==0){
      DioHelper.getData(url:'v2/top-headlines',
        query:
        {
          'country':'eg',
          'category':'science',
          'apiKey':'0a40587a9b78488c897a9218c7726fc6',
        },
      ).then((value) {
        scienceArticles = value.data['articles'];
        print(value.data['articles'][0]['title']);
        emit(AppGetScienceArticlesSuccessState());
      }).catchError((error){
        print(error.toString());
        emit(AppGetScienceArticlesErrorState(error.toString()));
      });
    }else {
      emit(AppGetScienceArticlesSuccessState());
    }

  }
  bool isDark = false;

  void changeAppMode({bool fromShared})
  {
    if(fromShared != null ){
      isDark = fromShared;
    }else{
      isDark = !isDark;
      ChaceHelper.putData(key: 'isDark', value: isDark).then((value) {

        emit(AppChangeModeState());
        print('from shared = $fromShared');
        print('isDark= $isDark');
      });
    }
  }

  void getSearchArticles(String value){
    searchArticles = [];
    emit(AppSearchLoadingState());
    if(searchArticles.length ==0){
      DioHelper.getData(url:'v2/everything',
        query:
        {
          'q': '$value',
          'apiKey':'0a40587a9b78488c897a9218c7726fc6',
        },
      ).then((value) {
        searchArticles = value.data['articles'];
        print(value.data['articles'][0]['title']);
        emit(AppGetSearchArticlesSuccessState());
      }).catchError((error){
        print(error.toString());
        emit(AppGetSearchArticlesErrorState(error.toString()));
      });
    }else {
      emit(AppGetSearchArticlesSuccessState());
    }

  }
}
//https://newsapi.org/v2/everything?q=tesla&apiKey=0a40587a9b78488c897a9218c7726fc6

// url:v2/everything
// query
//