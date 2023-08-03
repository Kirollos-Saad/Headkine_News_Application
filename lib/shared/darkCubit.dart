import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_application/cubit/states.dart';
import 'package:news_application/network/cache_helper.dart';
import 'package:news_application/shared/darkStates.dart';

class AppCubit extends Cubit<DarkStates> {
  AppCubit() : super (DarkInitialState());

  static AppCubit get(context) => BlocProvider.of(context);
  bool isDark=false;
  void changeAppMode()
  {
    isDark=!isDark;
    CacheHelper.putBoolean(key: 'isDark', value: isDark).then((value) {
      emit(NewsChangeModeState());

    });
  }
}