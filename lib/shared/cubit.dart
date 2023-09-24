import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_application/network/cache_helper.dart';

import 'states.dart';


class AppCubit extends Cubit<AppStates> {
  AppCubit() : super (AppInitialState());

  static AppCubit get(context) => BlocProvider.of(context);
  bool isDark=false;

  void ChangeAppMode({bool? formShared}) {
    if (formShared != null) {
      isDark = formShared;
      emit(NewsChangeModeState());
    } else {
      isDark = !isDark;

      CacheHelper.putBoolean(key: 'isDark', value: isDark).then((value) {
        emit(NewsChangeModeState());
      });
    }
  }
}