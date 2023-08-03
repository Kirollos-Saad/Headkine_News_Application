import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_application/cubit/states.dart';
import 'package:news_application/modules/business/business_screen.dart';
import 'package:news_application/modules/science/science_screen.dart';
import 'package:news_application/modules/settings_screen/settings_screen.dart';
import 'package:news_application/modules/sports/sports_screen.dart';
import 'package:news_application/network/dio_helper.dart';

class NewsCubit extends Cubit<NewsStates>
{
  NewsCubit(): super(NewsInitialState());
  static NewsCubit get(context)=> BlocProvider.of(context);
  int currentIndex=0;
 List<BottomNavigationBarItem> bottomItems=[
   BottomNavigationBarItem(
     icon: Icon(
       Icons.business,
     ),
     label:'Business' ,
   ),
   BottomNavigationBarItem(
     icon: Icon(
       Icons.sports,
     ),
     label:'Sports' ,
   ),
   BottomNavigationBarItem(
     icon: Icon(
       Icons.science,
     ),
     label:'Science' ,
   ),

 ];
 List<Widget> screens=[
   BusinessScreen(),
   SportsScreen(),
   ScienceScreen(),
 ];

 void changeBottomNavBar(int index)
 { 
   currentIndex=index;
   if(index==1) getSports();
   else if (index==2) getScience();
   emit(NewsBottomNavState());
 }
 List<dynamic> business= [];
 void getBusiness()
 { emit(NewsGetBusinessLoadingState());
   DioHelper.getData(
       url: 'v2/top-headlines',
       query: {
         'country':'eg',
         'category':'business',
         'apiKey':'9ccc83bbb2fa4b8f89ba45364e49d588',
       }
   ).then((value) {
     business=value.data['articles'];
     emit(NewsGetBusinessSuccessState());
   }).catchError((error){
     print(error.toString());
     emit(NewsGetBusinessErrorState(error.toString()));
   });
 }

  List<dynamic> sports= [];
  void getSports()
  { emit(NewsGetBusinessLoadingState());
    if(sports.length==0)
      {
        DioHelper.getData(
            url: 'v2/top-headlines',
            query: {
              'country':'eg',
              'category':'sports',
              'apiKey':'9ccc83bbb2fa4b8f89ba45364e49d588',
            }
        ).then((value) {
          sports=value.data['articles'];
          emit(NewsGetSportsSuccessState());
        }).catchError((error){
          print(error.toString());
          emit(NewsGetSportsErrorState(error.toString()));
        });
      }
    else
      {
        emit(NewsGetSportsSuccessState());
      }

  }

  List<dynamic> science= [];
  void getScience()
  { emit(NewsGetBusinessLoadingState());
    if(science.length==0)
      {
        DioHelper.getData(
            url: 'v2/top-headlines',
            query: {
              'country':'eg',
              'category':'science',
              'apiKey':'9ccc83bbb2fa4b8f89ba45364e49d588',
            }
        ).then((value) {
          science=value.data['articles'];
          emit(NewsGetScienceSuccessState());
        }).catchError((error){
          print(error.toString());
          emit(NewsGetScienceErrorState(error.toString()));
        });
      }
    else{
      emit(NewsGetScienceSuccessState());
    }

  }

  List<Map<String, dynamic>> search = [];
  void getSearch(String value) {
    emit(NewsGetSearchLoadingState());
    DioHelper.getData(
      url: 'v2/everything',
      query: {
        'q': '$value',
        'apiKey': '9ccc83bbb2fa4b8f89ba45364e49d588',
      },
    ).then((value) {
      List<Map<String, dynamic>> articles = List<Map<String, dynamic>>.from(value.data['articles']);
      search = articles; // Assign the list of articles to the 'search' variable.
      emit(NewsGetSearchSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(NewsGetSearchErrorState(error.toString()));
    });
  }
}







