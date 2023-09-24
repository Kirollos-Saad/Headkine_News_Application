import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_application/cubit/states.dart';
import 'package:news_application/modules/business/business_screen.dart';
import 'package:news_application/modules/science/science_screen.dart';
import 'package:news_application/modules/settings_screen/settings_screen.dart';
import 'package:news_application/modules/sports/sports_screen.dart';
import 'package:news_application/network/dio_helper.dart';

class NewsCubit extends Cubit<NewsStates> {
  NewsCubit() : super(NewsInitialState());

  static NewsCubit get(context) => BlocProvider.of(context);

  var currentIndex = 0;

  List<BottomNavigationBarItem> bottomItems = [
    const BottomNavigationBarItem(
      icon: Icon(Icons.business),
      label: 'Business',
    ),
    const BottomNavigationBarItem(
      icon: Icon(Icons.sports),
      label: 'Sports',
    ),
    const BottomNavigationBarItem(
      icon: Icon(Icons.science),
      label: 'Science',
    ),

  ];

  List<Widget> screens = [
    const BusinessScreen(),
    const SportsScreen(),
    const ScienceScreen(),

  ];

  void ChangeBottomNavBar(index){
    currentIndex = index;
    if (index == 1) {
      getSports();
    }
    if (index ==2) {
      getScience();
    }
    emit(NewsBottomNavBarState());
  }

  List<dynamic> business = [];

  void getBusiness(){
    emit(NewsGetBusinessLoadingState());
    DioHelper.getData(url: 'v2/top-headlines', query: {
      'country':'us',
      'category':'business',
      'apiKey':'38cae3cc77d8483c9867c93ed74dd5b0',
    }).then((value) {
      emit(NewsGetBusinessSuccessState());
      business = value.data['articles'];
      print(business[0]['title']);
    }).catchError((error){
      emit(NewsGetBusinessErrorState(error.toString()));
      print(error.toString());
    });
  }

  List<dynamic> sports = [];

  void getSports(){
    emit(NewsGetSportsLoadingState());
    if(sports.isEmpty){
      DioHelper.getData(url: 'v2/top-headlines', query: {
        'country':'us',
        'category':'sports',
        'apiKey':'38cae3cc77d8483c9867c93ed74dd5b0',
      }).then((value) {
        emit(NewsGetSportsSuccessState());
        sports = value.data['articles'];
        print(sports[0]['title']);
      }).catchError((error){
        emit(NewsGetSportsErrorState(error.toString()));
        print(error.toString());
      });
    }
    else {
      emit(NewsGetSportsSuccessState());
    }
  }


  List<dynamic> science = [];

  void getScience(){
    emit(NewsGetScienceLoadingState());
    if(science.isEmpty){
      DioHelper.getData(url: 'v2/top-headlines', query: {
        'country':'us',
        'category':'science',
        'apiKey':'38cae3cc77d8483c9867c93ed74dd5b0',
      }).then((value) {
        emit(NewsGetScienceSuccessState());
        science = value.data['articles'];
        print(science[0]['title']);
      }).catchError((error){
        emit(NewsGetScienceErrorState(error.toString()));
        print(error.toString());
      });
    }
    else {
      emit(NewsGetScienceSuccessState());
    }
  }

  List<dynamic> search = [];

  void getSearch(String value){
    emit(NewsGetSearchLoadingState());
    search = [];
    DioHelper.getData(url: 'v2/everything', query: {
      'q':'$value',
      'apiKey':'38cae3cc77d8483c9867c93ed74dd5b0',
    }).then((value) {
      emit(NewsGetSearchSuccessState());
      //print(value.data.toString());
      search = value.data['articles'];
      print(search[0]['title']);
    }).catchError((error){
      emit(NewsGetSearchErrorState(error.toString()));
      print(error.toString());
    });
  }

}







